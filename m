Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266093AbSKLBub>; Mon, 11 Nov 2002 20:50:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266094AbSKLBub>; Mon, 11 Nov 2002 20:50:31 -0500
Received: from cs6625132-47.austin.rr.com ([66.25.132.47]:45265 "EHLO
	dragon.taral.net") by vger.kernel.org with ESMTP id <S266093AbSKLBua>;
	Mon, 11 Nov 2002 20:50:30 -0500
Date: Mon, 11 Nov 2002 19:56:56 -0600
From: Taral <taral@taral.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] bogusness in af_key.c
Message-ID: <20021112015656.GA12342@hatchling.taral.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

pfkey_sendmsg returns the wrong value. Patch to fix:

--- linux-2.5.47/net/key/af_key.c.dist	2002-11-11 19:55:49.000000000 -0600
+++ linux-2.5.47/net/key/af_key.c	2002-11-11 19:09:57.000000000 -0600
@@ -2179,7 +2179,7 @@
 	if (skb)
 		kfree_skb(skb);
=20
-	return err;
+	return err !=3D 0 ? err : len;
 }
=20
 static int pfkey_recvmsg(struct kiocb *kiocb,

--=20
Taral <taral@taral.net>
This message is digitally signed. Please PGP encrypt mail to me.
"Pretty please with dollars on top?" -- Me

--4Ckj6UjgE2iN1+kY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE90F/ooQQF8xCPwJQRAtJjAJ0VtdGUg6UHMDsll1QvUbntvdnxagCeL1HJ
avosVopDrPGp7MgOtEDKwV0=
=pTxk
-----END PGP SIGNATURE-----

--4Ckj6UjgE2iN1+kY--
