Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261357AbUKFK1A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbUKFK1A (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 05:27:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbUKFK1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 05:27:00 -0500
Received: from mail18.syd.optusnet.com.au ([211.29.132.199]:34949 "EHLO
	mail18.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261357AbUKFK0x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 05:26:53 -0500
Message-ID: <418CA6DE.8020007@kolivas.org>
Date: Sat, 06 Nov 2004 21:26:38 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: [PATCH] [sched-int-changes 1/5] alter_kthread_prio
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5DEE8EC2F5F43FA92069531A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5DEE8EC2F5F43FA92069531A
Content-Type: multipart/mixed;
 boundary="------------000700050202000405080305"

This is a multi-part message in MIME format.
--------------000700050202000405080305
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

alter_kthread_prio.diff

As discussed previously with Ingo; please include in at least one -mm
release.


--------------000700050202000405080305
Content-Type: text/x-patch;
 name="sched-alter_kthread_prio.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-alter_kthread_prio.diff"

Timeslice proportion has been increased substantially for -niced tasks. As
a result of this kernel threads have much larger timeslices than they
previously had.

Change kernel threads' nice value to -5 to bring their timeslice back in line
with previous behaviour. This means kernel threads will be less likely to
cause large latencies under periods of system stress for normal nice 0
tasks.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

Index: linux-2.6.10-rc1-mm2/kernel/workqueue.c
===================================================================
--- linux-2.6.10-rc1-mm2.orig/kernel/workqueue.c	2004-11-02 13:19:19.000000000 +1100
+++ linux-2.6.10-rc1-mm2/kernel/workqueue.c	2004-11-02 14:13:13.196261374 +1100
@@ -188,7 +188,7 @@ static int worker_thread(void *__cwq)
 
 	current->flags |= PF_NOFREEZE;
 
-	set_user_nice(current, -10);
+	set_user_nice(current, -5);
 
 	/* Block and flush all signals */
 	sigfillset(&blocked);


--------------000700050202000405080305--

--------------enig5DEE8EC2F5F43FA92069531A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBjKbeZUg7+tp6mRURArLbAKCUUNj3MIdVVfg3wZbFF261TjEpawCfQLkq
2L+vHMuc0pxxm7RiAA1q1Cg=
=rOf1
-----END PGP SIGNATURE-----

--------------enig5DEE8EC2F5F43FA92069531A--
