Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261261AbUJ3PBM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261261AbUJ3PBM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 11:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbUJ3O7P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 10:59:15 -0400
Received: from mail01.syd.optusnet.com.au ([211.29.132.182]:6820 "EHLO
	mail01.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261215AbUJ3Okw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 10:40:52 -0400
Message-ID: <4183A7E4.2020405@kolivas.org>
Date: Sun, 31 Oct 2004 00:40:36 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Peter Williams <pwil3058@bigpond.net.au>,
       William Lee Irwin III <wli@holomorphy.com>,
       Alexander Nyberg <alexn@dsv.su.se>,
       Nick Piggin <nickpiggin@yahoo.com.au>
Subject: [PATCH][plugsched 21/28] Move private macro
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig98542F4DA5B2F69358F902AE"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig98542F4DA5B2F69358F902AE
Content-Type: multipart/mixed;
 boundary="------------070503010703080601090504"

This is a multi-part message in MIME format.
--------------070503010703080601090504
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Move private macro


--------------070503010703080601090504
Content-Type: text/x-patch;
 name="move_ingosched_macros.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="move_ingosched_macros.diff"

Take the MAX_PRIO macro and comments out of sched.h to allow more
flexible range of dynamic priorities and scheduler designs.

Signed-off-by: Con Kolivas <kernel@kolivas.org>


Index: linux-2.6.10-rc1-mm2-plugsched1/include/linux/sched.h
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/include/linux/sched.h	2004-10-29 21:47:52.739595073 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/include/linux/sched.h	2004-10-29 21:48:10.494824131 +1000
@@ -328,11 +328,6 @@ struct signal_struct {
 };
 
 /*
- * Priority of a process goes from 0..MAX_PRIO-1, valid RT
- * priority is 0..MAX_RT_PRIO-1, and SCHED_NORMAL tasks are
- * in the range MAX_RT_PRIO..MAX_PRIO-1. Priority values
- * are inverted: lower p->prio value means higher priority.
- *
  * The MAX_USER_RT_PRIO value allows the actual maximum
  * RT priority to be separate from the value exported to
  * user-space.  This allows kernel threads to set their
@@ -343,8 +338,6 @@ struct signal_struct {
 #define MAX_USER_RT_PRIO	100
 #define MAX_RT_PRIO		MAX_USER_RT_PRIO
 
-#define MAX_PRIO		(MAX_RT_PRIO + 40)
-
 extern int rt_task(task_t *p);
 
 /*
@@ -515,6 +508,8 @@ struct mempolicy;
 
 #include <linux/scheduler.h>
 
+extern struct sched_drv *scheduler;
+
 struct task_struct {
 	volatile long state;	/* -1 unrunnable, 0 runnable, >0 stopped */
 	struct thread_info *thread_info;
Index: linux-2.6.10-rc1-mm2-plugsched1/kernel/sched.c
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/kernel/sched.c	2004-10-29 21:48:08.237176468 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/kernel/sched.c	2004-10-29 21:48:10.495823975 +1000
@@ -59,6 +59,15 @@
 #endif
 
 /*
+ * Priority of a process goes from 0..MAX_PRIO-1, valid RT
+ * priority is 0..MAX_RT_PRIO-1, and SCHED_NORMAL tasks are
+ * in the range MAX_RT_PRIO..MAX_PRIO-1. Priority values
+ * are inverted: lower p->prio value means higher priority.
+ */
+
+#define MAX_PRIO		(MAX_RT_PRIO + 40)
+
+/*
  * Convert user-nice values [ -20 ... 0 ... 19 ]
  * to static priority [ MAX_RT_PRIO..MAX_PRIO-1 ],
  * and back.


--------------070503010703080601090504--

--------------enig98542F4DA5B2F69358F902AE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBg6fkZUg7+tp6mRURAmIqAJ9n2JKsp08OpCMPoBNFni+KlxxaDwCeJB49
1qsQYLn6BzgE5NnWYs7qAZs=
=hhZ+
-----END PGP SIGNATURE-----

--------------enig98542F4DA5B2F69358F902AE--
