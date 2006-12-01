Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758368AbWLADNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758368AbWLADNa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 22:13:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758372AbWLADNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 22:13:30 -0500
Received: from mail4.sea5.speakeasy.net ([69.17.117.6]:20196 "EHLO
	mail4.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1758366AbWLADN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 22:13:29 -0500
Message-ID: <456F9DD7.80801@freedesktop.org>
Date: Thu, 30 Nov 2006 19:13:27 -0800
From: Josh Triplett <josh@freedesktop.org>
User-Agent: Icedove 1.5.0.8 (X11/20061128)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Oleg Nesterov <oleg@tv-sign.ru>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Alan Stern <stern@rowland.harvard.edu>,
       Jens Axboe <jens.axboe@oracle.com>
Subject: [PATCH] Add Sparse annotations to QRCU lock functions and rcutorture
 wrappers
X-Enigmail-Version: 0.94.1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7D24CD507A57D74E1F200D94"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7D24CD507A57D74E1F200D94
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Josh Triplett <josh@freedesktop.org>
---
 include/linux/srcu.h |    4 ++--
 kernel/rcutorture.c  |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index fcdb749..03a9010 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -64,8 +64,8 @@ struct qrcu_struct {
 };
=20
 int init_qrcu_struct(struct qrcu_struct *qp);
-int qrcu_read_lock(struct qrcu_struct *qp);
-void qrcu_read_unlock(struct qrcu_struct *qp, int idx);
+int qrcu_read_lock(struct qrcu_struct *qp) __acquires(qp);
+void qrcu_read_unlock(struct qrcu_struct *qp, int idx) __releases(qp);
 void synchronize_qrcu(struct qrcu_struct *qp);
=20
 /**
diff --git a/kernel/rcutorture.c b/kernel/rcutorture.c
index ddafbbf..e1c5c4b 100644
--- a/kernel/rcutorture.c
+++ b/kernel/rcutorture.c
@@ -482,12 +482,12 @@ static void qrcu_torture_cleanup(void)
 	cleanup_qrcu_struct(&qrcu_ctl);
 }
=20
-static int qrcu_torture_read_lock(void)
+static int qrcu_torture_read_lock(void) __acquires(&qrcu_ctl)
 {
 	return qrcu_read_lock(&qrcu_ctl);
 }
=20
-static void qrcu_torture_read_unlock(int idx)
+static void qrcu_torture_read_unlock(int idx) __releases(&qrcu_ctl)
 {
 	qrcu_read_unlock(&qrcu_ctl, idx);
 }
--=20
1.4.4.1



--------------enig7D24CD507A57D74E1F200D94
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFb53XGJuZRtD+evsRAhpHAJ4yQoURcqCzZA9zw9CakKKCKVd5qACcDni9
yRcFEe4mAxWlxqgeEEcWJhk=
=xKAJ
-----END PGP SIGNATURE-----

--------------enig7D24CD507A57D74E1F200D94--
