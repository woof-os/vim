" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif

call plug#begin('~/.vim/plugged')

Plug 'itchyny/lightline.vim'
Plug 'preservim/nerdtree'
Plug 'neoclide/coc.nvim', {'do': 'npm install' }
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'gko/vim-coloresque'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'prettier/vim-prettier'
Plug 'pucka906/vdrpc' 
Plug 'vim-python/python-syntax'
Plug 'ambv/black'
Plug 'ryanoasis/vim-devicons'
Plug 'stevearc/vim-arduino'
Plug 'etdev/vim-hexcolor'
Plug 'arcticicestudio/nord-vim'
Plug 'airblade/vim-gitgutter'

call plug#end()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

function! GitStatus()
  let [a,m,r] = GitGutterGetHunkSummary()
  return printf('+%d ~%d -%d', a, m, r)
endfunction
set statusline+=%{GitStatus()}

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()

if executable('pyls')
    " pip install python-language-server
    au User lsp_setup call lsp#register_server({
        \ 'name': 'pyls',
        \ 'cmd': {server_info->['pyls']},
        \ 'allowlist': ['python'],
        \ })
endif

syntax on
set number
set termguicolors

nnoremap <C-Left> :tabprevious<CR>                                                                            
nnoremap <C-Right> :tabnext<CR>
nnoremap <C-j> :tabprevious<CR>                                      
nnoremap <C-k> :tabnext<CR>

nnoremap <C-t> :NERDTree <CR>
nnoremap <C-S-s> :vertical resize -5<CR>
nnoremap <C-S-g> :vertical resize +5<CR>

let g:lightline = {'colorscheme' : 'nord'}
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1
let g:javascript_plugin_flow = 1
let g:vim_jsx_pretty_colorful_config = 1 " default 0
let g:vdrpc_autostart = 1

""" prettier

let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0

" Max line length that prettier will wrap on: a number or 'auto' (use
" " textwidth).
" " default: 'auto'
let g:prettier#config#print_width = 'auto'
"
" " number of spaces per indentation level: a number or 'auto' (use
" " softtabstop)
" " default: 'auto'
let g:prettier#config#tab_width = 2
"
" " use tabs instead of spaces: true, false, or auto (use the expandtab
" setting).
" " default: 'auto'
let g:prettier#config#use_tabs = 'false'
"
" " flow|babylon|typescript|css|less|scss|json|graphql|markdown or empty
" string
" " (let prettier choose).
" " default: ''
let g:prettier#config#parser = ''
"
" " cli-override|file-override|prefer-file
" " default: 'file-override'
let g:prettier#config#config_precedence = 'file-override'
"
" " always|never|preserve
" " default: 'preserve'
let g:prettier#config#prose_wrap = 'preserve'
"
" " css|strict|ignore
" " default: 'css'
let g:prettier#config#html_whitespace_sensitivity = 'css'
"
" " false|true
" " default: 'false'
let g:prettier#config#require_pragma = 'false'
"
" " Define the flavor of line endings
" " lf|crlf|cr|all
" " defaut: 'lf'
let g:prettier#config#end_of_line = get(g:, 'prettier#config#end_of_line', 'lf')
"

let g:nord_style = "night"
let g:python_highlight_all = 1
colorscheme nord

set hlsearch
highlight Comment cterm=italic term=italic
highlight PythonClasses cterm=italic term=italic ctermfg=Green
match PythonClasses /self/

set mouse=a
set laststatus=2
set t_Co=256
set noshowmode
