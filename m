Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269154AbUIRHiG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269154AbUIRHiG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Sep 2004 03:38:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269157AbUIRHfm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Sep 2004 03:35:42 -0400
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:37246 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S269154AbUIRHcq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Sep 2004 03:32:46 -0400
Date: Sat, 18 Sep 2004 00:32:42 -0700
To: linux-kernel mailing list <linux-kernel@vger.kernel.org>
Cc: marcelo.tosatti@cyclades.com
Subject: [PATCH] piix: Support 6300ESB SATA DMA adapter
Message-ID: <20040918073242.GA4928@darjeeling.triplehelix.org>
Mail-Followup-To: joshk@triplehelix.org,
	linux-kernel mailing list <linux-kernel@vger.kernel.org>,
	marcelo.tosatti@cyclades.com
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline
X-Habeas-SWE-1: winter into spring
X-Habeas-SWE-2: brightly anticipated
X-Habeas-SWE-3: like Habeas SWE (tm)
X-Habeas-SWE-4: Copyright 2002 Habeas (tm)
X-Habeas-SWE-5: Sender Warranted Email (SWE) (tm). The sender of this
X-Habeas-SWE-6: email in exchange for a license for this Habeas
X-Habeas-SWE-7: warrant mark warrants that this is a Habeas Compliant
X-Habeas-SWE-8: Message (HCM) and not spam. Please report use of this
X-Habeas-SWE-9: mark in spam to <http://www.habeas.com/report/>.
User-Agent: Mutt/1.5.6+20040818i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

It turns out that the piix IDE driver works for PCI ID 8086:25a3
(PCI_DEVICE_ID_INTEL_ESB_3) as well, per http://bugs.debian.org/254748,
so this patch allows piix to recognize it automatically. Darik Horn
originally wrote this patch.

Marcelo, please apply.

Signed-off-by: Joshua Kwan <joshk@triplehelix.org>

--=20
Joshua Kwan

# origin: Debian, #254748
# cset: n/a
# inclusion: not submitted
# description: add PIIX support for ESB3 chipset
# revision date: 2004-09-03

diff -Ndru kernel-source-2.4.26/drivers/ide/pci/piix.c kernel-source-2.4.26=
-pe750/drivers/ide/pci/piix.c
--- kernel-source-2.4.26/drivers/ide/pci/piix.c	Wed Apr 14 13:05:30 2004
+++ kernel-source-2.4.26-pe750/drivers/ide/pci/piix.c	Tue Jun 15 20:50:25 2=
004
@@ -155,6 +155,7 @@
 			case PCI_DEVICE_ID_INTEL_82801E_11:
 			case PCI_DEVICE_ID_INTEL_ESB_2:
 			case PCI_DEVICE_ID_INTEL_ICH6_2:
+			case PCI_DEVICE_ID_INTEL_ESB_3:
 				p +=3D sprintf(p, "PIIX4 Ultra 100 ");
 				break;
 			case PCI_DEVICE_ID_INTEL_82372FB_1:
@@ -294,6 +295,7 @@
 		case PCI_DEVICE_ID_INTEL_82801EB_11:
 		case PCI_DEVICE_ID_INTEL_ESB_2:
 		case PCI_DEVICE_ID_INTEL_ICH6_2:
+		case PCI_DEVICE_ID_INTEL_ESB_3:
 			mode =3D 3;
 			break;
 		/* UDMA 66 capable */
@@ -686,6 +688,7 @@
 		case PCI_DEVICE_ID_INTEL_82801E_11:
 		case PCI_DEVICE_ID_INTEL_ESB_2:
 		case PCI_DEVICE_ID_INTEL_ICH6_2:
+		case PCI_DEVICE_ID_INTEL_ESB_3:
 		{
 			unsigned int extra =3D 0;
 			pci_read_config_dword(dev, 0x54, &extra);
@@ -883,6 +886,7 @@
  	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801EB_1, PCI_ANY_ID, PCI_AN=
Y_ID, 0, 0, 18},
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB_2, PCI_ANY_ID, PCI_ANY_ID,=
 0, 0, 19},
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_2, PCI_ANY_ID, PCI_ANY_ID=
, 0, 0, 20},
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB_3, PCI_ANY_ID, PCI_ANY_ID,=
 0, 0, 21},
 	{ 0, },
 };
=20
diff -Ndru kernel-source-2.4.26/drivers/ide/pci/piix.h kernel-source-2.4.26=
-pe750/drivers/ide/pci/piix.h
--- kernel-source-2.4.26/drivers/ide/pci/piix.h	Wed Apr 14 13:05:30 2004
+++ kernel-source-2.4.26-pe750/drivers/ide/pci/piix.h	Wed Jun 16 07:59:41 2=
004
@@ -333,6 +333,20 @@
 		.enablebits	=3D {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
 		.bootable	=3D ON_BOARD,
 		.extra		=3D 0,
+	},{	/* 21 */
+		.vendor		=3D PCI_VENDOR_ID_INTEL,
+		.device		=3D PCI_DEVICE_ID_INTEL_ESB_3,
+		.name		=3D "ICH5",
+		.init_setup	=3D init_setup_piix,
+		.init_chipset	=3D init_chipset_piix,
+		.init_iops	=3D NULL,
+		.init_hwif	=3D init_hwif_piix,
+		.init_dma	=3D init_dma_piix,
+		.channels	=3D 2,
+		.autodma	=3D AUTODMA,
+		.enablebits	=3D {{0x41,0x80,0x80}, {0x43,0x80,0x80}},
+		.bootable	=3D ON_BOARD,
+		.extra		=3D 0,
 	},{
 		.vendor		=3D 0,
 		.device		=3D 0,

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)
Comment: http://triplehelix.org/~joshk/pubkey_gpg.asc

iQIVAwUBQUvkmqOILr94RG8mAQLLDxAA41V/cP52QMUdKDihBGbxWfWdWl7/Xkbb
zexL437cUUP28iQy1r1segj5yNqm+RCGMEGmpsLBlxI60wJgQvc9kRIU5yMSqwk5
vBoFCUyqSVg+J+W0F7UnABNgcAcJnx1/jruheRQCdJsMyuypWy55lpSoEfiffeef
b4PPJq9sRkd8VJ3n/7I6aKfn6yearVPQL6ImGoq3olJGXiusO2y7Yg6A1h2CTjr1
J7X39yjHj+CpONYQiCeSDde/2X+0tH8VAkIO98YUQ9cy92nVv4KhvZVN4TO7Eyd/
zdE4sgYNDlnppM5lQZKCYi6DS7ivUEdbf8UbAdlfvoFkpewpWJIkDmBhGwxzOMHA
Up7rux6j/b7yFwygfCkffipjLSGtUcvqHExxrsraFfjlPs8mbReDC2Hw4Ez+yNWR
0ducnR2WU5JPeioe+yl7EagMasYPKi8qCdr4DJfA6XbOPABs6QySsb2zhaYZrZ7q
peV2LuqWJh/bxbHerb2AhURKH+SUbLXw5XXmGU6lKsrO0v84//DxBOcY6Z3hbXLa
3afDqdKgLEGt8B6Ptuw+sI81A+yPtYZW9b7aRAJB2Lr6MINEHadT5aE98DT8i51W
GYISK8mGxHSsikYNqCu/LeyxhfLCrIbcpl4Nyju0mrfYMPLW8R99vrmYORHb77ti
E1AfmMFlk8c=
=doff
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
