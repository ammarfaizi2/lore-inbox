Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265615AbTIJTjg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 15:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265530AbTIJTjf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 15:39:35 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:12044 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S265627AbTIJTSA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 15:18:00 -0400
Date: Wed, 10 Sep 2003 21:17:58 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Linus Torvalds <torvalds@osdl.org>, Russell King <rmk@arm.linux.org.uk>,
       linux-kernel@vger.kernel.org,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       Roman Zippel <zippel@linux-m68k.org>, linuxppc-dev@lists.linuxppc.org
Subject: kbuild: Build minimum in scripts/ when changing configuration
Message-ID: <20030910191758.GC5604@mars.ravnborg.org>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	Russell King <rmk@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
	Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
	Roman Zippel <zippel@linux-m68k.org>, linuxppc-dev@lists.linuxppc.org
References: <20030910191411.GA5517@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030910191411.GA5517@mars.ravnborg.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.1270  -> 1.1271 
#	            Makefile	1.427   -> 1.428  
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 03/09/10	sam@mars.ravnborg.org	1.1271
# kbuild: Build minimum in scripts/ when changing configuration
# 
# From: Ricky Beam <jfbeam@bluetronic.net>, me
# 
# With the increasing amount of programs located in scripts/, several
# of which is dependent on the kernel configuration, it makes sense to
# avoid building these too often.
# With this patch only fixdep is build, the minimal requirement for running
# any *config target
# --------------------------------------------
#
diff -Nru a/Makefile b/Makefile
--- a/Makefile	Wed Sep 10 21:15:44 2003
+++ b/Makefile	Wed Sep 10 21:15:44 2003
@@ -253,12 +253,15 @@
 
 # Helpers built in scripts/
 
-scripts/docproc scripts/fixdep scripts/split-include : scripts ;
+scripts/docproc scripts/split-include : scripts ;
 
-.PHONY: scripts
+.PHONY: scripts scripts/fixdep
 scripts:
 	$(Q)$(MAKE) $(build)=scripts
 
+scripts/fixdep:
+	$(Q)$(MAKE) $(build)=scripts $@
+
 
 # To make sure we do not include .config for any of the *config targets
 # catch them early, and hand them over to scripts/kconfig/Makefile
@@ -336,8 +339,8 @@
 
 # If .config is newer than include/linux/autoconf.h, someone tinkered
 # with it and forgot to run make oldconfig
-include/linux/autoconf.h: scripts/fixdep .config
-	$(Q)$(MAKE) $(build)=scripts/kconfig silentoldconfig
+include/linux/autoconf.h: .config
+	$(Q)$(MAKE) -f $(srctree)/Makefile silentoldconfig
 
 endif
 
