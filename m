Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932171AbVKXPxv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbVKXPxv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 10:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbVKXPxu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 10:53:50 -0500
Received: from xs4all.vs19.net ([213.84.236.198]:18045 "EHLO dipsaus.vs19.net")
	by vger.kernel.org with ESMTP id S932171AbVKXPxu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 10:53:50 -0500
Date: Thu, 24 Nov 2005 16:53:36 +0100
From: Jasper Spaans <jasper@vs19.net>
To: linux-kernel@vger.kernel.org, Antonino Daplas <adaplas@pol.net>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] fbcon: fix obvious bug in fbcon logo rotation code
Message-ID: <20051124155336.GA7119@spaans.vs19.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
X-Copyright: Copyright 2005 Jasper Spaans, unauthorised distribution prohibited
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Jasper Spaans <jasper@vs19.net>

This code fixes a tiny problem with the recent fbcon rotation changes:
fb_prepare_logo doesn't check the return value of fb_find_logo and that
causes a crash for my while booting.

Obvious & working & tested fix is here.

Signed-off-by: Jasper Spaans <jasper@vs19.net>
---

 drivers/video/fbmem.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

applies-to: 109d99a52b1533358445233dd16a5dfadcb618ce
d506fa9f5957183d7e05576620bc7470b1bc1b67
diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
index 7a2a8fa..b876dbb 100644
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -451,13 +451,17 @@ int fb_prepare_logo(struct fb_info *info
=20
 	/* Return if no suitable logo was found */
 	fb_logo.logo =3D fb_find_logo(depth);
+
+	if (!fb_logo.logo) {
+		return 0;
+	}
 =09
 	if (rotate =3D=3D FB_ROTATE_UR || rotate =3D=3D FB_ROTATE_UD)
 		yres =3D info->var.yres;
 	else
 		yres =3D info->var.xres;
=20
-	if (fb_logo.logo && fb_logo.logo->height > yres) {
+	if (fb_logo.logo->height > yres) {
 		fb_logo.logo =3D NULL;
 		return 0;
 	}
---
0.99.9.GIT

--=20
Jasper Spaans                                       http://jsp.vs19.net/
 16:52:44 up 10508 days,  8:39, 0 users, load average: 5.10 4.67 5.21

           emacs... car rater vi, c'est un droit inali=E9nable
--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDheIAN+t4ZIsVDPgRAoOAAKCMPy2+lsGL/ocfKNKrR7WUGmsT4ACdEbfV
y6NrK2LBL8jMvHBNaBiW1L8=
=aQ+6
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
