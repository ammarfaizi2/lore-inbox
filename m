Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263976AbTDNWK2 (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 18:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263978AbTDNWK1 (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 18:10:27 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:13552 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263976AbTDNWJ1 (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 18:09:27 -0400
Date: Tue, 15 Apr 2003 00:21:10 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: linux-kernel@vger.kernel.org
Subject: [RFC][2.5 patch] K6-II/K6-II: enable X86_USE_3DNOW
Message-ID: <20030414222110.GK9640@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If my patch is wrong and this is a RTFM please give me a hint where to 
find the "M".

The AMD K6-II and K6-III do support 3DNow!

The patch below adds a new option for the AMD K6-II and K6-III and 
enables CONFIG_X86_USE_3DNOW.

I'm currently running 2.5.67 with this patch applied on my K6-II.

Questions:
Is it really correct to enable CONFIG_X86_USE_3DNOW?
Is the -march=k6-2 correct?

TIA
Adrian


--- linux-2.5.67/arch/i386/Kconfig.old	2003-04-14 22:17:56.000000000 +0200
+++ linux-2.5.67/arch/i386/Kconfig	2003-04-14 22:21:07.000000000 +0200
@@ -128,7 +128,8 @@
 	  - "Pentium-II" for the Intel Pentium II or pre-Coppermine Celeron.
 	  - "Pentium-III" for the Intel Pentium III or Coppermine Celeron.
 	  - "Pentium-4" for the Intel Pentium 4 or P4-based Celeron.
-	  - "K6" for the AMD K6, K6-II and K6-III (aka K6-3D).
+	  - "K6" for the AMD K6.
+	  - "K6_2" for the AMD K6-II and K6-III (aka K6-3D).
 	  - "Athlon" for the AMD K7 family (Athlon/Duron/Thunderbird).
 	  - "Crusoe" for the Transmeta Crusoe series.
 	  - "Winchip-C6" for original IDT Winchip.
@@ -200,12 +201,19 @@
 	  optimizations.
 
 config MK6
-	bool "K6/K6-II/K6-III"
+	bool "K6"
 	help
-	  Select this for an AMD K6-family processor.  Enables use of
-	  some extended instructions, and passes appropriate optimization
+	  Select this for an AMD K6 processor.  Enables use of some
+	  extended instructions, and passes appropriate optimization
 	  flags to GCC.
 
+config MK6_2
+	bool "K6-II/K6-III"
+	help
+	  Select this for an AMD K6-II and K6-III processors.  Enables
+	  use of some extended instructions, and passes appropriate
+	  optimization flags to GCC.
+
 config MK7
 	bool "Athlon/Duron/K7"
 	help
@@ -289,7 +297,7 @@
 config X86_L1_CACHE_SHIFT
 	int
 	default "4" if MELAN || M486 || M386
-	default "5" if MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCRUSOE || MCYRIXIII || MK6 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || M586 || MVIAC3_2
+	default "5" if MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCRUSOE || MCYRIXIII || MK6 || MK6_2 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || M586 || MVIAC3_2
 	default "6" if MK7 || MK8
 	default "7" if MPENTIUM4
 
@@ -335,7 +343,7 @@
 
 config X86_ALIGNMENT_16
 	bool
-	depends on MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCYRIXIII || MELAN || MK6 || M586MMX || M586TSC || M586 || M486 || MVIAC3_2
+	depends on MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCYRIXIII || MELAN || MK6 || MK6_2 || M586MMX || M586TSC || M586 || M486 || MVIAC3_2
 	default y
 
 config X86_GOOD_APIC
@@ -350,12 +358,12 @@
 
 config X86_USE_PPRO_CHECKSUM
 	bool
-	depends on MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMIII || MPENTIUMII || M686 || MK8 || MVIAC3_2
+	depends on MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCYRIXIII || MK7 || MK6 || MK6_2 || MPENTIUM4 || MPENTIUMIII || MPENTIUMII || M686 || MK8 || MVIAC3_2
 	default y
 
 config X86_USE_3DNOW
 	bool
-	depends on MCYRIXIII || MK7
+	depends on MCYRIXIII || MK6_2 || MK7
 	default y
 
 config X86_OOSTORE
@@ -478,7 +486,7 @@
 
 config X86_TSC
 	bool
-	depends on (MWINCHIP3D || MWINCHIP2 || MCRUSOE || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || MK8 || MVIAC3_2) && !X86_NUMAQ
+	depends on (MWINCHIP3D || MWINCHIP2 || MCRUSOE || MCYRIXIII || MK7 || MK6 || MK6_2 || MPENTIUM4 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || MK8 || MVIAC3_2) && !X86_NUMAQ
 	default y
 
 config X86_MCE
--- linux-2.5.67/arch/i386/Makefile.old	2003-04-14 22:23:34.000000000 +0200
+++ linux-2.5.67/arch/i386/Makefile	2003-04-14 22:25:01.000000000 +0200
@@ -39,6 +39,7 @@
 cflags-$(CONFIG_MPENTIUMIII)	+= $(call check_gcc,-march=pentium3,-march=i686)
 cflags-$(CONFIG_MPENTIUM4)	+= $(call check_gcc,-march=pentium4,-march=i686)
 cflags-$(CONFIG_MK6)		+= $(call check_gcc,-march=k6,-march=i586)
+cflags-$(CONFIG_MK6_2)		+= $(call check_gcc,-march=k6-2,-march=i586)
 cflags-$(CONFIG_MK7)		+= $(call check_gcc,-march=athlon,-march=i686 $(align)-functions=4)
 cflags-$(CONFIG_MK8)		+= $(call check_gcc,-march=k8,$(call check_gcc,-march=athlon,-march=i686 $(align)-functions=4))
 cflags-$(CONFIG_MCRUSOE)	+= -march=i686 $(align)-functions=0 $(align)-jumps=0 $(align)-loops=0
--- linux-2.5.67/include/asm-i386/module.h.old	2003-04-14 22:25:59.000000000 +0200
+++ linux-2.5.67/include/asm-i386/module.h	2003-04-14 22:26:34.000000000 +0200
@@ -30,6 +30,8 @@
 #define MODULE_PROC_FAMILY "PENTIUM4 "
 #elif defined CONFIG_MK6
 #define MODULE_PROC_FAMILY "K6 "
+#elif defined CONFIG_MK6_2
+#define MODULE_PROC_FAMILY "K6II "
 #elif defined CONFIG_MK7
 #define MODULE_PROC_FAMILY "K7 "
 #elif defined CONFIG_MK8
