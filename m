Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262404AbUKBOYf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262404AbUKBOYf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 09:24:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262403AbUKBONh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 09:13:37 -0500
Received: from mail13.syd.optusnet.com.au ([211.29.132.194]:23759 "EHLO
	mail13.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261968AbUKBODJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 09:03:09 -0500
Message-ID: <41879387.1080502@kolivas.org>
Date: Wed, 03 Nov 2004 01:02:47 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
Cc: linux <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>
Subject: [PATCH] requeue at granularity intervals
References: <418707E5.90705@kolivas.org> <20041102124252.GE15290@elte.hu> <41878318.8020801@kolivas.org> <20041102125834.GI15290@elte.hu>
In-Reply-To: <20041102125834.GI15290@elte.hu>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig967A0A2CFBF195E7EF209593"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig967A0A2CFBF195E7EF209593
Content-Type: multipart/mixed;
 boundary="------------070809070508050601060907"

This is a multi-part message in MIME format.
--------------070809070508050601060907
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

requeue at granularity intervals


--------------070809070508050601060907
Content-Type: text/x-patch;
 name="sched-requeue_granularity.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-requeue_granularity.diff"

Change the granularity code to requeue tasks at their best priority
instead of changing priority while they're running. This keeps tasks at
their top interactive level during their whole timeslice.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

Index: linux-2.6.10-rc1-mm2/kernel/sched.c
===================================================================
--- linux-2.6.10-rc1-mm2.orig/kernel/sched.c	2004-11-03 00:55:48.638171430 +1100
+++ linux-2.6.10-rc1-mm2/kernel/sched.c	2004-11-03 00:57:50.863711719 +1100
@@ -2476,10 +2476,8 @@ void scheduler_tick(void)
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


--------------070809070508050601060907--

--------------enig967A0A2CFBF195E7EF209593
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBh5OHZUg7+tp6mRURAm1kAJ9b7PfUd1HrQtlNntUNoc/OC9h1owCfck4I
aY5WqZiJNqqFLJcpf8bDg2Q=
=mqCV
-----END PGP SIGNATURE-----

--------------enig967A0A2CFBF195E7EF209593--
