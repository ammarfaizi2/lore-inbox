Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316792AbSF0LpF>; Thu, 27 Jun 2002 07:45:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316794AbSF0LpE>; Thu, 27 Jun 2002 07:45:04 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:48905 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S316792AbSF0LpC>; Thu, 27 Jun 2002 07:45:02 -0400
Date: Thu, 27 Jun 2002 13:44:59 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [FIX] Cannot mount FreeBSD partitions w/ 2.4.19-pre10-ac2
Message-ID: <20020627114459.GA2316@merlin.emma.line.org>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Alan,

trying to mount a FreeBSD 4.6 partition on an IDE drive with Linux
2.4.19-pre10-ac2, I get this:

ufs_read_super: fragment size 1024 is too large

(I am using "mount -r -t ufs -o ufstype=3D44bsd /dev/MUMBLE /bsd" to mount).

I gather that your tree lacks Mikael Pettersson's trivial
bugfix from 2.5 (that is backported in 2.4.19-rc1), with this patch, I
can mount FreeBSD partitions fine.

I this will be fixed as you merge 2.4.19-rc1 anyways, but people might
find it useful until then:

--- linux/fs/ufs/super.c	Wed Jun  5 11:14:53 2002
+++ linux-2.4/fs/ufs/super.c	Thu Jun 27 11:32:46 2002
@@ -662,12 +662,12 @@
 			uspi->s_fsize);
 		goto failed;
 	}
-	if (uspi->s_bsize < 512) {
+	if (uspi->s_fsize < 512) {
 		printk(KERN_ERR "ufs_read_super: fragment size %u is too small\n",
 			uspi->s_fsize);
 		goto failed;
 	}
-	if (uspi->s_bsize > 4096) {
+	if (uspi->s_fsize > 4096) {
 		printk(KERN_ERR "ufs_read_super: fragment size %u is too large\n",
 			uspi->s_fsize);
 		goto failed;
@@ -679,7 +679,7 @@
 	}
 	if (uspi->s_bsize < 4096) {
 		printk(KERN_ERR "ufs_read_super: block size %u is too small\n",
-			uspi->s_fsize);
+			uspi->s_bsize);
 		goto failed;
 	}
 	if (uspi->s_bsize / uspi->s_fsize > 8) {

--=20
Matthias Andree

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9Gvq7FmbjPHp/pcMRAqR6AJ9DdrlI7OZufciMTtv/ASER7gdHiwCZAReC
LMnJyLwEO+Cswg6zOxk79eI=
=/QKR
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
