Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263805AbUDPV33 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 17:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263829AbUDPV32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 17:29:28 -0400
Received: from fw.osdl.org ([65.172.181.6]:37526 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263805AbUDPV1V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 17:27:21 -0400
Date: Fri, 16 Apr 2004 14:22:06 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: lkml <linux-kernel@vger.kernel.org>
Cc: m.c.p@kernel.linux-systeme.com, akpm@osdl.org
Subject: Re: [PATCH] use Kconfig.debug (v3-proposed) (was: Re: [PATCH] use
 Kconfig.debug (v2))
Message-Id: <20040416142206.02848d89.rddunlap@osdl.org>
In-Reply-To: <20040416110149.3e353333.rddunlap@osdl.org>
References: <20040415220338.3e351293.rddunlap@osdl.org>
	<200404161042.21164@WOLK>
	<20040416110149.3e353333.rddunlap@osdl.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Apr 2004 11:01:49 -0700 Randy.Dunlap wrote:

| On Fri, 16 Apr 2004 10:42:21 +0200 Marc-Christian Petersen wrote:
| 
| | On Friday 16 April 2004 07:03, Randy.Dunlap wrote:
| | 
| | Hi Randy,
| | 
| | > Use generic lib/Kconfig.debug and arch-specific arch/*/Kconfig.debug.
| | > Move KALLSYMS to generic debugging menu.
| | > Changes from version 1:
| | > 1.  remove global !CRIS && !H8300 from lib/Kconfig.debug;
| | > 2.  for CRIS and H8300, don't source lib/Kconfig.debug (not used);
| | > 3.  corrected several lib/Kconfig.debug ARCH usages;
| | > 4.  small change in generic debug menu order (moved SPINLOCK
| | > 	options together);
| | > Ready for testing IMO.  More comments?
| | 
| | yes. I'd like to see it this way:
| | 
| | Changes from version 2:
| | 1.  Early Printk should not depend on EMBEDDED
| | 2.  change "if foobar" to "depend on"
| 
| These mean the same thing to the config software, so I don't
| care which way it's done.
| 
| | 3.  remove endif's superfluous because of 2.
| | 4.  Move KALLSYMS some places lower
| 
| Then let's move KALLSYMS to the very end of the menu.
| At the very least it should be after the last "depends on
| DEBUG_KERNEL" entry, but it still interferes with that
| dependency chain as either of us has it.
| 
| | 5.  Add some more "depend on DEBUG_KERNEL" to indent the menu
| | 6.  Remove trailing new lines in some arch specific Kconfig.debug
| | 7.  move depends on DEBUG_KERNEL for arch/m68k/Kconfig.debug to
| |     the menu so you only see that menu if you select DEBUG_KERNEL
| |     You can't select anything there if DEBUG_KERNEL is N.
| 
| Maybe do the same for parisc and s390, so that they don't show up
| at all?
| 
| sparc is the same way:  only entry(s) depend on DEBUG_KERNEL.
| Same for x86_64.
| 
| However, I did it that way for "future-proofing".  Makes it
| easy for someone to add an entry without having to think about
| higher-level parameters/values etc.
| 
| | 8.  Whitespace cleanups
| | 
| | Comments?
| 
| Yes... and you?
| 
| 
| | Everything else is fine with me.
| | 
| | All-in-One v3-proposed is here:
| |  http://www.kernel.org/pub/linux/kernel/people/mcp/linux-2.6/kconf-debug-v3-proposed-2.6.6-rc1.patch
| | 
| | Update from v2 to v3-proposed is here too:
| |  http://www.kernel.org/pub/linux/kernel/people/mcp/linux-2.6/kconf-debug-v2-to-v3-proposed-2.6.6-rc1.patch


Here is my v2-to-v3 update patch, incorporating Marc's suggestions
with a few small additions as mentioned in my comments above.

Update patch is below and is also available at:
http://developer.osdl.org/rddunlap/patches/kconf_debug_v2v3.patch

This update patch applies to:
http://developer.osdl.org/rddunlap/patches/kconf_debug_266rc1.patch
(which applies to 2.6.6-rc1).

--
~Randy
"We have met the enemy and he is us."  -- Pogo (by Walt Kelly)
(Again.  Sometimes I think ln -s /usr/src/linux/.config .signature)


// merge changes from Marc (mcp)
// applies to 2.6.6-rc1 + http://developer.osdl.org/rddunlap/patches/kconf_debug_266rc1.patch
// This file is:  http://developer.osdl.org/rddunlap/patches/kconf_debug_v2v3.patch

Changes from version 2:
1.  Early Printk should not depend on EMBEDDED
2.  change "if foobar" to "depend on"
3.  remove endif's superfluous because of 2.
4.  Move KALLSYMS some places lower (last in generic menu)
5.  Add some more "depend on DEBUG_KERNEL" to indent the menu
6.  Remove trailing new lines in some arch specific Kconfig.debug
7.  move depends on DEBUG_KERNEL for arch/{m68k,parisc,s390,sparc}/Kconfig.debug
    to the menu so you only see that menu if you select DEBUG_KERNEL.
    You can't select anything there if DEBUG_KERNEL is N.
8.  Whitespace cleanups


diffstat:=
 arch/cris/Kconfig.debug      |    1 -
 arch/h8300/Kconfig.debug     |    1 -
 arch/i386/Kconfig.debug      |    1 -
 arch/ia64/Kconfig.debug      |    1 -
 arch/m68k/Kconfig.debug      |    3 +--
 arch/m68knommu/Kconfig.debug |    1 -
 arch/mips/Kconfig.debug      |    1 -
 arch/parisc/Kconfig.debug    |    2 +-
 arch/ppc/Kconfig.debug       |    1 -
 arch/ppc64/Kconfig.debug     |    1 -
 arch/s390/Kconfig.debug      |    1 +
 arch/sh/Kconfig.debug        |    1 -
 arch/sparc/Kconfig.debug     |    2 +-
 arch/sparc64/Kconfig.debug   |    1 -
 arch/um/Kconfig.debug        |    1 -
 arch/v850/Kconfig.debug      |    1 -
 arch/x86_64/Kconfig.debug    |    1 -
 lib/Kconfig.debug            |   35 +++++++++++++++++------------------
 18 files changed, 21 insertions(+), 35 deletions(-)


diff -Naurp ./arch/sparc/Kconfig.debug~mcp_v2v3 ./arch/sparc/Kconfig.debug
--- ./arch/sparc/Kconfig.debug~mcp_v2v3	2004-04-15 14:00:56.000000000 -0700
+++ ./arch/sparc/Kconfig.debug	2004-04-16 14:22:14.000000000 -0700
@@ -1,9 +1,9 @@
 
 menu "SPARC kernel hacking"
+	depends on DEBUG_KERNEL
 
 config DEBUG_BUGVERBOSE
 	bool "Verbose BUG() reporting (adds 70K)"
-	depends on DEBUG_KERNEL
 	help
 	  Say Y here to make BUG() panics output the file name and line number
 	  of the BUG call as well as the EIP and oops trace.  This aids
diff -Naurp ./arch/sparc64/Kconfig.debug~mcp_v2v3 ./arch/sparc64/Kconfig.debug
--- ./arch/sparc64/Kconfig.debug~mcp_v2v3	2004-04-15 14:00:56.000000000 -0700
+++ ./arch/sparc64/Kconfig.debug	2004-04-16 14:16:54.000000000 -0700
@@ -1,4 +1,3 @@
-
 menu "UltraSPARC kernel hacking"
 
 config DEBUG_BUGVERBOSE
diff -Naurp ./arch/i386/Kconfig.debug~mcp_v2v3 ./arch/i386/Kconfig.debug
--- ./arch/i386/Kconfig.debug~mcp_v2v3	2004-04-15 14:00:56.000000000 -0700
+++ ./arch/i386/Kconfig.debug	2004-04-16 14:16:54.000000000 -0700
@@ -1,4 +1,3 @@
-
 menu "X86 kernel hacking"
 
 config X86_FIND_SMP_CONFIG
diff -Naurp ./arch/sh/Kconfig.debug~mcp_v2v3 ./arch/sh/Kconfig.debug
--- ./arch/sh/Kconfig.debug~mcp_v2v3	2004-04-15 14:00:56.000000000 -0700
+++ ./arch/sh/Kconfig.debug	2004-04-16 14:16:54.000000000 -0700
@@ -1,4 +1,3 @@
-
 menu "SuperH kernel hacking"
 
 config SH_STANDARD_BIOS
diff -Naurp ./arch/ppc/Kconfig.debug~mcp_v2v3 ./arch/ppc/Kconfig.debug
--- ./arch/ppc/Kconfig.debug~mcp_v2v3	2004-04-15 14:00:56.000000000 -0700
+++ ./arch/ppc/Kconfig.debug	2004-04-16 14:16:54.000000000 -0700
@@ -1,4 +1,3 @@
-
 menu "PPC kernel hacking"
 
 config KGDB
diff -Naurp ./arch/mips/Kconfig.debug~mcp_v2v3 ./arch/mips/Kconfig.debug
--- ./arch/mips/Kconfig.debug~mcp_v2v3	2004-04-15 14:00:56.000000000 -0700
+++ ./arch/mips/Kconfig.debug	2004-04-16 14:16:54.000000000 -0700
@@ -1,4 +1,3 @@
-
 menu "MIPS kernel hacking"
 
 config CROSSCOMPILE
diff -Naurp ./arch/m68knommu/Kconfig.debug~mcp_v2v3 ./arch/m68knommu/Kconfig.debug
--- ./arch/m68knommu/Kconfig.debug~mcp_v2v3	2004-04-15 14:00:56.000000000 -0700
+++ ./arch/m68knommu/Kconfig.debug	2004-04-16 14:16:54.000000000 -0700
@@ -1,4 +1,3 @@
-
 menu "M68K-nommu kernel hacking"
 
 config FULLDEBUG
diff -Naurp ./arch/um/Kconfig.debug~mcp_v2v3 ./arch/um/Kconfig.debug
--- ./arch/um/Kconfig.debug~mcp_v2v3	2004-04-15 14:00:56.000000000 -0700
+++ ./arch/um/Kconfig.debug	2004-04-16 14:16:54.000000000 -0700
@@ -1,4 +1,3 @@
-
 menu "UML kernel hacking"
 
 config PT_PROXY
diff -Naurp ./arch/cris/Kconfig.debug~mcp_v2v3 ./arch/cris/Kconfig.debug
--- ./arch/cris/Kconfig.debug~mcp_v2v3	2004-04-15 14:00:56.000000000 -0700
+++ ./arch/cris/Kconfig.debug	2004-04-16 14:16:54.000000000 -0700
@@ -1,4 +1,3 @@
-
 menu "CRIS kernel hacking"
 
 #bool 'Debug kmalloc/kfree' CONFIG_DEBUG_MALLOC
diff -Naurp ./arch/m68k/Kconfig.debug~mcp_v2v3 ./arch/m68k/Kconfig.debug
--- ./arch/m68k/Kconfig.debug~mcp_v2v3	2004-04-15 14:00:56.000000000 -0700
+++ ./arch/m68k/Kconfig.debug	2004-04-16 14:16:54.000000000 -0700
@@ -1,9 +1,8 @@
-
 menu "M68K kernel hacking"
+	depends on DEBUG_KERNEL
 
 config DEBUG_BUGVERBOSE
 	bool "Verbose BUG() reporting"
-	depends on DEBUG_KERNEL
 
 endmenu
 
diff -Naurp ./arch/ia64/Kconfig.debug~mcp_v2v3 ./arch/ia64/Kconfig.debug
--- ./arch/ia64/Kconfig.debug~mcp_v2v3	2004-04-15 14:00:56.000000000 -0700
+++ ./arch/ia64/Kconfig.debug	2004-04-16 14:16:54.000000000 -0700
@@ -1,4 +1,3 @@
-
 menu "IA64 kernel hacking"
 
 choice
diff -Naurp ./arch/ppc64/Kconfig.debug~mcp_v2v3 ./arch/ppc64/Kconfig.debug
--- ./arch/ppc64/Kconfig.debug~mcp_v2v3	2004-04-15 14:00:56.000000000 -0700
+++ ./arch/ppc64/Kconfig.debug	2004-04-16 14:16:54.000000000 -0700
@@ -1,4 +1,3 @@
-
 menu "PPC64 kernel hacking"
 
 config DEBUGGER
diff -Naurp ./arch/parisc/Kconfig.debug~mcp_v2v3 ./arch/parisc/Kconfig.debug
--- ./arch/parisc/Kconfig.debug~mcp_v2v3	2004-04-15 14:00:56.000000000 -0700
+++ ./arch/parisc/Kconfig.debug	2004-04-16 14:20:29.000000000 -0700
@@ -1,5 +1,5 @@
-
 menu "PA-RISC kernel hacking"
+	depends on DEBUG_KERNEL
 
 endmenu
 
diff -Naurp ./arch/h8300/Kconfig.debug~mcp_v2v3 ./arch/h8300/Kconfig.debug
--- ./arch/h8300/Kconfig.debug~mcp_v2v3	2004-04-15 14:00:56.000000000 -0700
+++ ./arch/h8300/Kconfig.debug	2004-04-16 14:16:54.000000000 -0700
@@ -1,4 +1,3 @@
-
 menu "H8300 kernel hacking"
 
 config FULLDEBUG
diff -Naurp ./arch/v850/Kconfig.debug~mcp_v2v3 ./arch/v850/Kconfig.debug
--- ./arch/v850/Kconfig.debug~mcp_v2v3	2004-04-15 14:00:56.000000000 -0700
+++ ./arch/v850/Kconfig.debug	2004-04-16 14:16:54.000000000 -0700
@@ -1,4 +1,3 @@
-
 menu "V850 kernel hacking"
 
 config NO_KERNEL_MSG
diff -Naurp ./arch/x86_64/Kconfig.debug~mcp_v2v3 ./arch/x86_64/Kconfig.debug
--- ./arch/x86_64/Kconfig.debug~mcp_v2v3	2004-04-15 14:00:56.000000000 -0700
+++ ./arch/x86_64/Kconfig.debug	2004-04-16 14:16:54.000000000 -0700
@@ -1,4 +1,3 @@
-
 menu "X86-64 kernel hacking"
 
 # !SMP for now because the context switch early causes GPF in segment reloading
diff -Naurp ./arch/s390/Kconfig.debug~mcp_v2v3 ./arch/s390/Kconfig.debug
--- ./arch/s390/Kconfig.debug~mcp_v2v3	2004-04-16 14:21:17.000000000 -0700
+++ ./arch/s390/Kconfig.debug	2004-04-16 14:21:26.000000000 -0700
@@ -1,5 +1,6 @@
 
 menu "S/390 kernel hacking"
+	depends on DEBUG_KERNEL
 
 endmenu
 
diff -Naurp ./lib/Kconfig.debug~mcp_v2v3 ./lib/Kconfig.debug
--- ./lib/Kconfig.debug~mcp_v2v3	2004-04-15 21:50:59.000000000 -0700
+++ ./lib/Kconfig.debug	2004-04-16 14:17:35.000000000 -0700
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
@@ -109,19 +99,19 @@ config DEBUG_INFO
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
@@ -132,10 +122,10 @@ config FRAME_POINTER
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
@@ -143,5 +133,14 @@ config 4KSTACKS
 	  on the VM subsystem for higher order allocations. This option
 	  will also use IRQ stacks to compensate for the reduced stackspace.
 
+config KALLSYMS
+	bool "Load all symbols for debugging/kksymoops"
+	depends on DEBUG_KERNEL
+	default y if !ARCH_S390
+	help
+	  Say Y here to let the kernel print out symbolic crash information and
+	  symbolic stack backtraces. This increases the size of the kernel
+	  somewhat, as all symbols have to be loaded into the kernel image.
+
 endmenu
 
