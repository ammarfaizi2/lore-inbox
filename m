Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279802AbRJ0Ksq>; Sat, 27 Oct 2001 06:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279803AbRJ0Ksh>; Sat, 27 Oct 2001 06:48:37 -0400
Received: from dsl092-013-071.sfo1.dsl.speakeasy.net ([66.92.13.71]:3200 "EHLO
	pelerin.serpentine.com") by vger.kernel.org with ESMTP
	id <S279802AbRJ0KsV>; Sat, 27 Oct 2001 06:48:21 -0400
Subject: VIA KT133 data corruption update
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-Gknx28MR2c8G2GONtaLO"
X-Mailer: Evolution/0.16 (Preview Release)
Date: 27 Oct 2001 03:48:56 -0700
Message-Id: <1004179736.1615.19.camel@pelerin.serpentine.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Gknx28MR2c8G2GONtaLO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

After several months of begrudgingly putting up with my ASUS A7V
motherboard corrupting roughly 1 byte per 100 million read during
moderate to heavy PCI bus activity, I flashed VIA's 1009 BIOS this
evening.

I have not been able to reproduce any corruption since then (it was
ridiculously easy before the new BIOS), and my machine seems otherwise
as stable as I would hope.  This marks the first time since 2.4.6 that
I've been able to run a Linus kernel without cowering.

I also discovered, of necessity, a halfway manageable process for
creating a DOS boot floppy using Windows ME, which Microsoft would
apparently prefer was not possible.  I'll reproduce the steps here,
since otherwise flashing a new BIOS is likely to be nightmarish for
people stuck dual booting into WinME.

Most of these steps occur under Linux, and I'll assume that your Windows
Me "C:" drive is mounted as /dos/c.

- Format a floppy:
  fdformat /dev/fd0H1440

- Create a FAT filesystem:
  mkdosfs /dev/fd0

- Mount the floppy:
  mount /dev/fd0 /mnt

- Copy across a few files:
  cp /dos/c/command.com /mnt
  cp /dos/c/io.sys /mnt
  cp /dos/c/msdos.sys /mnt

- Edit /mnt/msdos.sys, and change values as follows:
  [Paths]
  WinDir=3Da:\
  WinBootDir=3Da:\
  HostWinBootDrv=3Da

  [Options]
  BootMulti=3D0
  BootGUI=3D0
  AutoScan=3D0

- Copy across your BIOS flash utility (probably aflash.exe) and BIOS
  image.  Unmount the floppy (important; don't just reboot):
  umount /mnt/floppy

- When you reboot to the floppy, it will desperately try to boot into
  Windows.  When it prompts you for the path to some Windows VXD, just
  type "a:\command.com", and lo, you've got a DOS prompt.

Cheers,

	<b

--=-Gknx28MR2c8G2GONtaLO
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA72pEYG8PvG6BKogcRAqQSAKC973/O/dbEEQFcOLWQosJqsO+VEgCcCyOV
zxdVvF1mgWttIXcAo/LCrb8=
=VRns
-----END PGP SIGNATURE-----

--=-Gknx28MR2c8G2GONtaLO--
