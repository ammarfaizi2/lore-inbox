Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751384AbWHMTpG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbWHMTpG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Aug 2006 15:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbWHMTpG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Aug 2006 15:45:06 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:36797 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1751384AbWHMTpE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Aug 2006 15:45:04 -0400
Date: Sun, 13 Aug 2006 21:45:03 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: What's in kbuild.git for 2.6.19
Message-ID: <20060813194503.GA21736@mars.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a quick intro to what is pending in kbuild.git/lxdialog.git for 2.6.19.
And a short status too.

Highlights:
	o unifdef is now included in the kernel source (used by
	  headers_* targets).
	o lxdialog is now built-in (this did not remove all flickering
	  but thats much easier to fix now).
	o Added color theme support to lxdialog (see help in menuconfig)
	o modpost is run twice on vmlinux in normal (modules included)
	  builds - which may result in duplicated warnings.
	  It is run twice to make sure we run modpost in non-modules
	  build. modpost does the section mismatch chcks in all cases
	o try the new "make V=2" thing. It tells why a target got
	  rebuild. It is good to catch those "why the heck did kbuild
	  rebuild that much after changing just a tine CONFIG_ option".

All of this is in latest -mm, and git trees at kernel.org.

Outstanding kbuild issues (I should fix a few of these for 2.6.18):
o make -j N is not as parallel as expected (latest report from Keith
  Ownens but others has complained as well). I assume it is a kbuild
  thing but has no clue how to fix it or debug it further.
o symlinked output directory is no good (Andi Kleen)
o dependency errors in scripts/ (Olaf Hering)
o fix -Wshadow in scripts/ (Jesper Juhl)
  I add quite a few warnings in lxdialog patch serie :-(
o Add a few more color themses from Jan Engelhardt
o bugzilla has a few more issues that needs some love & care

	Sam


Jan Engelhardt:
      kconfig: linguistic fixes for Documentation/kbuild/kconfig-language.txt
      kbuild: linguistic fixes for Documentation/kbuild/modules.txt
      kbuild: linguistic fixes for Documentation/kbuild/makefiles.txt

Magnus Damm:
      kbuild: ignore references from ".pci_fixup" to ".init.text"

Matthew Wilcox:
      kconfig: support DOS line endings

Olaf Hering:
      remove RPM_BUILD_ROOT from asm-offsets.h

Sam Ravnborg:
      kbuild: consistently decide when to rebuild a target
      kbuild: add unifdef
      kbuild: replace use of strlcpy with a dedicated implmentation in unifdef
      kbuild: use in-kernel unifdef
      kbuild: create output directory for hostprogs with O=.. build
      kbuild: remove debug left-over from Makefile.host
      kbuild: modpost on vmlinux regardless of CONFIG_MODULES
      kbuild: make V=2 tell why a target is rebuild
      kbuild: make -rR is now default
      kbuild: preperly align SYSMAP output
      kbuild: add missing return statement in modpost.c:secref_whitelist()

Sam Ravnborg:
      kconfig/lxdialog: refactor color support
      kconfig/lxdialog: add support for color themes and add blackbg theme
      kconfig/lxdialog: add a new theme bluetitle which is now default
      kconfig/menuconfig: lxdialog is now built-in
      kconfig/lxdialog: let <ESC><ESC> behave as expected
      kconfig/lxdialog: support resize
      kconfig/lxdialog: fix make mrproper

