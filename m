Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263219AbUERMjk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263219AbUERMjk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 08:39:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263229AbUERMjk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 08:39:40 -0400
Received: from adsl-74-86.38-151.net24.it ([151.38.86.74]:1034 "EHLO
	gateway.milesteg.arr") by vger.kernel.org with ESMTP
	id S263219AbUERMjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 08:39:37 -0400
Date: Tue, 18 May 2004 14:39:35 +0200
From: Daniele Venzano <webvenza@libero.it>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Dominik Karall <dominik.karall@gmx.net>
Subject: Re: [PATCH] Sis900 bug fixes 3/4
Message-ID: <20040518123935.GH23565@picchio.gall.it>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>,
	Dominik Karall <dominik.karall@gmx.net>
References: <20040518120237.GC23565@picchio.gall.it> <20040518123020.GF23565@picchio.gall.it>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NgG1H2o5aFKkgPy/"
Content-Disposition: inline
In-Reply-To: <20040518123020.GF23565@picchio.gall.it>
X-Operating-System: Debian GNU/Linux on kernel Linux 2.4.25-grsec
X-Copyright: Forwarding or publishing without permission is prohibited.
X-Truth: La vita e' una questione di culo, o ce l'hai o te lo fanno.
X-GPG-Fingerprint: 642A A345 1CEF B6E3 925C  23CE DAB9 8764 25B3 57ED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--NgG1H2o5aFKkgPy/
Content-Type: multipart/mixed; boundary="zqjkMoGlbUJ91oFe"
Content-Disposition: inline


--zqjkMoGlbUJ91oFe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Obviously I had to forget at least one attachment...
Sorry for the noise.

--=20
-----------------------------
Daniele Venzano
Web: http://teg.homeunix.org


--zqjkMoGlbUJ91oFe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sis900-phy-detection.diff"
Content-Transfer-Encoding: quoted-printable

--- linux-2.6.6/drivers/net/sis900.c	2004-05-18 11:43:20.000000000 +0200
+++ linux-sis900/drivers/net/sis900.c	2004-05-18 11:34:43.000000000 +0200
@@ -644,7 +644,7 @@
 static u16 sis900_default_phy(struct net_device * net_dev)
 {
 	struct sis900_private * sis_priv =3D net_dev->priv;
- 	struct mii_phy *phy =3D NULL, *phy_home =3D NULL, *default_phy =3D NULL;
+ 	struct mii_phy *phy =3D NULL, *phy_home =3D NULL, *default_phy =3D NULL,=
 *phy_lan =3D NULL;
 	u16 status;
=20
         for( phy=3Dsis_priv->first_mii; phy; phy=3Dphy->next ){
@@ -660,12 +660,16 @@
 				status | MII_CNTL_AUTO | MII_CNTL_ISOLATE);
 			if( phy->phy_types =3D=3D HOME )
 				phy_home =3D phy;
+			else if (phy->phy_types =3D=3D LAN)
+				phy_lan =3D phy;
 		 }
 	}
=20
-	if( (!default_phy) && phy_home )
+	if( !default_phy && phy_home )
 		default_phy =3D phy_home;
-	else if(!default_phy)
+	else if( !default_phy && phy_lan )
+		default_phy =3D phy_lan;
+	else if ( !default_phy )
 		default_phy =3D sis_priv->first_mii;
=20
 	if( sis_priv->mii !=3D default_phy ){

--zqjkMoGlbUJ91oFe--

--NgG1H2o5aFKkgPy/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAqgQH2rmHZCWzV+0RAiKJAJ9tR14MfYTsD34sNwlgNKleogAVvgCfYYQZ
VK3zkSZVMLQ8GYeBwaqFuAQ=
=a5Y5
-----END PGP SIGNATURE-----

--NgG1H2o5aFKkgPy/--
