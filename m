Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261355AbUKFKcy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbUKFKcy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 05:32:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261354AbUKFKcy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 05:32:54 -0500
Received: from mail01.syd.optusnet.com.au ([211.29.132.182]:39093 "EHLO
	mail01.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261355AbUKFKcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 05:32:48 -0500
Message-ID: <418CA820.8050501@kolivas.org>
Date: Sat, 06 Nov 2004 21:32:00 +1100
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Subject: [PATCH] [sched-int-changes 2/5] adjust_timeslice_granularity
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF866E455547218496657F286"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF866E455547218496657F286
Content-Type: multipart/mixed;
 boundary="------------070708000609050003080408"

This is a multi-part message in MIME format.
--------------070708000609050003080408
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

adjust_timeslice_granularity

Please include in at least one -mm release.


--------------070708000609050003080408
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

Index: linux-2.6.10-rc1-mm3/kernel/sched.c
===================================================================
--- linux-2.6.10-rc1-mm3.orig/kernel/sched.c	2004-11-05 20:54:25.302964953 +1100
+++ linux-2.6.10-rc1-mm3/kernel/sched.c	2004-11-05 20:56:46.608179150 +1100
@@ -134,12 +134,14 @@
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
 


--------------070708000609050003080408--

--------------enigF866E455547218496657F286
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBjKggZUg7+tp6mRURAg9LAJ0RB+qipMPeho1HgGLxTSnRrRnFHACfQZ7L
NlkZtHvjH1i4iRs1pTbLi1s=
=ZK3+
-----END PGP SIGNATURE-----

--------------enigF866E455547218496657F286--
