Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267292AbTASGmy>; Sun, 19 Jan 2003 01:42:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267386AbTASGmW>; Sun, 19 Jan 2003 01:42:22 -0500
Received: from yuzuki.cinet.co.jp ([61.197.228.219]:59010 "EHLO
	yuzuki.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S267292AbTASGmK>; Sun, 19 Jan 2003 01:42:10 -0500
Date: Sun, 19 Jan 2003 15:51:01 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCHSET] PC-9800 sub-arch (17/29) kernel
Message-ID: <20030119065101.GP2965@yuzuki.cinet.co.jp>
References: <20030119051043.GA2662@yuzuki.cinet.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030119051043.GA2662@yuzuki.cinet.co.jp>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patchset to support NEC PC-9800 subarchitecture
against 2.5.59 (17/29).

Misc files for support PC98.

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
 
 
diff -Nru linux/kernel/timer.c linux98/kernel/timer.c
--- linux/kernel/timer.c	2002-12-10 11:45:52.000000000 +0900
+++ linux98/kernel/timer.c	2002-12-16 16:14:08.000000000 +0900
@@ -434,8 +434,13 @@
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
