Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264164AbTEWUKu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 16:10:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264167AbTEWUKu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 16:10:50 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:39100 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S264164AbTEWUKs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 16:10:48 -0400
Date: Fri, 23 May 2003 17:22:52 -0300
From: Eduardo Pereira Habkost <ehabkost@conectiva.com.br>
To: gprocida@madge.com
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br,
       alan@lxorguk.ukuu.org.uk
Subject: [PATCH] Fix UCODE macro definition on ambassador driver
Message-ID: <20030523202252.GS2939@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mpb+VUhBqKoEsre9"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mpb+VUhBqKoEsre9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


When compiling the ambassador driver, gcc 3.3 gives the following
error:
drivers/atm/ambassador.c:301:21: pasting "." and "start" does not give a va=
lid preprocessing token

The following patch fixes that.

--=20
Eduardo

diff -purN linux-2.4.orig/drivers/atm/ambassador.c linux-2.4/drivers/atm/am=
bassador.c
--- linux-2.4.orig/drivers/atm/ambassador.c	2003-05-22 20:12:26.000000000 -=
0300
+++ linux-2.4/drivers/atm/ambassador.c	2003-05-22 20:12:26.000000000 -0300
@@ -290,12 +290,11 @@ static inline void __init show_version (
 /********** microcode **********/
=20
 #ifdef AMB_NEW_MICROCODE
-#define UCODE(x) UCODE1(atmsar12.,x)
+#define UCODE(x) UCODE1(atmsar12.x)
 #else
-#define UCODE(x) UCODE1(atmsar11.,x)
+#define UCODE(x) UCODE1(atmsar11.x)
 #endif
-#define UCODE2(x) #x
-#define UCODE1(x,y) UCODE2(x ## y)
+#define UCODE1(x) #x
=20
 static u32 __initdata ucode_start =3D=20
 #include UCODE(start)

--mpb+VUhBqKoEsre9
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+zoMccaRJ66w1lWgRAvNFAJ9WJ/nqcgAPZ1xAmttaPAKPxQk4oACeP9Ty
reD2ajLbljXa2wkpQRFEBCY=
=yZEw
-----END PGP SIGNATURE-----

--mpb+VUhBqKoEsre9--
