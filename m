Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262304AbUKDRNZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262304AbUKDRNZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 12:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262298AbUKDRNY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 12:13:24 -0500
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:44447 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262304AbUKDRGf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 12:06:35 -0500
Date: Thu, 4 Nov 2004 18:06:32 +0100
From: Martin Waitz <tali@admingilde.org>
To: Stelian Pop <stelian@popies.net>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] kfifo_alloc buffer
Message-ID: <20041104170632.GX3618@admingilde.org>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8R/sMIKPJVD0CT2D"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8R/sMIKPJVD0CT2D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hi :)

kfifo_alloc tries to round up the buffer size to the next power of two.
But it accidently uses the original size when calling kfifo_init,
which will BUG.

Signed-off-by: Martin Waitz <tali@admingilde.org>

Index: kernel/kfifo.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /home/inf3/mnwaitz/src/linux-cvs/linux-2.5/kernel/kfifo.c,v
retrieving revision 1.2
diff -u -p -r1.2 kfifo.c
--- kernel/kfifo.c	19 Oct 2004 15:12:21 -0000	1.2
+++ kernel/kfifo.c	4 Nov 2004 17:00:34 -0000
@@ -66,7 +66,6 @@ EXPORT_SYMBOL(kfifo_init);
  */
 struct kfifo *kfifo_alloc(unsigned int size, int gfp_mask, spinlock_t *loc=
k)
 {
-	unsigned int newsize;
 	unsigned char *buffer;
 	struct kfifo *ret;
=20
@@ -74,13 +73,12 @@ struct kfifo *kfifo_alloc(unsigned int s
 	 * round up to the next power of 2, since our 'let the indices
 	 * wrap' tachnique works only in this case.
 	 */
-	newsize =3D size;
 	if (size & (size - 1)) {
 		BUG_ON(size > 0x80000000);
-		newsize =3D roundup_pow_of_two(size);
+		size =3D roundup_pow_of_two(size);
 	}
=20
-	buffer =3D kmalloc(newsize, gfp_mask);
+	buffer =3D kmalloc(size, gfp_mask);
 	if (!buffer)
 		return ERR_PTR(-ENOMEM);
=20

--=20
Martin Waitz

--8R/sMIKPJVD0CT2D
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFBimGXj/Eaxd/oD7IRArp0AJ4peAdoyRK4uAWCjZddGcCLigSZngCfVlqE
Xur8TvjQHm/JHZaRPtSG9J4=
=V/Re
-----END PGP SIGNATURE-----

--8R/sMIKPJVD0CT2D--
