Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266115AbSKOMpz>; Fri, 15 Nov 2002 07:45:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266175AbSKOMpz>; Fri, 15 Nov 2002 07:45:55 -0500
Received: from precia.cinet.co.jp ([210.166.75.133]:51586 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S266115AbSKOMpw>; Fri, 15 Nov 2002 07:45:52 -0500
Message-ID: <3DD4EE0E.283303F7@cinet.co.jp>
Date: Fri, 15 Nov 2002 21:52:30 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
X-Mailer: Mozilla 4.8C-ja  [ja/Vine] (X11; U; Linux 2.5.47-ac4-pc98smp i686)
X-Accept-Language: ja, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: PC-9800 patch for 2.5.47-ac4: not merged yet (9/15) kernel
References: <3DD4E2D5.AEF13F1@cinet.co.jp>
Content-Type: multipart/mixed;
 boundary="------------86A1402729759646A37251A3"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------86A1402729759646A37251A3
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit

This is rest of core patch under kernel/.

diffstat:
 kernel/dma.c   |    3 +++
 kernel/ksyms.c |    4 ++++
 kernel/timer.c |    5 +++++
 3 files changed, 12 insertions(+)

-- 
Osamu Tomita
tomita@cinet.co.jp
--------------86A1402729759646A37251A3
Content-Type: text/plain; charset=iso-2022-jp;
 name="kernel.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="kernel.patch"

diff -urN linux/kernel/dma.c linux98/kernel/dma.c
--- linux/kernel/dma.c	Sun Aug 11 10:41:22 2002
+++ linux98/kernel/dma.c	Wed Aug 21 09:53:59 2002
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
+#ifndef CONFIG_PC9800
 	{ 1, "cascade" },
 	{ 0, 0 },
 	{ 0, 0 },
 	{ 0, 0 }
+#endif
 };
 
 
diff -urN linux/kernel/ksyms.c linux98/kernel/ksyms.c
--- linux/kernel/ksyms.c	Wed Nov 13 14:22:53 2002
+++ linux98/kernel/ksyms.c	Wed Nov 13 14:36:21 2002
@@ -601,5 +601,9 @@
 EXPORT_SYMBOL(__per_cpu_offset);
 #endif
 
+/* Whether PC-9800 architecture or not  No:0 Yes:1 */
+int pc98 = 0;
+EXPORT_SYMBOL(pc98);
+
 /* debug */
 EXPORT_SYMBOL(dump_stack);
diff -urN linux/kernel/timer.c linux98/kernel/timer.c
--- linux/kernel/timer.c	Mon Nov 11 15:46:23 2002
+++ linux98/kernel/timer.c	Mon Nov 11 16:49:10 2002
@@ -436,8 +436,13 @@
 /*
  * Timekeeping variables
  */
+#ifndef CONFIG_PC9800
 unsigned long tick_usec = TICK_USEC; 		/* ACTHZ   period (usec) */
 unsigned long tick_nsec = TICK_NSEC(TICK_USEC);	/* USER_HZ period (nsec) */
+#else
+extern unsigned long tick_usec; 		/* ACTHZ   period (usec) */
+extern unsigned long tick_nsec;			/* USER_HZ period (nsec) */
+#endif
 
 /* The current time */
 struct timespec xtime __attribute__ ((aligned (16)));

--------------86A1402729759646A37251A3--

