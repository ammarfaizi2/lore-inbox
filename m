Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266224AbUHBDMy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266224AbUHBDMy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Aug 2004 23:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266243AbUHBDMy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Aug 2004 23:12:54 -0400
Received: from mail024.syd.optusnet.com.au ([211.29.132.242]:41178 "EHLO
	mail024.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266224AbUHBDMu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Aug 2004 23:12:50 -0400
Message-ID: <410DB11C.9000903@kolivas.org>
Date: Mon, 02 Aug 2004 13:12:28 +1000
From: Con Kolivas <kernel@kolivas.org>
User-Agent: Mozilla Thunderbird 0.7.1 (X11/20040626)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Anton Blanchard <anton@samba.org>
Subject: [PATCH] adjust p4 per-cpu gain
X-Enigmail-Version: 0.84.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig32219D08CE79E1B2B9AD5A7C"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig32219D08CE79E1B2B9AD5A7C
Content-Type: multipart/mixed;
 boundary="------------090902000205090604020509"

This is a multi-part message in MIME format.
--------------090902000205090604020509
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

The smt-nice handling patch is a little too aggressive by not estimating 
the per cpu gain as high enough for pentium4 hyperthread. This patch 
changes the per sibling cpu gain from 15% to 25%. The true per cpu gain 
is entirely dependant on the workload but overall the 2 species of 
Pentium4 that support hyperthreading have about 20-30% gain.

Patch for 2.6.8-rc2-mm1 attached.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

P.S: Anton - For the power processors that are now using this SMT nice 
infrastructure it would be worth setting this value separately at 40%.

--------------090902000205090604020509
Content-Type: text/plain;
 name="sched-adjust-p4gain"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sched-adjust-p4gain"

Index: linux-2.6.8-rc2-mm1/include/linux/sched.h
===================================================================
--- linux-2.6.8-rc2-mm1.orig/include/linux/sched.h	2004-07-30 22:00:05.000000000 +1000
+++ linux-2.6.8-rc2-mm1/include/linux/sched.h	2004-08-02 13:05:39.753964232 +1000
@@ -636,7 +636,7 @@
 	.imbalance_pct		= 110,			\
 	.cache_hot_time		= 0,			\
 	.cache_nice_tries	= 0,			\
-	.per_cpu_gain		= 15,			\
+	.per_cpu_gain		= 25,			\
 	.flags			= SD_BALANCE_NEWIDLE	\
 				| SD_BALANCE_EXEC	\
 				| SD_WAKE_AFFINE	\

--------------090902000205090604020509--

--------------enig32219D08CE79E1B2B9AD5A7C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBDbEcZUg7+tp6mRURAm/MAJ9DKUF9vf4eYDpskjgQxI9p7NvleQCeIZLe
r/FQAAXdS4tiaOstbCce8Uw=
=5zxg
-----END PGP SIGNATURE-----

--------------enig32219D08CE79E1B2B9AD5A7C--
