Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293552AbSCWQPT>; Sat, 23 Mar 2002 11:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293602AbSCWQPK>; Sat, 23 Mar 2002 11:15:10 -0500
Received: from charger.oldcity.dca.net ([207.245.82.76]:52903 "EHLO
	charger.oldcity.dca.net") by vger.kernel.org with ESMTP
	id <S293552AbSCWQO5>; Sat, 23 Mar 2002 11:14:57 -0500
Date: Sat, 23 Mar 2002 11:16:47 -0500
From: christophe =?iso-8859-15?Q?barb=E9?= 
	<christophe.barbe.ml@online.fr>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@zip.com.au>
Subject: [PATCH] 3c59x and resume
Message-ID: <20020323161647.GA11471@ufies.org>
Mail-Followup-To: Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@zip.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: debian SID Gnu/Linux 2.4.19-pre4 on i586
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Here is a small patch tested with 2.4.18 and 2.4.19-pre4.
It was proposed by Andrew but not integrated in pre4.

The problem is when using the vortex driver and suspend/resuming the
machine. Without this patch the card id is each time greater. To resume
correctly this driver need the option enable_wol=3D1 but as-is it will
only be true for the first ID. You can enable it for the first 8 IDs
with enable_wol=3D1,1,1,1,1,1,1,1 but you can't do it for all IDs.
Said another way without this patch you can't suspend/resume more than
eight times your machine.

This is a fix for the most common use. The proper fix would be IMO to
keep a bitmap of used IDs but I don't know if it worsts it.
Also a fix would be to separate the suspend/resume functionality from
the wol functionality (wake up on lan).

Thanks,
Christophe

--- linux/drivers/net/3c59x.c	Sat Mar 23 10:24:56 2002
+++ linux/drivers/net/3c59x.c	Sat Mar 23 10:57:00 2002
@@ -2891,6 +2891,9 @@
=20
 	vp =3D dev->priv;
=20
+	if (vp->card_idx =3D=3D vortex_cards_found - 1)
+         vortex_cards_found--;
+
 	/* AKPM: FIXME: we should have
 	 *	if (vp->cb_fn_base) iounmap(vp->cb_fn_base);
 	 * here

--=20
Christophe Barb=E9 <christophe.barbe@ufies.org>
GnuPG FingerPrint: E0F6 FADF 2A5C F072 6AF8  F67A 8F45 2F1E D72C B41E

There's no sense in being precise when you don't even know what you're
talking about. -- John von Neumann

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Pour information voir http://www.gnupg.org

iD8DBQE8nKpvj0UvHtcstB4RAvzIAJ9pfdg/hRkMRXRDCU/CGSscrlg1vwCggxM+
qZEw0RRatzw9K7kRNE/0Grw=
=RU4J
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
