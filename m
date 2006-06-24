Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbWFXWWl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbWFXWWl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 18:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbWFXWWl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 18:22:41 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:44471 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751129AbWFXWWk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 18:22:40 -0400
Date: Sun, 25 Jun 2006 00:22:40 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Sam Ravnborg <sam@mars.ravnborg.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [GIT PATCHES] kbuild updates
Message-ID: <20060624222240.GA26563@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Please pull following updates from the kbuild tree.

git://git.kernel.org/pub/scm/linux/kernel/git/sam/kbuild.git

Part of this has been in -mm for a while. Other parts are rather new.

Noteworthy fixes:
o fix initramfs size. All files were included twice so it grow big
o kill several false positives among "section mismatch" warnings

Noteworthy changes:
o Roman Zippel's kconfig update - which also made some nice
  cleaning up in the top-level Makefile
o Support for generating export symbol statistics
  Build with MODVERSIONING and run "perl scripts/export_symbols"
o License compatibility check during build. Do not build
  GPL-incompatible moduels that included GPL only symbols.
  Also print aout warning if GPL_FUTURE is used by GPL-incompatible modules
o Support for symtypes files - so one can see what type a specific build
  uses compared to an older build
o Optionally strip modules while installing them

Shortlog + diffstat below.

	Sam

Al Viro:
      kbuild: kill some false positives from modpost

Andreas Gruenbacher:
      kbuild: support for %.symtypes files

Andrew Morton:
      kbuild: modpost build fix

Laurent Riffard:
      kbuild: fix module.symvers parsing in modpost

Masatake YAMATO:
      kbuild: adding symbols in Kconfig and defconfig to TAGS

Mike Wolf:
      kbuild: fix make rpm for powerpc

Nickolay:
      kbuild: bugfix with initramfs

Pavel Roskin:
      kbuild: obj-dirs is calculated incorrectly if hostprogs-y is defined

Ram Pai:
      kbuild: export-type enhancement to modpost.c
      kbuild: export-symbol usage report generator

Randy Dunlap:
      kbuild: ignore smp_locks section warnings from init/exit code
      kconfig: exit if no beginning filename

Roman Zippel:
      kconfig: improve config load/save output
      kconfig: fix .config dependencies
      kconfig: remove SYMBOL_{YES,MOD,NO}
      kconfig: allow multiple default values per symbol
      kconfig: allow loading multiple configurations
      kconfig: integrate split config into silentoldconfig
      kconfig: move .kernelrelease
      kconfig: add symbol option config syntax
      kconfig: add defconfig_list/module option
      kconfig: Add search option for xconfig
      kconfig: finer customization via popup menus
      kconfig: create links in info window
      kconfig: jump to linked menu prompt
      kconfig: warn about leading whitespace for menu prompts
      kconfig: remove leading whitespace in menu prompts
      kconfig: KCONFIG_OVERWRITECONFIG
      kbuild: `make kernelrelease' speedup
      kbuild: fix silentoldconfig recursion

Sam Ravnborg:
      kbuild: fix false section mismatch with ARCH=um build
      kbuild: check license compatibility when building modules
      kbuild: ignore make's built-in rules & variables
      kbuild: fix make -rR breakage
      kbuild: replace abort() with exit(1)
      kbuild: trivial fixes in Makefile

Theodore Ts'o:
      kbuild: add option for stripping modules while installing them

Uwe Zeisberger:
      kbuild: append git revision for all untagged commits
      kbuild: append -dirty for updated but uncommited changes

Zach Brown:
      kbuild: add dependency on kernel.release to the package targets

 Documentation/kbuild/makefiles.txt   |    8 
 Makefile                             |  223 ++++---
 arch/arm/Makefile                    |    2 
 arch/sh/Makefile                     |    4 
 arch/xtensa/Makefile                 |    2 
 drivers/mtd/Kconfig                  |    4 
 drivers/mtd/maps/Kconfig             |    2 
 drivers/scsi/Kconfig                 |   10 
 include/linux/license.h              |   14 
 init/Kconfig                         |    8 
 kernel/module.c                      |   11 
 scripts/Kbuild.include               |    5 
 scripts/Makefile.build               |   16 
 scripts/Makefile.host                |    6 
 scripts/Makefile.lib                 |    6 
 scripts/Makefile.modinst             |    2 
 scripts/Makefile.modpost             |    4 
 scripts/basic/Makefile               |    6 
 scripts/basic/split-include.c        |  226 -------
 scripts/export_report.pl             |  169 +++++
 scripts/genksyms/genksyms.c          |   77 +-
 scripts/genksyms/genksyms.h          |    1 
 scripts/genksyms/lex.c_shipped       |    2 
 scripts/genksyms/lex.l               |    2 
 scripts/kconfig/conf.c               |   23 
 scripts/kconfig/confdata.c           |  537 ++++++++++++-----
 scripts/kconfig/expr.c               |   53 -
 scripts/kconfig/expr.h               |   22 
 scripts/kconfig/gconf.c              |   12 
 scripts/kconfig/lex.zconf.c_shipped  |   91 +-
 scripts/kconfig/lkc.h                |   10 
 scripts/kconfig/lkc_proto.h          |    5 
 scripts/kconfig/menu.c               |   34 -
 scripts/kconfig/qconf.cc             | 1096 ++++++++++++++++++++++-------------
 scripts/kconfig/qconf.h              |  166 +++--
 scripts/kconfig/symbol.c             |   50 -
 scripts/kconfig/util.c               |    4 
 scripts/kconfig/zconf.gperf          |    3 
 scripts/kconfig/zconf.hash.c_shipped |  181 +++--
 scripts/kconfig/zconf.tab.c_shipped  |  930 +++++++++++++++++------------
 scripts/kconfig/zconf.y              |   33 +
 scripts/mod/mk_elfconfig.c           |    6 
 scripts/mod/modpost.c                |  181 +++++
 scripts/mod/modpost.h                |    4 
 scripts/package/mkspec               |    5 
 scripts/setlocalversion              |    4 
 sound/oss/Kconfig                    |    2 
 usr/Makefile                         |    3 
 48 files changed, 2672 insertions(+), 1593 deletions(-)
