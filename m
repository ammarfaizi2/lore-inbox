Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268894AbUH3Tqz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268894AbUH3Tqz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 15:46:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268883AbUH3Tpk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 15:45:40 -0400
Received: from ppp-62-11-78-150.dialup.tiscali.it ([62.11.78.150]:60801 "EHLO
	zion.localdomain") by vger.kernel.org with ESMTP id S268881AbUH3TpT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 15:45:19 -0400
Subject: [patch 1/2] Set-cflags-before-including-arch-Makefile
To: akpm@osdl.org
Cc: jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, blaisorblade_spam@yahoo.it
From: blaisorblade_spam@yahoo.it
Date: Mon, 30 Aug 2004 17:18:35 +0200
Message-Id: <20040830151835.E97F752AB@zion.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Please note that this patch, even if UML-related, should be immediately
discussed for merging in mainline, if possible. The UML patch to handle
this has therefore been separated.

---Patch purpose:
If arch/$(ARCH)/Makefile is included before adding -O2 (and the rest) to
CFLAGS, I must duplicate the addition of it to USER_CFLAGS for UML.
So let's fix this.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade_spam@yahoo.it>
---

 uml-linux-2.6.8.1-paolo/Makefile |   18 +++++++++---------
 1 files changed, 9 insertions(+), 9 deletions(-)

diff -puN Makefile~Set-cflags-before-including-arch-Makefile Makefile
--- uml-linux-2.6.8.1/Makefile~Set-cflags-before-including-arch-Makefile	2004-08-29 14:40:49.665661448 +0200
+++ uml-linux-2.6.8.1-paolo/Makefile	2004-08-29 14:40:49.668660992 +0200
@@ -428,15 +428,6 @@ else
 include/linux/autoconf.h: ;
 endif
 
-include $(srctree)/arch/$(ARCH)/Makefile
-
-# Default kernel image to build when no specific target is given.
-# KBUILD_IMAGE may be overruled on the commandline or
-# set in the environment
-# Also any assingments in arch/$(ARCH)/Makefiel take precedence over
-# this default value
-export KBUILD_IMAGE ?= vmlinux
-
 # The all: target is the default when no target is given on the
 # command line.
 # This allow a user to issue only 'make' to build a kernel including modules
@@ -460,6 +451,15 @@ endif
 # warn about C99 declaration after statement
 CFLAGS += $(call check_gcc,-Wdeclaration-after-statement,)
 
+include $(srctree)/arch/$(ARCH)/Makefile
+
+# Default kernel image to build when no specific target is given.
+# KBUILD_IMAGE may be overruled on the commandline or
+# set in the environment
+# Also any assingments in arch/$(ARCH)/Makefiel take precedence over
+# this default value
+export KBUILD_IMAGE ?= vmlinux
+
 #
 # INSTALL_PATH specifies where to place the updated kernel and system map
 # images.  Uncomment if you want to place them anywhere other than root.
_
