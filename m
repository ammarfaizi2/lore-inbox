Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263121AbUCSWLN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Mar 2004 17:11:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263101AbUCSWLN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Mar 2004 17:11:13 -0500
Received: from cfcafw.sgi.com ([198.149.23.1]:30382 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S263121AbUCSWLK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Mar 2004 17:11:10 -0500
Subject: Small bug in bio_clone?
From: Russell Cattelan <cattelan@xfs.org>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-/v9JMpAWqpRYIFJgL4kr"
Message-Id: <1079734269.3373.42.camel@naboo.americas.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5-4mdk 
Date: Fri, 19 Mar 2004 16:11:09 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-/v9JMpAWqpRYIFJgL4kr
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Shouldn't __bio_clone be checking the state flags
of the src bio?

--- /usr/tmp/TmpDir.29150-0/fs/bio.c_1.3        2004-03-19
16:07:12.000000000 -0600
+++ fs/bio.c    2004-03-19 16:06:24.348491070 -0600
@@ -225,7 +225,7 @@
         */
        bio->bi_vcnt =3D bio_src->bi_vcnt;
        bio->bi_idx =3D bio_src->bi_idx;
-       if (bio_flagged(bio, BIO_SEG_VALID)) {
+       if (bio_flagged(bio_src, BIO_SEG_VALID)) {
                bio->bi_phys_segments =3D bio_src->bi_phys_segments;
                bio->bi_hw_segments =3D bio_src->bi_hw_segments;
                bio->bi_flags |=3D (1 << BIO_SEG_VALID);


--=-/v9JMpAWqpRYIFJgL4kr
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAW2/9NRmM+OaGhBgRAif2AJ45mp/TR6c1IU3F08VzvfPi3qcxFgCfT/Nl
2j3T9AKEFNnfmY351necoOA=
=R973
-----END PGP SIGNATURE-----

--=-/v9JMpAWqpRYIFJgL4kr--

