Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261399AbVCFOZ1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbVCFOZ1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 09:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261403AbVCFOZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 09:25:27 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:13584 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261399AbVCFOZF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 09:25:05 -0500
Date: Sun, 6 Mar 2005 15:25:03 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>, jdike@karaya.com,
       Jim Houston <jim.houston@comcast.net>,
       Andy Whitcroft <apw@shadowen.org>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Prasanna S Panchamukhi <prasanna@in.ibm.com>
Subject: [-mm patch] one DEBUG_INFO is enough for everyone
Message-ID: <20050306142503.GB5070@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Why does everyone think one DEBUG_INFO wasn't enough?

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 arch/arm/Kconfig.debug   |    9 ---------
 arch/arm26/Kconfig.debug |   10 ----------
 arch/i386/Kconfig.kgdb   |    5 -----
 arch/x86_64/Kconfig.kgdb |    5 -----
 lib/Kconfig.debug        |   15 ++-------------
 5 files changed, 2 insertions(+), 42 deletions(-)

--- linux-2.6.11-mm1-full/lib/Kconfig.debug.old	2005-03-06 15:08:23.000000000 +0100
+++ linux-2.6.11-mm1-full/lib/Kconfig.debug	2005-03-06 15:10:33.000000000 +0100
@@ -136,26 +136,15 @@
 config DEBUG_INFO
 	bool "Compile the kernel with debug info"
 	depends on DEBUG_KERNEL
 	help
           If you say Y here the resulting kernel image will include
 	  debugging info resulting in a larger kernel image.
-	  Say Y here only if you plan to use gdb to debug the kernel.
-	  If you don't debug the kernel, you can say N.
+	  Say Y here only if you plan to debug the kernel.
 
-config DEBUG_INFO
-	bool "Enable kernel debugging symbols"
-	depends on DEBUG_KERNEL && USERMODE
-	help
-	  When this is enabled, the User-Mode Linux binary will include
-	  debugging symbols.  This enlarges the binary by a few megabytes,
-	  but aids in tracking down kernel problems in UML.  It is required
-	  if you intend to do any kernel development.
-
-	  If you're truly short on disk space or don't expect to report any
-	  bugs back to the UML developers, say N, otherwise say Y.
+	  If unsure, say N.
 
 config DEBUG_IOREMAP
 	bool "Enable ioremap() debugging"
 	depends on DEBUG_KERNEL && PARISC
 	help
 	  Enabling this option will cause the kernel to distinguish between
--- linux-2.6.11-mm1-full/arch/i386/Kconfig.kgdb.old	2005-03-06 15:11:29.000000000 +0100
+++ linux-2.6.11-mm1-full/arch/i386/Kconfig.kgdb	2005-03-06 15:11:41.000000000 +0100
@@ -61,17 +61,12 @@
 	default 4
 	help
 	  This is the irq for the debug port.  If everything is working
 	  correctly and the kernel has interrupts on a control C to the
 	  port should cause a break into the kernel debug stub.
 
-config DEBUG_INFO
-	bool
-	depends on KGDB
-	default y
-
 config KGDB_MORE
 	bool "Add any additional compile options"
 	depends on KGDB
 	default n
 	help
 	  Saying yes here turns on the ability to enter additional
--- linux-2.6.11-mm1-full/arch/arm/Kconfig.debug.old	2005-03-06 15:12:21.000000000 +0100
+++ linux-2.6.11-mm1-full/arch/arm/Kconfig.debug	2005-03-06 15:12:36.000000000 +0100
@@ -44,21 +44,12 @@
 	  printed when the kernel detects an internal error. This debugging
 	  information is useful to kernel hackers when tracking down problems,
 	  but mostly meaningless to other people. It's safe to say Y unless
 	  you are concerned with the code size or don't want to see these
 	  messages.
 
-config DEBUG_INFO
-	bool "Include GDB debugging information in kernel binary"
-	help
-	  Say Y here to include source-level debugging information in the
-	  `vmlinux' binary image. This is handy if you want to use gdb or
-	  addr2line to debug the kernel. It has no impact on the in-memory
-	  footprint of the running kernel but it can increase the amount of
-	  time and disk space needed for compilation of the kernel. If in
-	  doubt say N.
 
 # These options are only for real kernel hackers who want to get their hands dirty.
 config DEBUG_LL
 	bool "Kernel low-level debugging functions"
 	depends on DEBUG_KERNEL
 	help
--- linux-2.6.11-mm1-full/arch/arm26/Kconfig.debug.old	2005-03-06 15:13:05.000000000 +0100
+++ linux-2.6.11-mm1-full/arch/arm26/Kconfig.debug	2005-03-06 15:13:15.000000000 +0100
@@ -35,22 +35,12 @@
 	  printed when the kernel detects an internal error. This debugging
 	  information is useful to kernel hackers when tracking down problems,
 	  but mostly meaningless to other people. It's safe to say Y unless
 	  you are concerned with the code size or don't want to see these
 	  messages.
 
-config DEBUG_INFO
-	bool "Include GDB debugging information in kernel binary"
-	help
-	  Say Y here to include source-level debugging information in the
-	  `vmlinux' binary image. This is handy if you want to use gdb or
-	  addr2line to debug the kernel. It has no impact on the in-memory
-	  footprint of the running kernel but it can increase the amount of
-	  time and disk space needed for compilation of the kernel. If in
-	  doubt say N.
-
 # These options are only for real kernel hackers who want to get their hands dirty.
 config DEBUG_LL
 	bool "Kernel low-level debugging functions"
 	depends on DEBUG_KERNEL
 	help
 	  Say Y here to include definitions of printascii, printchar, printhex
--- linux-2.6.11-mm1-full/arch/x86_64/Kconfig.kgdb.old	2005-03-06 15:13:55.000000000 +0100
+++ linux-2.6.11-mm1-full/arch/x86_64/Kconfig.kgdb	2005-03-06 15:14:05.000000000 +0100
@@ -62,17 +62,12 @@
 	default 4
 	help
 	  This is the irq for the debug port.  If everything is working
 	  correctly and the kernel has interrupts on a control C to the
 	  port should cause a break into the kernel debug stub.
 
-config DEBUG_INFO
-	bool
-	depends on KGDB
-	default y
-
 config KGDB_MORE
 	bool "Add any additional compile options"
 	depends on KGDB
 	default n
 	help
 	  Saying yes here turns on the ability to enter additional

