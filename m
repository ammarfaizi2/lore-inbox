Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267646AbUG3INq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267646AbUG3INq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Jul 2004 04:13:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267647AbUG3INq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Jul 2004 04:13:46 -0400
Received: from rdrz.de ([217.160.107.209]:25242 "HELO rdrz.de")
	by vger.kernel.org with SMTP id S267646AbUG3INm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Jul 2004 04:13:42 -0400
Date: Fri, 30 Jul 2004 10:13:40 +0200
From: Raphael Zimmerer <killekulla@rdrz.de>
To: linux-kernel@vger.kernel.org
Cc: rmk+serial@arm.linux.org.uk
Subject: [PATCH] [serial, pci]: Support for Exar XR17C158 Octal UART
Message-ID: <20040730081340.GH7931@rdrz.de>
Reply-To: killekulla@rdrz.de
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

here a minimal patch to support the Exar Corp. XR17C158 Octal UART
Chip (PCI).

Regards,
Raphael

Signed-off-by: Raphael Zimmerer <killekulla@rdrz.de>

 drivers/serial/8250_pci.c |   22 ++++++++++++++++++++++
 include/linux/pci_ids.h   |    3 +++
 2 files changed, 25 insertions(+)

diff -rNu linux-2.6.8-rc2/drivers/serial/8250_pci.c linux-2.6.8-rc2-[uart]/=
drivers/serial/8250_pci.c
--- linux-2.6.8-rc2/drivers/serial/8250_pci.c	2004-07-27 13:13:38.000000000=
 +0200
+++ linux-2.6.8-rc2-[uart]/drivers/serial/8250_pci.c	2004-07-27 14:22:31.00=
0000000 +0200
@@ -630,6 +630,17 @@
 		.setup		=3D afavlab_setup,
 	},
 	/*
+	 * Exar Corp. XR17C158 Octal UART
+	 *  Only basic 16550A support.
+	 */
+	{
+		.vendor		=3D PCI_VENDOR_ID_EXAR,
+		.device		=3D PCI_DEVICE_ID_EXAR_XR17C158,
+		.subvendor	=3D PCI_ANY_ID,
+		.subdevice	=3D PCI_ANY_ID,
+		.setup		=3D pci_default_setup,
+	},
+	/*
 	 * HP Diva
 	 */
 	{
@@ -1069,6 +1080,7 @@
 	pbn_computone_6,
 	pbn_computone_8,
 	pbn_sbsxrsio,
+	pbn_exar_XR17C158,
 };
=20
 /*
@@ -1489,6 +1501,12 @@
 		.base_baud	=3D 460800,
 		.uart_offset	=3D 256,
 		.reg_shift	=3D 4,
+	},
+	[pbn_exar_XR17C158] =3D {
+		.flags		=3D FL_BASE0,
+		.num_ports	=3D 8,
+		.base_baud	=3D 921600,
+		.uart_offset	=3D 0x200,
 	}
 };
=20
@@ -1759,6 +1777,10 @@
 }
=20
 static struct pci_device_id serial_pci_tbl[] =3D {
+	{	PCI_VENDOR_ID_EXAR, PCI_DEVICE_ID_EXAR_XR17C158,
+		PCI_ANY_ID, PCI_ANY_ID,
+		0,
+		0, pbn_exar_XR17C158 },
 	{	PCI_VENDOR_ID_V3, PCI_DEVICE_ID_V3_V960,
 		PCI_SUBVENDOR_ID_CONNECT_TECH,
 		PCI_SUBDEVICE_ID_CONNECT_TECH_BH8_232, 0, 0,
diff -rNu linux-2.6.8-rc2/include/linux/pci_ids.h linux-2.6.8-rc2-[uart]/in=
clude/linux/pci_ids.h
--- linux-2.6.8-rc2/include/linux/pci_ids.h	2004-07-27 13:13:49.000000000 +=
0200
+++ linux-2.6.8-rc2-[uart]/include/linux/pci_ids.h	2004-07-27 14:52:53.0000=
00000 +0200
@@ -1794,6 +1794,9 @@
 #define PCI_DEVICE_ID_CCD_B00C		0xb00c
 #define PCI_DEVICE_ID_CCD_B100		0xb100
=20
+#define PCI_VENDOR_ID_EXAR		0x13a8
+#define PCI_DEVICE_ID_EXAR_XR17C158	0x0158
+
 #define PCI_VENDOR_ID_MICROGATE		0x13c0
 #define PCI_DEVICE_ID_MICROGATE_USC	0x0010
 #define PCI_DEVICE_ID_MICROGATE_SCC	0x0020

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFBCgM0UcUgUprPgz4RAhCBAJ0U1XowA5jdY7OgbaMbcIiqHwMxYACfT5Zo
iBPGXt/NkvdtIHjHUza/txw=
=nXP9
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
