Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932332AbVIERlf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932332AbVIERlf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 13:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbVIERlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 13:41:35 -0400
Received: from pfepa.post.tele.dk ([195.41.46.235]:23916 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S932332AbVIERlf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 13:41:35 -0400
Date: Mon, 5 Sep 2005 19:41:50 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>
Subject: [GIT PATCHES] kbuild updates
Message-ID: <20050905174150.GA17923@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus.

kbuild updates as accumulated over the last few months.
All patches has been in -mm in one or several versions.

Most noteworthy:
1) -Wundef added to CFLAGS. This is the cause of several new warnings,
   which for the most part has been fixed for now.
2) "PREEMPT" in UTS_VERSION. So we complain when dealing
   with modules compiled for a wrong kernel
3) Introduced Kbuild.include (the cause of most of
   the changes lines in top-level Makefile).
   It killed a lot of duplicate code
4) Introduce debug_kallsyms to better debug situations where
   kallsyms fails the consistency check
5) Added support for building rpm tarballs of source

Some of this was leftovers from my old bitkeeper tree, and authorship
is not correct due to wron cogito usage. The changelog message though 
attributes the correct author.

Please pull from:
www.kernel.org/pub/scm/linux/kernel/git/sam/kbuild.git

	Sam

Diffstat:
  
 Documentation/kbuild/makefiles.txt  |    6 +
 Makefile                            |  160 ++++++++++++++----------------------
 arch/m68knommu/Makefile             |    2 
 arch/mips/Makefile                  |    2 
 drivers/block/Kconfig               |   42 ---------
 include/asm-generic/vmlinux.lds.h   |    9 ++
 init/Kconfig                        |   22 ++++
 init/Makefile                       |    3 
 scripts/Kbuild.include              |   96 +++++++++++++++++++++
 scripts/Lindent                     |    2 
 scripts/Makefile.build              |    7 +
 scripts/Makefile.clean              |   14 +--
 scripts/Makefile.host               |    3 
 scripts/Makefile.lib                |   99 ----------------------
 scripts/Makefile.modinst            |    2 
 scripts/Makefile.modpost            |    1 
 scripts/conmakehash.c               |    2 
 scripts/kallsyms.c                  |    6 -
 scripts/kconfig/lkc.h               |    2 
 scripts/kconfig/menu.c              |    4 
 scripts/kconfig/zconf.tab.c_shipped |    8 -
 scripts/kconfig/zconf.y             |    8 -
 scripts/kernel-doc                  |    8 +
 scripts/lxdialog/dialog.h           |    2 
 scripts/lxdialog/inputbox.c         |    4 
 scripts/mkcompile_h                 |   12 +-
 scripts/mod/modpost.c               |    9 +-
 scripts/mod/sumversion.c            |    8 -
 scripts/package/Makefile            |   24 ++++-
 scripts/package/builddeb            |   56 +++++++++++-
 scripts/package/buildtar            |  111 ++++++++++++++++++++++++
 scripts/package/mkspec              |    9 ++
 scripts/reference_discarded.pl      |    1 
 scripts/reference_init.pl           |    1 
 scripts/setlocalversion             |   56 ++++++++++++
 usr/Kconfig                         |   46 ++++++++++
 usr/Makefile                        |    2 
 37 files changed, 555 insertions(+), 294 deletions(-)


Coywolf Qi Hunt:
  kbuild: make help binrpm-pkg fix

Fabio Massimo Di Nitto:
  kbuild: modpost needs to cope with new glibc elf header on sparc

Greg Edwards:
  kbuild: add ia64 support to rpm Makefile target

Ian Campbell:
  kbuild: allow cscope to index multiple architectures

J.A. Magallon:
  kbuild: signed char fixes for scripts

Jan-Benedict Glaw:
  kbuild: create tarballs

Jeff Mahoney:
  Lindent: ignore .indent.pro

Jesper Juhl:
  kallsyms: clarify KALLSYMS_ALL help text

Karl Hegbloom:
  kbuild: make 'cscope -q' play well with cscope.el

Keenan Pepper:
  kbuild: signed/unsigned char fix for make menuconfig

Matthias Urlichs:
  kbuild: obey HOSTLOADLIBES_programname for single-file compilation

Olaf Hering:
  kbuild: add -Wundef to global CFLAGS

Paolo 'Blaisorblade' Giarrusso:
  kbuild: describe Kbuild pitfall
  kconfig: trivial cleanup

Randy Dunlap:
  scripts/kernel-doc: don't use uninitialized SRCTREE

Ryan Anderson:
  kbuild: automatically append a short string to the version based upon the git commit

Sam Ravnborg:
  kbuild: Fix build as root then user
  buildcheck: reduce DEBUG_INFO noise from reference* scripts
  kbuild: Avoid inconsistent kallsyms data
  kbuild: "PREEMPT" in UTS_VERSION
  kbuild: Add target debug_kallsyms
  kbuild: fix buildcheck
  kbuild: Don't fail if include/asm symlink exists
  uml: Make deb-pkg build target build a Debian-style user-mode-linux package
  uml: Restore proper descriptions in make deb-pkg target
  kbuild: Fix bug in make deb-pkg when using seperate source and output directories
  kbuild: fix make O=... build
  kbuild: drop -Wundef from HOSTCFLAGS for now
  kbuild: drop descend - converting existing users
  kbuild: introduce Kbuild.include
  kbuild: fix make O=...
  kbuild: define clean before including kbuild file
  kbuild: KBUILD_VERBOSE was exported twice
  kbuild: pass less variables to second make invocation when using make O=...
  kbuild: silence mystery message
  kbuild: fix building external modules
  kbuild: fix make TAGS (for emacs use)
  kconfig: move initramfs options to General Setup

Tom Rini:
  kbuild: When checking depmod version, redirect stderr

Yum Rayan:
  kbuild: restrain output of "make help" to 80 columns

