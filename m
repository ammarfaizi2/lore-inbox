Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264236AbTEGTTA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 15:19:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264227AbTEGTR1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 15:17:27 -0400
Received: from [217.157.19.70] ([217.157.19.70]:4619 "EHLO jehova.dsm.dk")
	by vger.kernel.org with ESMTP id S264217AbTEGTQ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 15:16:28 -0400
Date: Wed, 7 May 2003 21:28:55 +0200 (CEST)
From: Thomas Horsten <thomas@horsten.com>
X-X-Sender: thomas@jehova.dsm.dk
To: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5.69 Changes to Kconfig and i386 Makefile to include
 support for various K7 optimizations
Message-ID: <Pine.LNX.4.40.0305072126450.30616-100000@jehova.dsm.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I made this patch to support the various K7 model-specific optimizations that
 the later GCC compilers can use.

Please have a look, and pass me any comments.

I also have the same patch for 2.4, if you are interested it's available on
 my Linux page on http://www.infowares.com/linux

// Thomas

diff -r -u linux-2.5.69.orig/arch/i386/Kconfig linux-2.5.69/arch/i386/Kconfig
--- linux-2.5.69.orig/arch/i386/Kconfig	2003-05-05 00:53:02.000000000 +0100
+++ linux-2.5.69/arch/i386/Kconfig	2003-05-07 18:00:11.000000000 +0100
@@ -273,6 +273,48 @@

 endchoice

+#
+# Select the exact K7 model for optimization purposes
+#
+choice
+	prompt "K7 Model Selection"
+	depends on MK7
+	default K7_STD
+
+config K7_STD
+	bool "Standard Athlon/Duron/Other"
+	help
+	  Select this if you have a standard Athlon or Duron processor, or
+	  another varian that is not listed below. Kernels compiled with this
+	  option should work on a system that uses any member of the K7 family
+	  of processors.
+
+config K7_TBIRD
+	bool "Athlon Thunderbird"
+	help
+	  Select this if you have the "Thunderbird" version of the Athlon CPU,
+	  to enable optimizations specific to that processor.
+
+config K7_ATHLON4
+	bool "Athlon 4 (Palomino)"
+	help
+	  Select this if you have an Athlon 4 CPU, also known as "Palomino",
+	  to enable optimizations specific to that processor.
+
+config K7_ATHLONXP
+	bool "Athlon XP"
+	help
+	  Select this if you have an Athlon XP CPU, to enable optimizations
+	  specific to that processor.
+
+config K7_ATHLONMP
+	bool "Athlon MP"
+	help
+	  Select this if you have an Athlon XP CPU, to enable optimizations
+	  specific to that processor.
+
+endchoice
+
 config X86_GENERIC
        bool "Generic x86 support"
        help
diff -r -u linux-2.5.69.orig/arch/i386/Makefile
 linux-2.5.69/arch/i386/Makefile ---
 linux-2.5.69.orig/arch/i386/Makefile	2003-05-05 00:53:12.000000000 +0100 +++
 linux-2.5.69/arch/i386/Makefile	2003-05-07 18:10:08.000000000 +0100 @@ -39,7
 +39,11 @@
 cflags-$(CONFIG_MPENTIUMIII)	+= $(call
 check_gcc,-march=pentium3,-march=i686) cflags-$(CONFIG_MPENTIUM4)	+= $(call
 check_gcc,-march=pentium4,-march=i686) cflags-$(CONFIG_MK6)		+= $(call
 check_gcc,-march=k6,-march=i586)
-cflags-$(CONFIG_MK7)		+= $(call check_gcc,-march=athlon,-march=i686
 $(align)-functions=4) +cflags-$(CONFIG_K7_STD)		+= $(call
 check_gcc,-march=athlon,-march=i686 $(align)-functions=4)
 +cflags-$(CONFIG_K7_TBIRD)	+= $(call check_gcc,-march=athlon-tbird,$(call
 check_gcc,-march=athlon,-march=i686 $(align)-functions=4))
 +cflags-$(CONFIG_K7_ATHLON4)	+= $(call check_gcc,-march=athlon-4,$(call
 check_gcc,-march=athlon,-march=i686 $(align)-functions=4))
 +cflags-$(CONFIG_K7_ATHLONXP)	+= $(call check_gcc,-march=athlon-xp,$(call
 check_gcc,-march=athlon,-march=i686 $(align)-functions=4))
 +cflags-$(CONFIG_K7_ATHLONMP)	+= $(call check_gcc,-march=athlon-mp,$(call
 check_gcc,-march=athlon,-march=i686 $(align)-functions=4))
 cflags-$(CONFIG_MK8)		+= $(call check_gcc,-march=k8,$(call
 check_gcc,-march=athlon,-march=i686 $(align)-functions=4))
 cflags-$(CONFIG_MCRUSOE)	+= -march=i686 $(align)-functions=0
 $(align)-jumps=0 $(align)-loops=0 cflags-$(CONFIG_MWINCHIPC6)	+= $(call
 check_gcc,-march=winchip-c6,-march=i586)

