Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272628AbTHPGDF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 02:03:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272635AbTHPGDF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 02:03:05 -0400
Received: from [80.146.195.226] ([80.146.195.226]:64278 "EHLO
	apollo.sven.bitebene.org") by vger.kernel.org with ESMTP
	id S272628AbTHPGC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 02:02:56 -0400
Date: Sat, 16 Aug 2003 08:01:51 +0200
From: Sven Schnelle <schnelle@kabelleipzig.de>
To: James Simmons <jsimmons@infradead.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Fbdev development list 
	<linux-fbdev-devel@lists.sourceforge.net>
Subject: Re: FBDEV updates.
Message-ID: <20030816060151.GA833@apollo.sven.bitebene.org>
Mail-Followup-To: Sven Schnelle <schnelle@kabelleipzig.de>,
	James Simmons <jsimmons@infradead.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Fbdev development list <linux-fbdev-devel@lists.sourceforge.net>
References: <Pine.LNX.4.44.0308142052440.15200-100000@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308142052440.15200-100000@phoenix.infradead.org>
X-Penguin: Linux version 2.6.0-test3-mm2-sv (root@apollo) (gcc version 3.3) B44 SMP Fri Aug 15 23:52:29 CEST 2003
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

James Simmons <jsimmons@infradead.org> wrote:
=20
>   Here is the latest fbdev BK drop. It is against 2.6.0-test3. Test it ou=
t=20
> and tell me your results. I like to do a code drop soon.=20

Thanks for this patch, it runs now quite nice on a RIVA TNT2. Is there
any special reason why you use soft_cursor in rivafb? I changed the
rivafb_cursor to the new code, maybe you have a look ;-)

-------------------------------------8<------------------------------------=
----------------------------
diff -Naur linux-2.6.0-test3/drivers/video/riva/fbdev.c linux-2.6.0-test3-s=
v/drivers/video/riva/fbdev.c
--- linux-2.6.0-test3/drivers/video/riva/fbdev.c	2003-08-16 07:47:20.000000=
000 +0200
+++ linux-2.6.0-test3-sv/drivers/video/riva/fbdev.c	2003-08-16 07:39:39.000=
000000 +0200
@@ -460,48 +460,11 @@
 	return (VGA_RD08(par->riva.PVIO, 0x3cc));
 }
=20
-static u8 byte_rev[256] =3D {
-	0x00, 0x80, 0x40, 0xc0, 0x20, 0xa0, 0x60, 0xe0,
-	0x10, 0x90, 0x50, 0xd0, 0x30, 0xb0, 0x70, 0xf0,
-	0x08, 0x88, 0x48, 0xc8, 0x28, 0xa8, 0x68, 0xe8,
-	0x18, 0x98, 0x58, 0xd8, 0x38, 0xb8, 0x78, 0xf8,
-	0x04, 0x84, 0x44, 0xc4, 0x24, 0xa4, 0x64, 0xe4,
-	0x14, 0x94, 0x54, 0xd4, 0x34, 0xb4, 0x74, 0xf4,
-	0x0c, 0x8c, 0x4c, 0xcc, 0x2c, 0xac, 0x6c, 0xec,
-	0x1c, 0x9c, 0x5c, 0xdc, 0x3c, 0xbc, 0x7c, 0xfc,
-	0x02, 0x82, 0x42, 0xc2, 0x22, 0xa2, 0x62, 0xe2,
-	0x12, 0x92, 0x52, 0xd2, 0x32, 0xb2, 0x72, 0xf2,
-	0x0a, 0x8a, 0x4a, 0xca, 0x2a, 0xaa, 0x6a, 0xea,
-	0x1a, 0x9a, 0x5a, 0xda, 0x3a, 0xba, 0x7a, 0xfa,
-	0x06, 0x86, 0x46, 0xc6, 0x26, 0xa6, 0x66, 0xe6,
-	0x16, 0x96, 0x56, 0xd6, 0x36, 0xb6, 0x76, 0xf6,
-	0x0e, 0x8e, 0x4e, 0xce, 0x2e, 0xae, 0x6e, 0xee,
-	0x1e, 0x9e, 0x5e, 0xde, 0x3e, 0xbe, 0x7e, 0xfe,
-	0x01, 0x81, 0x41, 0xc1, 0x21, 0xa1, 0x61, 0xe1,
-	0x11, 0x91, 0x51, 0xd1, 0x31, 0xb1, 0x71, 0xf1,
-	0x09, 0x89, 0x49, 0xc9, 0x29, 0xa9, 0x69, 0xe9,
-	0x19, 0x99, 0x59, 0xd9, 0x39, 0xb9, 0x79, 0xf9,
-	0x05, 0x85, 0x45, 0xc5, 0x25, 0xa5, 0x65, 0xe5,
-	0x15, 0x95, 0x55, 0xd5, 0x35, 0xb5, 0x75, 0xf5,
-	0x0d, 0x8d, 0x4d, 0xcd, 0x2d, 0xad, 0x6d, 0xed,
-	0x1d, 0x9d, 0x5d, 0xdd, 0x3d, 0xbd, 0x7d, 0xfd,
-	0x03, 0x83, 0x43, 0xc3, 0x23, 0xa3, 0x63, 0xe3,
-	0x13, 0x93, 0x53, 0xd3, 0x33, 0xb3, 0x73, 0xf3,
-	0x0b, 0x8b, 0x4b, 0xcb, 0x2b, 0xab, 0x6b, 0xeb,
-	0x1b, 0x9b, 0x5b, 0xdb, 0x3b, 0xbb, 0x7b, 0xfb,
-	0x07, 0x87, 0x47, 0xc7, 0x27, 0xa7, 0x67, 0xe7,
-	0x17, 0x97, 0x57, 0xd7, 0x37, 0xb7, 0x77, 0xf7,
-	0x0f, 0x8f, 0x4f, 0xcf, 0x2f, 0xaf, 0x6f, 0xef,
-	0x1f, 0x9f, 0x5f, 0xdf, 0x3f, 0xbf, 0x7f, 0xff,
-};
-
-static inline void reverse_order(u32 *l)
+static inline u32 reverse_order(u32 val)
 {
-	u8 *a =3D (u8 *)l;
-	*a =3D byte_rev[*a], a++;
-	*a =3D byte_rev[*a], a++;
-	*a =3D byte_rev[*a], a++;
-	*a =3D byte_rev[*a];
+return((val & 0x80808080) >> 7 | (val & 0x40404040) >> 5 | (val & 0x202020=
20) >> 3 | \
+       (val & 0x10101010) >> 1 | (val & 0x08080808) << 1 | (val & 0x040404=
04) << 3 | \
+       (val & 0x02020202) << 5 | (val & 0x01010101) << 7);
 }
=20
 /* -----------------------------------------------------------------------=
-- *
@@ -534,13 +497,14 @@
 	int i, j, k =3D 0;
 	u32 b, m, tmp;
=20
+	=09
 	for (i =3D 0; i < h; i++) {
-		b =3D *((u32 *)data)++;
+
+		b =3D reverse_order(*((u32 *)data)++);
 		m =3D *((u32 *)mask)++;
-		reverse_order(&b);
-	=09
+
 		for (j =3D 0; j < w/2; j++) {
-			tmp =3D 0;
+		tmp =3D 0;
 #if defined (__BIG_ENDIAN)
 			if (m & (1 << 31)) {
 				fg |=3D 1 << 15;
@@ -565,7 +529,7 @@
 			tmp =3D (b & 1) ? fg : bg;
 			b >>=3D 1;
 			m >>=3D 1;
-		=09
+
 			if (m & 1) {
 				fg |=3D 1 << 15;
 				bg |=3D 1 << 15;
@@ -573,10 +537,11 @@
 			tmp |=3D (b & 1) ? fg << 16 : bg << 16;
 			b >>=3D 1;
 			m >>=3D 1;
+		=09
 #endif
-			writel(tmp, par->riva.CURSOR + k++);
-		}
-		k +=3D (MAX_CURS - w)/2;
+				writel(tmp, par->riva.CURSOR + k++);
+			}
+		    k +=3D (MAX_CURS - w)/2;
 	}
 }
=20
@@ -1428,7 +1393,7 @@
 			     const struct fb_image *image)
 {
 	struct riva_par *par =3D (struct riva_par *) info->par;
-	u32 fgx =3D 0, bgx =3D 0, width, tmp;
+	u32 fgx =3D 0, bgx =3D 0, width;
 	u8 *cdat =3D (u8 *) image->data;
 	volatile u32 *d;
 	int i, size;
@@ -1474,23 +1439,20 @@
=20
 	width =3D (image->width + 31)/32;
 	size =3D width * image->height;
+
 	while (size >=3D 16) {
 		RIVA_FIFO_FREE(par->riva, Bitmap, 16);
-		for (i =3D 0; i < 16; i++) {
-			tmp =3D *((u32 *)cdat)++;
-			reverse_order(&tmp);
-			d[i] =3D tmp;
-		}
+		for (i =3D 0; i < 16; i++)=20
+			d[i] =3D reverse_order(*((u32 *)cdat)++);
 		size -=3D 16;
-	}
+		}
+
 	if (size) {
 		RIVA_FIFO_FREE(par->riva, Bitmap, size);
-		for (i =3D 0; i < size; i++) {
-			tmp =3D *((u32 *) cdat)++;
-			reverse_order(&tmp);
-			d[i] =3D tmp;
+		for (i =3D 0; i < size; i++)
+			d[i] =3D reverse_order(*((u32 *) cdat)++);
+
 		}
-	}
 }
=20
 /**
@@ -1509,9 +1471,17 @@
 static int rivafb_cursor(struct fb_info *info, struct fb_cursor *cursor)
 {
 	struct riva_par *par =3D (struct riva_par *) info->par;
+	unsigned int scan_align =3D info->pixmap.scan_align - 1;
+	unsigned int buf_align =3D info->pixmap.buf_align - 1;
+		u8 *dst =3D (u8 *) info->cursor.image.data;
+	unsigned int i, size, pitch;
 	u16 fg, bg;
-	int i;
=20
+	pitch =3D ((info->cursor.image.width + 7) >> 3) + scan_align;
+	pitch &=3D ~scan_align;
+	size =3D pitch * info->cursor.image.height + buf_align;
+	size &=3D ~buf_align;
+=09
 	par->riva.ShowHideCursor(&par->riva, 0);
=20
 	if (cursor->set & FB_CUR_SETPOS) {
@@ -1540,36 +1510,37 @@
 	if (cursor->set & (FB_CUR_SETSHAPE | FB_CUR_SETCMAP)) {
 		u32 bg_idx =3D info->cursor.image.bg_color;
 		u32 fg_idx =3D info->cursor.image.fg_color;
-		u8 *dat =3D (u8 *) info->cursor.image.data;
-		u8 *msk =3D (u8 *) info->cursor.mask;
-		u8 src[64];=09
-	=09
 		switch (info->cursor.rop) {
 		case ROP_XOR:
-			for (i =3D 0; i < info->sprite.size; i++)
-					src[i] =3D dat[i] ^ msk[i];
+			for (i =3D 0; i < size; i++)
+					dst[i] ^=3D info->cursor.mask[i];
 			break;
 		case ROP_COPY:
 		default:
-			for (i =3D 0; i < info->sprite.size; i++)
-					src[i] =3D dat[i] & msk[i];
+			for (i =3D 0; i < size; i++)
+					dst[i] &=3D info->cursor.mask[i];
 			break;
 		}
 	=09
 		bg =3D ((info->cmap.red[bg_idx] & 0xf8) << 7) |
 		     ((info->cmap.green[bg_idx] & 0xf8) << 2) |
-		     ((info->cmap.blue[bg_idx] & 0xf8) >> 3);
+		     ((info->cmap.blue[bg_idx] & 0xf8) >> 3) | 0x8000;
=20
 		fg =3D ((info->cmap.red[fg_idx] & 0xf8) << 7) |
 		     ((info->cmap.green[fg_idx] & 0xf8) << 2) |
-		     ((info->cmap.blue[fg_idx] & 0xf8) >> 3);
+		     ((info->cmap.blue[fg_idx] & 0xf8) >> 3) | 0x8000;
=20
 		par->riva.LockUnlock(&par->riva, 0);
=20
-		rivafb_load_cursor_image(par, dat, msk, bg, fg,
-					 info->cursor.image.width,=20
+	=09
+		memset_io(par->riva.CURSOR, 0, MAX_CURS * MAX_CURS*2);
+
+		if(info->cursor.image.data)=20
+		    rivafb_load_cursor_image(par, dst, info->cursor.mask, bg, fg, \
+					 info->cursor.image.width, \
 					 info->cursor.image.height);
-	}
+		}
+=09
 	if (info->cursor.enable)
 		par->riva.ShowHideCursor(&par->riva, 1);
 	return 0;
@@ -1602,7 +1573,7 @@
 	.fb_fillrect 	=3D rivafb_fillrect,
 	.fb_copyarea 	=3D rivafb_copyarea,
 	.fb_imageblit 	=3D rivafb_imageblit,
-	.fb_cursor	=3D soft_cursor,=09
+	.fb_cursor	=3D rivafb_cursor,=09
 	.fb_sync 	=3D rivafb_sync,
 };
-----------------------------------------8<--------------------------------=
---------=20


--=20
Sven Schnelle, <schnelle@kabelleipzig.de>
-----------------------------------------

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE/PcjP86MdxiXaIbERAhkJAJ42kbQfU463s8+1M/wE/qb55t5WtQCgnOUF
eStdzXVoAGIAtKAfmu0lnQA=
=VDs5
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
