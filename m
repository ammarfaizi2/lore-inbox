Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269864AbRHDU5a>; Sat, 4 Aug 2001 16:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269863AbRHDU5U>; Sat, 4 Aug 2001 16:57:20 -0400
Received: from schiele.swm.uni-mannheim.de ([134.155.20.124]:2200 "EHLO
	schiele.swm.uni-mannheim.de") by vger.kernel.org with ESMTP
	id <S269862AbRHDU5P>; Sat, 4 Aug 2001 16:57:15 -0400
Date: Sat, 4 Aug 2001 22:57:02 +0200
From: Robert Schiele <rschiele@uni-mannheim.de>
To: linux-kernel@vger.kernel.org
Cc: Anton Altaparmakov <antona@users.sourceforge.net>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] Fix for macros in fs/partitions/ldm.h
Message-ID: <20010804225702.B23455@schiele.swm.uni-mannheim.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="6sX45UoQRIJXqkqR"
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--6sX45UoQRIJXqkqR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

in fs/partitions/ldm.h from 2.4.8-pre3 there were duplicate
definitions of the macros SYS_IND(p), NR_SECTS(p) and START_SECT(p),
for each a correct (with parantesises aroud the parameter) and an
incorrect (without parantesises aroud the parameter) one.

In 2.4.8-pre4 one duplicate of each macro was deleted, unfortunately
the correct ones. :-(

The parantesises are needed, because in fs/partitions/ldm.c these
macros are called with an arithmetic expression as parameter.

So you might consider applying the following simple patch to replace
the incorrect #defines with the correct ones. --- The only differences
are the parantesises.

Robert

--- linux-2.4.8-pre4/fs/partitions/ldm.h~	Sat Aug  4 16:39:15 2001
+++ linux-2.4.8-pre4/fs/partitions/ldm.h	Sat Aug  4 17:08:35 2001
@@ -81,13 +81,13 @@
 #define TOC_BITMAP2		"log"		/* bitmaps in the TOCBLOCK. */
=20
 /* Borrowed from msdos.c */
-#define SYS_IND(p)		(get_unaligned(&p->sys_ind))
-#define NR_SECTS(p)		({ __typeof__(p->nr_sects) __a =3D	\
-					get_unaligned(&p->nr_sects);	\
+#define SYS_IND(p)		(get_unaligned(&(p)->sys_ind))
+#define NR_SECTS(p)		({ __typeof__((p)->nr_sects) __a =3D	\
+					get_unaligned(&(p)->nr_sects);	\
 					le32_to_cpu(__a);		\
 				})
-#define START_SECT(p)		({ __typeof__(p->start_sect) __a =3D	\
-					get_unaligned(&p->start_sect);	\
+#define START_SECT(p)		({ __typeof__((p)->start_sect) __a =3D	\
+					get_unaligned(&(p)->start_sect);\
 					le32_to_cpu(__a);		\
 				})
=20

--=20
Robert Schiele			mailto:rschiele@uni-mannheim.de
Tel./Fax: +49-621-10059		http://webrum.uni-mannheim.de/math/rschiele/

--6sX45UoQRIJXqkqR
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iQEVAwUBO2xhnsQAnns5HcHpAQHvXgf/RVvT7rcHYo6YQiVg7UiVtBVUH1Cc+KCb
eJeS3VwWMps/4/46Spj9mjyfVDETU6GD0vTif77T2l6FCVXAaaunPh4vZZSP3ikx
yZ4mLt0PN+1PoeN6czREubF246Ai4oRZuqYPw9HQXYQbP4k96o7vqflGJrlGvC58
Xn+9xGXYGovcMWOpzn3inEJTyKTyMPFdxfN3H4u9zK3aaJUNi1h5HYLdWiQQUwhH
NsUHqOXmYi7TqrGQmnmCTY+ox6JLFRCYtEDXFT+3vjLKlZrmSVg/lYw0OMIqi2EN
pGA4dZboSwyogMeqLML+7tMfLIlV7xfi4kBzsrRviLGNV+aUy+l25g==
=8zbv
-----END PGP SIGNATURE-----

--6sX45UoQRIJXqkqR--
