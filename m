Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261195AbUJ3Osq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261195AbUJ3Osq (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 10:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261233AbUJ3OsS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 10:48:18 -0400
Received: from mail03.syd.optusnet.com.au ([211.29.132.184]:30926 "EHLO
	mail03.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261195AbUJ3Oil (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 10:38:41 -0400
Message-ID: <4183A764.6070509@kolivas.org>
Date: Sun, 31 Oct 2004 00:38:28 +1000
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
Subject: [PATCH][plugsched 9/28] Make yield private
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigE1E352EF79AC9B06E96B93E2"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigE1E352EF79AC9B06E96B93E2
Content-Type: multipart/mixed;
 boundary="------------020605030006040109090009"

This is a multi-part message in MIME format.
--------------020605030006040109090009
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Make yield private


--------------020605030006040109090009
Content-Type: text/x-patch;
 name="privatise_yield.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="privatise_yield.diff"

Yield() implementation is scheduler dependant; privatise it.

Signed-off-by: Con Kolivas <kernel@kolivas.org>


Index: linux-2.6.10-rc1-mm2-plugsched1/kernel/sched.c
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/kernel/sched.c	2004-10-29 21:47:01.213636390 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/kernel/sched.c	2004-10-29 21:47:03.114339760 +1000
@@ -3162,20 +3162,6 @@ static long ingo_sys_sched_yield(void)
 	return 0;
 }
 
-/**
- * yield - yield the current processor to other threads.
- *
- * this is a shortcut for kernel-space yielding - it marks the
- * thread runnable and calls sys_sched_yield().
- */
-void __sched yield(void)
-{
-	set_current_state(TASK_RUNNING);
-	sys_sched_yield();
-}
-
-EXPORT_SYMBOL(yield);
-
 /*
  * This task is about to go to sleep on IO.  Increment rq->nr_iowait so
  * that process accounting knows that this is a task in IO wait state.
Index: linux-2.6.10-rc1-mm2-plugsched1/kernel/scheduler.c
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/kernel/scheduler.c	2004-10-29 21:47:01.214636234 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/kernel/scheduler.c	2004-10-29 21:47:03.115339604 +1000
@@ -621,6 +621,20 @@ int __sched cond_resched_softirq(void)
 
 EXPORT_SYMBOL(cond_resched_softirq);
 
+/**
+ * yield - yield the current processor to other threads.
+ *
+ * this is a shortcut for kernel-space yielding - it marks the
+ * thread runnable and calls sys_sched_yield().
+ */
+void __sched yield(void)
+{
+	set_current_state(TASK_RUNNING);
+	sys_sched_yield();
+}
+
+EXPORT_SYMBOL(yield);
+
 extern struct sched_drv ingo_sched_drv;
 static const struct sched_drv *scheduler = &ingo_sched_drv;
 


--------------020605030006040109090009--

--------------enigE1E352EF79AC9B06E96B93E2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBg6dkZUg7+tp6mRURAp18AJ9G+VkjpK/CxU74cVTeNWDiPUUrfwCfahqy
MzFUTE4MvATUayFBJZDdKnk=
=nNdv
-----END PGP SIGNATURE-----

--------------enigE1E352EF79AC9B06E96B93E2--
