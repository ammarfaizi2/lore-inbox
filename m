Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261586AbVA2WXo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbVA2WXo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 17:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbVA2WW4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 17:22:56 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:26287 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261579AbVA2WTy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 17:19:54 -0500
Date: Sat, 29 Jan 2005 23:19:47 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 4/8] Kconfig: cleanup kernel hacking menu
Message-ID: <Pine.LNX.4.61.0501292319300.7644@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This properly indents the kernel hacking menu.
Move LOG_BUF_SHIFT into kernel hacking menu (it already depended on DEBUG_KERNEL).
Add DEBUG_KERNEL dependency to EARLY_PRINTK, DEBUG_PREEMPT and FRAME_POINTER.
Remove overlong dependency, which included practically every arch.
Merge the two MAGIC_SYSRQ menu entries.
Remove unnecessary "default n" options.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 arch/i386/Kconfig.debug |    3 +-
 init/Kconfig            |   20 ------------------
 lib/Kconfig.debug       |   53 +++++++++++++++++++++++++++---------------------
 3 files changed, 32 insertions(+), 44 deletions(-)

Index: linux-2.6.11/init/Kconfig
===================================================================
--- linux-2.6.11.orig/init/Kconfig	2005-01-29 22:50:43.457937076 +0100
+++ linux-2.6.11/init/Kconfig	2005-01-29 22:56:22.470544173 +0100
@@ -157,7 +157,6 @@ config SYSCTL
 config AUDIT
 	bool "Auditing support"
 	default y if SECURITY_SELINUX
-	default n
 	help
 	  Enable auditing infrastructure that can be used with another
 	  kernel subsystem, such as SELinux (which requires this for
@@ -168,29 +167,11 @@ config AUDITSYSCALL
 	bool "Enable system-call auditing support"
 	depends on AUDIT && (X86 || PPC64 || ARCH_S390 || IA64)
 	default y if SECURITY_SELINUX
-	default n
 	help
 	  Enable low-overhead system-call auditing infrastructure that
 	  can be used independently or with another kernel subsystem,
 	  such as SELinux.
 
-config LOG_BUF_SHIFT
-	int "Kernel log buffer size (16 => 64KB, 17 => 128KB)" if DEBUG_KERNEL
-	range 12 21
-	default 17 if ARCH_S390
-	default 16 if X86_NUMAQ || IA64
-	default 15 if SMP
-	default 14
-	help
-	  Select kernel log buffer size as a power of 2.
-	  Defaults and Examples:
-	  	     17 => 128 KB for S/390
-		     16 => 64 KB for x86 NUMAQ or IA-64
-	             15 => 32 KB for SMP
-	             14 => 16 KB for uniprocessor
-		     13 =>  8 KB
-		     12 =>  4 KB
-
 config HOTPLUG
 	bool "Support for hot-pluggable devices" if !ARCH_S390
 	default ARCH_S390
@@ -304,7 +285,6 @@ config EPOLL
 config CC_OPTIMIZE_FOR_SIZE
 	bool "Optimize for size" if EMBEDDED
 	default y if ARM || H8300
-	default n
 	help
 	  Enabling this option will pass "-Os" instead of "-O2" to gcc
 	  resulting in a smaller kernel.
Index: linux-2.6.11/arch/i386/Kconfig.debug
===================================================================
--- linux-2.6.11.orig/arch/i386/Kconfig.debug	2005-01-29 22:50:43.458936904 +0100
+++ linux-2.6.11/arch/i386/Kconfig.debug	2005-01-29 22:56:22.470544173 +0100
@@ -3,7 +3,7 @@ menu "Kernel hacking"
 source "lib/Kconfig.debug"
 
 config EARLY_PRINTK
-	bool "Early printk" if EMBEDDED
+	bool "Early printk" if EMBEDDED && DEBUG_KERNEL
 	default y
 	help
 	  Write kernel log output directly into the VGA buffer or to a serial
@@ -48,6 +48,7 @@ config DEBUG_PAGEALLOC
 
 config 4KSTACKS
 	bool "Use 4Kb for kernel stacks instead of 8Kb"
+	depends on DEBUG_KERNEL
 	help
 	  If you say Y here the kernel will use a 4Kb stacksize for the
 	  kernel stack attached to each process/thread. This facilitates
Index: linux-2.6.11/lib/Kconfig.debug
===================================================================
--- linux-2.6.11.orig/lib/Kconfig.debug	2005-01-29 22:50:43.458936904 +0100
+++ linux-2.6.11/lib/Kconfig.debug	2005-01-29 22:56:22.471544001 +0100
@@ -1,14 +1,13 @@
 
 config DEBUG_KERNEL
 	bool "Kernel debugging"
-	depends on (ALPHA || ARM || CRIS || H8300 || X86 || IA64 || M32R || M68K || M68KNOMMU || MIPS || PARISC || PPC32 || PPC64 || ARCH_S390 || SUPERH || SUPERH64 || SPARC32 || SPARC64 || USERMODE || V850 || X86_64)
 	help
 	  Say Y here if you are developing drivers or trying to debug and
 	  identify kernel problems.
 
 config MAGIC_SYSRQ
 	bool "Magic SysRq key"
-	depends on DEBUG_KERNEL && (ALPHA || ARM || X86 || IA64 || M32R || M68K || MIPS || PARISC || PPC32 || PPC64 || ARCH_S390 || SUPERH || SUPERH64 || SPARC32 || SPARC64 || X86_64 || USERMODE)
+	depends on DEBUG_KERNEL
 	help
 	  If you say Y here, you will have some control over the system even
 	  if the system crashes for example during kernel debugging (e.g., you
@@ -20,12 +19,22 @@ config MAGIC_SYSRQ
 	  keys are documented in <file:Documentation/sysrq.txt>. Don't say Y
 	  unless you really know what this hack does.
 
-config MAGIC_SYSRQ
-	bool "Magic SysRq key"
-	depends on DEBUG_KERNEL && (H8300 || M68KNOMMU || V850)
-	help
-	  Enables console device to interpret special characters as
-	  commands to dump state information.
+config LOG_BUF_SHIFT
+	int "Kernel log buffer size (16 => 64KB, 17 => 128KB)" if DEBUG_KERNEL
+	range 12 21
+	default 17 if ARCH_S390
+	default 16 if X86_NUMAQ || IA64
+	default 15 if SMP
+	default 14
+	help
+	  Select kernel log buffer size as a power of 2.
+	  Defaults and Examples:
+	  	     17 => 128 KB for S/390
+		     16 => 64 KB for x86 NUMAQ or IA-64
+	             15 => 32 KB for SMP
+	             14 => 16 KB for uniprocessor
+		     13 =>  8 KB
+		     12 =>  4 KB
 
 config SCHEDSTATS
 	bool "Collect scheduler statistics"
@@ -41,7 +50,7 @@ config SCHEDSTATS
 
 config DEBUG_SLAB
 	bool "Debug memory allocations"
-	depends on DEBUG_KERNEL && (ALPHA || ARM || X86 || IA64 || M32R || M68K || MIPS || PARISC || PPC32 || PPC64 || ARCH_S390 || SPARC32 || SPARC64 || USERMODE || X86_64)
+	depends on DEBUG_KERNEL
 	help
 	  Say Y here to have the kernel do limited verification on memory
 	  allocation as well as poisoning memory on free to catch use of freed
@@ -49,7 +58,7 @@ config DEBUG_SLAB
 
 config DEBUG_PREEMPT
 	bool "Debug preemptible kernel"
-	depends on PREEMPT
+	depends on DEBUG_KERNEL && PREEMPT
 	default y
 	help
 	  If you say Y here then the kernel will use a debug variant of the
@@ -59,7 +68,7 @@ config DEBUG_PREEMPT
 
 config DEBUG_SPINLOCK
 	bool "Spinlock debugging"
-	depends on DEBUG_KERNEL && (ALPHA || ARM || X86 || IA64 || M32R || MIPS || PARISC || PPC32 || (SUPERH && !SUPERH64) || SPARC32 || SPARC64 || USERMODE || X86_64)
+	depends on DEBUG_KERNEL
 	help
 	  Say Y here and build SMP to catch missing spinlock initialization
 	  and certain other kinds of spinlock errors commonly made.  This is
@@ -68,7 +77,7 @@ config DEBUG_SPINLOCK
 
 config DEBUG_SPINLOCK_SLEEP
 	bool "Sleep-inside-spinlock checking"
-	depends on DEBUG_KERNEL && (X86 || IA64 || M32R || MIPS || PPC32 || PPC64 || ARCH_S390 || SPARC32 || SPARC64 || USERMODE)
+	depends on DEBUG_KERNEL
 	help
 	  If you say Y here, various routines which may sleep will become very
 	  noisy if they are called with a spinlock held.
@@ -82,7 +91,7 @@ config DEBUG_KOBJECT
 
 config DEBUG_HIGHMEM
 	bool "Highmem debugging"
-	depends on DEBUG_KERNEL && HIGHMEM && (X86 || PPC32 || MIPS || SPARC32)
+	depends on DEBUG_KERNEL && HIGHMEM
 	help
 	  This options enables addition error checking for high memory systems.
 	  Disable for production systems.
@@ -98,7 +107,7 @@ config DEBUG_BUGVERBOSE
 
 config DEBUG_INFO
 	bool "Compile the kernel with debug info"
-	depends on DEBUG_KERNEL && (ALPHA || CRIS || X86 || IA64 || M32R || M68K || MIPS || PARISC || PPC32 || PPC64 || ARCH_S390 || (SUPERH && !SUPERH64) || SPARC64 || V850 || X86_64)
+	depends on DEBUG_KERNEL
 	help
           If you say Y here the resulting kernel image will include
 	  debugging info resulting in a larger kernel image.
@@ -109,13 +118,13 @@ config DEBUG_INFO
 	bool "Enable kernel debugging symbols"
 	depends on DEBUG_KERNEL && USERMODE
 	help
-        When this is enabled, the User-Mode Linux binary will include
-        debugging symbols.  This enlarges the binary by a few megabytes,
-        but aids in tracking down kernel problems in UML.  It is required
-        if you intend to do any kernel development.
+	  When this is enabled, the User-Mode Linux binary will include
+	  debugging symbols.  This enlarges the binary by a few megabytes,
+	  but aids in tracking down kernel problems in UML.  It is required
+	  if you intend to do any kernel development.
 
-        If you're truly short on disk space or don't expect to report any
-        bugs back to the UML developers, say N, otherwise say Y.
+	  If you're truly short on disk space or don't expect to report any
+	  bugs back to the UML developers, say N, otherwise say Y.
 
 config DEBUG_IOREMAP
 	bool "Enable ioremap() debugging"
@@ -150,13 +159,11 @@ config PAGE_OWNER
 
 	  If unsure, say N.
 
-if !X86_64
 config FRAME_POINTER
 	bool "Compile the kernel with frame pointers"
-	depends on X86 || CRIS || M68KNOMMU
+	depends on DEBUG_KERNEL && ((X86 && !X86_64) || CRIS || M68K || M68KNOMMU)
 	help
 	  If you say Y here the resulting kernel image will be slightly larger
 	  and slower, but it will give very useful debugging information.
 	  If you don't debug the kernel, you can say N, but we may not be able
 	  to solve problems without frame pointers.
-endif
