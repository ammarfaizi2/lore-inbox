Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261235AbUJ3Ovj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbUJ3Ovj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 10:51:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261238AbUJ3Oux
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 10:50:53 -0400
Received: from mail22.syd.optusnet.com.au ([211.29.133.160]:49589 "EHLO
	mail22.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261193AbUJ3OiC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 10:38:02 -0400
Message-ID: <4183A73E.2050600@kolivas.org>
Date: Sun, 31 Oct 2004 00:37:50 +1000
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
Subject: [PATCH][plugsched 7/28] Make more nice syscalls public
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9DF7E32400BC85ECA42B6F27"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9DF7E32400BC85ECA42B6F27
Content-Type: multipart/mixed;
 boundary="------------050501050506040501010409"

This is a multi-part message in MIME format.
--------------050501050506040501010409
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Make more nice syscalls public


--------------050501050506040501010409
Content-Type: text/x-patch;
 name="publicise_morepriostuff.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="publicise_morepriostuff.diff"

Make priority min/max public by moving it to scheduler.c

Signed-off-by: Con Kolivas <kernel@kolivas.org>


Index: linux-2.6.10-rc1-mm2-plugsched1/kernel/sched.c
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/kernel/sched.c	2004-10-29 21:46:55.943458872 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/kernel/sched.c	2004-10-29 21:46:58.463065654 +1000
@@ -3272,51 +3272,6 @@ long __sched io_schedule_timeout(long ti
 }
 
 /**
- * sys_sched_get_priority_max - return maximum RT priority.
- * @policy: scheduling class.
- *
- * this syscall returns the maximum rt_priority that can be used
- * by a given scheduling class.
- */
-asmlinkage long sys_sched_get_priority_max(int policy)
-{
-	int ret = -EINVAL;
-
-	switch (policy) {
-	case SCHED_FIFO:
-	case SCHED_RR:
-		ret = MAX_USER_RT_PRIO-1;
-		break;
-	case SCHED_NORMAL:
-		ret = 0;
-		break;
-	}
-	return ret;
-}
-
-/**
- * sys_sched_get_priority_min - return minimum RT priority.
- * @policy: scheduling class.
- *
- * this syscall returns the minimum rt_priority that can be used
- * by a given scheduling class.
- */
-asmlinkage long sys_sched_get_priority_min(int policy)
-{
-	int ret = -EINVAL;
-
-	switch (policy) {
-	case SCHED_FIFO:
-	case SCHED_RR:
-		ret = 1;
-		break;
-	case SCHED_NORMAL:
-		ret = 0;
-	}
-	return ret;
-}
-
-/**
  * sys_sched_rr_get_interval - return the default timeslice of a process.
  * @pid: pid of the process.
  * @interval: userspace pointer to the timeslice value.
Index: linux-2.6.10-rc1-mm2-plugsched1/kernel/scheduler.c
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/kernel/scheduler.c	2004-10-29 21:46:55.945458560 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/kernel/scheduler.c	2004-10-29 21:46:58.465065342 +1000
@@ -511,6 +511,50 @@ asmlinkage long sys_sched_getaffinity(pi
 	return sizeof(cpumask_t);
 }
 
+/**
+ * sys_sched_get_priority_max - return maximum RT priority.
+ * @policy: scheduling class.
+ *
+ * this syscall returns the maximum rt_priority that can be used
+ * by a given scheduling class.
+ */
+asmlinkage long sys_sched_get_priority_max(int policy)
+{
+	int ret = -EINVAL;
+
+	switch (policy) {
+	case SCHED_FIFO:
+	case SCHED_RR:
+		ret = MAX_USER_RT_PRIO-1;
+		break;
+	case SCHED_NORMAL:
+		ret = 0;
+		break;
+	}
+	return ret;
+}
+
+/**
+ * sys_sched_get_priority_min - return minimum RT priority.
+ * @policy: scheduling class.
+ *
+ * this syscall returns the minimum rt_priority that can be used
+ * by a given scheduling class.
+ */
+asmlinkage long sys_sched_get_priority_min(int policy)
+{
+	int ret = -EINVAL;
+
+	switch (policy) {
+	case SCHED_FIFO:
+	case SCHED_RR:
+		ret = 1;
+		break;
+	case SCHED_NORMAL:
+		ret = 0;
+	}
+	return ret;
+}
 
 extern struct sched_drv ingo_sched_drv;
 static const struct sched_drv *scheduler = &ingo_sched_drv;


--------------050501050506040501010409--

--------------enig9DF7E32400BC85ECA42B6F27
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBg6c+ZUg7+tp6mRURAjC5AJ9TnIL5a3OQawR/QmKlHuLJybO/FwCdETlu
Hzd45EYHU3XFgVwynD+I2uA=
=Cy+y
-----END PGP SIGNATURE-----

--------------enig9DF7E32400BC85ECA42B6F27--
