Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbWAPL4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbWAPL4v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 06:56:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbWAPL4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 06:56:51 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:51204 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1750713AbWAPL4u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 06:56:50 -0500
Date: Mon, 16 Jan 2006 12:56:44 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Cc: Roman Zippel <zippel@linux-m68k.org>
Subject: [GIT PATCH] kbuild fixes
Message-ID: <20060116115644.GA3950@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus.

Please pull latest kbuild fixes from:

	ssh://master.kernel.org/pub/scm/linux/kernel/git/sam/kbuild.git
	
	Soon to be mirrored out at:
	git://git.kernel.org/pub/scm/linux/kernel/git/sam/kbuild.git
	
It contains four bugfixes to kbuild/kconfig:

Sam Ravnborg:
      kconfig: get rid of stray a.o, support ncursesw
      kbuild: fix make -jN with multiple targets with O=...
      kbuild: create .kernelrelease at *config step
      kbuild: fix 'make all install_modules install'

The commit named "kconfig: get rid of stray a.o, support ncursesw"
introduces support for ncursesw so a small feature enhancement was
sneaking in too. ncursesw giver nicer looking graphichs on text-only
usgae (if available).

	Sam


Diffstat:

 Makefile                                   |   30 ++++++++++++++---------------
 scripts/kconfig/confdata.c                 |    2 -
 scripts/kconfig/gconf.c                    |    2 -
 scripts/kconfig/lxdialog/Makefile          |    6 ++---
 scripts/kconfig/lxdialog/check-lxdialog.sh |   24 +++++++++++++++++------
 scripts/kconfig/mconf.c                    |    2 -
 scripts/kconfig/symbol.c                   |    5 +---
 7 files changed, 41 insertions(+), 30 deletions(-)

Patches has been sent to lkml in response to the submitters.


Change log entries:

commit df9df036d356078679a60135fba65f79cd6153d0
Author: Sam Ravnborg <sam@mars.ravnborg.org>
Date:   Mon Jan 16 12:46:07 2006 +0100

    kbuild: fix 'make all install_modules install'
    
    The command 'make all modules_install install' would fail
    in a virgin tree - pointing at a non-existing directory under
    /lib/modules/xxx
    
    KERNELRELEASE is part of MODLIB and we need to create .kernelrelease
    before we can properly evaluate KERNELRELEASE,
    Changing MODLIB to the recursively expanded flavor let it pick up
    the correct KERNELRELEASE value.
    
    Reported by: "Hemmann, Volker Armin" <volker.armin.hemmann@tu-clausthal.de>
    
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

commit 2244cbd8a9185c197ec5ba5de175aec288697223
Author: Sam Ravnborg <sam@mars.ravnborg.org>
Date:   Mon Jan 16 12:12:12 2006 +0100

    kbuild: create .kernelrelease at *config step
    
    To enable 'make kernelrelease' earlier now create .kernelrelease when
    one of the *config targets are used.
    Also introduce KERNELVERSION - only user is kconfig.
    KERNELVERSION was needed to display kernel version in menuconfig -
    KERNELRELEASE is not valid until configuration has completed.
    kconfig files modified to use KERNELVERSION.
    Bug reported by: Rene Rebe <rene@exactcode.de>
    
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

commit 296e0855b0f9a4ec9be17106ac541745a55b2ce1
Author: Sam Ravnborg <sam@mars.ravnborg.org>
Date:   Sun Jan 15 20:02:31 2006 +0100

    kbuild: fix make -jN with multiple targets with O=...
    
    The way multiple targets was handled with make O=...
    broke because for each high-level target make spawned
    a parallel make resulting in a broken build.
    Reported by Keith Owens <kaos@ocs.com.au>
    
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

commit 60f33b80443a3e7e79e2a3ddc625ab6246a61d3d
Author: Sam Ravnborg <sam@mars.ravnborg.org>
Date:   Sun Jan 15 15:28:35 2006 +0100

    kconfig: get rid of stray a.o, support ncursesw
    
    scripts/kconfig/lxdialog/check-lxdialog.sh uses gcc to check for
    what libraries are present. Redirect output to /dev/null
    so we do not generate an a.out.
    Also included support for ncursesw - so if present prefer that
    instead of ncurses.
    The order is now (first is preferred):
    1) ncursesw
    2) ncurses
    3) curses
    
    The latter is to support SunOS.
    
    Signed-off-by: Sam Ravnborg <sam@ravnborg.org>

