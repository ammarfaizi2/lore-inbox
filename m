Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318365AbSHKVB4>; Sun, 11 Aug 2002 17:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318367AbSHKVBz>; Sun, 11 Aug 2002 17:01:55 -0400
Received: from winch-as1-04.win.ORG ([204.184.50.100]:62592 "EHLO
	SpacedOut.fries.net") by vger.kernel.org with ESMTP
	id <S318365AbSHKVBx>; Sun, 11 Aug 2002 17:01:53 -0400
Date: Sun, 11 Aug 2002 16:08:26 -0500
From: David Fries <dfries@mail.win.org>
To: linux-kernel@vger.kernel.org
Subject: via vp3 udma corruption
Message-ID: <20020811210826.GA684@spacedout.fries.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I started on 2.4.19 testing a CD-ROM with the ide-scsi driver.  It
gave errors with UDMA enabled.  Many hours later I decided my
harddrive is silently flipping a bit every once and a while on read!
Why wouldn't the harddrive report CRC errors?

I don't see any errors with UDMA disabled on both the hard drive and
CDROM.

    Host bridge: VIA Technologies, Inc. VT82C597 [Apollo VP3] (rev 4).
    PCI bridge: VIA Technologies, Inc. VT82C598/694x [Apollo MVP3/Pro133x A=
GP] (rev 0).
    ISA bridge: VIA Technologies, Inc. VT82C586/A/B PCI-to-ISA [Apollo VP] =
(rev 65).
    IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 6).

Previously I had a scsi harddrive, scsi cdrom, and a ide harddrive
without any reported kernel errors (that I know of).  To make a long
story short I made a gzip tar file of a cdrom image which made about a
~150 MB file.  I copied it four times on the harddrive (now I have
five copies), and diff said that the binary files did not compare.  I
pulled out a diff program I wrote which writes the 2K sector of each
file that contains any differences to a file, prints how many bytes
differed and which byte number it was.  Usually one byte differed on a
file, but not all the time, sometimes they matched, and I don't think
I ever saw the same location twice.

Ok so I had a raw dump of the good sector and bad sector that has
given me fits (note I did the same diff test with 100+MB of 7eceee0e
without any errors so it is somewhat dependent on the data I would
assume.)  I concatenated the problem blocks until I had about 180MB
did a diff and had even more errors with these files than the original
ones.

Doing a diff of the hexdump of the corrupted and correct sectors shows
the following,

 0000220 8d87 35ea 6427 9581 d097 c938 0c65 1795
 0000230 5892 d9aa 658a 65ad 653a 652f 6521 65b4
 0000240 4b97 4bae 4be0 4b84 4bf8 4b48 1678 17d9
-0000250 171d 175d 4f27 1ee0 4f71 4e7e a75a 4fda
+0000250 171d 175d 4f27 1ee0 4f71 4f7e a75a 4fda
 0000260 4e72 4e52 1ef0 3eff 3d72 3d42 9a76 d96d
 0000270 97fc cc58 371a 02bf 433c 59b1 4f17 9c94
 0000280 ba27 6456 6f92 7f99 6527 b934 cbad eb55

 00001d0 d1c5 3c59 36bc eb6f 9cc4 4ece f60e 509a
 00001e0 de46 9bb7 6e6f fb55 c7e7 9c87 550e 93cb
 00001f0 f266 83fd bdd3 e5c3 f9e9 7349 3212 154c
-0000200 e003 3b57 ab0f 5f87 5b7c eced 59bd 9fec
+0000200 e003 3b57 ab0f 5f87 5b7c eded 59bd 9fec
 0000210 d3c7 479d 78cb 1515 c14f 53bb fede 9aa5
 0000220 b33b e05f 6f92 7967 b27e 68b7 d0cf ce0e
 0000230 67a6 fd68 e4a9 2170 9ed8 7dce 6e96 eada

 0000360 5fc1 93f6 5674 2ccf 883b 0d7f 0929 be94
 0000370 8b1c 2981 ee54 e75e 280b 1e06 4dfd a3c3
 0000380 74bf 38e0 ab2e 5ca8 f6a8 9755 9457 4b19
-0000390 68c4 9c3d 323d a256 961f bfde 6037 5fec
+0000390 68c4 9c3d 323d a256 961f bede 6037 5fec
 00003a0 51fc 8b7f da3d cb2e 087e dcf5 e480 1bad
 00003b0 5b90 2f08 8466 1572 112a 2837 beb4 590a
 00003c0 88cc b2ed 9308 aa8c 4fb5 5718 4586 ff1d

 0000180 8a68 1bac 6c64 2119 eb3d 7a22 88fe 9a7a
 0000190 04b8 e572 ec3b a3c7 8695 3e0c a56d a5e9
 00001a0 2518 d51c a8d9 59fe 4f73 d53e f957 91ef
-00001b0 c04b b398 2a31 c492 d2b1 bf4e 3599 c7cc
+00001b0 c04b b398 2a31 c492 d2b1 be4e 3599 c7cc
 00001c0 3317 0fea b4a0 076d 2c3a 1f94 cd76 4480
 00001d0 b798 091a de10 6f33 6135 4ad4 beb2 a6c9
 00001e0 578c 29ee d463 1bd8 d80b 16d4 273e c593

Sorry I didn't check to see if the - or the + has the 'correct' bits.
The corruption is in different places in the file, different places in
the 2K blocks, but always the same column of the hexdump.

ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
VP_IDE: IDE controller on PCI bus 00 dev 39
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
VP_IDE: VIA vt82c586b (rev 41) IDE UDMA33 controller on pci00:07.1
    ide0: BM-DMA at 0xe400-0xe407, BIOS settings: hda:DMA, hdb:DMA
    ide1: BM-DMA at 0xe408-0xe40f, BIOS settings: hdc:DMA, hdd:DMA
hda: QUANTUM FIREBALLP LM15, ATA DISK drive
hdc: TOSHIBA CD-ROM XM-6602B, ATAPI CD/DVD-ROM drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
ide1 at 0x170-0x177,0x376 on irq 15
SCSI subsystem driver Revision: 1.00
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: TOSHIBA   Model: CD-ROM XM-6602B   Rev: 1917
  Type:   CD-ROM                             ANSI SCSI revision: 02

Errors being reported from the cdrom drive on 2.4.19.
SCSI cdrom error : host 0 channel 0 id 0 lun 0 return code =3D 28000000
Current sd0b:00: sense key Hardware Error
Additional sense indicates Logical unit communication CRC error (Ultra-DMA/=
32)
 I/O error: dev 0b:00, sector 142012
SCSI cdrom error : host 0 channel 0 id 0 lun 0 return code =3D 28000000
Current sd0b:00: sense key Hardware Error
Additional sense indicates Logical unit communication CRC error (Ultra-DMA/=
32)
 I/O error: dev 0b:00, sector 145224

 Model=3DQUANTUM FIREBALLP LM15, FwRev=3DA35.0700, SerialNo=3D183007131435
 Config=3D{ HardSect NotMFM HdSw>15uSec Fixed DTR>10Mbs }
 RawCHS=3D16383/16/63, TrkSize=3D32256, SectSize=3D21298, ECCbytes=3D4
 BuffType=3DDualPortCache, BuffSize=3D1900kB, MaxMultSect=3D16, MultSect=3D=
16
 CurCHS=3D16383/16/63, CurSects=3D16514064, LBA=3Dyes, LBAsects=3D29336832
 IORDY=3Don/off, tPIO=3D{min:120,w/IORDY:120}, tDMA=3D{min:120,rec:120}
 PIO modes: pio0 pio1 pio2 pio3 pio4=20
 DMA modes: mdma0 mdma1 mdma2 udma0 udma1 *udma2 udma3 udma4=20
 AdvancedPM=3Dno WriteCache=3Denabled
 Drive Supports : ATA/ATAPI-5 T13 1321D revision 1 : ATA-1 ATA-2 ATA-3 ATA-=
4 ATA-5=20

I did most of my testing with 2.4.17 since my USB mouse doesn't work
with 2.4.19 but does with 2.4.17.

--=20
David Fries <dfries@mail.win.org>
http://fries.net/~david/pgp.txt

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAj1W0kkACgkQAI852cse6PA7FQCeMmQeS8siba0jxG3mW1ZfxNT2
bcgAn1VcskL00Ev552QcmsBxWf/95/aK
=s8s7
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
