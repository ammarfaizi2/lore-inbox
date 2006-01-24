Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030369AbWAXIZ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030369AbWAXIZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 03:25:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932475AbWAXIZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 03:25:56 -0500
Received: from relay.rost.ru ([80.254.111.11]:149 "EHLO relay.rost.ru")
	by vger.kernel.org with ESMTP id S932466AbWAXIZ4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 03:25:56 -0500
Date: Tue, 24 Jan 2006 11:25:38 +0300
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] SIIG 8-port serial boards support
Message-ID: <20060124082538.GB4855@pazke>
Mail-Followup-To: Russell King <rmk@arm.linux.org.uk>,
	linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZwgA9U+XZDXt4+m+"
Content-Disposition: inline
X-Uname: Linux 2.6.11-pazke i686
User-Agent: Mutt/1.5.11
From: Andrey Panin <pazke@donpac.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZwgA9U+XZDXt4+m+
Content-Type: multipart/mixed; boundary="BwCQnh7xodEAoBMC"
Content-Disposition: inline


--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

This patch (against 2.6.16-rc1) adds support for SIIG 8 port serial boards.
Please consider applying.

Best regards.

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--BwCQnh7xodEAoBMC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-siig-8port-board
Content-Transfer-Encoding: quoted-printable


 drivers/serial/8250_pci.c |   25 ++++++++++++++++++++++++-
 include/linux/pci_ids.h   |    3 +++
 2 files changed, 27 insertions(+), 1 deletion(-)

diff -urdpNX /usr/share/dontdiff linux-2.6.16-rc1.vanilla/drivers/serial/82=
50_pci.c linux-2.6.16-rc1/drivers/serial/8250_pci.c
--- linux-2.6.16-rc1.vanilla/drivers/serial/8250_pci.c	2006-01-24 10:14:24.=
000000000 +0300
+++ linux-2.6.16-rc1/drivers/serial/8250_pci.c	2006-01-24 10:16:56.00000000=
0 +0300
@@ -439,6 +439,20 @@ static int pci_siig_init(struct pci_dev=20
 	return -ENODEV;
 }
=20
+static int pci_siig_setup(struct serial_private *priv,
+			  struct pciserial_board *board,
+			  struct uart_port *port, int idx)
+{
+	unsigned int bar =3D FL_GET_BASE(board->flags) + idx, offset =3D 0;
+
+	if (idx > 3) {
+		bar =3D 4;
+		offset =3D (idx - 4) * 8;
+	}
+
+	return setup_port(priv, port, bar, offset, 0);
+}
+
 /*
  * Timedia has an explosion of boards, and to avoid the PCI table from
  * growing *huge*, we use this function to collapse some 70 entries
@@ -748,7 +762,7 @@ static struct pci_serial_quirk pci_seria
 		.subvendor	=3D PCI_ANY_ID,
 		.subdevice	=3D PCI_ANY_ID,
 		.init		=3D pci_siig_init,
-		.setup		=3D pci_default_setup,
+		.setup		=3D pci_siig_setup,
 	},
 	/*
 	 * Titan cards
@@ -2134,6 +2148,15 @@ static struct pci_device_id serial_pci_t
 	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_4S_20x_850,
 		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 		pbn_b0_bt_4_921600 },
+	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_8S_20x_550,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b0_bt_8_921600 },
+	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_8S_20x_650,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b0_bt_8_921600 },
+	{	PCI_VENDOR_ID_SIIG, PCI_DEVICE_ID_SIIG_8S_20x_850,
+		PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+		pbn_b0_bt_8_921600 },
=20
 	/*
 	 * Computone devices submitted by Doug McNash dmcnash@computone.com
diff -urdpNX /usr/share/dontdiff linux-2.6.16-rc1.vanilla/include/linux/pci=
_ids.h linux-2.6.16-rc1/include/linux/pci_ids.h
--- linux-2.6.16-rc1.vanilla/include/linux/pci_ids.h	2006-01-24 10:14:51.00=
0000000 +0300
+++ linux-2.6.16-rc1/include/linux/pci_ids.h	2006-01-24 10:16:56.000000000 =
+0300
@@ -1677,6 +1677,9 @@
 #define PCI_DEVICE_ID_SIIG_2S1P_20x_550	0x2060
 #define PCI_DEVICE_ID_SIIG_2S1P_20x_650	0x2061
 #define PCI_DEVICE_ID_SIIG_2S1P_20x_850	0x2062
+#define PCI_DEVICE_ID_SIIG_8S_20x_550	0x2080
+#define PCI_DEVICE_ID_SIIG_8S_20x_650	0x2081
+#define PCI_DEVICE_ID_SIIG_8S_20x_850	0x2082
 #define PCI_SUBDEVICE_ID_SIIG_QUARTET_SERIAL	0x2050
=20
 #define PCI_VENDOR_ID_RADISYS		0x1331

--BwCQnh7xodEAoBMC--

--ZwgA9U+XZDXt4+m+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFD1eSCPjHNUy6paxMRAulpAJ9cWL+qm5hBksgFyBJkcXvCveqxsACgpMEw
XQTFjQ8wlR9Fx1kyc+a/NrU=
=yUsm
-----END PGP SIGNATURE-----

--ZwgA9U+XZDXt4+m+--
