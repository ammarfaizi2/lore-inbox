Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266864AbRHFFvr>; Mon, 6 Aug 2001 01:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266853AbRHFFvh>; Mon, 6 Aug 2001 01:51:37 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:12810 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S266864AbRHFFvU>;
	Mon, 6 Aug 2001 01:51:20 -0400
Date: Mon, 6 Aug 2001 09:51:30 +0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] PNP BIOS oneliner fix
Message-ID: <20010806095130.A18726@orbita1.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cmJC7u66zC7hs+87"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Uptime: 9:18am  up 9 days, 16:24,  1 user,  load average: 0.16, 0.03, 0.01
X-Uname: Linux orbita1.ru 2.2.20pre2-acl 
From: Andrey Panin <pazke@orbita1.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--cmJC7u66zC7hs+87
Content-Type: multipart/mixed; boundary="HlL+5n6rz5pIUxbD"
Content-Disposition: inline


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

attached oneliner patch fixes buglet in PNP BIOS resource parsing code,=20
without this patch all io regions have IORESOURCE_MEM type.

Bug didn't hit parport_pc driver, because it doesn't check io region type (=
why?).

Best regards.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc
--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-pnpBIOS-oneliner
Content-Transfer-Encoding: quoted-printable

diff -urN -X /usr/dontdiff /linux.vanilla/drivers/pnp/pnp_bios.c /linux/dri=
vers/pnp/pnp_bios.c
--- /linux.vanilla/drivers/pnp/pnp_bios.c	Fri Aug  3 23:20:56 2001
+++ /linux/drivers/pnp/pnp_bios.c	Sun Aug  5 02:14:42 2001
@@ -656,7 +656,7 @@
 	if (i < DEVICE_COUNT_RESOURCE) {
 		dev->resource[i].start =3D io;
 		dev->resource[i].end =3D io + len;
-		dev->resource[i].flags =3D IORESOURCE_MEM;
+		dev->resource[i].flags =3D flags;
 	}
 }
=20

--HlL+5n6rz5pIUxbD--

--cmJC7u66zC7hs+87
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7bjBiBm4rlNOo3YgRAvuqAJ0WpJoXCdCNZ8dZ3P3gAQE7K+im7wCggFtK
r7nTxp0i7htB2wM+hExHz+8=
=1Mo5
-----END PGP SIGNATURE-----

--cmJC7u66zC7hs+87--
