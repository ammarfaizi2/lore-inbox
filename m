Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315483AbSEVJGn>; Wed, 22 May 2002 05:06:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316898AbSEVJGm>; Wed, 22 May 2002 05:06:42 -0400
Received: from point41.gts.donpac.ru ([213.59.116.41]:11020 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S315483AbSEVJGm>;
	Wed, 22 May 2002 05:06:42 -0400
Date: Wed, 22 May 2002 13:10:58 +0400
From: Andrey Panin <pazke@orbita1.ru>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Serverworks IDE driver: missing static
Message-ID: <20020522091058.GA312@pazke.ipt>
Mail-Followup-To: Martin Dalecki <dalecki@evision-ventures.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="b5gNqxB1S1yM7hjW"
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
X-Uname: Linux pazke 2.5.15 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--b5gNqxB1S1yM7hjW
Content-Type: multipart/mixed; boundary="G4iJoqBmSsgzjUCe"
Content-Disposition: inline


--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

svwks_tune_chipset() function contains 3 arrays which IMHO should be static.
Attached patch fixed it, saving for me 48 bytes of code :))
Compiles, but untested. Please consider applying.

Best regards.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net
--G4iJoqBmSsgzjUCe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-serverworks
Content-Transfer-Encoding: quoted-printable

diff -urN -X /usr/share/dontdiff linux.vanilla/drivers/ide/serverworks.c li=
nux/drivers/ide/serverworks.c
--- linux.vanilla/drivers/ide/serverworks.c	Tue May 21 01:55:59 2002
+++ linux/drivers/ide/serverworks.c	Wed May 22 03:36:04 2002
@@ -242,9 +242,9 @@
=20
 static int svwks_tune_chipset(struct ata_device *drive, byte speed)
 {
-	byte udma_modes[]	=3D { 0x00, 0x01, 0x02, 0x03, 0x04, 0x05 };
-	byte dma_modes[]	=3D { 0x77, 0x21, 0x20 };
-	byte pio_modes[]	=3D { 0x5d, 0x47, 0x34, 0x22, 0x20 };
+	static byte udma_modes[] =3D { 0x00, 0x01, 0x02, 0x03, 0x04, 0x05 };
+	static byte dma_modes[]	=3D { 0x77, 0x21, 0x20 };
+	static byte pio_modes[]	=3D { 0x5d, 0x47, 0x34, 0x22, 0x20 };
=20
 	struct ata_channel *hwif =3D drive->channel;
 	struct pci_dev *dev	=3D hwif->pci_dev;

--G4iJoqBmSsgzjUCe--

--b5gNqxB1S1yM7hjW
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE862CiBm4rlNOo3YgRArHvAKCF2fqeAQXAedft02Tu0HqLcssMRgCeNaTV
7yQC8YEf6NnlpsMr9SkZZPU=
=08jO
-----END PGP SIGNATURE-----

--b5gNqxB1S1yM7hjW--
