Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264304AbTFKKAe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 06:00:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264312AbTFKKAe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 06:00:34 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:5251 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S264304AbTFKKAZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 06:00:25 -0400
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: Andrew Morton <akpm@digeo.com>
Subject: [PATCH] Compile fix for 2.5.70-mm8/drivers/usb/media/vicam.c
Date: Wed, 11 Jun 2003 12:13:53 +0200
User-Agent: KMail/1.5.9
References: <20030611013325.355a6184.akpm@digeo.com>
In-Reply-To: <20030611013325.355a6184.akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-03=_nDw5+MKwr93ulo4";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200306111213.59596.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-03=_nDw5+MKwr93ulo4
Content-Type: multipart/mixed;
  boundary="Boundary-01=_hDw5+GFuxJ6ay8u"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_hDw5+GFuxJ6ay8u
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

it seems a copy_from_user() cleanup for the file mentioned above introduced=
=20
compile errors. This cleanup is (not yet) present in linus' tree and I do n=
ot=20
know who was the author of it, so I send this patch to you...

Best regards
  Thomas Schlichter

--Boundary-01=_hDw5+GFuxJ6ay8u
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="vicam.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline; filename="vicam.diff"

=2D-- linux-2.5.70-mm8/drivers/usb/media/vicam.c.orig	Wed Jun 11 11:43:48 2=
003
+++ linux-2.5.70-mm8/drivers/usb/media/vicam.c	Wed Jun 11 11:47:25 2003
@@ -618,13 +618,13 @@
 				break;
 			}
=20
=2D			DBG("VIDIOCSPICT depth =3D %d, pal =3D %d\n", vp->depth,
=2D			    vp->palette);
+			DBG("VIDIOCSPICT depth =3D %d, pal =3D %d\n", vp.depth,
+			    vp.palette);
=20
=2D			cam->gain =3D vp->brightness >> 8;
+			cam->gain =3D vp.brightness >> 8;
=20
=2D			if (vp->depth !=3D 24
=2D			    || vp->palette !=3D VIDEO_PALETTE_RGB24)
+			if (vp.depth !=3D 24
+			    || vp.palette !=3D VIDEO_PALETTE_RGB24)
 				retval =3D -EINVAL;
=20
 			break;
@@ -663,9 +663,9 @@
 				retval =3D -EFAULT;
 				break;
 			}
=2D			DBG("VIDIOCSWIN %d x %d\n", vw->width, vw->height);
+			DBG("VIDIOCSWIN %d x %d\n", vw.width, vw.height);
=20
=2D			if ( vw->width !=3D 320 || vw->height !=3D 240 )
+			if ( vw.width !=3D 320 || vw.height !=3D 240 )
 				retval =3D -EFAULT;
 		=09
 			break;

--Boundary-01=_hDw5+GFuxJ6ay8u--

--Boundary-03=_nDw5+MKwr93ulo4
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+5wDnYAiN+WRIZzQRAulpAKCMpUVkkfhldZjiRn046EePImrLoQCg/dMv
eFiqnld6Y9WbSVIgUHShEhk=
=6ym4
-----END PGP SIGNATURE-----

--Boundary-03=_nDw5+MKwr93ulo4--
