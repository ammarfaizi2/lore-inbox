Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262961AbTC1LhE>; Fri, 28 Mar 2003 06:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262962AbTC1LhE>; Fri, 28 Mar 2003 06:37:04 -0500
Received: from mail.loewe-komp.de ([62.156.155.230]:42471 "EHLO
	gluttony.loewe-komp.de") by vger.kernel.org with ESMTP
	id <S262961AbTC1LhC>; Fri, 28 Mar 2003 06:37:02 -0500
Date: Fri, 28 Mar 2003 12:48:02 +0100
From: Andre Landwehr <andre.landwehr@gmx.net>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH-2.5] Fix devfs' partition handling
Message-ID: <20030328114801.GA20934@mambo>
Mail-Followup-To: Andre Landwehr <andre.landwehr@gmx.net>,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux mambo 2.4.20-xfs 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,
with / on an IDE harddisk the disks partitions do not appear in
devfs, only the disc device. This is due to rescan_partitions
being called twice and deleting but not re-creating the entries
during the second call. Here's the patch:

diff -Nur linux-2.5-unmodified/fs/partitions/check.c linux-2.5/fs/partition=
s/check.c
--- linux-2.5-unmodified/fs/partitions/check.c	Thu Mar 27 13:44:20 2003
+++ linux-2.5/fs/partitions/check.c	Fri Mar 28 11:48:21 2003
@@ -262,6 +262,7 @@
 	p->nr_sects =3D 0;
 	p->reads =3D p->writes =3D p->read_sectors =3D p->write_sectors =3D 0;
 	devfs_unregister(p->de);
+	p->de =3D NULL;
 	kobject_unregister(&p->kobj);
 }
=20

Have fun
Andre


--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+hDZxC3ZlGS1b0mMRAp9PAJ4hgLJE3dUiaaP4V6/P+V1VIel3FgCfczxa
IPBbaG2bE85bT2ZGrtOV2z0=
=9PLe
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
