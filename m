Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266114AbTFWTbO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 15:31:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266115AbTFWTbO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 15:31:14 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:18195 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S266114AbTFWTbI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 15:31:08 -0400
Date: Mon, 23 Jun 2003 21:45:15 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Testing IDE-TCQ and Taskfile - doesn't work nicely:)
Message-ID: <20030623194514.GW6353@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9aSJXjR17r53A+a+"
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9aSJXjR17r53A+a+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I've played a bit with my "mirror" machine

- 200MHz Pentium-MMX
- 64MB RAM
- jbglaw@mirror:~$ cat /proc/ide/hd*/model
  WDC AC2850F		# System drive
  IC35L040AVER07-0	# \
  IC35L120AVV207-0	#   > Storage (with DM/LVM)
  Maxtor 4W100H6	# /
- jbglaw@mirror:~$ lspci |grep IDE
  00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01)
- Linux v2.5.73
- <*> Intel PIIXn chipsets support

Basically, if I enable Taskfile I/O, the box refuses to boot (basically,
the first drive sounds really broken like "clack   clack   clack" and no
data comes off the drive so there's no partition table, no root FS, but
a panic:) Is anybody interested in nailing this bug down?

Disabling Taskfile lets me boot the box, but hdc doesn't like TCQ and
gives errors:

ide_tcq_intr_timeout: timeout waiting for service interrupt
ide_tcq_intr_timeout: missing isr!
hdc: invalidating tag queue (0 commands)
hdc: drive_cmd: status=3D0x51 { DriveReady SeekComplete Error }
hdc: drive_cmd: error=3D0x04 { DriveStatusError }
[above messages repeat...]

IDE's boot log:

Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=3D=
xx
PIIX4: IDE controller at PCI slot 00:07.1
PIIX4: chipset revision 1
PIIX4: not 100% native mode: will probe irqs later
    ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:pio, hdb:pio
    ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:pio, hdd:pio
hda: WDC AC2850F, ATA DISK drive
hdb: IC35L040AVER07-0, ATA DISK drive
hda: tcq forbidden by blacklist
hdb: only one drive on a channel supported for tcq
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdc: IC35L120AVV207-0, ATA DISK drive
hdd: Maxtor 4W100H6, ATA DISK drive
hdc: tagged command queueing enabled, command queue depth 32
hdd: only one drive on a channel supported for tcq
ide1 at 0x170-0x177,0x376 on irq 15
hda: max request size: 128KiB
hda: task_no_data_intr: status=3D0x51 { DriveReady SeekComplete Error }
hda: task_no_data_intr: error=3D0x04 { DriveStatusError }
hda: 1667232 sectors (854 MB) w/64KiB Cache, CHS=3D1654/16/63, DMA
 hda: hda1 hda2 hda3
hdb: max request size: 128KiB
hdb: host protected area =3D> 1
hdb: 80418240 sectors (41174 MB) w/1916KiB Cache, CHS=3D79780/16/63, UDMA(3=
3)
 hdb: hdb1 hdb2 hdb3 hdb4
hdc: max request size: 1024KiB
hdc: host protected area =3D> 1
hdc: 241254720 sectors (123522 MB) w/1821KiB Cache, CHS=3D15017/255/63, UDM=
A(33)
 hdc: hdc1 < hdc5 hdc6 hdc7 hdc8 hdc9 hdc10 hdc11 hdc12 hdc13 hdc14 hdc15 h=
dc16 hdc17 >
hdd: max request size: 128KiB
hdd: host protected area =3D> 1
hdd: 195711264 sectors (100204 MB) w/2048KiB Cache, CHS=3D194158/16/63, UDM=
A(33)
 hdd: hdd1 < hdd5 hdd6 hdd7 hdd8 hdd9 hdd10 hdd11 hdd12 hdd13 hdd14 >

IDE settings:
mirror:~# lspci -xxx -v -d 8086:7111
00:07.1 IDE interface: Intel Corp. 82371AB/EB/MB PIIX4 IDE (rev 01) (prog-i=
f 80 [Master])
        Flags: bus master, medium devsel, latency 64
        I/O ports at f000 [size=3D16]
00: 86 80 11 71 05 00 80 02 01 80 01 01 00 40 00 00
10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
20: 01 f0 00 00 00 00 00 00 00 00 00 00 00 00 00 00
30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
40: 77 e1 77 e3 bb 00 00 00 0e 00 20 22 00 00 00 00
50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
f0: 00 00 00 00 00 00 00 00 28 0f 00 00 00 00 00 00

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--9aSJXjR17r53A+a+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+91jKHb1edYOZ4bsRAstbAKCR6Fne3zOq/i9Ue59XTsXcIcSrzwCeIacq
O4N4EJzZ6tCUieZwhNFI/hg=
=veKU
-----END PGP SIGNATURE-----

--9aSJXjR17r53A+a+--
