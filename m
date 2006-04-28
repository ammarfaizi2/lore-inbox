Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751425AbWD1RB1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751425AbWD1RB1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 13:01:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751754AbWD1RA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 13:00:58 -0400
Received: from [198.99.130.12] ([198.99.130.12]:32472 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751632AbWD1RAc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 13:00:32 -0400
Message-Id: <200604281601.k3SG17Nl007522@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Joris van Rantwijk <jvrantwijk@xs4all.nl>
Subject: [PATCH 2/6] UML - skas0 support for 2G/2G hosts
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 28 Apr 2006 12:01:07 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joris van Rantwijk <jvrantwijk@xs4all.nl>

A quick hack to allow skas0 mode to run on 2G/2G hosts.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.16/arch/um/Kconfig.i386
===================================================================
--- linux-2.6.16.orig/arch/um/Kconfig.i386	2006-04-26 11:30:35.000000000 -0400
+++ linux-2.6.16/arch/um/Kconfig.i386	2006-04-26 11:39:54.000000000 -0400
@@ -16,6 +16,19 @@ config SEMAPHORE_SLEEPERS
 	bool
 	default y
 
+config HOST_2G_2G
+	bool "2G/2G host address space split"
+	default n
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
 config TOP_ADDR
  	hex
  	default 0xc0000000 if !HOST_2G_2G
@@ -35,11 +48,13 @@ config 3_LEVEL_PGTABLES
 
 config STUB_CODE
 	hex
-	default 0xbfffe000
+	default 0xbfffe000 if !HOST_2G_2G
+	default 0x7fffe000 if HOST_2G_2G
 
 config STUB_DATA
 	hex
-	default 0xbffff000
+	default 0xbffff000 if !HOST_2G_2G
+	default 0x7ffff000 if HOST_2G_2G
 
 config STUB_START
 	hex
Index: linux-2.6.16/arch/um/Kconfig
===================================================================
--- linux-2.6.16.orig/arch/um/Kconfig	2006-04-25 12:00:49.000000000 -0400
+++ linux-2.6.16/arch/um/Kconfig	2006-04-26 11:39:40.000000000 -0400
@@ -57,20 +57,6 @@ config STATIC_LINK
 	chroot, and you disable CONFIG_MODE_TT, you probably want to say Y
 	here.
 
-config HOST_2G_2G
-	bool "2G/2G host address space split"
-	default n
-	depends on MODE_TT
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
 config KERNEL_HALF_GIGS
 	int "Kernel address space size (in .5G units)"
 	default "1"

