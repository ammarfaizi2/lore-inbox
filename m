Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932236AbVKKIj7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932236AbVKKIj7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 03:39:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932243AbVKKIjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 03:39:25 -0500
Received: from i121.durables.org ([64.81.244.121]:10190 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S932236AbVKKIgI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 03:36:08 -0500
Date: Fri, 11 Nov 2005 02:35:54 -0600
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
X-PatchBomber: http://selenic.com/scripts/mailpatches
In-Reply-To: <10.282480653@selenic.com>
Message-Id: <11.282480653@selenic.com>
Subject: [PATCH 10/15] misc: Make *[ug]id16 support optional
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Configurable 16-bit UID and friends support

This allows turning off the legacy 16 bit UID interfaces on embedded platforms.

   text    data     bss     dec     hex filename
3330172  529036  190556 4049764  3dcb64 vmlinux-baseline
3328268  529040  190556 4047864  3dc3f8 vmlinux

Signed-off-by: Matt Mackall <mpm@selenic.com>

Index: 2.6.14-misc/init/Kconfig
===================================================================
--- 2.6.14-misc.orig/init/Kconfig	2005-11-09 11:21:02.000000000 -0800
+++ 2.6.14-misc/init/Kconfig	2005-11-09 11:22:06.000000000 -0800
@@ -364,7 +364,16 @@ config SYSENTER
 	help
 	  Disabling this feature removes sysenter handling as well as
 	  vsyscall fixmaps.
- 
+
+config UID16
+	bool "Enable 16-bit UID system calls" if EMBEDDED
+	depends !ALPHA && !PPC && !PPC64 && !PARISC && !V850 && !ARCH_S390X
+	depends !X86_64 || IA32_EMULATION
+	depends !SPARC64 || SPARC32_COMPAT
+	help
+	  This enables the legacy 16-bit UID syscall wrappers.
+
+
 config CC_OPTIMIZE_FOR_SIZE
 	bool "Optimize for size" if EMBEDDED
 	default y if ARM || H8300
Index: 2.6.14-misc/arch/sparc/Kconfig
===================================================================
--- 2.6.14-misc.orig/arch/sparc/Kconfig	2005-10-27 17:02:08.000000000 -0700
+++ 2.6.14-misc/arch/sparc/Kconfig	2005-11-09 11:21:09.000000000 -0800
@@ -9,10 +9,6 @@ config MMU
 	bool
 	default y
 
-config UID16
-	bool
-	default y
-
 config HIGHMEM
 	bool
 	default y
Index: 2.6.14-misc/arch/arm26/Kconfig
===================================================================
--- 2.6.14-misc.orig/arch/arm26/Kconfig	2005-10-27 17:02:08.000000000 -0700
+++ 2.6.14-misc/arch/arm26/Kconfig	2005-11-09 11:21:09.000000000 -0800
@@ -34,10 +34,6 @@ config FORCE_MAX_ZONEORDER
         int
         default 9
 
-config UID16
-	bool
-	default y
-
 config RWSEM_GENERIC_SPINLOCK
 	bool
 	default y
Index: 2.6.14-misc/arch/m68k/Kconfig
===================================================================
--- 2.6.14-misc.orig/arch/m68k/Kconfig	2005-11-01 10:54:31.000000000 -0800
+++ 2.6.14-misc/arch/m68k/Kconfig	2005-11-09 11:21:09.000000000 -0800
@@ -10,10 +10,6 @@ config MMU
 	bool
 	default y
 
-config UID16
-	bool
-	default y
-
 config RWSEM_GENERIC_SPINLOCK
 	bool
 	default y
Index: 2.6.14-misc/arch/ppc64/Kconfig
===================================================================
--- 2.6.14-misc.orig/arch/ppc64/Kconfig	2005-11-01 10:54:32.000000000 -0800
+++ 2.6.14-misc/arch/ppc64/Kconfig	2005-11-09 11:21:09.000000000 -0800
@@ -13,9 +13,6 @@ config MMU
 config PPC_STD_MMU
 	def_bool y
 
-config UID16
-	bool
-
 config RWSEM_GENERIC_SPINLOCK
 	bool
 
Index: 2.6.14-misc/arch/sh/Kconfig
===================================================================
--- 2.6.14-misc.orig/arch/sh/Kconfig	2005-10-27 17:02:08.000000000 -0700
+++ 2.6.14-misc/arch/sh/Kconfig	2005-11-09 11:21:09.000000000 -0800
@@ -14,10 +14,6 @@ config SUPERH
 	  gaming console.  The SuperH port has a home page at
 	  <http://www.linux-sh.org/>.
 
-config UID16
-	bool
-	default y
-
 config RWSEM_GENERIC_SPINLOCK
 	bool
 	default y
Index: 2.6.14-misc/arch/s390/Kconfig
===================================================================
--- 2.6.14-misc.orig/arch/s390/Kconfig	2005-10-27 17:02:08.000000000 -0700
+++ 2.6.14-misc/arch/s390/Kconfig	2005-11-09 11:21:09.000000000 -0800
@@ -27,11 +27,6 @@ config ARCH_S390
 	bool
 	default y
 
-config UID16
-	bool
-	default y
-	depends on ARCH_S390X = 'n'
-
 source "init/Kconfig"
 
 menu "Base setup"
Index: 2.6.14-misc/arch/cris/Kconfig
===================================================================
--- 2.6.14-misc.orig/arch/cris/Kconfig	2005-10-27 17:02:08.000000000 -0700
+++ 2.6.14-misc/arch/cris/Kconfig	2005-11-09 11:21:09.000000000 -0800
@@ -9,10 +9,6 @@ config MMU
 	bool
 	default y
 
-config UID16
-	bool
-	default y
-
 config RWSEM_GENERIC_SPINLOCK
 	bool
 	default y
Index: 2.6.14-misc/arch/x86_64/Kconfig
===================================================================
--- 2.6.14-misc.orig/arch/x86_64/Kconfig	2005-10-27 17:02:08.000000000 -0700
+++ 2.6.14-misc/arch/x86_64/Kconfig	2005-11-09 11:21:09.000000000 -0800
@@ -517,11 +517,6 @@ config SYSVIPC_COMPAT
 	depends on COMPAT && SYSVIPC
 	default y
 
-config UID16
-	bool
-	depends on IA32_EMULATION
-	default y
-
 endmenu
 
 source "net/Kconfig"
Index: 2.6.14-misc/arch/arm/Kconfig
===================================================================
--- 2.6.14-misc.orig/arch/arm/Kconfig	2005-11-01 10:54:31.000000000 -0800
+++ 2.6.14-misc/arch/arm/Kconfig	2005-11-09 11:21:09.000000000 -0800
@@ -46,10 +46,6 @@ config MCA
 	  <file:Documentation/mca.txt> (and especially the web page given
 	  there) before attempting to build an MCA bus kernel.
 
-config UID16
-	bool
-	default y
-
 config RWSEM_GENERIC_SPINLOCK
 	bool
 	default y
Index: 2.6.14-misc/arch/um/Kconfig
===================================================================
--- 2.6.14-misc.orig/arch/um/Kconfig	2005-11-01 10:54:32.000000000 -0800
+++ 2.6.14-misc/arch/um/Kconfig	2005-11-09 11:22:29.000000000 -0800
@@ -23,10 +23,6 @@ config SBUS
 config PCI
 	bool
 
-config UID16
-	bool
-	default y
-
 config GENERIC_CALIBRATE_DELAY
 	bool
 	default y
Index: 2.6.14-misc/arch/m68knommu/Kconfig
===================================================================
--- 2.6.14-misc.orig/arch/m68knommu/Kconfig	2005-10-27 17:02:08.000000000 -0700
+++ 2.6.14-misc/arch/m68knommu/Kconfig	2005-11-09 11:21:09.000000000 -0800
@@ -17,10 +17,6 @@ config FPU
 	bool
 	default n
 
-config UID16
-	bool
-	default y
-
 config RWSEM_GENERIC_SPINLOCK
 	bool
 	default y
Index: 2.6.14-misc/arch/ppc/Kconfig
===================================================================
--- 2.6.14-misc.orig/arch/ppc/Kconfig	2005-11-01 10:54:32.000000000 -0800
+++ 2.6.14-misc/arch/ppc/Kconfig	2005-11-09 11:21:09.000000000 -0800
@@ -8,9 +8,6 @@ config MMU
 	bool
 	default y
 
-config UID16
-	bool
-
 config GENERIC_HARDIRQS
 	bool
 	default y
Index: 2.6.14-misc/arch/parisc/Kconfig
===================================================================
--- 2.6.14-misc.orig/arch/parisc/Kconfig	2005-11-01 10:54:31.000000000 -0800
+++ 2.6.14-misc/arch/parisc/Kconfig	2005-11-09 11:21:09.000000000 -0800
@@ -19,9 +19,6 @@ config MMU
 config STACK_GROWSUP
 	def_bool y
 
-config UID16
-	bool
-
 config RWSEM_GENERIC_SPINLOCK
 	def_bool y
 
Index: 2.6.14-misc/arch/sparc64/Kconfig
===================================================================
--- 2.6.14-misc.orig/arch/sparc64/Kconfig	2005-10-27 17:02:08.000000000 -0700
+++ 2.6.14-misc/arch/sparc64/Kconfig	2005-11-09 11:21:09.000000000 -0800
@@ -305,11 +305,6 @@ config COMPAT
 	depends on SPARC32_COMPAT
 	default y
 
-config UID16
-	bool
-	depends on SPARC32_COMPAT
-	default y
-
 config BINFMT_ELF32
 	tristate "Kernel support for 32-bit ELF binaries"
 	depends on SPARC32_COMPAT
Index: 2.6.14-misc/arch/v850/Kconfig
===================================================================
--- 2.6.14-misc.orig/arch/v850/Kconfig	2005-10-27 17:02:08.000000000 -0700
+++ 2.6.14-misc/arch/v850/Kconfig	2005-11-09 11:21:09.000000000 -0800
@@ -10,9 +10,6 @@ mainmenu "uClinux/v850 (w/o MMU) Kernel 
 config MMU
        	bool
 	default n
-config UID16
-	bool
-	default n
 config RWSEM_GENERIC_SPINLOCK
 	bool
 	default y
Index: 2.6.14-misc/arch/h8300/Kconfig
===================================================================
--- 2.6.14-misc.orig/arch/h8300/Kconfig	2005-10-27 17:02:08.000000000 -0700
+++ 2.6.14-misc/arch/h8300/Kconfig	2005-11-09 11:21:09.000000000 -0800
@@ -21,10 +21,6 @@ config FPU
 	bool
 	default n
 
-config UID16
-	bool
-	default y
-
 config RWSEM_GENERIC_SPINLOCK
 	bool
 	default y
Index: 2.6.14-misc/arch/alpha/Kconfig
===================================================================
--- 2.6.14-misc.orig/arch/alpha/Kconfig	2005-10-27 17:02:08.000000000 -0700
+++ 2.6.14-misc/arch/alpha/Kconfig	2005-11-09 11:21:09.000000000 -0800
@@ -18,9 +18,6 @@ config MMU
 	bool
 	default y
 
-config UID16
-	bool
-
 config RWSEM_GENERIC_SPINLOCK
 	bool
 
Index: 2.6.14-misc/arch/i386/Kconfig
===================================================================
--- 2.6.14-misc.orig/arch/i386/Kconfig	2005-11-01 10:54:31.000000000 -0800
+++ 2.6.14-misc/arch/i386/Kconfig	2005-11-09 11:21:09.000000000 -0800
@@ -29,10 +29,6 @@ config MMU
 config SBUS
 	bool
 
-config UID16
-	bool
-	default y
-
 config GENERIC_ISA_DMA
 	bool
 	default y
Index: 2.6.14-misc/kernel/sys_ni.c
===================================================================
--- 2.6.14-misc.orig/kernel/sys_ni.c	2005-11-09 11:20:21.000000000 -0800
+++ 2.6.14-misc/kernel/sys_ni.c	2005-11-09 11:22:56.000000000 -0800
@@ -84,6 +84,25 @@ cond_syscall(sys_inotify_add_watch);
 cond_syscall(sys_inotify_rm_watch);
 cond_syscall(sys_vm86old);
 cond_syscall(sys_vm86);
+cond_syscall(sys_chown16);
+cond_syscall(sys_fchown16);
+cond_syscall(sys_getegid16);
+cond_syscall(sys_geteuid16);
+cond_syscall(sys_getgid16);
+cond_syscall(sys_getgroups16);
+cond_syscall(sys_getresgid16);
+cond_syscall(sys_getresuid16);
+cond_syscall(sys_getuid16);
+cond_syscall(sys_lchown16);
+cond_syscall(sys_setfsgid16);
+cond_syscall(sys_setfsuid16);
+cond_syscall(sys_setgid16);
+cond_syscall(sys_setgroups16);
+cond_syscall(sys_setregid16);
+cond_syscall(sys_setresgid16);
+cond_syscall(sys_setresuid16);
+cond_syscall(sys_setreuid16);
+cond_syscall(sys_setuid16);
 
 /* arch-specific weak syscall entries */
 cond_syscall(sys_pciconfig_read);
