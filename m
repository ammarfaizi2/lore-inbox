Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750907AbVIKVSJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbVIKVSJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Sep 2005 17:18:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750912AbVIKVSJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Sep 2005 17:18:09 -0400
Received: from ciistr2.ist.utl.pt ([193.136.128.2]:39637 "EHLO
	ciistr2.ist.utl.pt") by vger.kernel.org with ESMTP id S1750908AbVIKVSI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Sep 2005 17:18:08 -0400
From: Pedro Venda <pjvenda@arrakis.net.dhis.org>
To: linux-kernel@vger.kernel.org
Subject: Bad I/O performance Highpoint Rocket 1520 SATA controller (kernel 2.6.11.12)
Date: Sun, 11 Sep 2005 22:17:57 +0000
User-Agent: KMail/1.8.2
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2242084.L7o2GuBA3A";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200509112217.57447.pjvenda@arrakis.dhis.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--nextPart2242084.L7o2GuBA3A
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hi,

I've been having bad I/O performance with this SATA controller card
(Highpoint Rocket RAID 1520). Kernel version is 2.6.11.12.

=46irst I used it with 2 samsung 80G P.ATA drives (with adapters) and it=20
was not so good... about 15Mb/s uncached throughput for each disk. Now=20
I've got 2 new Maxtor 200G native SATA drives attached and... the numbers=20
didn't change.

The old samsung drives now attached to a promise Ultra133 TX2 P.ATA=20
controller are quite faster than before and smoke the SATA drives...=20
weird.

What follows are some (modified) snips of dmesg:

hde: SAMSUNG SP0802N, ATA DISK drive
hde: max request size: 1024KiB
hde: 156368016 sectors (80060 MB) w/2048KiB Cache, CHS=3D16383/255/63,
UDMA(100) DISK drive
hdg: [same as hde]

hdi: Maxtor 6B200M0, ATA DISK drive
hdi: max request size: 1024KiB
hdi: 398297088 sectors (203928 MB) w/8192KiB Cache, CHS=3D24792/255/63,
UDMA(33)
hdk: [same as hdi]

PDC20269: IDE controller at PCI slot 0000:00:03.0
     ide2: BM-DMA at 0xb000-0xb007, BIOS settings: hde:pio, hdf:pio
     ide3: BM-DMA at 0xb008-0xb00f, BIOS settings: hdg:pio, hdh:pio
HPT372A: IDE controller at PCI slot 0000:01:02.0
     ide4: BM-DMA at 0x8400-0x8407, BIOS settings: hdi:DMA, hdj:pio
     ide5: BM-DMA at 0x8408-0x840f, BIOS settings: hdk:DMA, hdl:pio

Now, hdparm -tT tests show what I mean (results are median (not average,
the middle value) of 3 successive runs):

/dev/hde:
  Timing cached reads:   728 MB in  2.01 seconds =3D 362.97 MB/sec
  Timing buffered disk reads:  158 MB in  3.02 seconds =3D  52.27 MB/sec
/dev/hdi:
  Timing cached reads:   772 MB in  2.00 seconds =3D 385.67 MB/sec
  Timing buffered disk reads:   42 MB in  3.04 seconds =3D  13.80 MB/sec

One could think: well, your samsung drives got faster (~4x) and your
Maxtor drives are faulty. Not quite. If I re-run the tests plugging the
Maxtors via SATA-P.ATA adapters into the promise card, they score about=20
63Mb/s each for "Timing buffered disk reads" (no snip for that, just=20
believe me).

Is there anyone with an explanation or should I assume the Highpoint
SATA controller card... sucks. What could be a better replacement? Are
Promises SATA150 TX4 any good (on linux, of course)? or maybe SATA300 TX4?

best regards,
pedro venda.
=2D-
Pedro Jo=E3o Lopes Venda
pjvenda < at > arrakis dhis org
http://arrakis.dhis.org

--nextPart2242084.L7o2GuBA3A
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDJK0VeRy7HWZxjWERAq9FAKCQ4iO18KZIHz+u1ahL8UgobEY9IQCfYziY
qDwUiTk3Fofyg01mbYETHmI=
=LiNR
-----END PGP SIGNATURE-----

--nextPart2242084.L7o2GuBA3A--
