Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262191AbTERUHh (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 16:07:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbTERUHh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 16:07:37 -0400
Received: from cpt-dial-196-30-180-182.mweb.co.za ([196.30.180.182]:6785 "EHLO
	nosferatu.lan") by vger.kernel.org with ESMTP id S262191AbTERUHf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 16:07:35 -0400
Subject: Recent changes to sysctl.h breaks glibc
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: KML <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-5ys2jTl57WNbpIxsPBHn"
Organization: 
Message-Id: <1053289316.10127.41.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4- 
Date: 18 May 2003 22:21:56 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-5ys2jTl57WNbpIxsPBHn
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi

Some recent changes to include/linux/sysctl.h breaks glibc.

Problem is that __sysctl_args have been modified to use '__user',
but that is only defined if __KERNEL__ is defined, because that
is the only time compiler.h is included.

------------------------------------------------
--- linux-2.5.69-bk2/include/linux/sysctl.h	2003-05-05
01:53:31.000000000 +0200
+++ linux-2.5.69-bk12/include/linux/sysctl.h	2003-05-18
22:12:39.000000000 +0200
@@ -36,11 +36,11 @@
 				   member of a struct __sysctl_args to have? */
=20
 struct __sysctl_args {
-	int *name;
+	int __user *name;
 	int nlen;
-	void *oldval;
-	size_t *oldlenp;
-	void *newval;
+	void __user *oldval;
+	size_t __user *oldlenp;
+	void __user *newval;
 	size_t newlen;
 	unsigned long __unused[4];
 };
--------------------------------------------------
=20
Question:  Is this expected behaviour ?


Thanks,

--=20

Martin Schlemmer




--=-5ys2jTl57WNbpIxsPBHn
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA+x+tiqburzKaJYLYRAkgdAJ4/TUQtroV1/E+POJu87S5tQgwzaACeLM7p
kLLP1iDH/Y3YBlvKy8iy3sQ=
=GlTM
-----END PGP SIGNATURE-----

--=-5ys2jTl57WNbpIxsPBHn--

