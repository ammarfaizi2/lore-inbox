Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbTEAVEW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 17:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262584AbTEAVEW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 17:04:22 -0400
Received: from cpt-dial-196-30-180-5.mweb.co.za ([196.30.180.5]:50817 "EHLO
	nosferatu.lan") by vger.kernel.org with ESMTP id S262569AbTEAVES
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 17:04:18 -0400
Subject: OSS support for ICH5 sound
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: KML <linux-kernel@vger.kernel.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-oJE1ZAx1BZG0GEZ4KUJ7"
Organization: 
Message-Id: <1051823687.11068.11.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4- 
Date: 01 May 2003 23:14:47 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-oJE1ZAx1BZG0GEZ4KUJ7
Content-Type: multipart/mixed; boundary="=-CMCiExbdRP8MLZjZU1ln"


--=-CMCiExbdRP8MLZjZU1ln
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi

I basically just added the ID's for the ICH5 sound, and it seems
to be working fine here.  This is against bk7, I haven't had time
to verify with bk11 yet, sorry.


Regards,

--=20

Martin Schlemmer




--=-CMCiExbdRP8MLZjZU1ln
Content-Disposition: attachment; filename=ICH5_audio.patch
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; name=ICH5_audio.patch; charset=ISO-8859-1

--- linux/sound/oss/i810_audio.c.orig	2003-05-01 23:03:02.000000000 +0200
+++ linux/sound/oss/i810_audio.c	2003-05-01 23:03:53.000000000 +0200
@@ -115,6 +114,9 @@
 #ifndef PCI_DEVICE_ID_INTEL_ICH4
 #define PCI_DEVICE_ID_INTEL_ICH4	0x24c5
 #endif
+#ifndef PCI_DEVICE_ID_INTEL_ICH5
+#define PCI_DEVICE_ID_INTEL_ICH5	0x24d5
+#endif
 #ifndef PCI_DEVICE_ID_INTEL_440MX
 #define PCI_DEVICE_ID_INTEL_440MX	0x7195
 #endif
@@ -270,6 +272,7 @@
 	INTELICH2,
 	INTELICH3,
 	INTELICH4,
+	INTELICH5,
 	SI7012,
 	NVIDIA_NFORCE,
 	AMD768,
@@ -283,6 +286,7 @@
 	"Intel ICH2",
 	"Intel ICH3",
 	"Intel ICH4",
+	"Intel ICH5",
 	"SiS 7012",
 	"NVIDIA nForce Audio",
 	"AMD 768",
@@ -301,7 +306,8 @@
 	{  1, 0x0000 }, /* INTEL440MX */
 	{  1, 0x0000 }, /* INTELICH2 */
 	{  2, 0x0000 }, /* INTELICH3 */
-        {  3, 0x0003 }, /* INTELICH4 */
+ 	{  3, 0x0003 }, /* INTELICH4 */
+	{  3, 0x0003 }, /* INTELICH5 */
 	/*@FIXME to be verified*/	{  2, 0x0000 }, /* SI7012 */
 	/*@FIXME to be verified*/	{  2, 0x0000 }, /* NVIDIA_NFORCE */
 	/*@FIXME to be verified*/	{  2, 0x0000 }, /* AMD768 */
@@ -321,6 +326,8 @@
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, INTELICH3},
 	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH4,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, INTELICH4},
+	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH5,
+	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, INTELICH5},
 	{PCI_VENDOR_ID_SI, PCI_DEVICE_ID_SI_7012,
 	 PCI_ANY_ID, PCI_ANY_ID, 0, 0, SI7012},
 	{PCI_VENDOR_ID_NVIDIA, PCI_DEVICE_ID_NVIDIA_MCP1_AUDIO,
@@ -2791,7 +2799,7 @@
 	 */=09
 	/* see i810_ac97_init for the next 7 lines (jsaw) */
 	inw(card->ac97base);
-	if ((card->pci_id =3D=3D PCI_DEVICE_ID_INTEL_ICH4)
+	if ((card->pci_id =3D=3D PCI_DEVICE_ID_INTEL_ICH4 || card->pci_id =3D=3D =
PCI_DEVICE_ID_INTEL_ICH5)
 	    && (card->use_mmio)) {
 		primary_codec_id =3D (int) readl(card->iobase_mmio + SDM) & 0x3;
 		printk(KERN_INFO "i810_audio: Primary codec has ID %d\n",
@@ -2861,7 +2869,7 @@
 		   possible IO channels. Bit 0:1 of SDM then holds the=20
 		   last codec ID spoken to.=20
 		*/
-		if ((card->pci_id =3D=3D PCI_DEVICE_ID_INTEL_ICH4)
+		if ((card->pci_id =3D=3D PCI_DEVICE_ID_INTEL_ICH4 || card->pci_id =3D=3D=
 PCI_DEVICE_ID_INTEL_ICH5)
 		    && (card->use_mmio)) {
 			ac97_id =3D (int) readl(card->iobase_mmio + SDM) & 0x3;
 			printk(KERN_INFO "i810_audio: Connection %d with codec id %d\n",

--=-CMCiExbdRP8MLZjZU1ln--

--=-oJE1ZAx1BZG0GEZ4KUJ7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+sY5HqburzKaJYLYRAjGiAJ4lZT1VP3A0k9Rut6kgXfJL13pKgwCfV4Hu
uj6+vYN2XR2ufVmN6u0Hhsc=
=yseS
-----END PGP SIGNATURE-----

--=-oJE1ZAx1BZG0GEZ4KUJ7--

