Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261494AbTH3HFt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Aug 2003 03:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261542AbTH3HFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Aug 2003 03:05:49 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:50652 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S261494AbTH3HFS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Aug 2003 03:05:18 -0400
Date: Sat, 30 Aug 2003 09:05:13 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: cijoml@volny.cz, linux-kernel@vger.kernel.org
Subject: [2.6 patch] kill CONFIG_KCORE_AOUT
Message-ID: <20030830070513.GH7038@fs.tum.de>
References: <200308252332.46101.cijoml@volny.cz> <20030826105145.GC7038@fs.tum.de> <20030826135323.2c33e697.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030826135323.2c33e697.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 26, 2003 at 01:53:23PM -0700, Andrew Morton wrote:
> Adrian Bunk <bunk@fs.tum.de> wrote:
> >
> > Is there any specific reason to keep CONFIG_KCORE_AOUT or is it time to 
> > remove this option?
> 
> Time to kill it I suspect.
>...

The patch below kills CONFIG_KCORE_AOUT.

I've tested the compilation with 2.6.0-test4.

diffstat output:

 arch/alpha/Kconfig     |   34 ----------------------
 arch/arm/Kconfig       |   33 ---------------------
 arch/arm26/Kconfig     |   33 ---------------------
 arch/h8300/Kconfig     |    7 ----
 arch/i386/Kconfig      |   34 ----------------------
 arch/ia64/Kconfig      |   23 ---------------
 arch/m68k/Kconfig      |   34 ----------------------
 arch/m68knommu/Kconfig |    8 -----
 arch/mips/Kconfig      |   25 ----------------
 arch/parisc/Kconfig    |    5 ---
 arch/ppc/Kconfig       |   16 ----------
 arch/ppc64/Kconfig     |   16 ----------
 arch/s390/Kconfig      |    4 --
 arch/sh/Kconfig        |   34 ----------------------
 arch/sparc/Kconfig     |   23 ---------------
 arch/sparc64/Kconfig   |   23 ---------------
 arch/v850/Kconfig      |    8 -----
 arch/x86_64/Kconfig    |    5 ---
 fs/proc/kcore.c        |   68 ---------------------------------------------
 19 files changed, 1 insertion(+), 432 deletions(-)


cu
Adrian

--- linux-2.6.0-test4-not-full/arch/i386/Kconfig.old	2003-08-30 08:32:28.000000000 +0200
+++ linux-2.6.0-test4-not-full/arch/i386/Kconfig	2003-08-30 08:34:57.000000000 +0200
@@ -1156,40 +1156,6 @@
 
 menu "Executable file formats"
 
-choice
-	prompt "Kernel core (/proc/kcore) format"
-	depends on PROC_FS
-	default KCORE_ELF
-
-config KCORE_ELF
-	bool "ELF"
-	---help---
-	  If you enabled support for /proc file system then the file
-	  /proc/kcore will contain the kernel core image. This can be used
-	  in gdb:
-
-	  $ cd /usr/src/linux ; gdb vmlinux /proc/kcore
-
-	  You have two choices here: ELF and A.OUT. Selecting ELF will make
-	  /proc/kcore appear in ELF core format as defined by the Executable
-	  and Linking Format specification. Selecting A.OUT will choose the
-	  old "a.out" format which may be necessary for some old versions
-	  of binutils or on some architectures.
-
-	  This is especially useful if you have compiled the kernel with the
-	  "-g" option to preserve debugging information. It is mainly used
-	  for examining kernel data structures on the live kernel so if you
-	  don't understand what this means or are not a kernel hacker, just
-	  leave it at its default value ELF.
-
-config KCORE_AOUT
-	bool "A.OUT"
-	help
-	  Not necessary unless you're using a very out-of-date binutils
-	  version.  You probably want KCORE_ELF.
-
-endchoice
-
 source "fs/Kconfig.binfmt"
 
 endmenu
--- linux-2.6.0-test4-not-full/arch/mips/Kconfig.old	2003-08-30 08:34:00.000000000 +0200
+++ linux-2.6.0-test4-not-full/arch/mips/Kconfig	2003-08-30 08:35:14.000000000 +0200
@@ -1126,31 +1126,6 @@
 
 menu "Executable file formats"
 
-config KCORE_ELF
-	bool
-	default y
-	---help---
-	  If you enabled support for /proc file system then the file
-	  /proc/kcore will contain the kernel core image. This can be used
-	  in gdb:
-
-	  $ cd /usr/src/linux ; gdb vmlinux /proc/kcore
-
-	  You have two choices here: ELF and A.OUT. Selecting ELF will make
-	  /proc/kcore appear in ELF core format as defined by the Executable
-	  and Linking Format specification. Selecting A.OUT will choose the
-	  old "a.out" format which may be necessary for some old versions
-	  of binutils or on some architectures.
-
-	  This is especially useful if you have compiled the kernel with the
-	  "-g" option to preserve debugging information. It is mainly used
-	  for examining kernel data structures on the live kernel so if you
-	  don't understand what this means or are not a kernel hacker, just
-	  leave it at its default value ELF.
-
-config KCORE_AOUT
-	bool
-
 source "fs/Kconfig.binfmt"
 
 config TRAD_SIGNALS
--- linux-2.6.0-test4-not-full/arch/m68knommu/Kconfig.old	2003-08-30 08:35:44.000000000 +0200
+++ linux-2.6.0-test4-not-full/arch/m68knommu/Kconfig	2003-08-30 08:36:01.000000000 +0200
@@ -490,14 +490,6 @@
 
 menu "Executable file formats"
 
-config KCORE_AOUT
-	bool
-	default y
-
-config KCORE_ELF
-	bool
-	default y
-
 source "fs/Kconfig.binfmt"
 
 endmenu
--- linux-2.6.0-test4-not-full/arch/sh/Kconfig.old	2003-08-30 08:36:25.000000000 +0200
+++ linux-2.6.0-test4-not-full/arch/sh/Kconfig	2003-08-30 08:36:46.000000000 +0200
@@ -729,40 +729,6 @@
 
 menu "Executable file formats"
 
-choice
-	prompt "Kernel core (/proc/kcore) format"
-	depends on PROC_FS
-	default KCORE_ELF
-
-config KCORE_ELF
-	bool "ELF"
-	---help---
-	  If you enabled support for /proc file system then the file
-	  /proc/kcore will contain the kernel core image. This can be used
-	  in gdb:
-
-	  $ cd /usr/src/linux ; gdb vmlinux /proc/kcore
-
-	  You have two choices here: ELF and A.OUT. Selecting ELF will make
-	  /proc/kcore appear in ELF core format as defined by the Executable
-	  and Linking Format specification. Selecting A.OUT will choose the
-	  old "a.out" format which may be necessary for some old versions
-	  of binutils or on some architectures.
-
-	  This is especially useful if you have compiled the kernel with the
-	  "-g" option to preserve debugging information. It is mainly used
-	  for examining kernel data structures on the live kernel so if you
-	  don't understand what this means or are not a kernel hacker, just
-	  leave it at its default value ELF.
-
-config KCORE_AOUT
-	bool "A.OUT"
-	help
-	  Not necessary unless you're using a very out-of-date binutils
-	  version.  You probably want KCORE_ELF.
-
-endchoice
-
 source "fs/Kconfig.binfmt"
 
 endmenu
--- linux-2.6.0-test4-not-full/arch/arm26/Kconfig.old	2003-08-30 08:37:09.000000000 +0200
+++ linux-2.6.0-test4-not-full/arch/arm26/Kconfig	2003-08-30 08:37:23.000000000 +0200
@@ -146,39 +146,6 @@
 	  You may say N here if you are going to load the Acorn FPEmulator
 	  early in the bootup.
 
-choice
-	prompt "Kernel core (/proc/kcore) format"
-	default KCORE_ELF
-
-config KCORE_ELF
-	bool "ELF"
-	---help---
-	  If you enabled support for /proc file system then the file
-	  /proc/kcore will contain the kernel core image. This can be used
-	  in gdb:
-
-	  $ cd /usr/src/linux ; gdb vmlinux /proc/kcore
-
-	  You have two choices here: ELF and A.OUT. Selecting ELF will make
-	  /proc/kcore appear in ELF core format as defined by the Executable
-	  and Linking Format specification. Selecting A.OUT will choose the
-	  old "a.out" format which may be necessary for some old versions
-	  of binutils or on some architectures.
-
-	  This is especially useful if you have compiled the kernel with the
-	  "-g" option to preserve debugging information. It is mainly used
-	  for examining kernel data structures on the live kernel so if you
-	  don't understand what this means or are not a kernel hacker, just
-	  leave it at its default value ELF.
-
-config KCORE_AOUT
-	bool "A.OUT"
-	help
-	  Not necessary unless you're using a very out-of-date binutils
-	  version.  You probably want KCORE_ELF.
-
-endchoice
-
 source "fs/Kconfig.binfmt"
 
 config PREEMPT
--- linux-2.6.0-test4-not-full/arch/m68k/Kconfig.old	2003-08-30 08:37:43.000000000 +0200
+++ linux-2.6.0-test4-not-full/arch/m68k/Kconfig	2003-08-30 08:37:56.000000000 +0200
@@ -342,40 +342,6 @@
 
 menu "General setup"
 
-choice
-	prompt "Kernel core (/proc/kcore) format"
-	depends on PROC_FS
-	default KCORE_ELF
-
-config KCORE_ELF
-	bool "ELF"
-	---help---
-	  If you enabled support for /proc file system then the file
-	  /proc/kcore will contain the kernel core image. This can be used
-	  in gdb:
-
-	  $ cd /usr/src/linux ; gdb vmlinux /proc/kcore
-
-	  You have two choices here: ELF and A.OUT. Selecting ELF will make
-	  /proc/kcore appear in ELF core format as defined by the Executable
-	  and Linking Format specification. Selecting A.OUT will choose the
-	  old "a.out" format which may be necessary for some old versions
-	  of binutils or on some architectures.
-
-	  This is especially useful if you have compiled the kernel with the
-	  "-g" option to preserve debugging information. It is mainly used
-	  for examining kernel data structures on the live kernel so if you
-	  don't understand what this means or are not a kernel hacker, just
-	  leave it at its default value ELF.
-
-config KCORE_AOUT
-	bool "A.OUT"
-	help
-	  Not necessary unless you're using a very out-of-date binutils
-	  version.  You probably want KCORE_ELF.
-
-endchoice
-
 source "fs/Kconfig.binfmt"
 
 config ZORRO
--- linux-2.6.0-test4-not-full/arch/alpha/Kconfig.old	2003-08-30 08:38:17.000000000 +0200
+++ linux-2.6.0-test4-not-full/arch/alpha/Kconfig	2003-08-30 08:38:36.000000000 +0200
@@ -597,40 +597,6 @@
 
 source "drivers/pcmcia/Kconfig"
 
-choice
-	prompt "Kernel core (/proc/kcore) format"
-	depends on PROC_FS
-	default KCORE_ELF
-
-config KCORE_ELF
-	bool "ELF"
-	---help---
-	  If you enabled support for /proc file system then the file
-	  /proc/kcore will contain the kernel core image. This can be used
-	  in gdb:
-
-	  $ cd /usr/src/linux ; gdb vmlinux /proc/kcore
-
-	  You have two choices here: ELF and A.OUT. Selecting ELF will make
-	  /proc/kcore appear in ELF core format as defined by the Executable
-	  and Linking Format specification. Selecting A.OUT will choose the
-	  old "a.out" format which may be necessary for some old versions
-	  of binutils or on some architectures.
-
-	  This is especially useful if you have compiled the kernel with the
-	  "-g" option to preserve debugging information. It is mainly used
-	  for examining kernel data structures on the live kernel so if you
-	  don't understand what this means or are not a kernel hacker, just
-	  leave it at its default value ELF.
-
-config KCORE_AOUT
-	bool "A.OUT"
-	help
-	  Not necessary unless you're using a very out-of-date binutils
-	  version.  You probably want KCORE_ELF.
-
-endchoice
-
 config SRM_ENV
 	tristate "SRM environment through procfs"
 	depends on PROC_FS
--- linux-2.6.0-test4-not-full/arch/arm/Kconfig.old	2003-08-30 08:39:02.000000000 +0200
+++ linux-2.6.0-test4-not-full/arch/arm/Kconfig	2003-08-30 08:39:15.000000000 +0200
@@ -654,39 +654,6 @@
 	  If you do not feel you need a faster FP emulation you should better
 	  choose NWFPE.
 
-choice
-	prompt "Kernel core (/proc/kcore) format"
-	default KCORE_ELF
-
-config KCORE_ELF
-	bool "ELF"
-	---help---
-	  If you enabled support for /proc file system then the file
-	  /proc/kcore will contain the kernel core image. This can be used
-	  in gdb:
-
-	  $ cd /usr/src/linux ; gdb vmlinux /proc/kcore
-
-	  You have two choices here: ELF and A.OUT. Selecting ELF will make
-	  /proc/kcore appear in ELF core format as defined by the Executable
-	  and Linking Format specification. Selecting A.OUT will choose the
-	  old "a.out" format which may be necessary for some old versions
-	  of binutils or on some architectures.
-
-	  This is especially useful if you have compiled the kernel with the
-	  "-g" option to preserve debugging information. It is mainly used
-	  for examining kernel data structures on the live kernel so if you
-	  don't understand what this means or are not a kernel hacker, just
-	  leave it at its default value ELF.
-
-config KCORE_AOUT
-	bool "A.OUT"
-	help
-	  Not necessary unless you're using a very out-of-date binutils
-	  version.  You probably want KCORE_ELF.
-
-endchoice
-
 source "fs/Kconfig.binfmt"
 
 source "drivers/base/Kconfig"
--- linux-2.6.0-test4-not-full/arch/h8300/Kconfig.old	2003-08-30 08:39:40.000000000 +0200
+++ linux-2.6.0-test4-not-full/arch/h8300/Kconfig	2003-08-30 08:40:02.000000000 +0200
@@ -177,13 +177,6 @@
 
 menu "Executable file formats"
 
-config KCORE_AOUT
-	bool
-	default y
-
-config KCORE_ELF
-	default y
-
 source "fs/Kconfig.binfmt"
 
 endmenu
--- linux-2.6.0-test4-not-full/arch/v850/Kconfig.old	2003-08-30 08:40:22.000000000 +0200
+++ linux-2.6.0-test4-not-full/arch/v850/Kconfig	2003-08-30 08:40:35.000000000 +0200
@@ -262,14 +262,6 @@
 
 menu "Executable file formats"
 
-config KCORE_AOUT
-	bool
-	default y
-
-config KCORE_ELF
-	bool
-	default y
-
 source "fs/Kconfig.binfmt"
 
 endmenu
--- linux-2.6.0-test4-not-full/fs/proc/kcore.c.old	2003-08-30 08:41:11.000000000 +0200
+++ linux-2.6.0-test4-not-full/fs/proc/kcore.c	2003-08-30 08:41:55.000000000 +0200
@@ -1,5 +1,5 @@
 /*
- *	fs/proc/kcore.c kernel ELF/AOUT core dumper
+ *	fs/proc/kcore.c kernel ELF core dumper
  *
  *	Modelled on fs/exec.c:aout_core_dump()
  *	Jeremy Fitzhardinge <jeremy@sw.oz.au>
@@ -34,71 +34,6 @@
 	.open		= open_kcore,
 };
 
-#ifdef CONFIG_KCORE_AOUT
-static ssize_t read_kcore(struct file *file, char *buf, size_t count, loff_t *ppos)
-{
-	unsigned long long p = *ppos, memsize;
-	ssize_t read;
-	ssize_t count1;
-	char * pnt;
-	struct user dump;
-#if defined (__i386__) || defined (__mc68000__) || defined(__x86_64__)
-#	define FIRST_MAPPED	PAGE_SIZE	/* we don't have page 0 mapped on x86.. */
-#else
-#	define FIRST_MAPPED	0
-#endif
-
-	memset(&dump, 0, sizeof(struct user));
-	dump.magic = CMAGIC;
-	dump.u_dsize = (virt_to_phys(high_memory) >> PAGE_SHIFT);
-#if defined (__i386__) || defined(__x86_64__)
-	dump.start_code = PAGE_OFFSET;
-#endif
-#ifdef __alpha__
-	dump.start_data = PAGE_OFFSET;
-#endif
-
-	memsize = virt_to_phys(high_memory);
-	if (p >= memsize)
-		return 0;
-	if (count > memsize - p)
-		count = memsize - p;
-	read = 0;
-
-	if (p < sizeof(struct user) && count > 0) {
-		count1 = count;
-		if (p + count1 > sizeof(struct user))
-			count1 = sizeof(struct user)-p;
-		pnt = (char *) &dump + p;
-		if (copy_to_user(buf,(void *) pnt, count1))
-			return -EFAULT;
-		buf += count1;
-		p += count1;
-		count -= count1;
-		read += count1;
-	}
-
-	if (count > 0 && p < PAGE_SIZE + FIRST_MAPPED) {
-		count1 = PAGE_SIZE + FIRST_MAPPED - p;
-		if (count1 > count)
-			count1 = count;
-		if (clear_user(buf, count1))
-			return -EFAULT;
-		buf += count1;
-		p += count1;
-		count -= count1;
-		read += count1;
-	}
-	if (count > 0) {
-		if (copy_to_user(buf, (void *) (PAGE_OFFSET+p-PAGE_SIZE), count))
-			return -EFAULT;
-		read += count;
-	}
-	*ppos += read;
-	return read;
-}
-#else /* CONFIG_KCORE_AOUT */
-
 #ifndef kc_vaddr_to_offset
 #define	kc_vaddr_to_offset(v) ((v) - PAGE_OFFSET)
 #endif
@@ -480,4 +415,3 @@
 
 	return acc;
 }
-#endif /* CONFIG_KCORE_AOUT */
--- linux-2.6.0-test4-not-full/arch/sparc64/Kconfig.old	2003-08-30 08:42:56.000000000 +0200
+++ linux-2.6.0-test4-not-full/arch/sparc64/Kconfig	2003-08-30 08:43:13.000000000 +0200
@@ -363,29 +363,6 @@
 	  <file:Documentation/modules.txt>.
 	  The module will be called openpromfs.  If unsure, say M.
 
-config KCORE_ELF
-	bool
-	depends on PROC_FS
-	default y
-	---help---
-	  If you enabled support for /proc file system then the file
-	  /proc/kcore will contain the kernel core image. This can be used
-	  in gdb:
-
-	  $ cd /usr/src/linux ; gdb vmlinux /proc/kcore
-
-	  You have two choices here: ELF and A.OUT. Selecting ELF will make
-	  /proc/kcore appear in ELF core format as defined by the Executable
-	  and Linking Format specification. Selecting A.OUT will choose the
-	  old "a.out" format which may be necessary for some old versions
-	  of binutils or on some architectures.
-
-	  This is especially useful if you have compiled the kernel with the
-	  "-g" option to preserve debugging information. It is mainly used
-	  for examining kernel data structures on the live kernel so if you
-	  don't understand what this means or are not a kernel hacker, just
-	  leave it at its default value ELF.
-
 config SPARC32_COMPAT
 	bool "Kernel support for Linux/Sparc 32bit binary compatibility"
 	help
--- linux-2.6.0-test4-not-full/arch/sparc/Kconfig.old	2003-08-30 08:43:35.000000000 +0200
+++ linux-2.6.0-test4-not-full/arch/sparc/Kconfig	2003-08-30 08:43:50.000000000 +0200
@@ -254,29 +254,6 @@
 	  <file:Documentation/modules.txt>.
 	  The module will be called openpromfs.  If unsure, say M.
 
-config KCORE_ELF
-	bool
-	depends on PROC_FS
-	default y
-	---help---
-	  If you enabled support for /proc file system then the file
-	  /proc/kcore will contain the kernel core image. This can be used
-	  in gdb:
-
-	  $ cd /usr/src/linux ; gdb vmlinux /proc/kcore
-
-	  You have two choices here: ELF and A.OUT. Selecting ELF will make
-	  /proc/kcore appear in ELF core format as defined by the Executable
-	  and Linking Format specification. Selecting A.OUT will choose the
-	  old "a.out" format which may be necessary for some old versions
-	  of binutils or on some architectures.
-
-	  This is especially useful if you have compiled the kernel with the
-	  "-g" option to preserve debugging information. It is mainly used
-	  for examining kernel data structures on the live kernel so if you
-	  don't understand what this means or are not a kernel hacker, just
-	  leave it at its default value ELF.
-
 source "fs/Kconfig.binfmt"
 
 config SUNOS_EMUL
--- linux-2.6.0-test4-not-full/arch/ppc/Kconfig.old	2003-08-30 08:44:56.000000000 +0200
+++ linux-2.6.0-test4-not-full/arch/ppc/Kconfig	2003-08-30 08:45:31.000000000 +0200
@@ -795,22 +795,6 @@
 	bool "PCI for Permedia2"
 	depends on !4xx && !8xx && APUS
 
-# only elf supported, a.out is not -- Cort
-config KCORE_ELF
-	bool
-	depends on PROC_FS
-	default y
-	help
-	  If you enabled support for /proc file system then the file
-	  /proc/kcore will contain the kernel core image in ELF format. This
-	  can be used in gdb:
-
-	  $ cd /usr/src/linux ; gdb vmlinux /proc/kcore
-
-	  This is especially useful if you have compiled the kernel with the
-	  "-g" option to preserve debugging information. It is mainly used
-	  for examining kernel data structures on the live kernel.
-
 config KERNEL_ELF
 	bool
 	default y
--- linux-2.6.0-test4-not-full/arch/ia64/Kconfig.old	2003-08-30 08:46:04.000000000 +0200
+++ linux-2.6.0-test4-not-full/arch/ia64/Kconfig	2003-08-30 08:46:18.000000000 +0200
@@ -297,29 +297,6 @@
 	  If you are compiling a kernel that will run under SGI's IA-64
 	  simulator (Medusa) then say Y, otherwise say N.
 
-# On IA-64, we always want an ELF /proc/kcore.
-config KCORE_ELF
-	bool
-	default y
-	---help---
-	  If you enabled support for /proc file system then the file
-	  /proc/kcore will contain the kernel core image. This can be used
-	  in gdb:
-
-	  $ cd /usr/src/linux ; gdb vmlinux /proc/kcore
-
-	  You have two choices here: ELF and A.OUT. Selecting ELF will make
-	  /proc/kcore appear in ELF core format as defined by the Executable
-	  and Linking Format specification. Selecting A.OUT will choose the
-	  old "a.out" format which may be necessary for some old versions
-	  of binutils or on some architectures.
-
-	  This is especially useful if you have compiled the kernel with the
-	  "-g" option to preserve debugging information. It is mainly used
-	  for examining kernel data structures on the live kernel so if you
-	  don't understand what this means or are not a kernel hacker, just
-	  leave it at its default value ELF.
-
 config FORCE_MAX_ZONEORDER
 	int
 	default "18"
--- linux-2.6.0-test4-not-full/arch/ppc64/Kconfig.old	2003-08-30 08:46:52.000000000 +0200
+++ linux-2.6.0-test4-not-full/arch/ppc64/Kconfig	2003-08-30 08:47:03.000000000 +0200
@@ -175,22 +175,6 @@
 	bool
 	default PCI
 
-# only elf supported, a.out is not -- Cort
-config KCORE_ELF
-	bool
-	depends on PROC_FS
-	default y
-	help
-	  If you enabled support for /proc file system then the file
-	  /proc/kcore will contain the kernel core image in ELF format. This
-	  can be used in gdb:
-
-	  $ cd /usr/src/linux ; gdb vmlinux /proc/kcore
-
-	  This is especially useful if you have compiled the kernel with the
-	  "-g" option to preserve debugging information. It is mainly used
-	  for examining kernel data structures on the live kernel.
-
 source "fs/Kconfig.binfmt"
 
 source "drivers/pci/Kconfig"
--- linux-2.6.0-test4-not-full/arch/parisc/Kconfig.old	2003-08-30 08:47:39.000000000 +0200
+++ linux-2.6.0-test4-not-full/arch/parisc/Kconfig	2003-08-30 08:47:51.000000000 +0200
@@ -161,11 +161,6 @@
 
 menu "Executable file formats"
 
-config KCORE_ELF
-	bool
-	depends on PROC_FS
-	default y
-
 source "fs/Kconfig.binfmt"
 
 endmenu
--- linux-2.6.0-test4-not-full/arch/x86_64/Kconfig.old	2003-08-30 08:48:11.000000000 +0200
+++ linux-2.6.0-test4-not-full/arch/x86_64/Kconfig	2003-08-30 08:48:27.000000000 +0200
@@ -370,11 +370,6 @@
 
 menu "Executable file formats / Emulations"
 
-config KCORE_ELF
-	bool
-	depends on PROC_FS
-	default y
-
 source "fs/Kconfig.binfmt"
 
 config IA32_EMULATION
--- linux-2.6.0-test4-not-full/arch/s390/Kconfig.old	2003-08-30 08:48:55.000000000 +0200
+++ linux-2.6.0-test4-not-full/arch/s390/Kconfig	2003-08-30 08:49:08.000000000 +0200
@@ -217,10 +217,6 @@
 
 endchoice
 
-config KCORE_ELF
-	bool
-	default y
-
 source "fs/Kconfig.binfmt"
 
 config PROCESS_DEBUG
