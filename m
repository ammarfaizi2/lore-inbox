Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932253AbWACNUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932253AbWACNUp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 08:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932278AbWACNUp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 08:20:45 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:54790 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932253AbWACNUo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 08:20:44 -0500
Date: Tue, 3 Jan 2006 14:20:35 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       sam@mars.ravnborg.org
Cc: Roman Zippel <zippel@linux-m68k.org>
Subject: [PATCH] kbuild + kconfig updates for 2.6.16-rc
Message-ID: <20060103132035.GA17485@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Accumulated kbuild + kconfig updates for 2.6.16-rc.

The updates are available in the origin branch at my build git repository.
Please pull from:
git://git.kernel.org/pub/scm/linux/kernel/git/sam/kbuild.git from the origin branch.


Most noteworthy are:
- Fix so we always run silentoldconfig in a cleaned tree. Changes to Kconfig files could be missed
- Fix from Ustyugov Roman so we no longer hide for example the unix symbol when module is named unix.
- fix to genksyms so it handles typeof() correct
    Also updated to use recent version of gperf, flex + bison so _shipped files conatains lots of changes
- MODVERSIONING is no longer marked EXPERIMENTAL
- menuconfig are now readable in a text-only console.
    There was some strange indention troubles before that was no visible in a xterm window.
- lxdialog has been Lindented and moved causing a longer diffstat than usual.

shortlog below include the details.
Patches will be posted to linux-kernel as follow-up to this mail.

	Sam
	

Adrian Bunk:
      kbuild: remove the deprecated check_gcc

Bodo Eggert:
      kbuild: document INSTALL_MOD_PATH in 'make help'

Brian Gerst:
      gitignore: asm-offsets.h
      gitignore: x86_64 files
      gitignore: misc files

Brian Strand:
      kbuild: patch to Documentation/kbuild/modules.txt

John Kacur:
      kbuild: Add ctags support for function prototypes and external variable declarations

Luke Yang:
      kbuild: Fix crc-error warning on modules

Petr Baudis:
      kconfig: Remove support for lxdialog --checklist

Robin Holt:
      kbuild: Fix genksyms handling of DEFINE_PER_CPU(struct foo_s *, bar);

Sam Ravnborg:
      kconfig: Lindent scripts/lxdialog
      kconfig: fixup after Lindent
      kconfig: lxdialog is now sparse clean
      kconfig: Add print_title helper in lxdialog
      kconfig: Left aling menu items in menuconfig
      kconfig: Fix indention when using menuconfig in text-onle consoles
      kconfig: make lxdialog/menubox.c more readable
      kconfig: truncate too long menu lines in menuconfig
      kconfig: move lxdialog to scripts/kconfig/lxdialog
      kbuild: escape '#' in .target.cmd files
      kbuild: Create _shipped files for genksyms
      kbuild: remove EXPERIMENTAL tag from Module versioning
      kbuild: always run 'make silentoldconfig' when tree is cleaned

sam@mars.ravnborg.org:
      gitignore: ignore more generated files

Samuel Thibault:
      kbuild: tags file generation fixup

Ustyugov Roman:
      kbuild: set correct KBUILD_MODNAME when using well known kernel symbols as module names


diffstat:

 .gitignore                               |    1 
 Documentation/kbuild/modules.txt         |   25 
 Makefile                                 |   47 
 arch/x86_64/boot/.gitignore              |    3 
 arch/x86_64/boot/tools/.gitignore        |    1 
 arch/x86_64/ia32/.gitignore              |    2 
 drivers/char/.gitignore                  |    2 
 drivers/ieee1394/.gitignore              |    1 
 drivers/md/.gitignore                    |    4 
 drivers/net/wan/.gitignore               |    1 
 drivers/scsi/.gitignore                  |    3 
 drivers/scsi/aic7xxx/.gitignore          |    6 
 include/asm-mips/.gitignore              |    2 
 include/linux/spinlock.h                 |    3 
 init/Kconfig                             |    5 
 kernel/.gitignore                        |    5 
 scripts/.gitignore                       |    5 
 scripts/Makefile                         |    2 
 scripts/Makefile.lib                     |    8 
 scripts/basic/fixdep.c                   |   16 
 scripts/genksyms/.gitignore              |    4 
 scripts/genksyms/keywords.c_shipped      |  210 +-
 scripts/genksyms/lex.c_shipped           |  166 +
 scripts/genksyms/parse.c_shipped         | 2916 ++++++++++++++++++-------------
 scripts/genksyms/parse.h_shipped         |  167 +
 scripts/genksyms/parse.y                 |    2 
 scripts/kconfig/.gitignore               |    2 
 scripts/kconfig/Makefile                 |    3 
 scripts/kconfig/lxdialog/.gitignore      |    5 
 scripts/kconfig/lxdialog/BIG.FAT.WARNING |    4 
 scripts/kconfig/lxdialog/Makefile        |   42 
 scripts/kconfig/lxdialog/checklist.c     |  400 +++-
 scripts/kconfig/lxdialog/colors.h        |  154 +
 scripts/kconfig/lxdialog/dialog.h        |  193 +-
 scripts/kconfig/lxdialog/inputbox.c      |  224 ++
 scripts/kconfig/lxdialog/lxdialog.c      |  225 ++
 scripts/kconfig/lxdialog/menubox.c       |  425 ++++
 scripts/kconfig/lxdialog/msgbox.c        |   71 
 scripts/kconfig/lxdialog/textbox.c       |  533 +++++
 scripts/kconfig/lxdialog/util.c          |  362 +++
 scripts/kconfig/lxdialog/yesno.c         |  102 +
 scripts/kconfig/mconf.c                  |    2 
 scripts/kconfig/util.c                   |    3 
 scripts/lxdialog/BIG.FAT.WARNING         |    4 
 scripts/lxdialog/Makefile                |   42 
 scripts/lxdialog/checklist.c             | 1119 +++--------
 scripts/lxdialog/colors.h                |  155 -
 scripts/lxdialog/dialog.h                |  245 --
 scripts/lxdialog/inputbox.c              |  696 ++-----
 scripts/lxdialog/lxdialog.c              |  448 +---
 scripts/lxdialog/menubox.c               | 1373 ++++----------
 scripts/lxdialog/msgbox.c                |  195 --
 scripts/lxdialog/textbox.c               | 1606 +++++------------
 scripts/lxdialog/util.c                  |  842 ++------
 scripts/lxdialog/yesno.c                 |  280 --
 scripts/mod/modpost.c                    |    9 
 56 files changed, 6973 insertions(+), 6398 deletions(-)
