Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279364AbRJWKuk>; Tue, 23 Oct 2001 06:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279363AbRJWKub>; Tue, 23 Oct 2001 06:50:31 -0400
Received: from sj-msg-core-1.cisco.com ([171.71.163.11]:50414 "EHLO
	sj-msg-core-1.cisco.com") by vger.kernel.org with ESMTP
	id <S279362AbRJWKuQ>; Tue, 23 Oct 2001 06:50:16 -0400
Date: Tue, 23 Oct 2001 16:20:35 +0530 (IST)
From: Manik Raina <manik@cisco.com>
To: <linux-kernel@vger.kernel.org>
cc: <azu@sysgo.de>
Subject: [PATCH] : preventing multiple includes of the same header file
Message-ID: <Pine.GSO.4.33.0110231618100.29108-100000@cbin2-view1.cisco.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This patch should prevent multiple inclusions of some header
files in include/asm-ppc/

thanks
Manik

Index: serial.h
===================================================================
RCS file: /vger/linux/include/asm-ppc/serial.h,v
retrieving revision 1.14
diff -u -r1.14 serial.h
--- serial.h	23 May 2001 03:53:37 -0000	1.14
+++ serial.h	23 Oct 2001 10:45:31 -0000
@@ -6,6 +6,9 @@
  */

 #ifdef __KERNEL__
+#ifndef __PPC_SERIAL_H__
+#define __PPC_SERIAL_H__
+
 #include <linux/config.h>

 #ifdef CONFIG_GEMINI
@@ -133,4 +136,5 @@
 	MCA_SERIAL_PORT_DFNS

 #endif /* !CONFIG_GEMINI and others */
+#endif /* __PPC_SERIAL_H__ */
 #endif /* __KERNEL__ */
Index: smplock.h
===================================================================
RCS file: /vger/linux/include/asm-ppc/smplock.h,v
retrieving revision 1.6
diff -u -r1.6 smplock.h
--- smplock.h	23 May 2001 03:53:37 -0000	1.6
+++ smplock.h	23 Oct 2001 10:45:31 -0000
@@ -7,6 +7,9 @@
  * Default SMP lock implementation
  */
 #ifdef __KERNEL__
+#ifndef __PPC_SMPLOCK_H__
+#define __PPC_SMPLOCK_H__
+
 #include <linux/interrupt.h>
 #include <linux/spinlock.h>

@@ -53,4 +56,5 @@
 	if (--current->lock_depth < 0)
 		spin_unlock(&kernel_flag);
 }
+#endif /* __PPC_SMPLOCK_H__ */
 #endif /* __KERNEL__ */
Index: time.h
===================================================================
RCS file: /vger/linux/include/asm-ppc/time.h,v
retrieving revision 1.10
diff -u -r1.10 time.h
--- time.h	28 Aug 2001 21:33:28 -0000	1.10
+++ time.h	23 Oct 2001 10:45:31 -0000
@@ -9,6 +9,9 @@
  */

 #ifdef __KERNEL__
+#ifndef __PPC_TIME_H__
+#define __PPC_TIME_H__
+
 #include <linux/config.h>
 #include <linux/mc146818rtc.h>
 #include <linux/threads.h>
@@ -136,4 +139,5 @@
 ({unsigned z; asm ("mulhwu %0,%1,%2" : "=r" (z) : "r" (x), "r" (y)); z;})

 unsigned mulhwu_scale_factor(unsigned, unsigned);
+#endif /* __PPC_TIME_H__ */
 #endif /* __KERNEL__ */
Index: uninorth.h
===================================================================
RCS file: /vger/linux/include/asm-ppc/uninorth.h,v
retrieving revision 1.5
diff -u -r1.5 uninorth.h
--- uninorth.h	28 Aug 2001 21:33:28 -0000	1.5
+++ uninorth.h	23 Oct 2001 10:45:31 -0000
@@ -7,7 +7,8 @@
  *
  */
 #ifdef __KERNEL__
-
+#ifndef __PPC_UNINORTH_H__
+#define __PPC_UNINORTH_H__

 /*
  * Uni-N config space reg. definitions
@@ -131,4 +132,5 @@

 /* Uninorth 1.5 rev. has additional perf. monitor registers at 0xf00-0xf50 */

+#endif /* __PPC_UNINORTH_H__ */
 #endif /* __KERNEL__ */

