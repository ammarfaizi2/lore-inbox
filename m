Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268465AbUKBEQM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268465AbUKBEQM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 23:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S317823AbUKBELa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 23:11:30 -0500
Received: from mail08.syd.optusnet.com.au ([211.29.132.189]:37259 "EHLO
	mail08.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S518959AbUKBEHG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 23:07:06 -0500
Message-ID: <418707DE.70706@kolivas.org>
Date: Tue, 02 Nov 2004 15:06:54 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: [PATCH] adjust timeslice granularity
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6257E18F5133FBC3AED06272"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6257E18F5133FBC3AED06272
Content-Type: multipart/mixed;
 boundary="------------090107030109080300020105"

This is a multi-part message in MIME format.
--------------090107030109080300020105
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

adjust timeslice granularity



--------------090107030109080300020105
Content-Type: text/x-patch;
 name="sched-adjust_timeslice_granularity.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-adjust_timeslice_granularity.diff"

The minimum timeslice was decreased from 10ms to 5ms. In the process, the
timeslice granularity was leading to much more rapid round robinning of
interactive tasks at cache trashing levels.

Restore minimum granularity to 10ms.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

Index: linux-2.6.10-rc1-mm2/kernel/sched.c
===================================================================
--- linux-2.6.10-rc1-mm2.orig/kernel/sched.c	2004-11-02 13:51:39.000000000 +1100
+++ linux-2.6.10-rc1-mm2/kernel/sched.c	2004-11-02 14:19:32.973509317 +1100
@@ -133,12 +133,14 @@
 	(NS_TO_JIFFIES((p)->sleep_avg) * MAX_BONUS / \
 		MAX_SLEEP_AVG)
 
+#define GRANULARITY	(10 * HZ / 1000 ? : 1)
+
 #ifdef CONFIG_SMP
-#define TIMESLICE_GRANULARITY(p)	(MIN_TIMESLICE * \
+#define TIMESLICE_GRANULARITY(p)	(GRANULARITY * \
 		(1 << (((MAX_BONUS - CURRENT_BONUS(p)) ? : 1) - 1)) * \
 			num_online_cpus())
 #else
-#define TIMESLICE_GRANULARITY(p)	(MIN_TIMESLICE * \
+#define TIMESLICE_GRANULARITY(p)	(GRANULARITY * \
 		(1 << (((MAX_BONUS - CURRENT_BONUS(p)) ? : 1) - 1)))
 #endif
 


--------------090107030109080300020105--

--------------enig6257E18F5133FBC3AED06272
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBhwfeZUg7+tp6mRURAuHeAJ44QR0Gl/TYql+3DhyA3WlwIK6y3wCePPQq
zm0ydArP9ygrRAvaFFKyby8=
=V2JF
-----END PGP SIGNATURE-----

--------------enig6257E18F5133FBC3AED06272--
