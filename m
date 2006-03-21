Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750885AbWCUQR1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbWCUQR1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 11:17:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750983AbWCUQR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 11:17:27 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:15623 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750848AbWCUQR1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 11:17:27 -0500
Date: Tue, 21 Mar 2006 17:17:09 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Cc: Sam Ravnborg <sam@mars.ravnborg.org>
Subject: [GIT PATCH] kbuild updates
Message-ID: <20060321161709.GA8475@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus.

Here follows kbuild updates for 2.6.17.
Most noteworthy changes:
o Introduced section consistency checks during modpost.
    This generates a number of warnings for an allmodconfig build but it
    looks sane for most normal configs.
    There may be false positives around but they are getting less.
o Removed scripts/reference_* - they are replaced by the check for
  inconsistent section usage
o Introduced check for duplicated exported symbols
o Make kbuild compatible with a future gnu make change
o Improved support for external modules (depmod, exported symbols)
o Lindent a few files (modpost.c, genksyms.c) addidng to size of diff.

Almost all patches have been in -mm for a shorter or longer period.
Shortlog contains more details.
Patches (all 48) will follow as separate mails.

Please pull from:

  ssh://master.kernel.org/pub/scm/linux/kernel/git/sam/kbuild.git

	Sam

Diffstat:

 Documentation/DocBook/Makefile          |    8 
 Documentation/kbuild/makefiles.txt      |  173 +++--
 Documentation/kbuild/modules.txt        |   98 +++
 Documentation/smart-config.txt          |    4 
 Makefile                                |  234 +++-----
 arch/arm/Makefile                       |    5 
 arch/arm/boot/Makefile                  |    5 
 arch/arm/boot/bootp/Makefile            |    5 
 arch/arm26/Makefile                     |    7 
 arch/arm26/boot/Makefile                |    5 
 arch/i386/Makefile                      |    4 
 arch/i386/kernel/vmlinux.lds.S          |    4 
 arch/ia64/Makefile                      |    5 
 arch/m32r/Makefile                      |    5 
 arch/powerpc/Makefile                   |    2 
 arch/ppc/Makefile                       |    2 
 arch/ppc/boot/Makefile                  |    5 
 arch/ppc/boot/openfirmware/Makefile     |    7 
 arch/sh/Makefile                        |    2 
 arch/um/Makefile                        |    7 
 arch/x86_64/Makefile                    |    4 
 drivers/atm/.gitignore                  |    5 
 drivers/video/matrox/matroxfb_DAC1064.c |    1 
 drivers/video/matrox/matroxfb_DAC1064.h |    1 
 drivers/video/matrox/matroxfb_Ti3026.c  |    1 
 drivers/video/matrox/matroxfb_Ti3026.h  |    1 
 drivers/video/matrox/matroxfb_base.c    |    1 
 drivers/video/matrox/matroxfb_misc.c    |    1 
 init/Kconfig                            |   38 -
 scripts/Kbuild.include                  |   68 +-
 scripts/Makefile.build                  |   29 
 scripts/Makefile.clean                  |   10 
 scripts/Makefile.modinst                |   10 
 scripts/Makefile.modpost                |   19 
 scripts/basic/fixdep.c                  |   15 
 scripts/checkconfig.pl                  |   66 --
 scripts/genksyms/genksyms.c             |  935 ++++++++++++++------------------
 scripts/genksyms/genksyms.h             |   58 -
 scripts/kconfig/Makefile                |    7 
 scripts/kconfig/confdata.c              |    3 
 scripts/kconfig/lxdialog/Makefile       |    6 
 scripts/mkmakefile                      |    9 
 scripts/mod/file2alias.c                |   17 
 scripts/mod/mk_elfconfig.c              |    4 
 scripts/mod/modpost.c                   |  838 +++++++++++++++++++++-------
 scripts/mod/modpost.h                   |   27 
 scripts/mod/sumversion.c                |   34 -
 scripts/namespace.pl                    |    5 
 scripts/package/Makefile                |   30 -
 scripts/reference_discarded.pl          |  112 ---
 scripts/reference_init.pl               |  109 ---
 sound/oss/.gitignore                    |    5 
 52 files changed, 1624 insertions(+), 1432 deletions(-)

Shortlog:
Aaron Brooks:
      kbuild: make namespace.pl CROSS_COMPILE happy

Adrian Bunk:
      kbuild: remove a tab from an empty line
      Kconfig: remove the CONFIG_CC_ALIGN_* options

Andrew Morton:
      kbuild: fix modpost compile with older gcc

Brian Gerst:
      kbuild: remove checkconfig.pl

Chuck Ebbert:
      kbuild: add -fverbose-asm to i386 Makefile

Jan Beulich:
      kbuild: consolidate command line escaping
      kbuild: fix mkmakefile
      kbuild: version.h should depend on .kernelrelease
      kconfig: fix time ordering of writes to .kconfig.d and include/linux/autoconf.h

Jesper Juhl:
      kbuild: small update of allnoconfig description

Luke Yang:
      kbuild: Fix bug in crc symbol generating of kernel and modules

Martin Michlmayr:
      kbuild: Accept various mips sub-types in SUBARCH

Mattia Dongili:
      kbuild: fix a cscope bug (make cscope segfaults)

Paul Smith:
      kbuild: change kbuild to not rely on incorrect GNU make behavior

Sam Ravnborg:
      kbuild: support building individual files for external modules
      kbuild: use warn()/fatal() consistent in modpost
      kbuild: apply CodingStyle to modpost.c
      kbuild: improved modversioning support for external modules
      kbuild: warn about duplicate exported symbols
      kbuild: avoid stale modules in $(MODVERDIR) for external modules
      kbuild: run depmod when installing external modules
      kbuild: check for section mismatch during modpost stage
      kbuild: make cc-version available in kbuild files
      kbuild: fix comment in Kbuild.include
      kbuild: do not segfault in modpost if MODVERDIR is not defined
      kbuild: fix segfault in modpost
      kbuild: include symbol names in section mismatch warnings
      kbuild: do not warn when unwind sections references .init/.exit sections
      kbuild: Add copyright to modpost.c
      kbuild: ignore all generated files for make allmodconfig (x86_64)
      kbuild: whitelist false section mismatch warnings
      kbuild: kill trailing whitespace in modpost & friends
      kbuild: kill false positives from section mismatch warnings for powerpc
      kbuild: fix section mismatch check for unwind on IA64
      kbuild: in the section mismatch check try harder to find symbols
      kbuild: fix make dir/file.xx when asm symlink is missing
      kbuild: when warning symbols exported twice now tell user this is the problem
      kbuild: replace PHONY with FORCE
      kbuild: in makefile.txt note that Makefile is preferred name for kbuild files
      kbuild: fix genksyms build error
      kbuild: Lindent genksyms.c
      kbuild: clean-up genksyms
      kbuild: fix make help & make *pkg
      kbuild: remove obsoleted scripts/reference_* files

Zach Brown:
      x86: align per-cpu section to configured cache bytes

