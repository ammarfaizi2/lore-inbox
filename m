Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbVLaJyI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbVLaJyI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 04:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932121AbVLaJyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 04:54:08 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:54991 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932120AbVLaJyG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 04:54:06 -0500
From: Prakash Punnoor <prakash@punnoor.de>
To: jgarzik@pobox.com
Subject: Re: libata support for JMicron JMB360 ?
Date: Sat, 31 Dec 2005 10:47:50 +0100
User-Agent: KMail/1.9
Cc: lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
References: <200512301541.36483.prakash@punnoor.de>
In-Reply-To: <200512301541.36483.prakash@punnoor.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2183198.CPaStozmtu";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200512311047.54929.prakash@punnoor.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:cec1af1025af73746bdd9be3587eb485
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2183198.CPaStozmtu
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Freitag Dezember 30 2005 15:41 schrieb Prakash Punnoor:
> Hi,
>
> I read in an old thread that this question was asked once and you replied
> you never heard of this chip. Maybe now the situation has changed? If not,
> please take a look here:
>
> http://www.jmicron.com/product/jmb360.htm
>
> It claims the chip is ahci compatible, but the libata ahci driver can't
> detect it (tried 2.6.14.2 and 2.6.15-rc7).
>
> Maybe just adding some ids or such is enough for supporting it?
> Following lspci -vvv -xxx regrading the Jmicron stuff:

[...]

Well, I tried adding the ids into ahci.c, but this wasn't enough:

=2D-- linux-2.6.15-rc7/drivers/scsi/ahci.c.old	2005-12-31 10:36:35.00000000=
0=20
+0100
+++ linux-2.6.15-rc7/drivers/scsi/ahci.c	2005-12-31 10:36:45.000000000 +0100
@@ -277,6 +277,8 @@
 	  board_ahci }, /* ESB2 */
 	{ PCI_VENDOR_ID_INTEL, 0x27c6, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
 	  board_ahci }, /* ICH7-M DH */
+	{ 0x197b, 0x2360, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
+	  board_ahci }, /* JMicron JMB360 */
 	{ }	/* terminate list */
 };
=20
dmesg gives:
libata version 1.20 loaded.
ahci 0000:03:00.0: version 1.2
ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 35 (level, low) -> IRQ 50
PCI: Setting latency timer of device 0000:03:00.0 to 64
ahci 0000:03:00.0: AHCI 0001.0000 32 slots 1 ports 3 Gbps 0x1 impl SATA mode
ahci 0000:03:00.0: flags: 64bit ncq pm led clo pmp pio slum part=20
ata1: SATA max UDMA/133 cmd 0xF8804100 ctl 0x0 bmdma 0x0 irq 50
ata1 is slow to respond, please be patient
ata1 failed to respond (30 secs)
scsi0 : ahci

Any ideas?
=2D-=20
(=C2=B0=3D                 =3D=C2=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart2183198.CPaStozmtu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDtlPKxU2n/+9+t5gRAtTNAKCOLV73BnMx1T+3uIoE3TgZN532DwCfbg2k
di6gpTYIJUAgep2YXCzcHQ4=
=xWNs
-----END PGP SIGNATURE-----

--nextPart2183198.CPaStozmtu--
