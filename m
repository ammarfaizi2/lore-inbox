Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265901AbSKFSac>; Wed, 6 Nov 2002 13:30:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265945AbSKFSab>; Wed, 6 Nov 2002 13:30:31 -0500
Received: from precia.cinet.co.jp ([210.166.75.133]:45952 "EHLO
	precia.cinet.co.jp") by vger.kernel.org with ESMTP
	id <S265901AbSKFSa0>; Wed, 6 Nov 2002 13:30:26 -0500
Message-ID: <3DC9614B.A5F2B8D6@cinet.co.jp>
Date: Thu, 07 Nov 2002 03:36:59 +0900
From: Osamu Tomita <tomita@cinet.co.jp>
X-Mailer: Mozilla 4.8C-ja  [ja/Vine] (X11; U; Linux 2.5.45-pc98smp i686)
X-Accept-Language: ja, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCHSET 11/17] support PC-9800 against 2.5.45-ac1 (kernel)
References: <3DC94C7B.79DE5EBC@cinet.co.jp>
Content-Type: multipart/mixed;
 boundary="------------6CAB9E442477D46EC15F4ED8"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------6CAB9E442477D46EC15F4ED8
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit

This patch includes linux/kernel/* files changes.

diffstat:
 kernel/dma.c   |    3 +++
 kernel/ksyms.c |    4 ++++
 kernel/timer.c |    5 +++++
 3 files changed, 12 insertions(+)

-- 
Osamu Tomita
--------------6CAB9E442477D46EC15F4ED8
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
--- linux/kernel/ksyms.c	Tue Nov  5 10:16:25 2002
+++ linux98/kernel/ksyms.c	Wed Nov  6 10:02:10 2002
@@ -602,5 +602,9 @@
 EXPORT_SYMBOL(__per_cpu_offset);
 #endif
 
+/* Whether PC-9800 architecture or not  No:0 Yes:1 */
+int pc98 = 0;
+EXPORT_SYMBOL(pc98);
+
 /* debug */
 EXPORT_SYMBOL(dump_stack);
diff -urN linux/kernel/timer.c linux98/kernel/timer.c
--- linux/kernel/timer.c	Thu Oct 31 13:23:44 2002
+++ linux98/kernel/timer.c	Thu Oct 31 17:36:24 2002
@@ -400,8 +400,13 @@
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

--------------6CAB9E442477D46EC15F4ED8--

