Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129243AbRBWHyi>; Fri, 23 Feb 2001 02:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129423AbRBWHy1>; Fri, 23 Feb 2001 02:54:27 -0500
Received: from orbita.don.sitek.net ([213.24.25.98]:5639 "EHLO
	orbita.don.sitek.net") by vger.kernel.org with ESMTP
	id <S129243AbRBWHyU>; Fri, 23 Feb 2001 02:54:20 -0500
Date: Fri, 23 Feb 2001 10:53:59 +0300
From: Andrey Panin <pazke@orbita.don.sitek.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/char/serial.c unchecked ioremap() calls
Message-ID: <20010223105359.A20170@orbita1.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8P1HSweYDcXXzwPJ"
User-Agent: Mutt/1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8P1HSweYDcXXzwPJ
Content-Type: multipart/mixed; boundary="GvXjxJ+pjyke8COw"


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable


Hi all,

16x50 serial driver doesn't check ioremap() return value.=20
Atached patch should fix this it.

Best regards.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc
--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-ioremap-serial
Content-Transfer-Encoding: quoted-printable

diff -ur linux.vanilla/drivers/char/serial.c linux/drivers/char/serial.c
--- linux.vanilla/drivers/char/serial.c	Thu Feb 22 20:50:18 2001
+++ linux/drivers/char/serial.c	Thu Feb 22 23:01:48 2001
@@ -3876,7 +3876,8 @@
 		return 0;
 	}
 	req->io_type =3D SERIAL_IO_MEM;
-	req->iomem_base =3D ioremap(port, board->uart_offset);
+	if ((req->iomem_base =3D ioremap(port, board->uart_offset)) =3D=3D NULL)
+		return 1;
 	req->iomem_reg_shift =3D board->reg_shift;
 	req->port =3D 0;
 	return 0;
@@ -4010,7 +4011,8 @@
 				      data | pci_config);
 =09
 	/* enable/disable interrupts */
-	p =3D ioremap(pci_resource_start(dev, 0), 0x80);
+	if ((p =3D ioremap(pci_resource_start(dev, 0), 0x80)) =3D=3D NULL)
+		return 1;
 	writel(enable ? irq_config : 0x00, (unsigned long)p + 0x4c);
 	iounmap(p);
=20
@@ -4053,7 +4055,8 @@
=20
        if (!enable) return 0;
=20
-       p =3D ioremap(pci_resource_start(dev, 0), 0x80);
+       if ((p =3D ioremap(pci_resource_start(dev, 0), 0x80)) =3D=3D NULL)
+		return 1;
=20
        switch (dev->device & 0xfff8) {
                case PCI_DEVICE_ID_SIIG_1S_10x:         /* 1S */

--GvXjxJ+pjyke8COw--

--8P1HSweYDcXXzwPJ
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6lhcXBm4rlNOo3YgRAusAAJ4k9KJd9lg8gV9LiX4brEIH+RJf3QCfZFet
thfQodqEOVFBGQwGE4+KD+k=
=eAYS
-----END PGP SIGNATURE-----

--8P1HSweYDcXXzwPJ--
