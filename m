Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261360AbUKFKiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261360AbUKFKiz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 05:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261361AbUKFKiy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 05:38:54 -0500
Received: from mail16.syd.optusnet.com.au ([211.29.132.197]:22499 "EHLO
	mail16.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261360AbUKFKio (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 05:38:44 -0500
Message-ID: <418CA982.5000607@kolivas.org>
Date: Sat, 06 Nov 2004 21:37:54 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: [PATCH] [sched-int-changes 4/5] requeue_granularity
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig1DC88BAF554C3A49F01A9107"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig1DC88BAF554C3A49F01A9107
Content-Type: multipart/mixed;
 boundary="------------010605040604070602090309"

This is a multi-part message in MIME format.
--------------010605040604070602090309
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

requeue_granularity

Please include in at least 2 -mm releases


--------------010605040604070602090309
Content-Type: text/x-patch;
 name="sched-requeue_granularity.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-requeue_granularity.diff"

Change the granularity code to requeue tasks at their best priority
instead of changing priority while they're running. This keeps tasks at
their top interactive level during their whole timeslice.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

Index: linux-2.6.10-rc1-mm3/kernel/sched.c
===================================================================
--- linux-2.6.10-rc1-mm3.orig/kernel/sched.c	2004-11-05 20:57:14.376900024 +1100
+++ linux-2.6.10-rc1-mm3/kernel/sched.c	2004-11-05 20:58:30.467178052 +1100
@@ -2506,10 +2506,8 @@ void scheduler_tick(void)
 			(p->time_slice >= TIMESLICE_GRANULARITY(p)) &&
 			(p->array == rq->active)) {
 
-			dequeue_task(p, rq->active);
+			requeue_task(p, rq->active);
 			set_tsk_need_resched(p);
-			p->prio = effective_prio(p);
-			enqueue_task(p, rq->active);
 		}
 	}
 out_unlock:


--------------010605040604070602090309--

--------------enig1DC88BAF554C3A49F01A9107
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD4DBQFBjKmCZUg7+tp6mRURAjUZAKCEIzaPssy/I6IeFYHGlvgwPswDkgCYh4BP
mWShE1tTQc3iib8C9+G8Hg==
=IhrM
-----END PGP SIGNATURE-----

--------------enig1DC88BAF554C3A49F01A9107--
