Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261411AbUBVOJm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 09:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261359AbUBVOJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 09:09:41 -0500
Received: from service.sh.cvut.cz ([147.32.127.214]:37588 "EHLO
	service.sh.cvut.cz") by vger.kernel.org with ESMTP id S261351AbUBVOJf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 09:09:35 -0500
Date: Sun, 22 Feb 2004 15:09:29 +0100
From: Pavol Luptak <P.Luptak@sh.cvut.cz>
To: linux-kernel@vger.kernel.org
Cc: linux-raid@vger.kernel.org
Subject: SW RAID5 + cryptoloop problem: data corruption in 2.6.3
Message-ID: <20040222140928.GG29211@psilocybus>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="61jdw2sOBCFtR2d/"
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--61jdw2sOBCFtR2d/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,
I created software RAID5 from 4 disks (two Western Digital 120 GB JB 8MB and
another two Western Digital 120 GB Serial ATA) each on a separate channel=
=20
using standart AMD/nVidia IDE disk driver and SII 3112 serial ATA disk
driver. I use A7N8X Deluxe mainboard and the latest vanilla 2.6.3 kernel.
For the RAID I choosed left-symmetric parity-algoritm and 256 kb chunksize=
=20
(I found this value is optimal for my purposes). I set up crypto loop devic=
e on
my raid device and choosed AES for encryption. On the loop device I created
ext2 filesystem using 'mke2fs -b 4096 -R stride=3D64 /dev/loop0'. I mounted=
 this
device and started to copying about the 250 GB of data from unencrypted IDE
disk to the encrypted RAID (it took a lot of hours with permanent load aver=
age
7.0-8.0).

I got a lot of these messages in the random time interval (for a few minutes
after one or two hours)

Feb 21 13:58:45 psil kernel: init_special_inode: bogus i_mode (54131)
Feb 21 13:58:47 psil kernel: init_special_inode: bogus i_mode (162354)
Feb 21 13:58:47 psil kernel: init_special_inode: bogus i_mode (52412)
Feb 21 15:23:27 psil kernel: init_special_inode: bogus i_mode (54131)
Feb 21 15:23:28 psil kernel: init_special_inode: bogus i_mode (171767)
Feb 21 15:23:29 psil kernel: init_special_inode: bogus i_mode (153374)
Feb 21 15:45:54 psil kernel: init_special_inode: bogus i_mode (165515)
Feb 21 16:45:26 psil kernel: init_special_inode: bogus i_mode (54131)
Feb 21 16:45:27 psil kernel: init_special_inode: bogus i_mode (153374)
Feb 21 22:53:14 psil kernel: init_special_inode: bogus i_mode (54131)
Feb 21 22:53:17 psil kernel: init_special_inode: bogus i_mode (50242)
=2E.

Each message corresponds to the invalid (and unusable) creation of file on =
my
crypto RAID (creation of invalid i-node).

I have no problem with cryptoloop + SW RAID1 (two parallel ATA disks) on
2.6.1/2.6.2.

Can someone explain this behaviour?
I have no idea if this problem is in SII3122 disk driver, RAID5 or cryptolo=
op
driver.

Regards,

Pavol Luptak
--=20
___________________________________________________________________________=
__
[wilder@hq.sk] [http://trip.sk/wilder/] [talker: ttt.sk 5678] [ICQ: 1334035=
56]

--61jdw2sOBCFtR2d/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAOLgYhL+8XxdK5TIRAh+DAKDBSwFOk0ixVr+IsUK1MnpoM5I6hgCeOlgW
yBFVTaJuEcGMPl8HKm9UPZM=
=fdfj
-----END PGP SIGNATURE-----

--61jdw2sOBCFtR2d/--
