Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261201AbUJ3PiO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbUJ3PiO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 11:38:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbUJ3Ph3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 11:37:29 -0400
Received: from mail10.syd.optusnet.com.au ([211.29.132.191]:15507 "EHLO
	mail10.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261202AbUJ3Ojv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 10:39:51 -0400
Message-ID: <4183A7A5.1080805@kolivas.org>
Date: Sun, 31 Oct 2004 00:39:33 +1000
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
Subject: [PATCH][plugsched 15/28] oom support function
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigBABD3A541D865EDD50CD4E0B"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigBABD3A541D865EDD50CD4E0B
Content-Type: multipart/mixed;
 boundary="------------070800020509020407000609"

This is a multi-part message in MIME format.
--------------070800020509020407000609
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

oom support function



--------------070800020509020407000609
Content-Type: text/x-patch;
 name="oom_compat.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="oom_compat.diff"

__oom_kill_task sets a specific time_slice; modify it to have it's
time_slice adjusted in a cpu-scheduler dependant fashion.

Signed-off-by: Con Kolivas <kernel@kolivas.org>


Index: linux-2.6.10-rc1-mm2-plugsched1/include/linux/sched.h
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/include/linux/sched.h	2004-10-29 21:47:05.007044378 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/include/linux/sched.h	2004-10-29 21:47:46.780525066 +1000
@@ -741,6 +741,7 @@ extern int task_prio(const task_t *p);
 extern int task_nice(const task_t *p);
 extern int task_curr(const task_t *p);
 extern int idle_cpu(int cpu);
+extern void set_oom_timeslice(task_t *p);
 
 void yield(void);
 
Index: linux-2.6.10-rc1-mm2-plugsched1/mm/oom_kill.c
===================================================================
--- linux-2.6.10-rc1-mm2-plugsched1.orig/mm/oom_kill.c	2004-10-29 21:42:40.068391609 +1000
+++ linux-2.6.10-rc1-mm2-plugsched1/mm/oom_kill.c	2004-10-29 21:47:46.781524910 +1000
@@ -156,7 +156,7 @@ static void __oom_kill_task(task_t *p)
 	 * all the memory it needs. That way it should be able to
 	 * exit() and clear out its resources quickly...
 	 */
-	p->time_slice = HZ;
+	set_oom_timeslice(p);
 	p->flags |= PF_MEMALLOC | PF_MEMDIE;
 
 	/* This process has hardware access, be more careful. */



--------------070800020509020407000609--

--------------enigBABD3A541D865EDD50CD4E0B
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBg6emZUg7+tp6mRURAlr/AJ4z1jkxol1MkNerGUpKM/XLB3Nr4gCeLwLo
oN/6Kmnns3uqnmXGVYN9IYk=
=1sti
-----END PGP SIGNATURE-----

--------------enigBABD3A541D865EDD50CD4E0B--
