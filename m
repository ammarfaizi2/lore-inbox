Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262528AbVCVICZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262528AbVCVICZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 03:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262543AbVCVICZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 03:02:25 -0500
Received: from 81-223-104-78.krugerstrasse.xdsl-line.inode.at ([81.223.104.78]:131
	"EHLO mail.sk-tech.net") by vger.kernel.org with ESMTP
	id S262528AbVCVIBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 03:01:53 -0500
Date: Tue, 22 Mar 2005 09:01:43 +0100 (CET)
From: Kianusch Sayah Karadji <kianusch@sk-tech.net>
To: Andrew Morton <akpm@osdl.org>
cc: alan@lxorguk.ukuu.org.uk, dvrabel@cantab.net, lsorense@csclub.uwaterloo.ca,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Support for GEODE CPUs
In-Reply-To: <20050321231302.76b29950.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0503220852010.2618@kryx.sk-tech.net>
References: <200503081935.j28JZ433020124@hera.kernel.org>
 <1110387668.28860.205.camel@localhost.localdomain> <20050309173344.GD17865@csclub.uwaterloo.ca>
 <1110405563.3072.250.camel@localhost.localdomain> <422F8623.4030405@cantab.net>
 <1110413198.3116.278.camel@localhost.localdomain> <20050310174206.6b2f27b8.akpm@osdl.org>
 <1110538950.15927.15.camel@localhost.localdomain> <20050321154105.3c24c88e.akpm@osdl.org>
 <Pine.LNX.4.61.0503220146470.1994@localhost> <20050321231302.76b29950.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

On Mon, 21 Mar 2005, Andrew Morton wrote:

> The original patch was already applied, so I made an incremental update. 
> Please double-check it.
>
> Sometime, could you send me a little description of what the patch does 
> ("the adjustments Alan suggested") so Linus knows what we're doing to 
> his kernel?  And a Signed-off-by: line too, please.

  Changed Name/defines from "Geode GX" to "Geode GX1" for clarification

  Dropped "-march=i586" in favor of "-march=i486"

  Dopped X86_OOSTORE support for Geode GX1

Signed-off-by: Kianusch Sayah Karadji <kianusch@sk-tech.net>

---

diff -puN arch/i386/Kconfig~x86-geode-support-fixes arch/i386/Kconfig
--- 25/arch/i386/Kconfig~x86-geode-support-fixes	2005-03-21 23:09:34.000000000 -0800
+++ 25-akpm/arch/i386/Kconfig	2005-03-21 23:09:53.000000000 -0800
@@ -187,7 +187,7 @@ config M386
  	  - "Winchip-C6" for original IDT Winchip.
  	  - "Winchip-2" for IDT Winchip 2.
  	  - "Winchip-2A" for IDT Winchips with 3dNow! capabilities.
-	  - "MediaGX/Geode" for Cyrix MediaGX aka Geode.
+	  - "GeodeGX1" for Geode GX1 (Cyrix MediaGX).
  	  - "CyrixIII/VIA C3" for VIA Cyrix III or VIA C3.
  	  - "VIA C3-2 for VIA C3-2 "Nehemiah" (model 9 and above).

@@ -315,12 +315,10 @@ config MWINCHIP3D
  	  stores for this CPU, which can increase performance of some
  	  operations.

-config MGEODE
-	bool "MediaGX/Geode"
+config MGEODEGX1
+	bool "GeodeGX1"
  	help
-	  Select this for a Cyrix MediaGX aka Geode chip. Linux and GCC
-          treat this chip as a 586TSC with some extended instructions
-          and alignment reqirements.
+	  Select this for a Geode GX1 (Cyrix MediaGX) chip.

  config MCYRIXIII
  	bool "CyrixIII/VIA-C3"
@@ -372,7 +370,7 @@ config X86_L1_CACHE_SHIFT
  	int
  	default "7" if MPENTIUM4 || X86_GENERIC
  	default "4" if X86_ELAN || M486 || M386
-	default "5" if MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCRUSOE || MEFFICEON || MCYRIXIII || MK6 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || M586 || MVIAC3_2 || MGEODE
+	default "5" if MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCRUSOE || MEFFICEON || MCYRIXIII || MK6 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || M586 || MVIAC3_2 || MGEODEGX1
  	default "6" if MK7 || MK8 || MPENTIUMM

  config RWSEM_GENERIC_SPINLOCK
@@ -391,7 +389,7 @@ config GENERIC_CALIBRATE_DELAY

  config X86_PPRO_FENCE
  	bool
-	depends on M686 || M586MMX || M586TSC || M586 || M486 || M386 || MGEODE
+	depends on M686 || M586MMX || M586TSC || M586 || M486 || M386 || MGEODEGX1
  	default y

  config X86_F00F_BUG
@@ -421,7 +419,7 @@ config X86_POPAD_OK

  config X86_ALIGNMENT_16
  	bool
-	depends on MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCYRIXIII || X86_ELAN || MK6 || M586MMX || M586TSC || M586 || M486 || MVIAC3_2 || MGEODE
+	depends on MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCYRIXIII || X86_ELAN || MK6 || M586MMX || M586TSC || M586 || M486 || MVIAC3_2 || MGEODEGX1
  	default y

  config X86_GOOD_APIC
@@ -446,7 +444,7 @@ config X86_USE_3DNOW

  config X86_OOSTORE
  	bool
-	depends on (MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MGEODE) && MTRR
+	depends on (MWINCHIP3D || MWINCHIP2 || MWINCHIPC6) && MTRR
  	default y

  config HPET_TIMER
@@ -582,7 +580,7 @@ config X86_VISWS_APIC

  config X86_TSC
  	bool
-	depends on (MWINCHIP3D || MWINCHIP2 || MCRUSOE || MEFFICEON || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || MK8 || MVIAC3_2 || MGEODE) && !X86_NUMAQ
+	depends on (MWINCHIP3D || MWINCHIP2 || MCRUSOE || MEFFICEON || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || MK8 || MVIAC3_2 || MGEODEGX1) && !X86_NUMAQ
  	default y

  config X86_MCE
diff -puN arch/i386/Makefile~x86-geode-support-fixes arch/i386/Makefile
--- 25/arch/i386/Makefile~x86-geode-support-fixes	2005-03-21 23:09:34.000000000 -0800
+++ 25-akpm/arch/i386/Makefile	2005-03-21 23:09:53.000000000 -0800
@@ -14,7 +14,7 @@
  # 19990713  Artur Skawina <skawina@geocities.com>
  #           Added '-march' and '-mpreferred-stack-boundary' support
  #
-#           Kianusch Sayah Karadji <kianusch@sk-tech.net>
+# 20050320  Kianusch Sayah Karadji <kianusch@sk-tech.net>
  #           Added support for GEODE CPU

  LDFLAGS		:= -m elf_i386
@@ -54,8 +54,8 @@ cflags-$(CONFIG_MVIAC3_2)	+= $(call cc-o
  # AMD Elan support
  cflags-$(CONFIG_X86_ELAN)	+= -march=i486

-# MediaGX aka Geode support
-cflags-$(CONFIG_MGEODE)		+= $(call cc-option,-march=pentium-mmx,-march=i586)
+# Geode GX1 support
+cflags-$(CONFIG_MGEODEGX1)		+= $(call cc-option,-march=pentium-mmx,-march=i486)

  # -mregparm=3 works ok on gcc-3.0 and later
  #
diff -puN include/asm-i386/module.h~x86-geode-support-fixes include/asm-i386/module.h
--- 25/include/asm-i386/module.h~x86-geode-support-fixes	2005-03-21 23:09:34.000000000 -0800
+++ 25-akpm/include/asm-i386/module.h	2005-03-21 23:09:53.000000000 -0800
@@ -52,8 +52,8 @@ struct mod_arch_specific
  #define MODULE_PROC_FAMILY "CYRIXIII "
  #elif defined CONFIG_MVIAC3_2
  #define MODULE_PROC_FAMILY "VIAC3-2 "
-#elif CONFIG_MGEODE
-#define MODULE_PROC_FAMILY "GEODE "
+#elif CONFIG_MGEODEGX1
+#define MODULE_PROC_FAMILY "GEODEGX1 "
  #else
  #error unknown processor family
  #endif
_
