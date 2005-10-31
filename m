Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751320AbVJaDrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbVJaDrs (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 22:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbVJaDrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 22:47:16 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:34566 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S1751317AbVJaDqv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 22:46:51 -0500
Message-Id: <200510310439.j9V4dimX000883@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 10/10] UML - Make tt mode-dependent options depend on MODE_TT
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 30 Oct 2005 23:39:44 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This makes some of the tt-specific options actually depend on
CONFIG_MODE_TT.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.14/arch/um/Kconfig
===================================================================
--- linux-2.6.14.orig/arch/um/Kconfig	2005-10-28 12:58:12.000000000 -0400
+++ linux-2.6.14/arch/um/Kconfig	2005-10-30 19:29:28.000000000 -0500
@@ -63,6 +63,30 @@ config STATIC_LINK
 	chroot, and you disable CONFIG_MODE_TT, you probably want to say Y
 	here.
 
+config HOST_2G_2G
+	bool "2G/2G host address space split"
+	default n
+	depends on MODE_TT
+	help
+	This is needed when the host on which you run has a 2G/2G memory
+	split, instead of the customary 3G/1G.
+
+	Note that to enable such a host
+	configuration, which makes sense only in some cases, you need special
+	host patches.
+
+	So, if you do not know what to do here, say 'N'.
+
+config KERNEL_HALF_GIGS
+	int "Kernel address space size (in .5G units)"
+	default "1"
+	depends on MODE_TT
+	help
+        This determines the amount of address space that UML will allocate for
+        its own, measured in half Gigabyte units.  The default is 1.
+        Change this only if you need to boot UML with an unusually large amount
+        of physical memory.
+
 config MODE_SKAS
 	bool "Separate Kernel Address Space support"
 	default y
@@ -180,19 +204,6 @@ config MAGIC_SYSRQ
 	The keys are documented in <file:Documentation/sysrq.txt>. Don't say Y
 	unless you really know what this hack does.
 
-config HOST_2G_2G
-	bool "2G/2G host address space split"
-	default n
-	help
-	This is needed when the host on which you run has a 2G/2G memory
-	split, instead of the customary 3G/1G.
-
-	Note that to enable such a host
-	configuration, which makes sense only in some cases, you need special
-	host patches.
-
-	So, if you do not know what to do here, say 'N'.
-
 config SMP
 	bool "Symmetric multi-processing support (EXPERIMENTAL)"
 	default n
@@ -239,15 +250,6 @@ config NEST_LEVEL
         set to the host's CONFIG_NEST_LEVEL + CONFIG_KERNEL_HALF_GIGS.
         Only change this if you are running nested UMLs.
 
-config KERNEL_HALF_GIGS
-	int "Kernel address space size (in .5G units)"
-	default "1"
-	help
-        This determines the amount of address space that UML will allocate for
-        its own, measured in half Gigabyte units.  The default is 1.
-        Change this only if you need to boot UML with an unusually large amount
-        of physical memory.
-
 config HIGHMEM
 	bool "Highmem support"
 	depends on !64BIT

