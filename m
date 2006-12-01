Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758303AbWLADKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758303AbWLADKl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 22:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758362AbWLADKk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 22:10:40 -0500
Received: from mail3.sea5.speakeasy.net ([69.17.117.5]:21934 "EHLO
	mail3.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1758294AbWLADKk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 22:10:40 -0500
Message-ID: <456F9D2D.9090305@freedesktop.org>
Date: Thu, 30 Nov 2006 19:10:37 -0800
From: Josh Triplett <josh@freedesktop.org>
User-Agent: Icedove 1.5.0.8 (X11/20061128)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Oleg Nesterov <oleg@tv-sign.ru>,
       "Paul E. McKenney" <paulmck@us.ibm.com>
Subject: [PATCH] Add Sparse annotations to SRCU wrapper functions in rcutorture
X-Enigmail-Version: 0.94.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig21220BA31B7775FA787FD81A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig21220BA31B7775FA787FD81A
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The SRCU wrapper functions srcu_torture_read_lock and srcu_torture_read_u=
nlock
in rcutorture intentionally change the SRCU context; annotate them
accordingly, to avoid a warning.

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
 kernel/rcutorture.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/rcutorture.c b/kernel/rcutorture.c
index cd27547..ddafbbf 100644
--- a/kernel/rcutorture.c
+++ b/kernel/rcutorture.c
@@ -401,7 +401,7 @@ static void srcu_torture_cleanup(void)
 	cleanup_srcu_struct(&srcu_ctl);
 }
=20
-static int srcu_torture_read_lock(void)
+static int srcu_torture_read_lock(void) __acquires(&srcu_ctl)
 {
 	return srcu_read_lock(&srcu_ctl);
 }
@@ -419,7 +419,7 @@ static void srcu_read_delay(struct rcu_random_state *=
rrsp)
 		schedule_timeout_interruptible(longdelay);
 }
=20
-static void srcu_torture_read_unlock(int idx)
+static void srcu_torture_read_unlock(int idx) __releases(&srcu_ctl)
 {
 	srcu_read_unlock(&srcu_ctl, idx);
 }
--=20
1.4.4.1



--------------enig21220BA31B7775FA787FD81A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFb50tGJuZRtD+evsRAq6FAJ9Ph/mEWfrP0mvZxMACl2XHXGU2hACffkGl
CS9qvJ9fR3AYYSIAbd4zBxU=
=0kzc
-----END PGP SIGNATURE-----

--------------enig21220BA31B7775FA787FD81A--
