Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261158AbUJ3PUt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbUJ3PUt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 11:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261154AbUJ3PUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 11:20:49 -0400
Received: from mail16.syd.optusnet.com.au ([211.29.132.197]:21970 "EHLO
	mail16.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261212AbUJ3Okk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 10:40:40 -0400
Message-ID: <4183A7D9.9030307@kolivas.org>
Date: Sun, 31 Oct 2004 00:40:25 +1000
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
Subject: [PATCH][plugsched 20/28] Identify ingosched
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigB55183A8EDA5036F56C6E512"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigB55183A8EDA5036F56C6E512
Content-Type: multipart/mixed;
 boundary="------------020209050606010703090903"

This is a multi-part message in MIME format.
--------------020209050606010703090903
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Identify ingosched


--------------020209050606010703090903
Content-Type: text/x-patch;
 name="combine_headers.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="combine_headers.diff"

Give ingosched it's unique identity.

Signed-off-by: Con Kolivas <kernel@kolivas.org>


Index: linux-2.6.10-rc1-mm2-plugsched1/include/linux/scheduler.h
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/include/linux/scheduler.h	2004-10-29 21:48:05.209648954 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/include/linux/scheduler.h	2004-10-29 21:48:08.235176780 +1000
@@ -1,5 +1,13 @@
+/*
+ * include/linux/scheduler.h
+ * This contains the driver struct for all the exported per-cpu-scheduler
+ * functions, and the private per-scheduler data in task_struct.
+ */
 #define SCHED_NAME_MAX	(16)
 
+/*
+ * This is the main scheduler driver struct.
+ */
 struct sched_drv
 {
 	char cpusched_name[SCHED_NAME_MAX];
@@ -40,6 +48,11 @@ struct sched_drv
 #endif
 };
 
+/*
+ * All private per-scheduler entries in task_struct are defined here as
+ * separate structs placed into the cpusched union in task_struct.
+ */
+
 struct cpusched_ingo {
 	int prio;
 	struct list_head run_list;
Index: linux-2.6.10-rc1-mm2-plugsched1/kernel/sched.c
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/kernel/sched.c	2004-10-29 21:48:05.211648642 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/kernel/sched.c	2004-10-29 21:48:08.237176468 +1000
@@ -1,7 +1,7 @@
 /*
  *  kernel/sched.c
  *
- *  Kernel scheduler and related syscalls
+ *  This is "ingosched"; the default cpu scheduler.
  *
  *  Copyright (C) 1991-2002  Linus Torvalds
  *
Index: linux-2.6.10-rc1-mm2-plugsched1/kernel/scheduler.c
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/kernel/scheduler.c	2004-10-29 21:48:05.212648486 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/kernel/scheduler.c	2004-10-29 21:48:08.238176312 +1000
@@ -879,7 +879,7 @@ EXPORT_SYMBOL(complete_all);
 
 extern struct sched_drv ingo_sched_drv;
 
-static struct sched_drv *scheduler = &ingo_sched_drv;
+struct sched_drv *scheduler = &ingo_sched_drv;
 
 static int __init scheduler_setup(char *str)
 {


--------------020209050606010703090903--

--------------enigB55183A8EDA5036F56C6E512
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBg6fZZUg7+tp6mRURApLhAJ98h3Xr5dT/9MHWNC4MVtAuktbL5gCdFo+n
TJYWgvfMBshQHZRi4rZUZFc=
=kwUo
-----END PGP SIGNATURE-----

--------------enigB55183A8EDA5036F56C6E512--
