Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261313AbVAaTTA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261313AbVAaTTA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 14:19:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261327AbVAaTTA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 14:19:00 -0500
Received: from nijmegen.renzel.net ([195.243.213.130]:21942 "EHLO
	mx1.renzel.net") by vger.kernel.org with ESMTP id S261313AbVAaTSY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 14:18:24 -0500
From: Mws <mws@twisted-brains.org>
To: linux-kernel@vger.kernel.org
Subject: strange behaviour using cryptoloop & ext2
Date: Mon, 31 Jan 2005 20:18:38 +0100
User-Agent: KMail/1.7.91
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart3047452.53Mz7YB6QU";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200501312018.43934.mws@twisted-brains.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart3047452.53Mz7YB6QU
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hi,

i just tried to set up a 120 gb S-ATA device using cryptoloop.
losetup worked.
mkfs.ext2 results into following dmesg output when nearly 400/896 blocks ar=
e finished.

oom-killer: gfp_mask=3D0xd0
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
cpu 1 hot: low 2, high 6, batch 1
cpu 1 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
HighMem per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16

=46ree pages:      699244kB (695360kB HighMem)
Active:102229 inactive:193160 dirty:0 writeback:176544 unstable:0 free:1748=
11 slab:42715 mapped:101414 pagetables:857
DMA free:68kB min:68kB low:84kB high:100kB active:156kB inactive:6744kB pre=
sent:16384kB pages_scanned:1997 all_unreclaimable? no
protections[]: 0 0 0
Normal free:3816kB min:3756kB low:4692kB high:5632kB active:756kB inactive:=
700644kB present:901120kB pages_scanned:1193 all_unreclaimable? no
protections[]: 0 0 0
HighMem free:695360kB min:512kB low:640kB high:768kB active:408004kB inacti=
ve:65324kB present:1179328kB pages_scanned:0 all_unreclaimable? no
protections[]: 0 0 0
DMA: 3*4kB 1*8kB 1*16kB 1*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*20=
48kB 0*4096kB =3D 68kB
Normal: 0*4kB 63*8kB 13*16kB 9*32kB 2*64kB 1*128kB 0*256kB 1*512kB 0*1024kB=
 1*2048kB 0*4096kB =3D 3816kB
HighMem: 11378*4kB 8793*8kB 3051*16kB 1276*32kB 760*64kB 537*128kB 409*256k=
B 137*512kB 71*1024kB 33*2048kB 14*4096kB =3D 695360kB
Swap cache: add 0, delete 0, find 0/0, race 0+0
Out of Memory: Killed process 29470 (konqueror).
oom-killer: gfp_mask=3D0x80d0
DMA per-cpu:
cpu 0 hot: low 2, high 6, batch 1
cpu 0 cold: low 0, high 2, batch 1
cpu 1 hot: low 2, high 6, batch 1
cpu 1 cold: low 0, high 2, batch 1
Normal per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16
HighMem per-cpu:
cpu 0 hot: low 32, high 96, batch 16
cpu 0 cold: low 0, high 32, batch 16
cpu 1 hot: low 32, high 96, batch 16
cpu 1 cold: low 0, high 32, batch 16

otherwise mkfs.xfs worked properly and gave the following output.

mkfs.xfs /dev/loop0
meta-data=3D/dev/loop0             isize=3D256    agcount=3D16, agsize=3D18=
31535 blks
         =3D                       sectsz=3D512
data     =3D                       bsize=3D4096   blocks=3D29304560, imaxpc=
t=3D25
         =3D                       sunit=3D0      swidth=3D0 blks, unwritte=
n=3D1
naming   =3Dversion 2              bsize=3D4096
log      =3Dinternal log           bsize=3D4096   blocks=3D14308, version=
=3D1
         =3D                       sectsz=3D512   sunit=3D0 blks
realtime =3Dnone                   extsz=3D65536  blocks=3D0, rtextents=3D0


util-linux is @version util-linux-2.12p
kernel is 2.6.11-rc2 having the ITE8212 patch from the ac patchset
glibc is GNU C Library 20041102 release version 2.3.4, by Roland McGrath et=
 al.
gcc is versioned gcc-3.4.3.20050110

HD is=20
Host: scsi2 Channel: 00 Id: 00 Lun: 00
  Vendor: ATA      Model: ST3120026AS      Rev: 3.05
  Type:   Direct-Access                    ANSI SCSI revision: 05

lspci shows
lspci
0000:00:00.0 Host bridge: Intel Corp. 925X/XE Memory Controller Hub (rev 04)
0000:00:01.0 PCI bridge: Intel Corp. 925X/XE PCI Express Root Port (rev 04)
0000:00:1b.0 Class 0403: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) Hi=
gh Definition Audio Controller (rev 03)
0000:00:1c.0 PCI bridge: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) PC=
I Express Port 1 (rev 03)
0000:00:1c.1 PCI bridge: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) PC=
I Express Port 2 (rev 03)
0000:00:1c.2 PCI bridge: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) PC=
I Express Port 3 (rev 03)
0000:00:1d.0 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family=
) USB UHCI #1 (rev 03)
0000:00:1d.1 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family=
) USB UHCI #2 (rev 03)
0000:00:1d.2 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family=
) USB UHCI #3 (rev 03)
0000:00:1d.3 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family=
) USB UHCI #4 (rev 03)
0000:00:1d.7 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family=
) USB2 EHCI Controller (rev 03)
0000:00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev d3)
0000:00:1f.0 ISA bridge: Intel Corp. 82801FB/FR (ICH6/ICH6R) LPC Interface =
Bridge (rev 03)
0000:00:1f.1 IDE interface: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family)=
 IDE Controller (rev 03)
0000:00:1f.2 Class 0106: Intel Corp. 82801FR/FRW (ICH6R/ICH6RW) SATA Contro=
ller (rev 03)
0000:00:1f.3 SMBus: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) SMBus C=
ontroller (rev 03)
0000:01:00.0 Ethernet controller: Marvell Technology Group Ltd.: Unknown de=
vice 1fa7 (rev 07)
0000:01:03.0 FireWire (IEEE 1394): Texas Instruments TSB82AA2 IEEE-1394b Li=
nk Layer Controller (rev 01)
0000:01:04.0 Unknown mass storage controller: Integrated Technology Express=
, Inc. IT/ITE8212 Dual channel ATA RAID controller (PCI version seems to be=
 IT8212, embedded seems (rev 13)
0000:01:05.0 Unknown mass storage controller: Silicon Image, Inc. (formerly=
 CMD Technology Inc) SiI 3114 [SATALink/SATARaid] Serial ATA Controller (re=
v 02)
0000:01:0a.0 Multimedia controller: Philips Semiconductors SAA7146 (rev 01)
0000:02:00.0 Ethernet controller: Marvell Technology Group Ltd. Gigabit Eth=
ernet Controller (rev 15)
0000:03:00.0 Ethernet controller: Marvell Technology Group Ltd. Gigabit Eth=
ernet Controller (rev 15)
0000:05:00.0 VGA compatible controller: ATI Technologies Inc RV370 5B62 [Ra=
deon X600 (PCIE)]
0000:05:00.1 Display controller: ATI Technologies Inc: Unknown device 5b72



if more information is needed - please contact me.

help is appriciated.

regards
marcel


--nextPart3047452.53Mz7YB6QU
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQBB/oSTPpA+SyJsko8RAnlBAKDWEKlscgWBApiimt/l8BbO7dACUwCgt7C7
ipKcMP7/PNOHN0lTlnkK1y8=
=mKYM
-----END PGP SIGNATURE-----

--nextPart3047452.53Mz7YB6QU--
