Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264330AbTFEACj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 20:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264334AbTFEACj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 20:02:39 -0400
Received: from relais.videotron.ca ([24.201.245.36]:35661 "EHLO
	VL-MS-MR001.sc1.videotron.ca") by vger.kernel.org with ESMTP
	id S264330AbTFEACh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 20:02:37 -0400
Date: Wed, 04 Jun 2003 20:15:58 -0400
From: Mike Jones <ashmodai@ashmodai.com>
Subject: [PATCH] include/linux/bitops.h "integer" constants too large for	u64
To: linux-kernel@vger.kernel.org
Message-id: <1054772158.30802.9.camel@ashmodai.ashmodai.com>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.3.92 (Preview Release)
Content-type: multipart/signed; boundary="=-xmabRGlj3CIP2pJypmzC";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-xmabRGlj3CIP2pJypmzC
Content-Type: multipart/mixed; boundary="=-TA6YXxbYRCChssUK0A3w"


--=-TA6YXxbYRCChssUK0A3w
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I'm using GCC 3.3 to compile 2.5.70-mm4, and am being bombarded by
warnings regarding the use of integer constants in
include/linux/bitops.h.  The attached patch, which is trivial, should
fix the problem.

Please CC me on any replies, as I am not subscribed to the linux-kernel
mailing list.

Regards,

Mike Jones

An excerpt of the warnings displayed on almost every compiled file:

include/linux/bitops.h: In function `generic_hweight64':
include/linux/bitops.h:118: warning: integer constant is too large for
"unsigned long" type
include/linux/bitops.h:118: warning: integer constant is too large for
"unsigned long" type
include/linux/bitops.h:119: warning: integer constant is too large for
"unsigned long" type
include/linux/bitops.h:119: warning: integer constant is too large for
"unsigned long" type
include/linux/bitops.h:120: warning: integer constant is too large for
"unsigned long" type
include/linux/bitops.h:120: warning: integer constant is too large for
"unsigned long" type
include/linux/bitops.h:121: warning: integer constant is too large for
"unsigned long" type
include/linux/bitops.h:121: warning: integer constant is too large for
"unsigned long" type
include/linux/bitops.h:122: warning: integer constant is too large for
"unsigned long" type
include/linux/bitops.h:122: warning: integer constant is too large for
"unsigned long" type


--=-TA6YXxbYRCChssUK0A3w
Content-Description: 
Content-Disposition: inline; filename=bitops.h.diff
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

--- bitops.h	2003-06-04 20:06:07.000000000 -0400
+++ linux-2.5.70/include/linux/bitops.h	2003-06-04 20:03:56.000000000 -0400
@@ -115,12 +115,12 @@
 		return generic_hweight32((unsigned int)(w >> 32)) +
 					generic_hweight32((unsigned int)w);
=20
-	res =3D (w & 0x5555555555555555) + ((w >> 1) & 0x5555555555555555);
-	res =3D (res & 0x3333333333333333) + ((res >> 2) & 0x3333333333333333);
-	res =3D (res & 0x0F0F0F0F0F0F0F0F) + ((res >> 4) & 0x0F0F0F0F0F0F0F0F);
-	res =3D (res & 0x00FF00FF00FF00FF) + ((res >> 8) & 0x00FF00FF00FF00FF);
-	res =3D (res & 0x0000FFFF0000FFFF) + ((res >> 16) & 0x0000FFFF0000FFFF);
-	return (res & 0x00000000FFFFFFFF) + ((res >> 32) & 0x00000000FFFFFFFF);
+	res =3D (w & 0x5555555555555555ULL) + ((w >> 1) & 0x5555555555555555ULL);
+	res =3D (res & 0x3333333333333333ULL) + ((res >> 2) & 0x3333333333333333U=
LL);
+	res =3D (res & 0x0F0F0F0F0F0F0F0FULL) + ((res >> 4) & 0x0F0F0F0F0F0F0F0FU=
LL);
+	res =3D (res & 0x00FF00FF00FF00FFULL) + ((res >> 8) & 0x00FF00FF00FF00FFU=
LL);
+	res =3D (res & 0x0000FFFF0000FFFFULL) + ((res >> 16) & 0x0000FFFF0000FFFF=
ULL);
+	return (res & 0x00000000FFFFFFFFULL) + ((res >> 32) & 0x00000000FFFFFFFFU=
LL);
 }
=20
 static inline unsigned long hweight_long(unsigned long w)

--=-TA6YXxbYRCChssUK0A3w--

--=-xmabRGlj3CIP2pJypmzC
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iD8DBQA+3ou+QST/ojU/5mcRAicwAJ4tHWcEIM67VW3Bd6SAKMeQxIJnOQCeNu/n
/Gk/CLNoISKNn5QyM3KYB2s=
=5yzr
-----END PGP SIGNATURE-----

--=-xmabRGlj3CIP2pJypmzC--

