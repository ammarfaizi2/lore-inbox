Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266888AbSKZUVe>; Tue, 26 Nov 2002 15:21:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266897AbSKZUVd>; Tue, 26 Nov 2002 15:21:33 -0500
Received: from imap.laposte.net ([213.30.181.7]:35986 "EHLO smtp.laposte.net")
	by vger.kernel.org with ESMTP id <S266888AbSKZUVa>;
	Tue, 26 Nov 2002 15:21:30 -0500
Subject: Re: Re:[PATCH] [2.4] AGP Support for VIA KT400
From: Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>
To: marcelo <marcelo@connectiva.com.br>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       ldelgass <ldelgass@retinalburn.net>, alan <alan@lxorguk.ukuu.org.uk>,
       jw <jw@tks6.net>
In-Reply-To: <H66RDK$A51F2CB58537836203238D57286D3D15@laposte.net>
References: <H66RDK$A51F2CB58537836203238D57286D3D15@laposte.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-1rneqbua2kfpcGs82IcD"
Organization: 
Message-Id: <1038342519.1233.9.camel@rousalka>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 (1.2.0-3) 
Date: 26 Nov 2002 21:28:39 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-1rneqbua2kfpcGs82IcD
Content-Type: multipart/mixed; boundary="=-62aq9JNkYAZdlhFFxVAe"


--=-62aq9JNkYAZdlhFFxVAe
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

[Please CC me replies as I'm not on the list]

Le mar 26/11/2002 =E0 14:41, Nicolas Mailhot a =E9crit :

> In fact I've been cleaning up a bit the 2.4 version before
> submitting it -- the entries for other VIA chips are a bit
> more convoluted and I suspect the first patch is not as
> complete as it should be. In fact I think I'll post a 2.5
> followup soon.
>=20
> Please do not apply the first patch and use this one instead.

Which was webmail-borked. Sorry, should not have let the other
submission rush me.

Anyway here is a cleaned-up tested version for 2.4.20-rc4. It's
basically a straight port of the 2.5 patch, plus the dri bits I missed
in 2.5 (purely cosmetic, but hey not having his dmesg full of unknown
chips is always nice), plus some kt400-related pci ids for the database.

The effect is the same as the patch that went in 2.5, with a few nicer
printks.

Please apply

--=20
Nicolas Mailhot <Nicolas.Mailhot@laPoste.net>

--=-62aq9JNkYAZdlhFFxVAe
Content-Disposition: attachment; filename=kt400-agp.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-patch; name=kt400-agp.patch; charset=ISO-8859-15

diff -uNr linux-2.4.20-rc4.orig/drivers/char/agp/agpgart_be.c linux-2.4.20-=
rc4/drivers/char/agp/agpgart_be.c
--- linux-2.4.20-rc4.orig/drivers/char/agp/agpgart_be.c	2002-11-26 20:37:23=
.000000000 +0100
+++ linux-2.4.20-rc4/drivers/char/agp/agpgart_be.c	2002-11-26 20:54:16.0000=
00000 +0100
@@ -4714,6 +4714,12 @@
 		"Via",
 		"Apollo Pro KT266",
 		via_generic_setup },
+        { PCI_DEVICE_ID_VIA_8377_0,
+		PCI_VENDOR_ID_VIA,
+		VIA_APOLLO_KT400,
+		"Via",
+		"Apollo Pro KT400",
+		via_generic_setup },
 	{ 0,
 		PCI_VENDOR_ID_VIA,
 		VIA_GENERIC,
diff -uNr linux-2.4.20-rc4.orig/drivers/char/drm/drm_agpsupport.h linux-2.4=
.20-rc4/drivers/char/drm/drm_agpsupport.h
--- linux-2.4.20-rc4.orig/drivers/char/drm/drm_agpsupport.h	2002-11-26 20:3=
7:23.000000000 +0100
+++ linux-2.4.20-rc4/drivers/char/drm/drm_agpsupport.h	2002-11-26 20:54:16.=
000000000 +0100
@@ -279,6 +279,8 @@
 			break;
 		case VIA_APOLLO_KT133:	head->chipset =3D "VIA Apollo KT133";
 			break;
+		case VIA_APOLLO_KT400:  head->chipset =3D "VIA Apollo KT400";
+			break;
 		case VIA_APOLLO_PRO: 	head->chipset =3D "VIA Apollo Pro";
 			break;
=20
diff -uNr linux-2.4.20-rc4.orig/drivers/char/drm-4.0/agpsupport.c linux-2.4=
.20-rc4/drivers/char/drm-4.0/agpsupport.c
--- linux-2.4.20-rc4.orig/drivers/char/drm-4.0/agpsupport.c	2002-02-25 20:3=
7:57.000000000 +0100
+++ linux-2.4.20-rc4/drivers/char/drm-4.0/agpsupport.c	2002-11-26 20:54:16.=
000000000 +0100
@@ -275,6 +275,8 @@
 			break;
 		case VIA_APOLLO_KT133:	head->chipset =3D "VIA Apollo KT133";=20
 			break;
+		case VIA_APOLLO_KT400:  head->chipset =3D "VIA Apollo KT400";
+			break;
 #endif
=20
 		case VIA_APOLLO_PRO: 	head->chipset =3D "VIA Apollo Pro";
diff -uNr linux-2.4.20-rc4.orig/drivers/pci/pci.ids linux-2.4.20-rc4/driver=
s/pci/pci.ids
--- linux-2.4.20-rc4.orig/drivers/pci/pci.ids	2002-11-26 20:37:24.000000000=
 +0100
+++ linux-2.4.20-rc4/drivers/pci/pci.ids	2002-11-26 20:54:16.000000000 +010=
0
@@ -582,6 +582,7 @@
 	6003  CS 4614/22/24 [CrystalClear SoundFusion Audio Accelerator]
 		1013 4280  Crystal SoundFusion PCI Audio Accelerator
 		1681 0050  Hercules Game Theater XP
+		1681 a011  Hercules Fortissimo III 7.1
 	6004  CS 4614/22/24 [CrystalClear SoundFusion Audio Accelerator]
 	6005  Crystal CS4281 PCI Audio
 		1013 4281  Crystal CS4281 PCI Audio
@@ -2678,6 +2679,7 @@
 	0505  VT82C505
 	0561  VT82C561
 	0571  VT82C586B PIPC Bus Master IDE
+		1458 5002 GA-7VAX Mainboard
 	0576  VT82C576 3V [Apollo Master]
 	0585  VT82C585VP [Apollo VP1/VPX]
 	0586  VT82C586/A/B PCI-to-ISA [Apollo VP]
@@ -2726,6 +2728,7 @@
 		1462 3091  MS-6309 Onboard Audio
 		15dd 7609  Onboard Audio
 	3059  VT8233 AC97 Audio Controller
+		1458 a002  GA-7VAX Onboard Audio (Realtek ALC650)=20
 	3065  VT6102 [Rhine-II]
 		1186 1400  DFE-530TX rev A
 		1186 1401  DFE-530TX rev B
@@ -2739,6 +2742,7 @@
 	3102  VT8662 Host Bridge
 	3103  VT8615 Host Bridge
 	3104  USB 2.0
+		1458 5004  GA-7VAX Mainboard
 	3109  VT8233C PCI to ISA Bridge
 	3112  VT8361 [KLE133] Host Bridge
 	3128  VT8753 [P4X266 AGP]
@@ -2747,6 +2751,9 @@
 	3148  P4M266 Host Bridge
 	3156  P/KN266 Host Bridge
 	3177  VT8233A ISA Bridge
+		1458 5001 GA-7VAX Mainboard
+	3189  VT8377 [KT400 AGP] Host Bridge
+		1458 5000 GA-7VAX Mainboard
 	5030  VT82C596 ACPI [Apollo PRO]
 	6100  VT85C100A [Rhine II]
 	8231  VT8231 [PCI-to-ISA Bridge]
@@ -2767,6 +2774,7 @@
 	b102  VT8362 AGP Bridge
 	b103  VT8615 AGP Bridge
 	b112  VT8361 [KLE133] AGP Bridge
+	b168  VT8235 PCI Bridge
 1107  Stratus Computers
 	0576  VIA VT82C570MV [Apollo] (Wrong vendor ID!)
 1108  Proteon, Inc.
diff -uNr linux-2.4.20-rc4.orig/include/linux/agp_backend.h linux-2.4.20-rc=
4/include/linux/agp_backend.h
--- linux-2.4.20-rc4.orig/include/linux/agp_backend.h	2002-11-26 20:37:29.0=
00000000 +0100
+++ linux-2.4.20-rc4/include/linux/agp_backend.h	2002-11-26 20:54:16.000000=
000 +0100
@@ -60,6 +60,7 @@
 	VIA_APOLLO_PRO,
 	VIA_APOLLO_KX133,
 	VIA_APOLLO_KT133,
+	VIA_APOLLO_KT400,
 	SIS_GENERIC,
 	AMD_GENERIC,
 	AMD_IRONGATE,
diff -uNr linux-2.4.20-rc4.orig/include/linux/pci_ids.h linux-2.4.20-rc4/in=
clude/linux/pci_ids.h
--- linux-2.4.20-rc4.orig/include/linux/pci_ids.h	2002-11-26 20:37:29.00000=
0000 +0100
+++ linux-2.4.20-rc4/include/linux/pci_ids.h	2002-11-26 20:54:16.000000000 =
+0100
@@ -986,6 +986,7 @@
 #define PCI_DEVICE_ID_VIA_8233C_0	0x3109
 #define PCI_DEVICE_ID_VIA_8361		0x3112
 #define PCI_DEVICE_ID_VIA_8233A		0x3147
+#define PCI_DEVICE_ID_VIA_8377_0	0x3189
 #define PCI_DEVICE_ID_VIA_86C100A	0x6100
 #define PCI_DEVICE_ID_VIA_8231		0x8231
 #define PCI_DEVICE_ID_VIA_8231_4	0x8235

--=-62aq9JNkYAZdlhFFxVAe--

--=-1rneqbua2kfpcGs82IcD
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA949l2I2bVKDsp8g0RAjYkAKClXfVAfvBDH5/RKb5U3qhxcj6knQCghEgA
D4NnPzHdfVhqUuwPBl2zC9A=
=mPwh
-----END PGP SIGNATURE-----

--=-1rneqbua2kfpcGs82IcD--

