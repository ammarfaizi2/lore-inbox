Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262772AbUDPIqR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 04:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262773AbUDPIqR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 04:46:17 -0400
Received: from [62.241.33.80] ([62.241.33.80]:26387 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S262772AbUDPIp7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 04:45:59 -0400
From: Marc-Christian Petersen <m.c.p@kernel.linux-systeme.com>
Organization: Linux-Systeme GmbH
To: linux-kernel@vger.kernel.org
Subject: [PATCH] use Kconfig.debug (v3-proposed) (was: Re: [PATCH] use Kconfig.debug (v2))
Date: Fri, 16 Apr 2004 10:42:21 +0200
User-Agent: KMail/1.6.1
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, akpm <akpm@osdl.org>
References: <20040415220338.3e351293.rddunlap@osdl.org>
In-Reply-To: <20040415220338.3e351293.rddunlap@osdl.org>
X-Operating-System: Linux 2.6.4-wolk2.3 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200404161042.21164@WOLK>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_tx5fArZa181w8aS"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_tx5fArZa181w8aS
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Friday 16 April 2004 07:03, Randy.Dunlap wrote:

Hi Randy,

> Use generic lib/Kconfig.debug and arch-specific arch/*/Kconfig.debug.
> Move KALLSYMS to generic debugging menu.
> Changes from version 1:
> 1.  remove global !CRIS && !H8300 from lib/Kconfig.debug;
> 2.  for CRIS and H8300, don't source lib/Kconfig.debug (not used);
> 3.  corrected several lib/Kconfig.debug ARCH usages;
> 4.  small change in generic debug menu order (moved SPINLOCK
> 	options together);
> Ready for testing IMO.  More comments?

yes. I'd like to see it this way:

Changes from version 2:
1.  Early Printk should not depend on EMBEDDED
2.  change "if foobar" to "depend on"
3.  remove endif's superfluous because of 2.
4.  Move KALLSYMS some places lower
5.  Add some more "depend on DEBUG_KERNEL" to indent the menu
6.  Remove trailing new lines in some arch specific Kconfig.debug
7.  move depends on DEBUG_KERNEL for arch/m68k/Kconfig.debug to
    the menu so you only see that menu if you select DEBUG_KERNEL
    You can't select anything there if DEBUG_KERNEL is N.
8.  Whitespace cleanups

Comments?


Everything else is fine with me.

All-in-One v3-proposed is here:
 http://www.kernel.org/pub/linux/kernel/people/mcp/linux-2.6/kconf-debug-v3-proposed-2.6.6-rc1.patch

Update from v2 to v3-proposed is here too:
 http://www.kernel.org/pub/linux/kernel/people/mcp/linux-2.6/kconf-debug-v2-to-v3-proposed-2.6.6-rc1.patch


ciao, Marc

--Boundary-00=_tx5fArZa181w8aS
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="kconf-debug-v2-to-v3-proposed-2.6.6-rc1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="kconf-debug-v2-to-v3-proposed-2.6.6-rc1.patch"

diff -Naurp linux-2.6.6-rc1-Kconfig.debug.v2/arch/cris/Kconfig.debug linux-2.6.6-rc1-Kconfig.debug.v3-proposed/arch/cris/Kconfig.debug
--- linux-2.6.6-rc1-Kconfig.debug.v2/arch/cris/Kconfig.debug	2004-04-16 09:52:20.000000000 +0200
+++ linux-2.6.6-rc1-Kconfig.debug.v3-proposed/arch/cris/Kconfig.debug	2004-04-16 10:17:52.000000000 +0200
@@ -1,4 +1,3 @@
-
 menu "CRIS kernel hacking"
 
 #bool 'Debug kmalloc/kfree' CONFIG_DEBUG_MALLOC
diff -Naurp linux-2.6.6-rc1-Kconfig.debug.v2/arch/h8300/Kconfig.debug linux-2.6.6-rc1-Kconfig.debug.v3-proposed/arch/h8300/Kconfig.debug
--- linux-2.6.6-rc1-Kconfig.debug.v2/arch/h8300/Kconfig.debug	2004-04-16 09:52:20.000000000 +0200
+++ linux-2.6.6-rc1-Kconfig.debug.v3-proposed/arch/h8300/Kconfig.debug	2004-04-16 10:18:19.000000000 +0200
@@ -1,4 +1,3 @@
-
 menu "H8300 kernel hacking"
 
 config FULLDEBUG
diff -Naurp linux-2.6.6-rc1-Kconfig.debug.v2/arch/i386/Kconfig.debug linux-2.6.6-rc1-Kconfig.debug.v3-proposed/arch/i386/Kconfig.debug
--- linux-2.6.6-rc1-Kconfig.debug.v2/arch/i386/Kconfig.debug	2004-04-16 09:52:20.000000000 +0200
+++ linux-2.6.6-rc1-Kconfig.debug.v3-proposed/arch/i386/Kconfig.debug	2004-04-16 10:18:30.000000000 +0200
@@ -1,4 +1,3 @@
-
 menu "X86 kernel hacking"
 
 config X86_FIND_SMP_CONFIG
diff -Naurp linux-2.6.6-rc1-Kconfig.debug.v2/arch/ia64/Kconfig.debug linux-2.6.6-rc1-Kconfig.debug.v3-proposed/arch/ia64/Kconfig.debug
--- linux-2.6.6-rc1-Kconfig.debug.v2/arch/ia64/Kconfig.debug	2004-04-16 09:52:20.000000000 +0200
+++ linux-2.6.6-rc1-Kconfig.debug.v3-proposed/arch/ia64/Kconfig.debug	2004-04-16 10:18:56.000000000 +0200
@@ -1,4 +1,3 @@
-
 menu "IA64 kernel hacking"
 
 choice
diff -Naurp linux-2.6.6-rc1-Kconfig.debug.v2/arch/m68k/Kconfig.debug linux-2.6.6-rc1-Kconfig.debug.v3-proposed/arch/m68k/Kconfig.debug
--- linux-2.6.6-rc1-Kconfig.debug.v2/arch/m68k/Kconfig.debug	2004-04-16 09:52:20.000000000 +0200
+++ linux-2.6.6-rc1-Kconfig.debug.v3-proposed/arch/m68k/Kconfig.debug	2004-04-16 10:09:59.000000000 +0200
@@ -1,9 +1,8 @@
-
 menu "M68K kernel hacking"
+	depends on DEBUG_KERNEL
 
 config DEBUG_BUGVERBOSE
 	bool "Verbose BUG() reporting"
-	depends on DEBUG_KERNEL
 
 endmenu
 
diff -Naurp linux-2.6.6-rc1-Kconfig.debug.v2/arch/m68knommu/Kconfig.debug linux-2.6.6-rc1-Kconfig.debug.v3-proposed/arch/m68knommu/Kconfig.debug
--- linux-2.6.6-rc1-Kconfig.debug.v2/arch/m68knommu/Kconfig.debug	2004-04-16 09:52:20.000000000 +0200
+++ linux-2.6.6-rc1-Kconfig.debug.v3-proposed/arch/m68knommu/Kconfig.debug	2004-04-16 10:19:19.000000000 +0200
@@ -1,4 +1,3 @@
-
 menu "M68K-nommu kernel hacking"
 
 config FULLDEBUG
diff -Naurp linux-2.6.6-rc1-Kconfig.debug.v2/arch/mips/Kconfig.debug linux-2.6.6-rc1-Kconfig.debug.v3-proposed/arch/mips/Kconfig.debug
--- linux-2.6.6-rc1-Kconfig.debug.v2/arch/mips/Kconfig.debug	2004-04-16 09:52:20.000000000 +0200
+++ linux-2.6.6-rc1-Kconfig.debug.v3-proposed/arch/mips/Kconfig.debug	2004-04-16 10:19:28.000000000 +0200
@@ -1,4 +1,3 @@
-
 menu "MIPS kernel hacking"
 
 config CROSSCOMPILE
diff -Naurp linux-2.6.6-rc1-Kconfig.debug.v2/arch/parisc/Kconfig.debug linux-2.6.6-rc1-Kconfig.debug.v3-proposed/arch/parisc/Kconfig.debug
--- linux-2.6.6-rc1-Kconfig.debug.v2/arch/parisc/Kconfig.debug	2004-04-16 09:52:20.000000000 +0200
+++ linux-2.6.6-rc1-Kconfig.debug.v3-proposed/arch/parisc/Kconfig.debug	2004-04-16 10:10:54.000000000 +0200
@@ -1,4 +1,3 @@
-
 menu "PA-RISC kernel hacking"
 
 endmenu
diff -Naurp linux-2.6.6-rc1-Kconfig.debug.v2/arch/ppc/Kconfig.debug linux-2.6.6-rc1-Kconfig.debug.v3-proposed/arch/ppc/Kconfig.debug
--- linux-2.6.6-rc1-Kconfig.debug.v2/arch/ppc/Kconfig.debug	2004-04-16 09:52:20.000000000 +0200
+++ linux-2.6.6-rc1-Kconfig.debug.v3-proposed/arch/ppc/Kconfig.debug	2004-04-16 10:19:38.000000000 +0200
@@ -1,4 +1,3 @@
-
 menu "PPC kernel hacking"
 
 config KGDB
diff -Naurp linux-2.6.6-rc1-Kconfig.debug.v2/arch/ppc64/Kconfig.debug linux-2.6.6-rc1-Kconfig.debug.v3-proposed/arch/ppc64/Kconfig.debug
--- linux-2.6.6-rc1-Kconfig.debug.v2/arch/ppc64/Kconfig.debug	2004-04-16 09:52:20.000000000 +0200
+++ linux-2.6.6-rc1-Kconfig.debug.v3-proposed/arch/ppc64/Kconfig.debug	2004-04-16 10:19:41.000000000 +0200
@@ -1,4 +1,3 @@
-
 menu "PPC64 kernel hacking"
 
 config DEBUGGER
diff -Naurp linux-2.6.6-rc1-Kconfig.debug.v2/arch/sh/Kconfig.debug linux-2.6.6-rc1-Kconfig.debug.v3-proposed/arch/sh/Kconfig.debug
--- linux-2.6.6-rc1-Kconfig.debug.v2/arch/sh/Kconfig.debug	2004-04-16 09:52:20.000000000 +0200
+++ linux-2.6.6-rc1-Kconfig.debug.v3-proposed/arch/sh/Kconfig.debug	2004-04-16 10:19:52.000000000 +0200
@@ -1,4 +1,3 @@
-
 menu "SuperH kernel hacking"
 
 config SH_STANDARD_BIOS
diff -Naurp linux-2.6.6-rc1-Kconfig.debug.v2/arch/sparc64/Kconfig.debug linux-2.6.6-rc1-Kconfig.debug.v3-proposed/arch/sparc64/Kconfig.debug
--- linux-2.6.6-rc1-Kconfig.debug.v2/arch/sparc64/Kconfig.debug	2004-04-16 09:52:20.000000000 +0200
+++ linux-2.6.6-rc1-Kconfig.debug.v3-proposed/arch/sparc64/Kconfig.debug	2004-04-16 10:20:03.000000000 +0200
@@ -1,4 +1,3 @@
-
 menu "UltraSPARC kernel hacking"
 
 config DEBUG_BUGVERBOSE
diff -Naurp linux-2.6.6-rc1-Kconfig.debug.v2/arch/um/Kconfig.debug linux-2.6.6-rc1-Kconfig.debug.v3-proposed/arch/um/Kconfig.debug
--- linux-2.6.6-rc1-Kconfig.debug.v2/arch/um/Kconfig.debug	2004-04-16 09:52:20.000000000 +0200
+++ linux-2.6.6-rc1-Kconfig.debug.v3-proposed/arch/um/Kconfig.debug	2004-04-16 10:20:11.000000000 +0200
@@ -1,4 +1,3 @@
-
 menu "UML kernel hacking"
 
 config PT_PROXY
diff -Naurp linux-2.6.6-rc1-Kconfig.debug.v2/arch/v850/Kconfig.debug linux-2.6.6-rc1-Kconfig.debug.v3-proposed/arch/v850/Kconfig.debug
--- linux-2.6.6-rc1-Kconfig.debug.v2/arch/v850/Kconfig.debug	2004-04-16 09:52:20.000000000 +0200
+++ linux-2.6.6-rc1-Kconfig.debug.v3-proposed/arch/v850/Kconfig.debug	2004-04-16 10:20:22.000000000 +0200
@@ -1,4 +1,3 @@
-
 menu "V850 kernel hacking"
 
 config NO_KERNEL_MSG
diff -Naurp linux-2.6.6-rc1-Kconfig.debug.v2/arch/x86_64/Kconfig.debug linux-2.6.6-rc1-Kconfig.debug.v3-proposed/arch/x86_64/Kconfig.debug
--- linux-2.6.6-rc1-Kconfig.debug.v2/arch/x86_64/Kconfig.debug	2004-04-16 09:52:20.000000000 +0200
+++ linux-2.6.6-rc1-Kconfig.debug.v3-proposed/arch/x86_64/Kconfig.debug	2004-04-16 10:20:29.000000000 +0200
@@ -1,4 +1,3 @@
-
 menu "X86-64 kernel hacking"
 
 # !SMP for now because the context switch early causes GPF in segment reloading
diff -Naurp linux-2.6.6-rc1-Kconfig.debug.v2/lib/Kconfig.debug linux-2.6.6-rc1-Kconfig.debug.v3-proposed/lib/Kconfig.debug
--- linux-2.6.6-rc1-Kconfig.debug.v2/lib/Kconfig.debug	2004-04-16 09:52:20.000000000 +0200
+++ linux-2.6.6-rc1-Kconfig.debug.v3-proposed/lib/Kconfig.debug	2004-04-16 10:21:15.000000000 +0200
@@ -1,3 +1,4 @@
+# Generic debug menu
 
 menu "Generic kernel hacking"
 
@@ -22,18 +23,9 @@ config MAGIC_SYSRQ
 	  keys are documented in <file:Documentation/sysrq.txt>. Don't say Y
 	  unless you really know what this hack does.
 
-config KALLSYMS
-	 bool "Load all symbols for debugging/kksymoops" if EMBEDDED
-	 default y if !ARCH_S390
-	 help
-	   Say Y here to let the kernel print out symbolic crash information and
-	   symbolic stack backtraces. This increases the size of the kernel
-	   somewhat, as all symbols have to be loaded into the kernel image.
-
-if X86 || X86_64 || MACH_DECSTATION || ALPHA_GENERIC || ALPHA_SRM || PPC64
-
 config EARLY_PRINTK
-	bool "Early printk" if EMBEDDED
+	bool "Early printk"
+	depends on DEBUG_KERNEL && (X86 || X86_64 || MACH_DECSTATION || ALPHA_GENERIC || ALPHA_SRM || PPC64)
 	default y
 	help
 	  Write kernel log output directly into the VGA buffer or to a serial
@@ -45,8 +37,6 @@ config EARLY_PRINTK
 	  with klogd/syslogd or the X server. You should normally N here,
 	  unless you want to debug such a crash.
 
-endif
-
 config DEBUG_STACKOVERFLOW
 	bool "Check for stack overflows"
 	depends on DEBUG_KERNEL && !ALPHA && !M68K && !S390 && !SUPERH && !V850
@@ -99,6 +89,15 @@ config DEBUG_HIGHMEM
 	  This options enables addition error checking for high memory systems.
 	  Disable for production systems.
 
+config KALLSYMS
+	bool "Load all symbols for debugging/kksymoops"
+	depends on DEBUG_KERNEL
+	default y if !ARCH_S390
+	help
+	  Say Y here to let the kernel print out symbolic crash information and
+	  symbolic stack backtraces. This increases the size of the kernel
+	  somewhat, as all symbols have to be loaded into the kernel image.
+
 config DEBUG_INFO
 	bool "Compile the kernel with debug info"
 	depends on DEBUG_KERNEL && !SUPERH
@@ -109,19 +108,19 @@ config DEBUG_INFO
 	  Say Y here only if you plan to use gdb to debug the kernel.
 	  If you don't debug the kernel, you can say N.
 	  
-if !ARM && !ARM26 && !X86_64 && !S390 && !V850
 config FRAME_POINTER
 	bool "Compile the kernel with frame pointers"
+	depends on DEBUG_KERNEL && (!ARM && !ARM26 && !X86_64 && !S390 && !V850)
 	default y if (SUPERH && KGDB) || (USERMODE && DEBUG_INFO)
 	help
 	  If you say Y here the resulting kernel image will be slightly larger
 	  and slower, but it will give very useful debugging information.
 	  If you don't debug the kernel, you can say N, but we may not be able
 	  to solve problems without frame pointers.
-endif
-if X86_64
+
 config FRAME_POINTER
 	bool "Compile the kernel with frame pointers"
+	depends on DEBUG_KERNEL && X86_64
 	help
 	  If you say Y here the resulting kernel image will be slightly larger
 	  and slower, but it will give very useful debugging information.
@@ -132,10 +131,10 @@ config FRAME_POINTER
 	  the x86-64 kernel doesn't ensure a consistent
 	  frame pointer through inline assembly (semaphores etc.)
 	  Normally you should say N.
-endif
 
 config 4KSTACKS
-	bool "Use 4Kb for kernel stacks instead of 8Kb" if !M68K && !SUPERH && !V850
+	bool "Use 4Kb for kernel stacks instead of 8Kb"
+	depends on !M68K && !SUPERH && !V850
 	help
 	  If you say Y here the kernel will use a 4Kb stacksize for the
 	  kernel stack attached to each process/thread. This facilitates

--Boundary-00=_tx5fArZa181w8aS--
