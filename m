Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262726AbUKXTVZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262726AbUKXTVZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 14:21:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262775AbUKXTVZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 14:21:25 -0500
Received: from atlrel7.hp.com ([156.153.255.213]:60306 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S262726AbUKXTVW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 14:21:22 -0500
Subject: [PATCH] cciss: Off-by-one error causing oops in CCISS_GETLUNIFO
	ioctl
From: Andrew Patterson <andrew.patterson@hp.com>
Reply-To: andrew.patterson@hp.com
To: linux-kernel@vger.kernel.org
Cc: Mike Miller <Mike.Miller@hp.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-2tsix+mfH5zAEjTTybtK"
Date: Wed, 24 Nov 2004 11:27:04 -0700
Message-Id: <1101320824.30680.15.camel@bluto.andrew>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-2tsix+mfH5zAEjTTybtK
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

This patch fixes an an "off-by-one" error found in the CCISS_GETLUNIFO
ioctl in the cciss driver.  It is cycling through the part table of the
gendisk structure which is a zero-based array, not a one-based array.
This often causes an oops when referencing the out-of-bounds element. =20

Signed-off by: Andrew Patterson <andrew.patterson@hp.com>
---

--- linux-2.6.9/drivers/block/cciss.c.orig	2004-11-24 10:22:30.000000000 -0=
700
+++ linux-2.6.9/drivers/block/cciss.c	2004-11-24 10:27:38.000000000 -0700
@@ -799,7 +799,7 @@
  		luninfo.num_opens =3D drv->usage_count;
  		luninfo.num_parts =3D 0;
  		/* count partitions 1 to 15 with sizes > 0 */
- 		for(i=3D1; i <MAX_PART; i++) {
+ 		for(i=3D0; i <MAX_PART-1; i++) {
 			if (!disk->part[i])
 				continue;
 			if (disk->part[i]->nr_sects !=3D 0)



--=-2tsix+mfH5zAEjTTybtK
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBpNJ3oKXgdXvblSgRAl/jAJ4v1wvMnBf5Jmtz8PU245iGv7xreQCfbdGd
HymyOJ6LXZPH/fNwhNZqG+o=
=qyPX
-----END PGP SIGNATURE-----

--=-2tsix+mfH5zAEjTTybtK--

