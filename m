Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271853AbTGRV2z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 17:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272037AbTGRVZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 17:25:55 -0400
Received: from server0011.freedom2surf.net ([194.106.56.14]:8859 "EHLO
	server0027.freedom2surf.net") by vger.kernel.org with ESMTP
	id S272027AbTGRVW4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 17:22:56 -0400
Date: Fri, 18 Jul 2003 22:37:50 +0100
From: Ian Molton <spyro@f2s.com>
To: linux-kernel@vger.kernel.org
Subject: CLEANUP [PATCH] Kconfig tidyup for kcore options
Message-Id: <20030718223750.0e8e7645.spyro@f2s.com>
Organization: The Dragon Roost
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

This patch cleans up the multiple copies of KCORE options on those
architectures that offered a choice between AOUT or ELF.

 arch/alpha/Kconfig       |   35 +----------------------------------
 arch/arm/Kconfig         |   34 +---------------------------------
 arch/arm26/Kconfig       |   34 +---------------------------------
 arch/h8300/Kconfig       |    8 +-------
 arch/i386/Kconfig        |   35 +----------------------------------
 arch/m68k/Kconfig        |   35 +----------------------------------
 arch/m68knommu/Kconfig   |    9 +--------
 arch/mips/Kconfig-shared |   26 +-------------------------
 arch/sh/Kconfig          |   35 +----------------------------------
 arch/v850/Kconfig        |    8 +-------
 fs/proc/Kconfig.kcore    |   33 +++++++++++++++++++++++++++++++++
 11 files changed, 43 insertions(+), 249 deletions(-)


diff -urN linux-2.6.0-test1/arch/alpha/Kconfig linux-2.6.0-test1-new/arch/alpha/Kconfig
--- linux-2.6.0-test1/arch/alpha/Kconfig	2003-07-15 17:10:41.000000000 +0100
+++ linux-2.6.0-test1-new/arch/alpha/Kconfig	2003-07-18 22:21:56.000000000 +0100
@@ -579,40 +579,6 @@
 
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
@@ -636,6 +602,7 @@
 	  This driver is also available as a module and will be called
 	  srm_env then.
 
+source "fs/proc/Kconfig.kcore"
 source "fs/Kconfig.binfmt"
 
 source "drivers/parport/Kconfig"
diff -urN linux-2.6.0-test1/arch/arm/Kconfig linux-2.6.0-test1-new/arch/arm/Kconfig
--- linux-2.6.0-test1/arch/arm/Kconfig	2003-07-15 17:10:41.000000000 +0100
+++ linux-2.6.0-test1-new/arch/arm/Kconfig	2003-07-18 22:18:53.000000000 +0100
@@ -668,39 +668,7 @@
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
+source "fs/proc/Kconfig.kcore"
 source "fs/Kconfig.binfmt"
 
 source "drivers/base/Kconfig"
diff -urN linux-2.6.0-test1/arch/arm26/Kconfig linux-2.6.0-test1-new/arch/arm26/Kconfig
--- linux-2.6.0-test1/arch/arm26/Kconfig	2003-07-15 17:10:41.000000000 +0100
+++ linux-2.6.0-test1-new/arch/arm26/Kconfig	2003-07-18 22:18:21.000000000 +0100
@@ -146,39 +146,7 @@
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
+source "fs/proc/Kconfig.kcore"
 source "fs/Kconfig.binfmt"
 
 config PREEMPT
diff -urN linux-2.6.0-test1/arch/h8300/Kconfig linux-2.6.0-test1-new/arch/h8300/Kconfig
--- linux-2.6.0-test1/arch/h8300/Kconfig	2003-07-02 21:52:59.000000000 +0100
+++ linux-2.6.0-test1-new/arch/h8300/Kconfig	2003-07-18 22:22:50.000000000 +0100
@@ -134,13 +134,7 @@
 
 menu "Executable file formats"
 
-config KCORE_AOUT
-	bool
-	default y
-
-config KCORE_ELF
-	default y
-
+source "fs/proc/Kconfig.kcore"
 source "fs/Kconfig.binfmt"
 
 endmenu
diff -urN linux-2.6.0-test1/arch/i386/Kconfig linux-2.6.0-test1-new/arch/i386/Kconfig
--- linux-2.6.0-test1/arch/i386/Kconfig	2003-07-15 17:10:41.000000000 +0100
+++ linux-2.6.0-test1-new/arch/i386/Kconfig	2003-07-18 22:15:35.000000000 +0100
@@ -1156,40 +1156,7 @@
 
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
+source "fs/proc/Kconfig.kcore"
 source "fs/Kconfig.binfmt"
 
 endmenu
diff -urN linux-2.6.0-test1/arch/m68k/Kconfig linux-2.6.0-test1-new/arch/m68k/Kconfig
--- linux-2.6.0-test1/arch/m68k/Kconfig	2003-07-02 21:49:26.000000000 +0100
+++ linux-2.6.0-test1-new/arch/m68k/Kconfig	2003-07-18 22:19:30.000000000 +0100
@@ -342,40 +342,7 @@
 
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
+source "fs/proc/Kconfig.kcore"
 source "fs/Kconfig.binfmt"
 
 config ZORRO
diff -urN linux-2.6.0-test1/arch/m68knommu/Kconfig linux-2.6.0-test1-new/arch/m68knommu/Kconfig
--- linux-2.6.0-test1/arch/m68knommu/Kconfig	2003-07-15 17:10:33.000000000 +0100
+++ linux-2.6.0-test1-new/arch/m68knommu/Kconfig	2003-07-18 22:25:15.000000000 +0100
@@ -490,14 +490,7 @@
 
 menu "Executable file formats"
 
-config KCORE_AOUT
-	bool
-	default y
-
-config KCORE_ELF
-	bool
-	default y
-
+source "fs/proc/Kconfig.kcore"
 source "fs/Kconfig.binfmt"
 
 endmenu
diff -urN linux-2.6.0-test1/arch/mips/Kconfig-shared linux-2.6.0-test1-new/arch/mips/Kconfig-shared
--- linux-2.6.0-test1/arch/mips/Kconfig-shared	2003-07-02 21:40:11.000000000 +0100
+++ linux-2.6.0-test1-new/arch/mips/Kconfig-shared	2003-07-18 22:24:29.000000000 +0100
@@ -1110,31 +1110,7 @@
 
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
+source "fs/proc/Kconfig.kcore"
 source "fs/Kconfig.binfmt"
 
 config BINFMT_IRIX
diff -urN linux-2.6.0-test1/arch/sh/Kconfig linux-2.6.0-test1-new/arch/sh/Kconfig
--- linux-2.6.0-test1/arch/sh/Kconfig	2003-07-02 21:57:36.000000000 +0100
+++ linux-2.6.0-test1-new/arch/sh/Kconfig	2003-07-18 22:17:37.000000000 +0100
@@ -729,40 +729,7 @@
 
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
+source "fs/proc/Kconfig.kcore"
 source "fs/Kconfig.binfmt"
 
 endmenu
diff -urN linux-2.6.0-test1/arch/v850/Kconfig linux-2.6.0-test1-new/arch/v850/Kconfig
--- linux-2.6.0-test1/arch/v850/Kconfig	2003-07-02 21:46:55.000000000 +0100
+++ linux-2.6.0-test1-new/arch/v850/Kconfig	2003-07-18 22:23:14.000000000 +0100
@@ -236,13 +236,7 @@
 
 menu "Executable file formats"
 
-config KCORE_AOUT
-	bool
-	default y
-
-config KCORE_ELF
-	default y
-
+source "fs/proc/Kconfig.kcore"
 source "fs/Kconfig.binfmt"
 
 endmenu
diff -urN linux-2.6.0-test1/fs/proc/Kconfig.kcore linux-2.6.0-test1-new/fs/proc/Kconfig.kcore
--- linux-2.6.0-test1/fs/proc/Kconfig.kcore	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.0-test1-new/fs/proc/Kconfig.kcore	2003-07-18 22:15:02.000000000 +0100
@@ -0,0 +1,33 @@
+choice
+        prompt "Kernel core (/proc/kcore) format"
+        depends on PROC_FS
+        default KCORE_ELF
+
+config KCORE_ELF
+        bool "ELF"
+        ---help---
+          If you enabled support for /proc file system then the file
+          /proc/kcore will contain the kernel core image. This can be used
+          in gdb:
+
+          $ cd /usr/src/linux ; gdb vmlinux /proc/kcore
+
+          You have two choices here: ELF and A.OUT. Selecting ELF will make
+          /proc/kcore appear in ELF core format as defined by the Executable
+          and Linking Format specification. Selecting A.OUT will choose the
+          old "a.out" format which may be necessary for some old versions
+          of binutils or on some architectures.
+
+          This is especially useful if you have compiled the kernel with the
+          "-g" option to preserve debugging information. It is mainly used
+          for examining kernel data structures on the live kernel so if you
+          don't understand what this means or are not a kernel hacker, just
+          leave it at its default value ELF.
+
+config KCORE_AOUT
+        bool "A.OUT"
+        help
+          Not necessary unless you're using a very out-of-date binutils
+          version.  You probably want KCORE_ELF.
+
+endchoice


-- 
Spyros lair: http://www.mnementh.co.uk/   ||||   Maintainer: arm26 linux

Do not meddle in the affairs of Dragons, for you are tasty and good with
ketchup.
