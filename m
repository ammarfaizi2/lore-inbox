Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269284AbTCBTtp>; Sun, 2 Mar 2003 14:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269285AbTCBTtp>; Sun, 2 Mar 2003 14:49:45 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:60676 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S269284AbTCBTto>;
	Sun, 2 Mar 2003 14:49:44 -0500
Date: Sun, 2 Mar 2003 21:00:07 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: do not run split-include for all compilations
Message-ID: <20030302200007.GA14104@mars.ravnborg.org>
Mail-Followup-To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When a rule in the top-level Makefile includes scripts as one
of the prerequisites it inherits FORCE, and thus is always build.
include/linux/autoconf.h recently included scripts hereby forcing
split-include to be run for each compilation.

Fix all rules that lists scripts as a prerequisite but did not list FORCE.
Fixed by listing the executable needed direct.

	Sam

===== Makefile 1.388 vs edited =====
--- 1.388/Makefile	Sat Mar  1 19:57:24 2003
+++ edited/Makefile	Sun Mar  2 20:46:38 2003
@@ -460,7 +460,7 @@
 # 	if .config is newer than include/linux/autoconf.h, someone tinkered
 # 	with it and forgot to run make oldconfig
 
-include/linux/autoconf.h: .config scripts
+include/linux/autoconf.h: .config scripts/fixdep
 	$(Q)$(MAKE) $(build)=scripts/kconfig scripts/kconfig/conf
 	./scripts/kconfig/conf -s arch/$(ARCH)/Kconfig
 
@@ -804,7 +804,7 @@
 
 # Documentation targets
 # ---------------------------------------------------------------------------
-sgmldocs psdocs pdfdocs htmldocs: scripts
+sgmldocs psdocs pdfdocs htmldocs: scripts/docproc FORCE
 	$(Q)$(MAKE) $(build)=Documentation/DocBook $@
 
 # Scripts to check various things for consistency
