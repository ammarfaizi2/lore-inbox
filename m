Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278371AbRJSMVE>; Fri, 19 Oct 2001 08:21:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278375AbRJSMUz>; Fri, 19 Oct 2001 08:20:55 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:19723 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S278371AbRJSMUm>;
	Fri, 19 Oct 2001 08:20:42 -0400
Date: Fri, 19 Oct 2001 16:21:02 +0400
To: linux-kernel@vger.kernel.org
Subject: [PATCH] MODULE_DEVICE_TABLE for Multi-Tech serial card driver
Message-ID: <20011019162102.B3170@orbita1.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tEFtbjk+mNEviIIX"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Uptime: 3:51pm  up 7 days,  4:01,  4 users,  load average: 0.24, 0.12, 0.15
X-Uname: Linux orbita1.ru 2.2.20pre2 
From: Andrey Panin <pazke@orbita1.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tEFtbjk+mNEviIIX
Content-Type: multipart/mixed; boundary="uh9ZiVrAOUUm9fzH"
Content-Disposition: inline


--uh9ZiVrAOUUm9fzH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


Ugh .. yet another MODULE_DEVICE_TABLE, looks like many drivers lack it.
Also some static zero initializers removed.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc
--uh9ZiVrAOUUm9fzH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-isicom
Content-Transfer-Encoding: quoted-printable

diff -u -X dontdiff linux.old/drivers/char/isicom.c linux/drivers/char/isic=
om.c
--- linux.old/drivers/char/isicom.c	Mon Oct 15 15:34:17 2001
+++ linux/drivers/char/isicom.c	Fri Oct 19 16:19:06 2001
@@ -60,24 +60,27 @@
=20
 #include <linux/isicom.h>
=20
-static int device_id[] =3D {      0x2028,
-				0x2051,
-				0x2052,
-				0x2053,
-				0x2054,
-				0x2055,
-				0x2056,
-				0x2057,
-				0x2058
-			};
+static struct pci_device_id isicom_pci_tbl[] =3D {
+	{ VENDOR_ID, 0x2028, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ VENDOR_ID, 0x2051, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ VENDOR_ID, 0x2052, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ VENDOR_ID, 0x2053, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ VENDOR_ID, 0x2054, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ VENDOR_ID, 0x2055, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ VENDOR_ID, 0x2056, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ VENDOR_ID, 0x2057, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ VENDOR_ID, 0x2058, PCI_ANY_ID, PCI_ANY_ID, 0, 0, 0 },
+	{ 0 }
+};
+MODULE_DEVICE_TABLE(pci, isicom_pci_tbl);
=20
-static int isicom_refcount =3D 0;
+static int isicom_refcount;
 static int prev_card =3D 3;	/*	start servicing isi_card[0]	*/
-static struct isi_board * irq_to_board[16] =3D { NULL, };
+static struct isi_board * irq_to_board[16];
 static struct tty_driver isicom_normal, isicom_callout;
-static struct tty_struct * isicom_table[PORT_COUNT] =3D { NULL, };
-static struct termios * isicom_termios[PORT_COUNT] =3D { NULL, };
-static struct termios * isicom_termios_locked[PORT_COUNT] =3D { NULL, };
+static struct tty_struct * isicom_table[PORT_COUNT];
+static struct termios * isicom_termios[PORT_COUNT];
+static struct termios * isicom_termios_locked[PORT_COUNT];
=20
 static struct isi_board isi_card[BOARD_COUNT];
 static struct isi_port  isi_ports[PORT_COUNT];
@@ -1974,7 +1977,7 @@
 		for (idx=3D0; idx < DEVID_COUNT; idx++) {
 			dev =3D NULL;
 			for (;;){
-				if (!(dev =3D pci_find_device(VENDOR_ID, device_id[idx], dev)))
+				if (!(dev =3D pci_find_device(VENDOR_ID, isicom_pci_tbl[idx].device, d=
ev)))
 					break;
 				if (card >=3D BOARD_COUNT)
 					break;
@@ -1988,7 +1991,7 @@
 								       * space.
 								       */
 				pciirq =3D dev->irq;
-				printk(KERN_INFO "ISI PCI Card(Device ID 0x%x)\n", device_id[idx]);
+				printk(KERN_INFO "ISI PCI Card(Device ID 0x%x)\n", isicom_pci_tbl[idx]=
.device);
 				/*
 				 * allot the first empty slot in the array
 				 */			=09

--uh9ZiVrAOUUm9fzH--

--tEFtbjk+mNEviIIX
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE70BquBm4rlNOo3YgRAhVIAJ9Lky4J8JBJUep8PUuqhubxT+AssACfdYOi
OzvC0FX5GyoQR+WGI/h7u5A=
=PlsD
-----END PGP SIGNATURE-----

--tEFtbjk+mNEviIIX--
