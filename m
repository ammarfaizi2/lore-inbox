Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129233AbRBSNEU>; Mon, 19 Feb 2001 08:04:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129400AbRBSNEK>; Mon, 19 Feb 2001 08:04:10 -0500
Received: from orbita.don.sitek.net ([213.24.25.98]:59655 "EHLO
	orbita.don.sitek.net") by vger.kernel.org with ESMTP
	id <S129233AbRBSND7>; Mon, 19 Feb 2001 08:03:59 -0500
Date: Mon, 19 Feb 2001 16:03:42 +0300
From: Andrey Panin <pazke@orbita.don.sitek.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] check_region() removal: drivers/media/video/pms.c
Message-ID: <20010219160342.A31562@orbita1.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nVMJ2NtxeReIH9PS"
User-Agent: Mutt/1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nVMJ2NtxeReIH9PS
Content-Type: multipart/mixed; boundary="SUOF0GtieIMvvwua"


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable


Hi all,
I think subject is self explaining :))

Best regards.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc
--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-pms
Content-Transfer-Encoding: quoted-printable

--- /linux/drivers/media/video/pms.c.orig	Mon Feb 19 19:33:26 2001
+++ /linux/drivers/media/video/pms.c	Mon Feb 19 22:05:34 2001
@@ -934,14 +934,15 @@
 		0xE4
 	};
 =09
-	if(check_region(0x9A01,1))
+	if (!request_region(0x9A01, 1, "Mediavision PMS config"))
 	{
 		printk(KERN_WARNING "mediavision: unable to detect: 0x9A01 in use.\n");
 		return -EBUSY;
 	}
-	if(check_region(io_port,3))
+	if (!request_region(io_port, 3, "Mediavision PMS"))
 	{
 		printk(KERN_WARNING "mediavision: I/O port %d in use.\n", io_port);
+		release_region(0x9A01, 1);
 		return -EBUSY;
 	}
 	outb(0xB8, 0x9A01);		/* Unlock */
@@ -960,16 +961,16 @@
 	else=20
 		idec=3D0;
=20
-	printk(KERN_INFO "PMS type is %d\n", idec);	=09
-	if(idec=3D=3D0)
-		return -ENODEV;=09
+	printk(KERN_INFO "PMS type is %d\n", idec);
+	if(idec =3D=3D 0) {
+		release_region(io_port, 3);
+		release_region(0x9A01, 1);
+		return -ENODEV;
+	}
=20
 	/*
 	 *	Ok we have a PMS of some sort
 	 */
-	=20
-	request_region(io_port,3, "Mediavision PMS");
-	request_region(0x9A01, 1, "Mediavision PMS config");
 =09
 	mvv_write(0x04, mem_base>>12);	/* Set the memory area */
 =09

--SUOF0GtieIMvvwua--

--nVMJ2NtxeReIH9PS
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6kRmuBm4rlNOo3YgRAgE8AJsGdiz8uZCnAM2hHGDK8Li+f18IeQCgjgOW
P1llc5k7IWS76jRXqUEVG6s=
=YTqg
-----END PGP SIGNATURE-----

--nVMJ2NtxeReIH9PS--
