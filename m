Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750913AbWJVNr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750913AbWJVNr0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Oct 2006 09:47:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751808AbWJVNr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Oct 2006 09:47:26 -0400
Received: from main.gmane.org ([80.91.229.2]:25305 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750913AbWJVNrZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Oct 2006 09:47:25 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: [patch] Makefile: cancel implicit rules on included and top makefiles.
Date: Sun, 22 Oct 2006 13:47:14 +0000 (UTC)
Organization: Palacky University in Olomouc, experimental physics department.
Message-ID: <slrnejmtvc.30t.olecom@flower.upol.cz>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: flower.upol.cz
User-Agent: quilt/0.45-1
Content-Disposition: inline; filename=cancel-implicit-rules-on-included-and-top-makefile.patch
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>, Oleg Verych <olecom@flower.upol.cz>, Sam Ravnborg <sam@ravnborg.org>, Kai Germaschewski <kai@germaschewski.name>, <kbuild-devel@lists.sourceforge.net>, Andrew Morton <akpm@osdl.org>
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 `make -d help | grep Makefile` shows patterns, where make tries to rebuild
 included and top makefiles.
 Do not let make to do so, by canceling implicit rules on this files.
 This must apply for all kinds of top makefiles's targets: *config, *build.

 Signed-off-by: Oleg Verych <olecom@flower.upol.cz>
---
 Makefile |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

Index: linux-2.6.19-rc2-git7/Makefile
===================================================================
--- linux-2.6.19-rc2-git7.orig/Makefile	2006-10-22 13:01:08.000000000 +0000
+++ linux-2.6.19-rc2-git7/Makefile	2006-10-22 13:15:31.340337846 +0000
@@ -271,8 +271,10 @@
 # Look for make include files relative to root of kernel src
 MAKEFLAGS += --include-dir=$(srctree)
 
-# We need some generic definitions
-include  $(srctree)/scripts/Kbuild.include
+# We need some generic definitions from another makefile.
+# Do not let `make' to try its implicit rules on it.
+$(srctree)/scripts/Kbuild.include: ;
+include $(srctree)/scripts/Kbuild.include
 
 # Do not use make's built-in rules and variables
 # This increases performance and avoid hard-to-debug behavour
@@ -1484,6 +1486,9 @@
 PHONY += FORCE
 FORCE:
 
+# Cancel implicit rules on arch and top makefiles.
+$(srctree)/Makefile Makefile:     ;
+$(srctree)/arch/$(ARCH)/Makefile: ;
 
 # Declare the contents of the .PHONY variable as phony.  We keep that
 # information in a variable se we can use it in if_changed and friends.

--

