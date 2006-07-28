Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932177AbWG1H0w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbWG1H0w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 03:26:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932586AbWG1H0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 03:26:52 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:20684 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S932177AbWG1H0w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 03:26:52 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] Use BUG_ON(foo) instead of "if (foo) BUG()" in include/asm-i386/dma-mapping.h
Date: Fri, 28 Jul 2006 09:28:49 +0200
User-Agent: KMail/1.9.3
Cc: trivial@kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1515896.y1ZaRTF6EZ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200607280928.54306.eike-kernel@sf-tec.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart1515896.y1ZaRTF6EZ
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

We have BUG_ON() right for this, don't we?

Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>

=2D--
commit e3f6da52c54970711fb90ffb0f6765f8fd0ee93e
tree 093ee6b4d8fb087a54c2c90e006b66783186aaff
parent e7156df18ec5f0ee8c9fe7ac0c0367ff9a1532e8
author Rolf Eike Beer <eike-kernel@sf-tec.de> Fri, 28 Jul 2006 09:27:31 +02=
00
committer Rolf Eike Beer <beer@siso-eb-i34d.silicon-software.de> Fri, 28 Ju=
l 2006 09:27:31 +0200

 include/asm-i386/dma-mapping.h |    9 +++------
 1 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/include/asm-i386/dma-mapping.h b/include/asm-i386/dma-mapping.h
index 9cf20ca..576ae01 100644
=2D-- a/include/asm-i386/dma-mapping.h
+++ b/include/asm-i386/dma-mapping.h
@@ -21,8 +21,7 @@ static inline dma_addr_t
 dma_map_single(struct device *dev, void *ptr, size_t size,
 	       enum dma_data_direction direction)
 {
=2D	if (direction =3D=3D DMA_NONE)
=2D		BUG();
+	BUG_ON(direction =3D=3D DMA_NONE);
 	WARN_ON(size =3D=3D 0);
 	flush_write_buffers();
 	return virt_to_phys(ptr);
@@ -32,8 +31,7 @@ static inline void
 dma_unmap_single(struct device *dev, dma_addr_t dma_addr, size_t size,
 		 enum dma_data_direction direction)
 {
=2D	if (direction =3D=3D DMA_NONE)
=2D		BUG();
+	BUG_ON(direction =3D=3D DMA_NONE);
 }
=20
 static inline int
@@ -42,8 +40,7 @@ dma_map_sg(struct device *dev, struct sc
 {
 	int i;
=20
=2D	if (direction =3D=3D DMA_NONE)
=2D		BUG();
+	BUG_ON(direction =3D=3D DMA_NONE);
 	WARN_ON(nents =3D=3D 0 || sg[0].length =3D=3D 0);
=20
 	for (i =3D 0; i < nents; i++ ) {

--nextPart1515896.y1ZaRTF6EZ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBEyby2XKSJPmm5/E4RAsFcAJ4oBwTk2apP4gY6hnTK4jCtkdfxwwCgnlJN
zX9Xd2YlZcDINKHDhFG0nSw=
=Guig
-----END PGP SIGNATURE-----

--nextPart1515896.y1ZaRTF6EZ--
