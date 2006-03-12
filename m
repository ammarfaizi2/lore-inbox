Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750975AbWCLWVO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbWCLWVO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 17:21:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750854AbWCLWVO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 17:21:14 -0500
Received: from pool-68-237-228-215.ny325.east.verizon.net ([68.237.228.215]:62207
	"EHLO mail.blazebox.homeip.net") by vger.kernel.org with ESMTP
	id S1750730AbWCLWVN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 17:21:13 -0500
Subject: Re: Linux v2.6.16-rc6
From: Paul Blazejowski <paulb@blazebox.homeip.net>
To: Lee Revell <rlrevell@joe-job.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-ide@vger.kernel.org
In-Reply-To: <1142199970.25358.173.camel@mindpipe>
References: <1142189154.21274.20.camel@blaze.homeip.net>
	 <1142199970.25358.173.camel@mindpipe>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-AuaVLhJw6rINZlbA0O+t"
Date: Sun, 12 Mar 2006 17:21:29 -0500
Message-Id: <1142202089.9934.13.camel@blaze.homeip.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.5.92 Dropline GNOME 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-AuaVLhJw6rINZlbA0O+t
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sun, 2006-03-12 at 16:46 -0500, Lee Revell wrote:
> On Sun, 2006-03-12 at 13:45 -0500, Paul Blazejowski wrote:
> > On recent kernel 2.6.15.6 (or any 2.6.15.x) and latest testing
> > 2.6.16-rc6 libata detects and sets wrong UDMA modes for one of the
> > SATA-1 drives. This seems to be a bug.
> >=20
> > My setup is as follows:
> >=20
> > ASUS A8N-SLI-Premium Nforce4 mainboard
> > AMD Athlon X2 CPU running SMP
> > GCC 3.3.6
> > Slackware 10.2 Linux
> >=20
> > The drives are used in RAID1 array (dmraid), they are WDC-WD2000JD
> > series purchased few months apart. Sata is compiled in the kernel as
> > module sata_nv and functions properly, no errors or any other anomalies
> > were noticed but the UDMA mode detection seem wrong on the second drive=
.
> >=20
> > Drive one reports ata3: dev 0 configured for UDMA/100 while drive two
> > ata4: dev 0 configured for UDMA/133
>=20
> This bug report is still somewhat unclear.
>=20
> What are the correct modes you expect to see?
>=20
> Lee
>=20
>=20

I belive the modes should say DMA100 because UDMA133 would be mode ATA-7
and DMA100 ATA-6 mode. This is the info i get from hdparm -I on the ata3
drive: DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3 udma4 *udma5

while on the ata4 one:  DMA: mdma0 mdma1 mdma2 udma0 udma1 udma2 udma3
udma4 udma5 *udma6

The thing is that the older drive is the one with the mode being set at
133 while the newer with mode 100. I belive they come from the same
factory but do carry different firmware revisons.

I also tried the drives on sata_sil (sil3114) controller and they show
the same modes being detected:

sata_sil 0000:05:0a.0: Applying R_ERR on DMA activate FIS errata fix
ata5: SATA max UDMA/100 cmd 0xF9402080 ctl 0xF940208A bmdma 0xF9402000
irq 23
ata6: SATA max UDMA/100 cmd 0xF94020C0 ctl 0xF94020CA bmdma 0xF9402008
irq 23
ata7: SATA max UDMA/100 cmd 0xF9402280 ctl 0xF940228A bmdma 0xF9402200
irq 23
ata8: SATA max UDMA/100 cmd 0xF94022C0 ctl 0xF94022CA bmdma 0xF9402208
irq 23
ata5: SATA link up 1.5 Gbps (SStatus 113)
ata5: dev 0 cfg 49:2f00 82:306b 83:7e01 84:4003 85:3068 86:3c01 87:4003
88:203f
ata5: dev 0 ATA-6, max UDMA/100, 390721968 sectors: LBA48
ata5: dev 0 configured for UDMA/100
scsi5 : sata_sil
ata6: SATA link up 1.5 Gbps (SStatus 113)
ata6: dev 0 cfg 49:2f00 82:346b 83:7f61 84:4003 85:3468 86:3c41 87:4003
88:207f
ata6: dev 0 ATA-6, max UDMA/133, 390721968 sectors: LBA48
ata6: dev 0 configured for UDMA/100
scsi6 : sata_sil
ata7: SATA link down (SStatus 0)
scsi7 : sata_sil
ata8: SATA link down (SStatus 0)
scsi8 : sata_sil
  Vendor: ATA       Model: WDC WD2000JD-60K  Rev: 08.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdb: 390721968 512-byte hdwr sectors (200050 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
SCSI device sdb: 390721968 512-byte hdwr sectors (200050 MB)
sdb: Write Protect is off
sdb: Mode Sense: 00 3a 00 00
SCSI device sdb: drive cache: write back
 sdb: sdb1 sdb2 sdb3 sdb4
sd 5:0:0:0: Attached scsi disk sdb
  Vendor: ATA       Model: WDC WD2000JD-00H  Rev: 08.0
  Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sdc: 390721968 512-byte hdwr sectors (200050 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
SCSI device sdc: 390721968 512-byte hdwr sectors (200050 MB)
sdc: Write Protect is off
sdc: Mode Sense: 00 3a 00 00
SCSI device sdc: drive cache: write back
 sdc: sdc1 sdc2 sdc3 sdc4
sd 6:0:0:0: Attached scsi disk sdc

I also see a difference with the transfer rates from hdparm -Tt:

ata3 drive (mode UDMA100) shows:

Timing buffered disk reads:  172 MB in  3.00 seconds =3D  57.30 MB/sec

while ata4 drive (mode UDMA133) shows:

Timing buffered disk reads:  118 MB in  3.03 seconds =3D  38.96 MB/sec

At this point is this due to drive capabilites in regards to modes
supported, broken drive? or libata code bug? I am trying to be as clear
as possible, anything else i should provide?

Thanks,

Paul B.

--=-AuaVLhJw6rINZlbA0O+t
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEFJ7pwu5Nmh3PsiMRAhuSAJ9QJAZzRLi8GzjBFu2rBXuCa2tXHwCghBho
55i9UVBzTd5WnqRNV6A19nE=
=Luqc
-----END PGP SIGNATURE-----

--=-AuaVLhJw6rINZlbA0O+t--

