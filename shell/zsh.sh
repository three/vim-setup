source $DOTFILES/shell/common.sh

export ZSH=$DOTFILES/deps/oh-my-zsh
export DISABLE_AUTO_UPDATE="true"

export ZSH_CUSTOM="$DOTFILES/deps"

if [[ -z "$POWERLEVEL9K_COLOR_SCHEME" ]]; then
    export POWERLEVEL9K_COLOR_SCHEME="light"
fi

if [[ "$MYCONFIG_POWERLINE" == "true" ]]; then
    export ZSH_THEME="powerlevel9k/powerlevel9k"
    source $(dirname $0:A)/powerlevel9k.sh
else
    export ZSH_THEME="clean"
fi

plugins=(git)
unsetopt AUTO_CD

source "$ZSH/oh-my-zsh.sh"

# Fedora implements this annoying package auto-installer,
# just override it completely
command_not_found_handler() {
    printf 'zsh: %scommand not found\n' "${1:+$1: }" >&2
}

# Intead of loading NVM immediately (since it's rarely used), only load on
# first use. Note the definition of the nvm command will be overwritten by
# nvm.sh, so this is not actually recursive

export NVM_DIR="$DOTFILES/deps/nvm"
nvm() {
    source $NVM_DIR/nvm.sh || return 1
    nvm "$@"
}

# Misc Utilities
source "$DOTFILES/shell/utilities.sh"

# Aliases
source "$DOTFILES/shell/alias.sh"

# K
source "$DOTFILES/shell/k.zsh"
