Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268039AbTCFSdO>; Thu, 6 Mar 2003 13:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268149AbTCFSdN>; Thu, 6 Mar 2003 13:33:13 -0500
Received: from ip68-107-142-198.tc.ph.cox.net ([68.107.142.198]:62113 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP
	id <S268039AbTCFSdH>; Thu, 6 Mar 2003 13:33:07 -0500
Date: Thu, 6 Mar 2003 11:43:32 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Gabriel Paubert <paubert@iram.es>, randy.dunlap@verizon.net,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH] move SWAP option in menu
Message-ID: <20030306184332.GA23580@ip68-0-152-218.tc.ph.cox.net>
References: <3E657EBD.59E167D6@verizon.net> <20030305181748.GA11729@iram.es> <20030305131444.1b9b0cf2.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030305131444.1b9b0cf2.rddunlap@osdl.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 05, 2003 at 01:14:44PM -0800, Randy.Dunlap wrote:
> On Wed, 5 Mar 2003 19:17:48 +0100 Gabriel Paubert <paubert@iram.es> wrote:
> 
> | On Tue, Mar 04, 2003 at 08:36:13PM -0800, Randy.Dunlap wrote:
> | > Hi,
> | > 
> | > Please apply this patch (option B of 2 choices) from
> | > Tomas Szepe to move the SWAP option into the General Setup
> | > menu.
> | > 
> | > Patch is to 2.5.64.
> | > 
> [snip]
> | 
> | Why restrict it to Intel only? I don't know if it works properly on
> | other architectures, but at least it would give people the opportunity 
> | to test it on embedded PPC/Arm/MIPS/CRIS/whatever.
> | 
> | >From a quick grep over a recent BK tree, the only files who have 
> | sections conditional on CONFIG_SWAP are:
> | 
> | include/linux/page-flags.h
> | include/linux/swap.h
> | mm/vmscan.c
> | mm/Makefile
> | 
> | no architecture specific code at all. From a quick look, the
> | conditionals are rather simple (most of them are replacements of
> | actual functions by dummies) and should work on all architectures.
> | Please let people test it on non-X86, after all it's still a 
> | development kernel. Any breakage is unlikely to be serious and 
> | embedded people are going to be the most interested since it 
> | saves some space.
> 
> OK, please send a patch.

How's this look?  I picked MMU=x implies SWAP=x for defaults, just
because that's how they were before...

===== arch/alpha/Kconfig 1.10 vs edited =====
--- 1.10/arch/alpha/Kconfig	Tue Feb 18 16:57:50 2003
+++ edited/arch/alpha/Kconfig	Thu Mar  6 11:36:47 2003
@@ -15,10 +15,6 @@
 	bool
 	default y
 
-config SWAP
-	bool
-	default y
-
 config UID16
 	bool
 
===== arch/arm/Kconfig 1.9 vs edited =====
--- 1.9/arch/arm/Kconfig	Sat Feb 15 02:34:08 2003
+++ edited/arch/arm/Kconfig	Thu Mar  6 11:36:56 2003
@@ -20,10 +20,6 @@
 	bool
 	default y
 
-config SWAP
-	bool
-	default y
-
 config EISA
 	bool
 	---help---
===== arch/cris/Kconfig 1.5 vs edited =====
--- 1.5/arch/cris/Kconfig	Sun Feb  9 18:29:49 2003
+++ edited/arch/cris/Kconfig	Thu Mar  6 11:37:00 2003
@@ -9,10 +9,6 @@
 	bool
 	default y
 
-config SWAP
-	bool
-	default y
-
 config UID16
 	bool
 	default y
===== arch/i386/Kconfig 1.46 vs edited =====
--- 1.46/arch/i386/Kconfig	Sun Mar  2 19:14:31 2003
+++ edited/arch/i386/Kconfig	Thu Mar  6 11:36:15 2003
@@ -18,15 +18,6 @@
 	bool
 	default y
 
-config SWAP
-	bool "Support for paging of anonymous memory"
-	default y
-	help
-	  This option allows you to choose whether you want to have support
-	  for socalled swap devices or swap files in your kernel that are
-	  used to provide more virtual memory than the actual RAM present
-	  in your computer.  If unusre say Y.
-
 config SBUS
 	bool
 
===== arch/ia64/Kconfig 1.14 vs edited =====
--- 1.14/arch/ia64/Kconfig	Sun Feb  9 18:29:49 2003
+++ edited/arch/ia64/Kconfig	Thu Mar  6 11:37:08 2003
@@ -22,10 +22,6 @@
 	bool
 	default y
 
-config SWAP
-	bool
-	default y
-
 config RWSEM_GENERIC_SPINLOCK
 	bool
 	default y
===== arch/m68k/Kconfig 1.9 vs edited =====
--- 1.9/arch/m68k/Kconfig	Sun Feb  9 18:29:49 2003
+++ edited/arch/m68k/Kconfig	Thu Mar  6 11:37:11 2003
@@ -10,10 +10,6 @@
 	bool
 	default y
 
-config SWAP
-	bool
-	default y
-
 config UID16
 	bool
 	default y
===== arch/m68knommu/Kconfig 1.6 vs edited =====
--- 1.6/arch/m68knommu/Kconfig	Tue Feb 18 03:27:38 2003
+++ edited/arch/m68knommu/Kconfig	Thu Mar  6 11:37:25 2003
@@ -9,10 +9,6 @@
 	bool
 	default n
 
-config SWAP
-	bool
-	default n
-
 config FPU
 	bool
 	default n
===== arch/mips/Kconfig 1.8 vs edited =====
--- 1.8/arch/mips/Kconfig	Sun Feb  9 18:29:49 2003
+++ edited/arch/mips/Kconfig	Thu Mar  6 11:37:29 2003
@@ -10,10 +10,6 @@
 	bool
 	default y
 
-config SWAP
-	bool
-	default y
-
 config SMP
 	bool
 	---help---
===== arch/mips64/Kconfig 1.9 vs edited =====
--- 1.9/arch/mips64/Kconfig	Sun Feb  9 18:29:49 2003
+++ edited/arch/mips64/Kconfig	Thu Mar  6 11:37:33 2003
@@ -9,10 +9,6 @@
 	bool
 	default y
 
-config SWAP
-	bool
-	default y
-
 source "init/Kconfig"
 
 
===== arch/parisc/Kconfig 1.10 vs edited =====
--- 1.10/arch/parisc/Kconfig	Sun Feb  9 18:29:49 2003
+++ edited/arch/parisc/Kconfig	Thu Mar  6 11:37:35 2003
@@ -18,10 +18,6 @@
 	bool
 	default y
 
-config SWAP
-	bool
-	default y
-
 config STACK_GROWSUP
 	bool
 	default y
===== arch/ppc/Kconfig 1.17 vs edited =====
--- 1.17/arch/ppc/Kconfig	Sun Feb  9 18:29:49 2003
+++ edited/arch/ppc/Kconfig	Thu Mar  6 11:37:47 2003
@@ -1126,22 +1126,6 @@
 config PIN_TLB
 	bool "Pinned Kernel TLBs (860 ONLY)"
 	depends on ADVANCED_OPTIONS && 8xx
-
-config SWAP
-	bool "Enable support for swap"
-	depends on ADVANCED_OPTIONS
-	help
-	  This option allows you to turn off support for swapfiles in
-	  the kernel.  This can be useful if you know that your system
-	  will never have swap.
-
-	  Say Y here unless you know what you are doing.
-
-config SWAP
-	bool
-	depends on !ADVANCED_OPTIONS
-	default y
-
 endmenu
 
 source "drivers/mtd/Kconfig"
===== arch/ppc64/Kconfig 1.13 vs edited =====
--- 1.13/arch/ppc64/Kconfig	Thu Feb 13 01:47:26 2003
+++ edited/arch/ppc64/Kconfig	Thu Mar  6 11:37:50 2003
@@ -7,10 +7,6 @@
 	bool
 	default y
 
-config SWAP
-	bool
-	default y
-
 config UID16
 	bool
 
===== arch/s390/Kconfig 1.7 vs edited =====
--- 1.7/arch/s390/Kconfig	Mon Feb 24 11:24:34 2003
+++ edited/arch/s390/Kconfig	Thu Mar  6 11:37:54 2003
@@ -7,10 +7,6 @@
 	bool
 	default y
 
-config SWAP
-	bool
-	default y
-
 config UID16
 	bool
 	default y
===== arch/s390x/Kconfig 1.8 vs edited =====
--- 1.8/arch/s390x/Kconfig	Mon Feb 24 11:24:34 2003
+++ edited/arch/s390x/Kconfig	Thu Mar  6 11:37:59 2003
@@ -7,10 +7,6 @@
 	bool
 	default y
 
-config SWAP
-	bool
-	default y
-
 config RWSEM_GENERIC_SPINLOCK
 	bool
 
===== arch/sh/Kconfig 1.7 vs edited =====
--- 1.7/arch/sh/Kconfig	Sun Feb  9 18:29:49 2003
+++ edited/arch/sh/Kconfig	Thu Mar  6 11:38:02 2003
@@ -18,10 +18,6 @@
 	bool
 	default y
 
-config SWAP
-	bool
-	default y
-
 config UID16
 	bool
 	default y
===== arch/sparc/Kconfig 1.10 vs edited =====
--- 1.10/arch/sparc/Kconfig	Mon Mar  3 01:33:45 2003
+++ edited/arch/sparc/Kconfig	Thu Mar  6 11:38:04 2003
@@ -9,10 +9,6 @@
 	bool
 	default y
 
-config SWAP
-	bool
-	default y
-
 config UID16
 	bool
 	default y
===== arch/sparc64/Kconfig 1.15 vs edited =====
--- 1.15/arch/sparc64/Kconfig	Wed Mar  5 09:22:15 2003
+++ edited/arch/sparc64/Kconfig	Thu Mar  6 11:38:06 2003
@@ -9,10 +9,6 @@
 	bool
 	default y
 
-config SWAP
-	bool
-	default y
-
 source "init/Kconfig"
 
 
===== arch/um/Kconfig 1.8 vs edited =====
--- 1.8/arch/um/Kconfig	Wed Feb  5 21:16:01 2003
+++ edited/arch/um/Kconfig	Thu Mar  6 11:38:09 2003
@@ -7,10 +7,6 @@
 	bool
 	default y
 
-config SWAP
-	bool
-	default y
-
 mainmenu "Linux/Usermode Kernel Configuration"
 
 config ISA
===== arch/v850/Kconfig 1.7 vs edited =====
--- 1.7/arch/v850/Kconfig	Tue Feb 18 19:40:02 2003
+++ edited/arch/v850/Kconfig	Thu Mar  6 11:38:13 2003
@@ -10,9 +10,6 @@
 config MMU
        	bool
 	default n
-config SWAP
-	bool
-	default n
 config UID16
 	bool
 	default n
===== arch/x86_64/Kconfig 1.15 vs edited =====
--- 1.15/arch/x86_64/Kconfig	Wed Feb 12 06:38:20 2003
+++ edited/arch/x86_64/Kconfig	Thu Mar  6 11:38:19 2003
@@ -24,10 +24,6 @@
 	bool
 	default y
 
-config SWAP
-	bool
-	default y
-
 config ISA
 	bool
 
===== init/Kconfig 1.10 vs edited =====
--- 1.10/init/Kconfig	Mon Feb  3 13:19:37 2003
+++ edited/init/Kconfig	Thu Mar  6 11:41:51 2003
@@ -37,6 +37,16 @@
 
 menu "General setup"
 
+config SWAP
+	bool "Support for paging of anonymous memory"
+	default y if MMU
+	default n if !MMU
+	help
+	  This option allows you to choose whether you want to have support
+	  for socalled swap devices or swap files in your kernel that are
+	  used to provide more virtual memory than the actual RAM present
+	  in your computer.  If unusre say Y.
+
 config SYSVIPC
 	bool "System V IPC"
 	---help---

-- 
Tom Rini
http://gate.crashing.org/~trini/
