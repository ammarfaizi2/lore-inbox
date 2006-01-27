Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932432AbWA0JFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbWA0JFt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 04:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932431AbWA0JFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 04:05:48 -0500
Received: from moutng.kundenserver.de ([212.227.126.171]:30408 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932429AbWA0JFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 04:05:47 -0500
From: Prakash Punnoor <prakash@punnoor.de>
To: jgarzik@pobox.com
Subject: Re: libata support for JMicron JMB360 ?
Date: Fri, 27 Jan 2006 10:08:22 +0100
User-Agent: KMail/1.9
Cc: lkml <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
References: <200512301541.36483.prakash@punnoor.de> <200512311047.54929.prakash@punnoor.de>
In-Reply-To: <200512311047.54929.prakash@punnoor.de>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart19973450.pgB6uOvJAf";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200601271008.25812.prakash@punnoor.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:cec1af1025af73746bdd9be3587eb485
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart19973450.pgB6uOvJAf
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Samstag Dezember 31 2005 10:47 schrieb Prakash Punnoor:
> Am Freitag Dezember 30 2005 15:41 schrieb Prakash Punnoor:
> > Hi,
> >
> > I read in an old thread that this question was asked once and you repli=
ed
> > you never heard of this chip. Maybe now the situation has changed? If
> > not, please take a look here:
> >
> > http://www.jmicron.com/product/jmb360.htm
> >
> > It claims the chip is ahci compatible, but the libata ahci driver can't
> > detect it (tried 2.6.14.2 and 2.6.15-rc7).
> >
> > Maybe just adding some ids or such is enough for supporting it?
> > Following lspci -vvv -xxx regrading the Jmicron stuff:
>
> [...]
>
> Well, I tried adding the ids into ahci.c, but this wasn't enough:
>
> --- linux-2.6.15-rc7/drivers/scsi/ahci.c.old	2005-12-31 10:36:35.000000000
> +0100
> +++ linux-2.6.15-rc7/drivers/scsi/ahci.c	2005-12-31 10:36:45.000000000
> +0100 @@ -277,6 +277,8 @@
>  	  board_ahci }, /* ESB2 */
>  	{ PCI_VENDOR_ID_INTEL, 0x27c6, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
>  	  board_ahci }, /* ICH7-M DH */
> +	{ 0x197b, 0x2360, PCI_ANY_ID, PCI_ANY_ID, 0, 0,
> +	  board_ahci }, /* JMicron JMB360 */
>  	{ }	/* terminate list */
>  };
>
> dmesg gives:
> libata version 1.20 loaded.
> ahci 0000:03:00.0: version 1.2
> ACPI: PCI Interrupt 0000:03:00.0[A] -> GSI 35 (level, low) -> IRQ 50
> PCI: Setting latency timer of device 0000:03:00.0 to 64
> ahci 0000:03:00.0: AHCI 0001.0000 32 slots 1 ports 3 Gbps 0x1 impl SATA
> mode ahci 0000:03:00.0: flags: 64bit ncq pm led clo pmp pio slum part
> ata1: SATA max UDMA/133 cmd 0xF8804100 ctl 0x0 bmdma 0x0 irq 50
> ata1 is slow to respond, please be patient
> ata1 failed to respond (30 secs)
> scsi0 : ahci


Hi Jeff,

I still haven't got a reply from lkml, but an JMicron employee contacted me=
=20
and told me how to get this working:

> //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=20
> Root Cause:=20
> Although AsRock reserves AHCI/IDE mode for JMB360, AsRock sets JMB360 in =
=20
> IDE mode actually when boot.=20
> JMB360 needs a Reset mechanism to switch to AHCI mode on AsRock MB for =20
> your Linux driver porting.=20
> =20
> Reset Mechanism:=20
> 1. At PCI Configuration Address h'41, write value h'a1 (default is h'f1)=
=20
> 2. At AHCI Base address+offset h'04, write 1'b1 at bit 0 location. It is =
=20
> "HBA Reset" bit.=20
> 3. And then JMB360 come back to AHCI mode=20
> //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
 =20
Unfortunately my kernel knowledge is next to none, so I cannot implement th=
is.=20
But I guess it should be easy for you or anyone else having done similar. T=
he=20
employee actually told me that he mailed above to you, so was it just lack =
of=20
time, you didn't made a quirk or any other reason?

Cheers,
=2D-=20
(=C2=B0=3D                 =3D=C2=B0)
//\ Prakash Punnoor /\\
V_/                 \_V

--nextPart19973450.pgB6uOvJAf
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBD2eMJxU2n/+9+t5gRAmj+AKDb0c3bbRSHHaezOfxpM8Q5JoYNwQCePIfD
3A8sgLQ0qYOBxmln9qRqc7Y=
=CNy0
-----END PGP SIGNATURE-----

--nextPart19973450.pgB6uOvJAf--
