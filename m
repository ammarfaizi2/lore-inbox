Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751064AbWDNLSz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751064AbWDNLSz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 07:18:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751132AbWDNLSz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 07:18:55 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:23815 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1751064AbWDNLSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 07:18:54 -0400
Date: Fri, 14 Apr 2006 13:18:53 +0200
From: Adrian Bunk <bunk@stusta.de>
To: linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] DEBUG_KERNEL menu cleanups
Message-ID: <20060414111853.GG4162@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- move DEBUG_FS above the DEBUG_KERNEL options (it did break the menu)
- let the following options depend on DEBUG_KERNEL:
  - PRINTK_TIME
  - DEBUG_SHIRQ
  - RT_MUTEX_TESTER
  - UNWIND_INFO
- fix the formatting of the DEBUG_SHIRQ help text

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 lib/Kconfig.debug |   59 +++++++++++++++++++++++-----------------------
 1 file changed, 30 insertions(+), 29 deletions(-)

--- linux-2.6.17-rc1-mm2-full/lib/Kconfig.debug.old	2006-04-14 13:05:39.000000000 +0200
+++ linux-2.6.17-rc1-mm2-full/lib/Kconfig.debug	2006-04-14 13:13:10.000000000 +0200
@@ -1,14 +1,4 @@
 
-config PRINTK_TIME
-	bool "Show timing information on printks"
-	help
-	  Selecting this option causes timing information to be
-	  included in printk output.  This allows you to measure
-	  the interval between kernel operations, including bootup
-	  operations.  This is useful for identifying long delays
-	  in kernel startup.
-
-
 config MAGIC_SYSRQ
 	bool "Magic SysRq key"
 	depends on !UML
@@ -23,14 +13,15 @@
 	  keys are documented in <file:Documentation/sysrq.txt>. Don't say Y
 	  unless you really know what this hack does.
 
-config DEBUG_SHIRQ
-       bool "Debug shared IRQ handlers"
-       depends on GENERIC_HARDIRQS
-       help
-         Enable this to generate a spurious interrupt as soon as a shared interrupt
-	 handler is registered, and just before one is deregistered. Drivers ought
-	 to be able to handle interrupts coming in at those points; some don't and
-	 need to be caught.
+config DEBUG_FS
+	bool "Debug Filesystem"
+	depends on SYSFS
+	help
+	  debugfs is a virtual file system that kernel developers use to put
+	  debugging files into.  Enable this option to be able to read and
+	  write to these files.
+
+	  If unsure, say N.
 
 config DEBUG_KERNEL
 	bool "Kernel debugging"
@@ -38,6 +29,25 @@
 	  Say Y here if you are developing drivers or trying to debug and
 	  identify kernel problems.
 
+config PRINTK_TIME
+	bool "Show timing information on printks"
+	depends on DEBUG_KERNEL
+	help
+	  Selecting this option causes timing information to be
+	  included in printk output.  This allows you to measure
+	  the interval between kernel operations, including bootup
+	  operations.  This is useful for identifying long delays
+	  in kernel startup.
+
+config DEBUG_SHIRQ
+       bool "Debug shared IRQ handlers"
+       depends on GENERIC_HARDIRQS && DEBUG_KERNEL
+       help
+         Enable this to generate a spurious interrupt as soon as a shared
+	 interrupt handler is registered, and just before one is deregistered.
+	 Drivers ought to be able to handle interrupts coming in at those
+	 points; some don't and need to be caught.
+
 config LOG_BUF_SHIFT
 	int "Kernel log buffer size (16 => 64KB, 17 => 128KB)" if DEBUG_KERNEL
 	range 12 21
@@ -136,7 +146,7 @@
 
 config RT_MUTEX_TESTER
 	bool "Built-in scriptable tester for rt-mutexes"
-	depends on RT_MUTEXES
+	depends on RT_MUTEXES && DEBUG_KERNEL
 	default n
 	help
 	  This option enables a rt-mutex tester.
@@ -201,16 +211,6 @@
 
 	  If unsure, say N.
 
-config DEBUG_FS
-	bool "Debug Filesystem"
-	depends on SYSFS
-	help
-	  debugfs is a virtual file system that kernel developers use to put
-	  debugging files into.  Enable this option to be able to read and
-	  write to these files.
-
-	  If unsure, say N.
-
 config DEBUG_VM
 	bool "Debug VM"
 	depends on DEBUG_KERNEL
@@ -232,6 +232,7 @@
 
 config UNWIND_INFO
 	bool "Compile the kernel with frame unwind information"
+	depends on DEBUG_KERNEL
 	depends on !IA64
 	depends on !MODULES || !(MIPS || PARISC || PPC || SUPERH || SPARC64 || V850)
 	help

