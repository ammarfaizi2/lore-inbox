Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264449AbUADC3B (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 21:29:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264451AbUADC3B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 21:29:01 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:49328 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S264449AbUADC26 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 21:28:58 -0500
Date: Sun, 4 Jan 2004 03:28:48 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: Pentium M config option for 2.6
Message-ID: <20040104022848.GB14540@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since the Pentium M has 64 byte cache lines and is not a K7 or K8...  ;)

-- 
Tomas Szepe <szepe@pinerecords.com>


diff -urN a/arch/i386/Kconfig b/arch/i386/Kconfig
--- a/arch/i386/Kconfig	2004-01-04 03:10:01.000000000 +0100
+++ b/arch/i386/Kconfig	2004-01-04 03:06:09.000000000 +0100
@@ -231,6 +231,13 @@
 	  correct cache shift, and applies any applicable Pentium III
 	  optimizations.
 
+config MPENTIUMM
+	bool "Pentium M (Banias/Centrino)"
+	help
+	  Select this for Intel Pentium M chips.  This option enables
+	  compile flags optimized for the chip, uses the correct cache
+	  shift, and applies any applicable Pentium III/IV optimizations.
+
 config MK6
 	bool "K6/K6-II/K6-III"
 	help
@@ -330,7 +337,7 @@
 	default "7" if MPENTIUM4 || X86_GENERIC
 	default "4" if MELAN || M486 || M386
 	default "5" if MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCRUSOE || MCYRIXIII || MK6 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || M586 || MVIAC3_2
-	default "6" if MK7 || MK8
+	default "6" if MPENTIUMM || MK7 || MK8
 
 config RWSEM_GENERIC_SPINLOCK
 	bool
@@ -379,17 +386,17 @@
 
 config X86_GOOD_APIC
 	bool
-	depends on MK7 || MPENTIUM4 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || MK8
+	depends on MK7 || MPENTIUMM || MPENTIUM4 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || MK8
 	default y
 
 config X86_INTEL_USERCOPY
 	bool
-	depends on MPENTIUM4 || MPENTIUMIII || MPENTIUMII || M586MMX || X86_GENERIC || MK8 || MK7
+	depends on MPENTIUMM || MPENTIUM4 || MPENTIUMIII || MPENTIUMII || M586MMX || X86_GENERIC || MK8 || MK7
 	default y
 
 config X86_USE_PPRO_CHECKSUM
 	bool
-	depends on MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMIII || MPENTIUMII || M686 || MK8 || MVIAC3_2
+	depends on MWINCHIP3D || MWINCHIP2 || MWINCHIPC6 || MCYRIXIII || MK7 || MK6 || MPENTIUMM || MPENTIUM4 || MPENTIUMIII || MPENTIUMII || M686 || MK8 || MVIAC3_2
 	default y
 
 config X86_USE_3DNOW
@@ -512,7 +519,7 @@
 
 config X86_TSC
 	bool
-	depends on (MWINCHIP3D || MWINCHIP2 || MCRUSOE || MCYRIXIII || MK7 || MK6 || MPENTIUM4 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || MK8 || MVIAC3_2) && !X86_NUMAQ
+	depends on (MWINCHIP3D || MWINCHIP2 || MCRUSOE || MCYRIXIII || MK7 || MK6 || MPENTIUMM || MPENTIUM4 || MPENTIUMIII || MPENTIUMII || M686 || M586MMX || M586TSC || MK8 || MVIAC3_2) && !X86_NUMAQ
 	default y
 
 config X86_MCE
diff -urN a/arch/i386/Makefile b/arch/i386/Makefile
--- a/arch/i386/Makefile	2003-09-28 11:38:05.000000000 +0200
+++ b/arch/i386/Makefile	2004-01-04 03:02:52.000000000 +0100
@@ -35,6 +35,7 @@
 cflags-$(CONFIG_MPENTIUMII)	+= $(call check_gcc,-march=pentium2,-march=i686)
 cflags-$(CONFIG_MPENTIUMIII)	+= $(call check_gcc,-march=pentium3,-march=i686)
 cflags-$(CONFIG_MPENTIUM4)	+= $(call check_gcc,-march=pentium4,-march=i686)
+cflags-$(CONFIG_MPENTIUMM)	+= $(call check_gcc,-march=pentium4,-march=i686)
 cflags-$(CONFIG_MK6)		+= $(call check_gcc,-march=k6,-march=i586)
 # Please note, that patches that add -march=athlon-xp and friends are pointless.
 # They make zero difference whatsosever to performance at this time.
diff -urN a/include/asm-i386/module.h b/include/asm-i386/module.h
--- a/include/asm-i386/module.h	2003-08-23 01:52:22.000000000 +0200
+++ b/include/asm-i386/module.h	2004-01-04 03:08:17.000000000 +0100
@@ -28,6 +28,8 @@
 #define MODULE_PROC_FAMILY "PENTIUMIII "
 #elif defined CONFIG_MPENTIUM4
 #define MODULE_PROC_FAMILY "PENTIUM4 "
+#elif defined CONFIG_MPENTIUMM
+#define MODULE_PROC_FAMILY "PENTIUMM "
 #elif defined CONFIG_MK6
 #define MODULE_PROC_FAMILY "K6 "
 #elif defined CONFIG_MK7
