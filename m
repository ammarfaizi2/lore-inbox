Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267273AbTBLN7N>; Wed, 12 Feb 2003 08:59:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267196AbTBLN7M>; Wed, 12 Feb 2003 08:59:12 -0500
Received: from chii.cinet.co.jp ([61.197.228.217]:40832 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S267273AbTBLN6h>; Wed, 12 Feb 2003 08:58:37 -0500
Date: Wed, 12 Feb 2003 23:07:19 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCHSET] PC-9800 subarch. support for 2.5.60 (22/34) kernel
Message-ID: <20030212140719.GW1551@yuzuki.cinet.co.jp>
References: <20030212131737.GA1551@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030212131737.GA1551@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patchset to support NEC PC-9800 subarchitecture
against 2.5.60 (22/34).

Misc files for support PC98.

- Osamu Tomita

diff -Nru linux/kernel/dma.c linux98/kernel/dma.c
--- linux/kernel/dma.c	2002-08-11 10:41:22.000000000 +0900
+++ linux98/kernel/dma.c	2002-08-21 09:53:59.000000000 +0900
@@ -9,6 +9,7 @@
  *   [It also happened to remove the sizeof(char *) == sizeof(int)
  *   assumption introduced because of those /proc/dma patches. -- Hennus]
  */
+#include <linux/config.h>
 #include <linux/module.h>
 #include <linux/kernel.h>
 #include <linux/errno.h>
@@ -62,10 +63,12 @@
 	{ 0, 0 },
 	{ 0, 0 },
 	{ 0, 0 },
+#ifndef CONFIG_X86_PC9800
 	{ 1, "cascade" },
 	{ 0, 0 },
 	{ 0, 0 },
 	{ 0, 0 }
+#endif
 };
 
 
diff -Nru linux-2.5.60/kernel/timer.c linux98-2.5.60/kernel/timer.c
--- linux-2.5.60/kernel/timer.c	2003-02-11 03:38:50.000000000 +0900
+++ linux98-2.5.60/kernel/timer.c	2003-02-11 13:04:49.000000000 +0900
@@ -437,8 +437,13 @@
 /*
  * Timekeeping variables
  */
+#ifndef CONFIG_X86_PC9800
 unsigned long tick_usec = TICK_USEC; 		/* ACTHZ   period (usec) */
 unsigned long tick_nsec = TICK_NSEC(TICK_USEC);	/* USER_HZ period (nsec) */
+#else
+extern unsigned long tick_usec; 		/* ACTHZ   period (usec) */
+extern unsigned long tick_nsec;			/* USER_HZ period (nsec) */
+#endif
 
 /* The current time */
 struct timespec xtime __attribute__ ((aligned (16)));
diff -Nru linux/include/linux/kernel.h linux98/include/linux/kernel.h
--- linux/include/linux/kernel.h	2003-01-14 14:58:03.000000000 +0900
+++ linux98/include/linux/kernel.h	2003-01-14 23:11:42.000000000 +0900
@@ -224,4 +224,10 @@
 #define __FUNCTION__ (__func__)
 #endif
 
+#ifdef CONFIG_X86_PC9800
+#define pc98 1
+#else
+#define pc98 0
+#endif
+
 #endif
