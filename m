Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263149AbUERMWQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263149AbUERMWQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 May 2004 08:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263184AbUERMWQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 May 2004 08:22:16 -0400
Received: from adsl-74-86.38-151.net24.it ([151.38.86.74]:48398 "EHLO
	gateway.milesteg.arr") by vger.kernel.org with ESMTP
	id S263149AbUERMWL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 May 2004 08:22:11 -0400
Date: Tue, 18 May 2004 14:22:09 +0200
From: Daniele Venzano <webvenza@libero.it>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Cc: Eric BENARD / Free <ebenard@free.fr>
Subject: Re: [PATCH] Sis900 bug fixes 2/4
Message-ID: <20040518122209.GE23565@picchio.gall.it>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Eric BENARD / Free <ebenard@free.fr>
References: <20040518120237.GC23565@picchio.gall.it>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Dzs2zDY0zgkG72+7"
Content-Disposition: inline
In-Reply-To: <20040518120237.GC23565@picchio.gall.it>
X-Operating-System: Debian GNU/Linux on kernel Linux 2.4.25-grsec
X-Copyright: Forwarding or publishing without permission is prohibited.
X-Truth: La vita e' una questione di culo, o ce l'hai o te lo fanno.
X-GPG-Fingerprint: 642A A345 1CEF B6E3 925C  23CE DAB9 8764 25B3 57ED
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Dzs2zDY0zgkG72+7
Content-Type: multipart/mixed; boundary="UoPmpPX/dBe4BELn"
Content-Disposition: inline


--UoPmpPX/dBe4BELn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Patch 2 of 4

Add new ISA bridge PCI ID

I added some constants to make the code more readable and modified the if
body to check for another ID in case the first check fails.

Any comment is highly appreciated.

--=20
-----------------------------
Daniele Venzano
Web: http://teg.homeunix.org


--UoPmpPX/dBe4BELn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sis900-isa-bridge-id.diff"
Content-Transfer-Encoding: quoted-printable

diff -Naru -X /home/venza/kernel/dontdiff linux-2.6.6/drivers/net/sis900.c =
linux-sis900/drivers/net/sis900.c
--- linux-2.6.6/drivers/net/sis900.c	2004-04-04 22:31:55.000000000 +0200
+++ linux-sis900/drivers/net/sis900.c	2004-05-18 10:51:39.000000000 +0200
@@ -260,9 +260,13 @@
 	u8 reg;
 	int i;
=20
-	if ((isa_bridge =3D pci_find_device(0x1039, 0x0008, isa_bridge)) =3D=3D N=
ULL) {
-		printk("%s: Can not find ISA bridge\n", net_dev->name);
-		return 0;
+	isa_bridge =3D pci_find_device(PCI_VENDOR_ID_SI, SIS630E_ISA_BRIDGE_ID_1,=
 isa_bridge);
+	if (!isa_bridge) {
+		isa_bridge =3D pci_find_device(PCI_VENDOR_ID_SI, SIS630E_ISA_BRIDGE_ID_2=
, isa_bridge);
+		if (!isa_bridge) {
+			printk("%s: Can not find ISA bridge\n", net_dev->name);
+			return 0;
+		}
 	}
 	pci_read_config_byte(isa_bridge, 0x48, &reg);
 	pci_write_config_byte(isa_bridge, 0x48, reg | 0x40);
diff -Naru -X /home/venza/kernel/dontdiff linux-2.6.6/drivers/net/sis900.h =
linux-sis900/drivers/net/sis900.h
--- linux-2.6.6/drivers/net/sis900.h	2003-06-17 06:19:41.000000000 +0200
+++ linux-sis900/drivers/net/sis900.h	2004-05-18 10:49:50.000000000 +0200
@@ -274,6 +274,9 @@
 #define TX_TOTAL_SIZE	NUM_TX_DESC*sizeof(BufferDesc)
 #define RX_TOTAL_SIZE	NUM_RX_DESC*sizeof(BufferDesc)
=20
+#define SIS630E_ISA_BRIDGE_ID_1	0x0008=09
+#define SIS630E_ISA_BRIDGE_ID_2	0x0018=09
+
 /* PCI stuff, should be move to pci.h */
 #define SIS630_VENDOR_ID        0x1039
 #define SIS630_DEVICE_ID        0x0630

--UoPmpPX/dBe4BELn--

--Dzs2zDY0zgkG72+7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAqf/x2rmHZCWzV+0RAn0EAJ9GXCmbaH0D2Gd/v7EtuYnE5ae9OwCgg3o5
U7QoXwe3Vn6CeMLxHDaAwnc=
=QfjL
-----END PGP SIGNATURE-----

--Dzs2zDY0zgkG72+7--
