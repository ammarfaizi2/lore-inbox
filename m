Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261901AbTK1CXd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Nov 2003 21:23:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261890AbTK1CWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Nov 2003 21:22:24 -0500
Received: from dialin-212-144-182-198.arcor-ip.net ([212.144.182.198]:896 "EHLO
	dbintra.dmz.lightweight.ods.org") by vger.kernel.org with ESMTP
	id S261892AbTK1CWC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Nov 2003 21:22:02 -0500
Date: Fri, 28 Nov 2003 02:41:20 +0100
From: Tonnerre Anklin <thunder@keepsake.ch>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [I4L] isdn_ppp_ccp.c uses uninitialized spinlock
Message-ID: <20031128014120.GD1635@dbintra.dmz.lightweight.ods.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9UV9rz0O2dU/yYYn"
Content-Disposition: inline
X-GPG-KeyID: 0xDEBA90FF
X-GPG-Fingerprint: 6288 DAF3 13F7 276D 77A5  0914 CA04 0D20 DEBA 90FF
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9UV9rz0O2dU/yYYn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Salut,

This spinlock was used uninitialized. Gave me a lot of warnings.

More on this patch can be found at
<URL:http://keepsake.keepsake.ch/~thunder/noyau/2.6.0-test11-ta1/isdn_ccp_u=
ninitialized_spinlock.xml>

				Thunder

diff -Nur linux-2.6.0-test9-mm3/drivers/isdn/i4l/isdn_ppp_ccp.c linux-2.6.0=
-test9-mm3-ta1/drivers/isdn/i4l/isdn_ppp_ccp.c
--- linux-2.6.0-test9-mm3/drivers/isdn/i4l/isdn_ppp_ccp.c	2003-10-08 21:24:=
04.000000000 +0200
+++ linux-2.6.0-test9-mm3-ta1/drivers/isdn/i4l/isdn_ppp_ccp.c	2003-11-24 13=
:41:47.000000000 +0100
@@ -557,7 +557,7 @@
 }
=20
 static LIST_HEAD(ipc_head);
-static spinlock_t ipc_head_lock;
+static spinlock_t ipc_head_lock =3D SPIN_LOCK_UNLOCKED;
=20
 int
 ippp_ccp_set_compressor(struct ippp_ccp *ccp, int unit,

--9UV9rz0O2dU/yYYn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/xqfAygQNIN66kP8RAo5XAKC4zPRrahWdzU7Z2XBV2d1qCVyyIwCgjebc
hvZnmsIlGISAof7rZ5VArCI=
=FHxB
-----END PGP SIGNATURE-----

--9UV9rz0O2dU/yYYn--
