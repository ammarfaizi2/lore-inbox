Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261156AbVGBKzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261156AbVGBKzf (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 06:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbVGBKzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 06:55:35 -0400
Received: from oldconomy.demon.nl ([212.238.217.56]:54948 "EHLO
	artemis.slagter.name") by vger.kernel.org with ESMTP
	id S261156AbVGBKzE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 06:55:04 -0400
Subject: [PATCH] ich6m-pciid-piix.patch
From: Erik Slagter <erik@slagter.name>
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-d9CY5WW9SRLrbIkgBGaQ"
Date: Sat, 02 Jul 2005 12:57:54 +0200
Message-Id: <1120301874.4300.35.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-8) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-d9CY5WW9SRLrbIkgBGaQ
Content-Type: multipart/mixed; boundary="=-IYlZOT46YpJrPZPVe1bF"


--=-IYlZOT46YpJrPZPVe1bF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

I am not sure someone already did this one, but it doesn't seem to be in
git nor mm at the moment.

This adds ICH6M to the pci ids of the (standard) piix ide driver. This
makes it possible to use the standard ide driver for this chipset and
enable udma.

The other way is to use the libata driver, but this has too many
drawback for the moment (no hdparm/smart/atapi support, with
patch/#define it does, but doesn't work for me and crashes). Also pata
harddisks are assigned incorrectly sda device names.

This look okay to me, having said this, I must admit I don't know ***
from this source file ;-)

Thx.

diff -ur a/drivers/ide/pci/piix.c linux-2.6.12/drivers/ide/pci/piix.c
--- a/drivers/ide/pci/piix.c	2005-06-17 21:48:29.000000000 +0200
+++ b/drivers/ide/pci/piix.c	2005-07-02 12:37:43.000000000 +0200
@@ -133,6 +133,7 @@
 		case PCI_DEVICE_ID_INTEL_82801EB_11:
 		case PCI_DEVICE_ID_INTEL_ESB_2:
 		case PCI_DEVICE_ID_INTEL_ICH6_19:
+		case PCI_DEVICE_ID_INTEL_ICH6_5:
 		case PCI_DEVICE_ID_INTEL_ICH7_21:
 		case PCI_DEVICE_ID_INTEL_ESB2_18:
 			mode =3D 3;
@@ -447,6 +448,7 @@
 		case PCI_DEVICE_ID_INTEL_82801E_11:
 		case PCI_DEVICE_ID_INTEL_ESB_2:
 		case PCI_DEVICE_ID_INTEL_ICH6_19:
+		case PCI_DEVICE_ID_INTEL_ICH6_5:
 		case PCI_DEVICE_ID_INTEL_ICH7_21:
 		case PCI_DEVICE_ID_INTEL_ESB2_18:
 		{
@@ -575,6 +577,7 @@
 	/* 21 */ DECLARE_PIIX_DEV("ICH7"),
 	/* 22 */ DECLARE_PIIX_DEV("ICH4"),
 	/* 23 */ DECLARE_PIIX_DEV("ESB2"),
+	/* 24 */ DECLARE_PIIX_DEV("ICH6M"),
 };
=20
 /**
@@ -651,6 +654,7 @@
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_21, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 21},
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_1, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 22},
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ESB2_18, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 23},
+ 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_5, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 24},
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, piix_pci_tbl);


--=-IYlZOT46YpJrPZPVe1bF
Content-Disposition: inline; filename=ich6m-pciid-piix.patch
Content-Type: text/x-patch; name=ich6m-pciid-piix.patch; charset=UTF-8
Content-Transfer-Encoding: base64

ZGlmZiAtdXIgYS9kcml2ZXJzL2lkZS9wY2kvcGlpeC5jIGxpbnV4LTIuNi4xMi9kcml2ZXJzL2lk
ZS9wY2kvcGlpeC5jDQotLS0gYS9kcml2ZXJzL2lkZS9wY2kvcGlpeC5jCTIwMDUtMDYtMTcgMjE6
NDg6MjkuMDAwMDAwMDAwICswMjAwDQorKysgYi9kcml2ZXJzL2lkZS9wY2kvcGlpeC5jCTIwMDUt
MDctMDIgMTI6Mzc6NDMuMDAwMDAwMDAwICswMjAwDQpAQCAtMTMzLDYgKzEzMyw3IEBADQogCQlj
YXNlIFBDSV9ERVZJQ0VfSURfSU5URUxfODI4MDFFQl8xMToNCiAJCWNhc2UgUENJX0RFVklDRV9J
RF9JTlRFTF9FU0JfMjoNCiAJCWNhc2UgUENJX0RFVklDRV9JRF9JTlRFTF9JQ0g2XzE5Og0KKwkJ
Y2FzZSBQQ0lfREVWSUNFX0lEX0lOVEVMX0lDSDZfNToNCiAJCWNhc2UgUENJX0RFVklDRV9JRF9J
TlRFTF9JQ0g3XzIxOg0KIAkJY2FzZSBQQ0lfREVWSUNFX0lEX0lOVEVMX0VTQjJfMTg6DQogCQkJ
bW9kZSA9IDM7DQpAQCAtNDQ3LDYgKzQ0OCw3IEBADQogCQljYXNlIFBDSV9ERVZJQ0VfSURfSU5U
RUxfODI4MDFFXzExOg0KIAkJY2FzZSBQQ0lfREVWSUNFX0lEX0lOVEVMX0VTQl8yOg0KIAkJY2Fz
ZSBQQ0lfREVWSUNFX0lEX0lOVEVMX0lDSDZfMTk6DQorCQljYXNlIFBDSV9ERVZJQ0VfSURfSU5U
RUxfSUNINl81Og0KIAkJY2FzZSBQQ0lfREVWSUNFX0lEX0lOVEVMX0lDSDdfMjE6DQogCQljYXNl
IFBDSV9ERVZJQ0VfSURfSU5URUxfRVNCMl8xODoNCiAJCXsNCkBAIC01NzUsNiArNTc3LDcgQEAN
CiAJLyogMjEgKi8gREVDTEFSRV9QSUlYX0RFVigiSUNINyIpLA0KIAkvKiAyMiAqLyBERUNMQVJF
X1BJSVhfREVWKCJJQ0g0IiksDQogCS8qIDIzICovIERFQ0xBUkVfUElJWF9ERVYoIkVTQjIiKSwN
CisJLyogMjQgKi8gREVDTEFSRV9QSUlYX0RFVigiSUNINk0iKSwNCiB9Ow0KIA0KIC8qKg0KQEAg
LTY1MSw2ICs2NTQsNyBAQA0KIAl7IFBDSV9WRU5ET1JfSURfSU5URUwsIFBDSV9ERVZJQ0VfSURf
SU5URUxfSUNIN18yMSwgUENJX0FOWV9JRCwgUENJX0FOWV9JRCwgMCwgMCwgMjF9LA0KIAl7IFBD
SV9WRU5ET1JfSURfSU5URUwsIFBDSV9ERVZJQ0VfSURfSU5URUxfODI4MDFEQl8xLCBQQ0lfQU5Z
X0lELCBQQ0lfQU5ZX0lELCAwLCAwLCAyMn0sDQogCXsgUENJX1ZFTkRPUl9JRF9JTlRFTCwgUENJ
X0RFVklDRV9JRF9JTlRFTF9FU0IyXzE4LCBQQ0lfQU5ZX0lELCBQQ0lfQU5ZX0lELCAwLCAwLCAy
M30sDQorIAl7IFBDSV9WRU5ET1JfSURfSU5URUwsIFBDSV9ERVZJQ0VfSURfSU5URUxfSUNINl81
LCBQQ0lfQU5ZX0lELCBQQ0lfQU5ZX0lELCAwLCAwLCAyNH0sDQogCXsgMCwgfSwNCiB9Ow0KIE1P
RFVMRV9ERVZJQ0VfVEFCTEUocGNpLCBwaWl4X3BjaV90YmwpOw0K


--=-IYlZOT46YpJrPZPVe1bF--

--=-d9CY5WW9SRLrbIkgBGaQ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCxnMyJgD/6j32wUYRAoYiAJ9HOL9P6cCwSTwItmZKztLrb15Y3gCdEtsA
UFBh2pJow4FXNea0CDD2tCY=
=F/jy
-----END PGP SIGNATURE-----

--=-d9CY5WW9SRLrbIkgBGaQ--
