Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263711AbUALX0i (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 18:26:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263723AbUALX0i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 18:26:38 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:20437 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S263711AbUALX0d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 18:26:33 -0500
Date: Tue, 13 Jan 2004 00:26:21 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [2/3] add Pentium M and Pentium-4 M options
Message-ID: <20040112232621.GR9677@fs.tum.de>
References: <20040112230839.GP9677@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040112230839.GP9677@fs.tum.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

add Pentium M and Pentium-4 M options:
- add MPENTIUMM (equivalent to PENTIUMIII except for a bigger
  X86_L1_CACHE_SHIFT)
- document that MPENTIUM4 is the right choice for a Pentium-4 M


diffstat output:

 arch/i386/Kconfig         |   28 +++++++++++++++++-----------
 arch/i386/Makefile        |    1 +
 include/asm-i386/module.h |    4 +++-
 3 files changed, 21 insertions(+), 12 deletions(-)


--- linux-2.6.1/include/asm-i386/module.h.old	2004-01-10 15:12:39.000000000 +0100
+++ linux-2.6.1/include/asm-i386/module.h	2004-01-10 15:24:14.000000000 +0100
@@ -26,6 +26,8 @@
 #define MODULE_PROC_FAMILY "PENTIUMII "
 #elif defined CONFIG_MPENTIUMIII
 #define MODULE_PROC_FAMILY "PENTIUMIII "
+#elif defined CONFIG_MPENTIUMM
+#define MODULE_PROC_FAMILY "PENTIUMM "
 #elif defined CONFIG_MPENTIUM4
 #define MODULE_PROC_FAMILY "PENTIUM4 "
 #elif defined CONFIG_MK6
@@ -49,7 +51,7 @@
 #elif CONFIG_MVIAC3_2
 #define MODULE_PROC_FAMILY "VIAC3-2 "
 #else
-#error unknown processor family
+#define MODULE_PROC_FAMILY "this needs to be fixed"
 #endif
 
 #define MODULE_ARCH_VERMAGIC MODULE_PROC_FAMILY
--- linux-2.6.1-mm2/arch/i386/Kconfig.old	2004-01-13 00:21:54.000000000 +0100
+++ linux-2.6.1-mm2/arch/i386/Kconfig	2004-01-13 00:23:53.000000000 +0100
@@ -222,14 +222,20 @@
 	  extended prefetch instructions in addition to the Pentium II
 	  extensions.
 
+config MPENTIUMM
+	bool "Pentium M"
+	help
+	  Select this for Intel Pentium M (not Pentium-4 M)
+	  notebook chips.
+
 config MPENTIUM4
-	bool "Pentium-4/Celeron(P4-based)/Xeon"
+	bool "Pentium-4/Celeron(P4-based)/Pentium-4 M/Xeon"
 	help
-	  Select this for Intel Pentium 4 chips.  This includes both
-	  the Pentium 4 and P4-based Celeron chips.  This option
-	  enables compile flags optimized for the chip, uses the
-	  correct cache shift, and applies any applicable Pentium III
-	  optimizations.
+	  Select this for Intel Pentium 4 chips.  This includes the
+	  Pentium 4, P4-based Celeron and Xeon, and Pentium-4 M
+	  (not Pentium M) chips.  This option enables compile flags
+	  optimized for the chip, uses the correct cache shift, and
+	  applies any applicable Pentium III optimizations.
 
 config MK6
 	bool "K6/K6-II/K6-III"
@@ -329,7 +335,7 @@
 	int
 	default "7" if MPENTIUM4 || X86_GENERIC
 	default "4" if MELAN || M486 || M386
-	default "5" if MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCRUSOE || MCYRIXIII || MK6 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || M586 || MVIAC3_2
+	default "5" if MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCRUSOE || MCYRIXIII || MK6 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || M586 || MVIAC3_2
 	default "6" if MK7 || MK8
 
 config RWSEM_GENERIC_SPINLOCK
@@ -379,17 +385,17 @@
 
 config X86_GOOD_APIC
 	bool
-	depends on MK7 || MPENTIUM4 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || MK8
+	depends on MK7 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || MK8
 	default y
 
 config X86_INTEL_USERCOPY
 	bool
-	depends on MPENTIUM4 || MPENTIUMIII || MPENTIUMII || M586MMX || X86_GENERIC || MK8 || MK7
+	depends on MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M586MMX || X86_GENERIC || MK8 || MK7
 	default y
 
 config X86_USE_PPRO_CHECKSUM
 	bool
-	depends on MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMIII || MPENTIUMII || M686 || MK8 || MVIAC3_2
+	depends on MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || MK8 || MVIAC3_2
 	default y
 
 config X86_USE_3DNOW
@@ -561,7 +567,7 @@
 
 config X86_TSC
 	bool
-	depends on (MWINCHIP3D || MWINCHIP2 || MCRUSOE || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || MK8 || MVIAC3_2) && !X86_NUMAQ
+	depends on (MWINCHIP3D || MWINCHIP2 || MCRUSOE || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || MK8 || MVIAC3_2) && !X86_NUMAQ
 	default y
 
 config X86_MCE
--- linux-2.6.1-mm2/arch/i386/Makefile.old	2004-01-13 00:21:45.000000000 +0100
+++ linux-2.6.1-mm2/arch/i386/Makefile	2004-01-13 00:21:58.000000000 +0100
@@ -34,6 +34,7 @@
 cflags-$(CONFIG_M686)		+= -march=i686
 cflags-$(CONFIG_MPENTIUMII)	+= $(call check_gcc,-march=pentium2,-march=i686)
 cflags-$(CONFIG_MPENTIUMIII)	+= $(call check_gcc,-march=pentium3,-march=i686)
+cflags-$(CONFIG_MPENTIUMM)	+= $(call check_gcc,-march=pentium3,-march=i686)
 cflags-$(CONFIG_MPENTIUM4)	+= $(call check_gcc,-march=pentium4,-march=i686)
 cflags-$(CONFIG_MK6)		+= -march=k6
 # Please note, that patches that add -march=athlon-xp and friends are pointless.
