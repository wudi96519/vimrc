call plug#begin('~/.vim/plugged')
Plug 'preservim/nerdcommenter'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Yggdroot/indentLine'
Plug 'majutsushi/tagbar'
Plug 'scrooloose/nerdtree'
Plug 'python-mode/python-mode'
Plug 'google/yapf'
Plug 'timothycrosley/isort'
" markdown
Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'kannokanno/previm'
Plug 'tyru/open-browser.vim'
" markdown-setting {{{
"使用:PrevimOpen就可以预览
" }}}
"sudo apt-get install ctags
call plug#end()
map <C-\> <leader>c<Space>
set mouse=a
set nu
set cursorline
"Ctrl+Shift+上下移动当前行
nnoremap <silent><C-S-Down> :m .+1<CR>==
nnoremap <silent><C-S-Up> :m .-2<CR>==
inoremap <silent><C-S-Down> <Esc>:m .+1<CR>==gi
inoremap <silent><C-S-Up> <Esc>:m .-2<CR>==gi
"上下移动选中的行
vnoremap <silent><C-S-Down> :m '>+1<CR>gv=gv
vnoremap <silent><C-S-Up> :m '<-2<CR>gv=gv
set foldmethod=indent
map z<Left> zm
map z<Right> zr
map z<Space> zo
"zc
map <F5>m :PrevimOpen<CR>
nmap <F9> :TagbarToggle<CR>
" 启动时自动focus
let g:tagbar_autofocus = 1
map <F3> :NERDTreeToggle<CR>
map <S-s> :split term://$SHELL<CR>i

""""""""""""""""""""""
"Quickly Run
""""""""""""""""""""""
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
exec "w"
if &filetype == 'c'
    exec "!g++ % -o %<"
    exec "!time ./%<"
elseif &filetype == 'cpp'
    exec "!g++ % -o %<"
    exec "!time ./%<"
elseif &filetype == 'java'
    exec "!javac %"
    exec "!time java %<"
elseif &filetype == 'sh'
    :!time bash %
elseif &filetype == 'python'
    exec "!time python2.7 %"
elseif &filetype == 'html'
    exec "!firefox % &"
endif
endfunc

set foldlevel=3
 
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""新文件标题
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"新建.c,.h,.sh,.java文件，自动插入文件头 
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.java exec ":call SetTitle()" 
""定义函数SetTitle，自动插入文件头 
func SetTitle() 
	call setline(1, "/*************************************************************************") 
	call append(line("."), "	> File Name: ".expand("%")) 
	call append(line(".")+1, "	> Author: wudi") 
	call append(line(".")+2, "	> Mail: wudi96519@gmail.com ") 
	call append(line(".")+3, "	> Created Time: ".strftime("%c")) 
	call append(line(".")+4, " ************************************************************************/") 
	call append(line(".")+5, "")
	if &filetype == 'cpp'
		call append(line(".")+6, "#include<iostream>")
    		call append(line(".")+7, "using namespace std;")
		call append(line(".")+8, "")
	endif
	if &filetype == 'c'
		call append(line(".")+6, "#include<stdio.h>")
		call append(line(".")+7, "")
	endif
	"新建文件后，自动定位到文件末尾
	autocmd BufNewFile * normal G
endfunc
"文件自动检测外部更改
set autoread

"去除vi的一致性
set nocompatible

" +lag {{{

"在光标接近底端或顶端时，自动下滚或上滚
set scrolloff=15


" 分割出来的窗口位于当前窗口下边/右边
set splitbelow
set splitright
let g:ale_fix_on_save = 1

let g:ale_fixers = {
\  'python': [
\    'remove_trailing_lines',
\    'isort',
\    'yapf'
\   ]
\}
let g:pymode_trim_whitespaces = 1
let g:pymode_options = 1
let g:pymode_run = 0

map <C-f> :PymodeLintAuto<CR>
let g:pymode_lint_cwindow = 0
"let g:pymode_lint_on_write = 0
"编辑时进行检查
"let g:pymode_lint_on_fly = 0
"let g:pymode_lint_checkers = ['pyflakes', 'pep8']

syntax on  
colorscheme dracula
