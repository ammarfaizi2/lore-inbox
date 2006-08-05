Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161588AbWHEHCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161588AbWHEHCZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Aug 2006 03:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161590AbWHEHCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Aug 2006 03:02:25 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:22441 "EHLO smtp.gentoo.org")
	by vger.kernel.org with ESMTP id S1161588AbWHEHCY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Aug 2006 03:02:24 -0400
From: Christian Heim <phreak@gentoo.org>
Reply-To: phreak@gentoo.org
Organization: Gentoo Foundation, Inc.
To: Antonino Daplas <adaplas@pol.net>
Subject: [PATCH] Updating Documentation/fb/vesafb.txt
User-Agent: KMail/1.9.4
MIME-Version: 1.0
Cc: linux-fbdev-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       trivial@kernel.org
Date: Sat, 5 Aug 2006 09:02:17 +0200
Content-Type: multipart/signed;
  boundary="nextPart4599528.H8neQ0G2lL";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200608050902.20163.phreak@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart4599528.H8neQ0G2lL
Content-Type: multipart/mixed;
  boundary="Boundary-01=_5JE1E04fVF/j45q"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_5JE1E04fVF/j45q
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello Antonino,

I recently tried to figure how to get my vesafb to 1600x1200 and updated th=
e=20
vesafb.txt documentation accordingly. I'm still not sure about the video mo=
de=20
for 256, since it doesn't seem to follow the algorithm the other vga-modes=
=20
seem to follow.

Example:
    | 640x480  800x600  1024x768 1280x1024
=2D---+-------------------------------------
256 |  0x301    0x303    0x305    0x307     | +0x002
32k |  0x310    0x313    0x316    0x319
      -------  -------  -------  -------
      +0x009    +0x010   +0x011   +0x012

So accordingly to that algorithm, the mode for 1600x1200@256 should either =
be=20
0x309 or 0x360 which both don't work.

=46ind attached the mentioned patch to update vesafb.txt.

Please CC me on replies, since I'm not subscribed to the list.

=2D-=20
Christian Heim <phreak at gentoo.org>
GPG: 9A9F68E6 / AEC4 87B8 32B8 4922 B3A9  DF79 CAE3 556F 9A9F 68E6

Your friendly mobile/kernel/vserver/openvz monkey

Signed-off-by: Christian Heim <phreak@gentoo.org>
=2D-

--Boundary-01=_5JE1E04fVF/j45q
Content-Type: text/x-diff;
  charset="us-ascii";
  name="vesafb-document-1600x1200-video-mode.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="vesafb-document-1600x1200-video-mode.patch"

diff --git a/Documentation/fb/vesafb.txt b/Documentation/fb/vesafb.txt
index ee277dd..9565543 100644
=2D-- a/Documentation/fb/vesafb.txt
+++ b/Documentation/fb/vesafb.txt
@@ -40,12 +40,12 @@ The graphic modes are NOT in the list wh
 vga=3Dask and hit return. The mode you wish to use is derived from the
 VESA mode number. Here are those VESA mode numbers:
=20
=2D    | 640x480  800x600  1024x768 1280x1024
=2D----+-------------------------------------
=2D256 |  0x101    0x103    0x105    0x107  =20
=2D32k |  0x110    0x113    0x116    0x119  =20
=2D64k |  0x111    0x114    0x117    0x11A  =20
=2D16M |  0x112    0x115    0x118    0x11B  =20
+    | 640x480  800x600  1024x768 1280x1024 1600x1200
+----+-----------------------------------------------
+256 |  0x101    0x103    0x105    0x107     0x???  =20
+32k |  0x110    0x113    0x116    0x119     0x173  =20
+64k |  0x111    0x114    0x117    0x11A     0x174  =20
+16M |  0x112    0x115    0x118    0x11B     0x175  =20
=20
 The video mode number of the Linux kernel is the VESA mode number plus
 0x200.
@@ -54,12 +54,12 @@ The video mode number of the Linux kerne
=20
 So the table for the Kernel mode numbers are:
=20
=2D    | 640x480  800x600  1024x768 1280x1024
=2D----+-------------------------------------
=2D256 |  0x301    0x303    0x305    0x307  =20
=2D32k |  0x310    0x313    0x316    0x319  =20
=2D64k |  0x311    0x314    0x317    0x31A  =20
=2D16M |  0x312    0x315    0x318    0x31B  =20
+    | 640x480  800x600  1024x768 1280x1024 1600x1200
+----+-----------------------------------------------
+256 |  0x301    0x303    0x305    0x307     0x???  =20
+32k |  0x310    0x313    0x316    0x319     0x373  =20
+64k |  0x311    0x314    0x317    0x31A     0x374  =20
+16M |  0x312    0x315    0x318    0x31B     0x375  =20
=20
 To enable one of those modes you have to specify "vga=3Dask" in the
 lilo.conf file and rerun LILO. Then you can type in the desired

--Boundary-01=_5JE1E04fVF/j45q--

--nextPart4599528.H8neQ0G2lL
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBE1EJ8yuNVb5qfaOYRAkzPAJ9jle2DLjnEG1QR7FOEhAzmhe1jwQCeLNLX
a1n1AYq0FQJCPO8nULDkNqI=
=myaG
-----END PGP SIGNATURE-----

--nextPart4599528.H8neQ0G2lL--
