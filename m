Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262229AbUKQIT2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262229AbUKQIT2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 03:19:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262231AbUKQITY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 03:19:24 -0500
Received: from mail.renesas.com ([202.234.163.13]:27096 "EHLO
	mail02.idc.renesas.com") by vger.kernel.org with ESMTP
	id S262229AbUKQISx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 03:18:53 -0500
Date: Wed, 17 Nov 2004 17:18:43 +0900 (JST)
Message-Id: <20041117.171843.241896829.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
Subject: [PATCH 2.6.10-rc2-bk1] m32r: Kconfig.debug support
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch update Kconfig and add Kconfig.debug for m32r.
Please apply.

	* arch/m32r/Kconfig: Move "Kernel hacking" menu to Kconfig.debug.

	* arch/m32r/Kconfig.debug: Newly added.

	* lib/Kconfig.debug: Add m32r arch.

Regards,

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/Kconfig       |   98 ++++--------------------------------------------
 arch/m32r/Kconfig.debug |   34 ++++++++++++++++
 lib/Kconfig.debug       |   14 +++---
 3 files changed, 51 insertions(+), 95 deletions(-)


diff -ruNp a/arch/m32r/Kconfig b/arch/m32r/Kconfig
--- a/arch/m32r/Kconfig	2004-10-19 06:53:06.000000000 +0900
+++ b/arch/m32r/Kconfig	2004-11-17 14:36:53.000000000 +0900
@@ -3,7 +3,7 @@
 # see Documentation/kbuild/kconfig-language.txt.
 #
 
-mainmenu "Linux Kernel Configuration"
+mainmenu "Linux/M32R Kernel Configuration"
 
 config M32R
 	bool
@@ -20,6 +20,10 @@ config GENERIC_ISA_DMA
 	bool
 	default y
 
+#config GENERIC_HARDIRQS
+#	bool
+#	default y
+
 source "init/Kconfig"
 
 
@@ -189,6 +193,10 @@ config RWSEM_XCHGADD_ALGORITHM
 	bool
 	default n
 
+config GENERIC_CALIBRATE_DELAY
+	bool
+	default y
+
 config PREEMPT
 	bool "Preemptible Kernel"
 	help
@@ -346,96 +354,10 @@ source "fs/Kconfig"
 
 source "arch/m32r/oprofile/Kconfig"
 
-menu "Kernel hacking"
-
-config DEBUG_KERNEL
-	bool "Kernel debugging"
-	help
-	  Say Y here if you are developing drivers or trying to debug and
-	  identify kernel problems.
-
-config DEBUG_STACKOVERFLOW
-	bool "Check for stack overflows"
-	depends on DEBUG_KERNEL
-
-config DEBUG_SLAB
-	bool "Debug memory allocations"
-	depends on DEBUG_KERNEL
-	help
-	  Say Y here to have the kernel do limited verification on memory
-	  allocation as well as poisoning memory on free to catch use of freed
-	  memory.
-
-config DEBUG_IOVIRT
-	bool "Memory mapped I/O debugging"
-	depends on DEBUG_KERNEL
-	help
-	  Say Y here to get warned whenever an attempt is made to do I/O on
-	  obviously invalid addresses such as those generated when ioremap()
-	  calls are forgotten.  Memory mapped I/O will go through an extra
-	  check to catch access to unmapped ISA addresses, an access method
-	  that can still be used by old drivers that are being ported from
-	  2.0/2.2.
-
-config MAGIC_SYSRQ
-	bool "Magic SysRq key"
-	depends on DEBUG_KERNEL
-	help
-	  If you say Y here, you will have some control over the system even
-	  if the system crashes for example during kernel debugging (e.g., you
-	  will be able to flush the buffer cache to disk, reboot the system
-	  immediately or dump some status information). This is accomplished
-	  by pressing various keys while holding SysRq (Alt+PrintScreen). It
-	  also works on a serial console (on PC hardware at least), if you
-	  send a BREAK and then within 5 seconds a command keypress. The
-	  keys are documented in <file:Documentation/sysrq.txt>. Don't say Y
-	  unless you really know what this hack does.
-
-config DEBUG_SPINLOCK
-	bool "Spinlock debugging"
-	depends on DEBUG_KERNEL
-	help
-	  Say Y here and build SMP to catch missing spinlock initialization
-	  and certain other kinds of spinlock errors commonly made.  This is
-	  best used in conjunction with the NMI watchdog so that spinlock
-	  deadlocks are also debuggable.
-
-config DEBUG_PAGEALLOC
-	bool "Page alloc debugging"
-	depends on DEBUG_KERNEL
-	help
-	  Unmap pages from the kernel linear mapping after free_pages().
-	  This results in a large slowdown, but helps to find certain types
-	  of memory corruptions.
-
-config DEBUG_INFO
-	bool "Compile the kernel with debug info"
-	depends on DEBUG_KERNEL
-	help
-          If you say Y here the resulting kernel image will include
-	  debugging info resulting in a larger kernel image.
-	  Say Y here only if you plan to use gdb to debug the kernel.
-	  If you don't debug the kernel, you can say N.
-
-config DEBUG_SPINLOCK_SLEEP
-	bool "Sleep-inside-spinlock checking"
-	help
-	  If you say Y here, various routines which may sleep will become very
-	  noisy if they are called with a spinlock held.
-
-config FRAME_POINTER
-	bool "Compile the kernel with frame pointers"
-	help
-	  If you say Y here the resulting kernel image will be slightly larger
-	  and slower, but it will give very useful debugging information.
-	  If you don't debug the kernel, you can say N, but we may not be able
-	  to solve problems without frame pointers.
-
-endmenu
+source "arch/m32r/Kconfig.debug"
 
 source "security/Kconfig"
 
 source "crypto/Kconfig"
 
 source "lib/Kconfig"
-
diff -ruNp a/arch/m32r/Kconfig.debug b/arch/m32r/Kconfig.debug
--- a/arch/m32r/Kconfig.debug	1970-01-01 09:00:00.000000000 +0900
+++ b/arch/m32r/Kconfig.debug	2004-11-17 14:37:02.000000000 +0900
@@ -0,0 +1,34 @@
+menu "Kernel hacking"
+
+source "lib/Kconfig.debug"
+
+config DEBUG_STACKOVERFLOW
+	bool "Check for stack overflows"
+	depends on DEBUG_KERNEL
+
+config DEBUG_STACK_USAGE
+	bool "Stack utilization instrumentation"
+	depends on DEBUG_KERNEL
+	help
+	  Enables the display of the minimum amount of free stack which each
+	  task has ever had available in the sysrq-T and sysrq-P debug output.
+
+	  This option will slow down process creation somewhat.
+
+config DEBUG_PAGEALLOC
+	bool "Page alloc debugging"
+	depends on DEBUG_KERNEL
+	help
+	  Unmap pages from the kernel linear mapping after free_pages().
+	  This results in a large slowdown, but helps to find certain types
+	  of memory corruptions.
+
+config FRAME_POINTER
+	bool "Compile the kernel with frame pointers"
+	help
+	  If you say Y here the resulting kernel image will be slightly larger
+	  and slower, but it will give very useful debugging information.
+	  If you don't debug the kernel, you can say N, but we may not be able
+	  to solve problems without frame pointers.
+
+endmenu
diff -ruNp a/lib/Kconfig.debug b/lib/Kconfig.debug
--- a/lib/Kconfig.debug	2004-11-15 12:17:37.000000000 +0900
+++ b/lib/Kconfig.debug	2004-11-17 14:43:55.000000000 +0900
@@ -1,14 +1,14 @@
 
 config DEBUG_KERNEL
 	bool "Kernel debugging"
-	depends on (ALPHA || ARM || CRIS || H8300 || X86 || IA64 || M68K || M68KNOMMU || MIPS || PARISC || PPC32 || PPC64 || ARCH_S390 || SUPERH || SUPERH64 || SPARC32 || SPARC64 || USERMODE || V850 || X86_64)
+	depends on (ALPHA || ARM || CRIS || H8300 || X86 || IA64 || M32R || M68K || M68KNOMMU || MIPS || PARISC || PPC32 || PPC64 || ARCH_S390 || SUPERH || SUPERH64 || SPARC32 || SPARC64 || USERMODE || V850 || X86_64)
 	help
 	  Say Y here if you are developing drivers or trying to debug and
 	  identify kernel problems.
 
 config MAGIC_SYSRQ
 	bool "Magic SysRq key"
-	depends on DEBUG_KERNEL && (ALPHA || ARM || X86 || IA64 || M68K || MIPS || PARISC || PPC32 || PPC64 || ARCH_S390 || SUPERH || SUPERH64 || SPARC32 || SPARC64 || X86_64 || USERMODE)
+	depends on DEBUG_KERNEL && (ALPHA || ARM || X86 || IA64 || M32R || M68K || MIPS || PARISC || PPC32 || PPC64 || ARCH_S390 || SUPERH || SUPERH64 || SPARC32 || SPARC64 || X86_64 || USERMODE)
 	help
 	  If you say Y here, you will have some control over the system even
 	  if the system crashes for example during kernel debugging (e.g., you
@@ -42,7 +42,7 @@ config SCHEDSTATS
 
 config DEBUG_SLAB
 	bool "Debug memory allocations"
-	depends on DEBUG_KERNEL && (ALPHA || ARM || X86 || IA64 || M68K || MIPS || PARISC || PPC32 || PPC64 || ARCH_S390 || SPARC32 || SPARC64 || USERMODE || X86_64)
+	depends on DEBUG_KERNEL && (ALPHA || ARM || X86 || IA64 || M32R || M68K || MIPS || PARISC || PPC32 || PPC64 || ARCH_S390 || SPARC32 || SPARC64 || USERMODE || X86_64)
 	help
 	  Say Y here to have the kernel do limited verification on memory
 	  allocation as well as poisoning memory on free to catch use of freed
@@ -50,7 +50,7 @@ config DEBUG_SLAB
 
 config DEBUG_SPINLOCK
 	bool "Spinlock debugging"
-	depends on DEBUG_KERNEL && (ALPHA || ARM || X86 || IA64 || MIPS || PARISC || PPC32 || (SUPERH && !SUPERH64) || SPARC32 || SPARC64 || USERMODE || X86_64)
+	depends on DEBUG_KERNEL && (ALPHA || ARM || X86 || IA64 || M32R || MIPS || PARISC || PPC32 || (SUPERH && !SUPERH64) || SPARC32 || SPARC64 || USERMODE || X86_64)
 	help
 	  Say Y here and build SMP to catch missing spinlock initialization
 	  and certain other kinds of spinlock errors commonly made.  This is
@@ -59,7 +59,7 @@ config DEBUG_SPINLOCK
 
 config DEBUG_SPINLOCK_SLEEP
 	bool "Sleep-inside-spinlock checking"
-	depends on DEBUG_KERNEL && (X86 || IA64 || MIPS || PPC32 || PPC64 || ARCH_S390 || SPARC32 || SPARC64 || USERMODE)
+	depends on DEBUG_KERNEL && (X86 || IA64 || M32R || MIPS || PPC32 || PPC64 || ARCH_S390 || SPARC32 || SPARC64 || USERMODE)
 	help
 	  If you say Y here, various routines which may sleep will become very
 	  noisy if they are called with a spinlock held.
@@ -80,7 +80,7 @@ config DEBUG_HIGHMEM
 
 config DEBUG_BUGVERBOSE
 	bool "Verbose BUG() reporting (adds 70K)"
-	depends on DEBUG_KERNEL && (ARM || ARM26 || M68K || SPARC32 || SPARC64)
+	depends on DEBUG_KERNEL && (ARM || ARM26 || M32R || M68K || SPARC32 || SPARC64)
 	help
 	  Say Y here to make BUG() panics output the file name and line number
 	  of the BUG call as well as the EIP and oops trace.  This aids
@@ -88,7 +88,7 @@ config DEBUG_BUGVERBOSE
 
 config DEBUG_INFO
 	bool "Compile the kernel with debug info"
-	depends on DEBUG_KERNEL && (ALPHA || CRIS || X86 || IA64 || M68K || MIPS || PARISC || PPC32 || PPC64 || ARCH_S390 || (SUPERH && !SUPERH64) || SPARC64 || V850 || X86_64)
+	depends on DEBUG_KERNEL && (ALPHA || CRIS || X86 || IA64 || M32R || M68K || MIPS || PARISC || PPC32 || PPC64 || ARCH_S390 || (SUPERH && !SUPERH64) || SPARC64 || V850 || X86_64)
 	help
           If you say Y here the resulting kernel image will include
 	  debugging info resulting in a larger kernel image.

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
