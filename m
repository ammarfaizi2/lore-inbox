Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161543AbWAMKYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161543AbWAMKYT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 05:24:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161542AbWAMKX4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 05:23:56 -0500
Received: from mail26.syd.optusnet.com.au ([211.29.133.167]:32165 "EHLO
	mail26.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1161540AbWAMKXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 05:23:53 -0500
From: Con Kolivas <kernel@kolivas.org>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [PATCH 5/5] sched-include_noninteractive_sleep_in_idle_detect.patch
Date: Fri, 13 Jan 2006 21:23:37 +1100
User-Agent: KMail/1.9
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
MIME-Version: 1.0
X-Length: 1517
Content-Type: multipart/signed;
  boundary="nextPart1181150.FPnX3hh632";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200601132123.39481.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1181150.FPnX3hh632
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Tasks waiting in SLEEP_NONINTERACTIVE state can now get to best priority so
they need to be included in the idle detection code.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

 kernel/sched.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

Index: linux-2.6.15/kernel/sched.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=2D-- linux-2.6.15.orig/kernel/sched.c
+++ linux-2.6.15/kernel/sched.c
@@ -752,8 +752,7 @@ static int recalc_task_prio(task_t *p, u
 		 * active yet prevent them suddenly becoming cpu hogs and
 		 * starving other processes.
 		 */
=2D		if (p->mm && p->sleep_type !=3D SLEEP_NONINTERACTIVE &&
=2D			sleep_time > INTERACTIVE_SLEEP(p)) {
+		if (p->mm && sleep_time > INTERACTIVE_SLEEP(p)) {
 				unsigned long ceiling;
=20
 				ceiling =3D JIFFIES_TO_NS(MAX_SLEEP_AVG -

--nextPart1181150.FPnX3hh632
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDx3+rZUg7+tp6mRURAtdbAJ4uVzgRsyG9/bINPuIZiKHLT7crXwCeLGPE
/hE2ld8BgWhX2sldaEHXKKw=
=MCL5
-----END PGP SIGNATURE-----

--nextPart1181150.FPnX3hh632--
