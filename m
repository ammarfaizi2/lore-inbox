Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264826AbRFSWxQ>; Tue, 19 Jun 2001 18:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264829AbRFSWxH>; Tue, 19 Jun 2001 18:53:07 -0400
Received: from mail-smtp.socket.net ([216.106.1.32]:36103 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S264826AbRFSWwy>; Tue, 19 Jun 2001 18:52:54 -0400
Date: Tue, 19 Jun 2001 17:52:24 -0500
From: "Gregory T. Norris" <haphazard@socket.net>
To: rio500-devel <rio500-devel@lists.sourceforge.net>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: [patch] rio500 devfs support
Message-ID: <20010619175224.A1137@glitch.snoozer.net>
Mail-Followup-To: rio500-devel <rio500-devel@lists.sourceforge.net>,
	linux-kernel <linux-kernel@vger.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mojUlQ0s9EVzWg2t"
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
X-Operating-System: Linux glitch 2.4.5 #1 Tue Jun 19 17:19:57 CDT 2001 i686 unknown
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mojUlQ0s9EVzWg2t
Content-Type: multipart/mixed; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The attached diff adds devfs support to the rio500 driver, so that
/dev/usb/rio500 gets created automagically.  It was generated against
2.4.5, but probably applies fine against any recent kernel.  Comments
are welcome (but be gentle, this is my first attempt at a kernel
patch :-).

Cheers!

--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="rio500-devfs.diff"
Content-Transfer-Encoding: quoted-printable

diff -urN linux-2.4.5.orig/drivers/usb/rio500.c linux-2.4.5/drivers/usb/rio=
500.c
--- linux-2.4.5.orig/drivers/usb/rio500.c	Mon Jun 18 17:10:39 2001
+++ linux-2.4.5/drivers/usb/rio500.c	Tue Jun 19 17:12:26 2001
@@ -38,6 +38,7 @@
 #include <linux/spinlock.h>
 #include <linux/usb.h>
 #include <linux/smp_lock.h>
+#include <linux/devfs_fs_kernel.h>
=20
 #include "rio500_usb.h"
=20
@@ -70,6 +71,7 @@
 };
=20
 static struct rio_usb_data rio_instance;
+static devfs_handle_t rio500_devfs_handle;
=20
 static int open_rio(struct inode *inode, struct file *file)
 {
@@ -492,6 +494,12 @@
 	if (usb_register(&rio_driver) < 0)
 		return -1;
=20
+	rio500_devfs_handle =3D devfs_register(NULL, "usb/rio500",
+					DEVFS_FL_DEFAULT,
+					USB_MAJOR, RIO_MINOR,
+					S_IFCHR | S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP,
+					&usb_rio_fops, NULL);
+
 	info(DRIVER_VERSION " " DRIVER_AUTHOR);
 	info(DRIVER_DESC);
=20
@@ -506,6 +514,7 @@
 	rio->present =3D 0;
 	usb_deregister(&rio_driver);
=20
+	devfs_unregister(rio500_devfs_handle);
=20
 }
=20

--RnlQjJ0d97Da+TV1--

--mojUlQ0s9EVzWg2t
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD4DBQE7L9eogrEMyr8Cx2YRAjgrAKDVbFL2NzkollY+l3ME90yJ/Ny1tACUDo9B
3N++izUKDq1TUxnKiZppuw==
=MVW7
-----END PGP SIGNATURE-----

--mojUlQ0s9EVzWg2t--
