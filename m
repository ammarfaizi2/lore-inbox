Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267892AbTB1OZO>; Fri, 28 Feb 2003 09:25:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267932AbTB1OZO>; Fri, 28 Feb 2003 09:25:14 -0500
Received: from 24-216-225-11.charter.com ([24.216.225.11]:36226 "EHLO
	wally.rdlg.net") by vger.kernel.org with ESMTP id <S267892AbTB1OZI>;
	Fri, 28 Feb 2003 09:25:08 -0500
Date: Fri, 28 Feb 2003 09:35:28 -0500
From: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Slowing down disk access?
Message-ID: <20030228143528.GA2432@rdlg.net>
Mail-Followup-To: Linux-Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable



  I've got a system I need to slow down disk access on it would seem.  The
syerver, a dual 1.5Ghz Athalon has two 3ware IDE controllers, 8 disks
each for a total of sixteen 180 Gig disks.  This system is laid out in
four RAID5 arrays that it shares out via NFS.  kernel 2.4.19-ac4, ext3
file systems.  I've got 7 of these.

  This works great and provides a LOT of cheap disk that we use for
staging backups before cloning off to tape.

  The problem is that when the array's get pounded HARD, such as when
legato is cleaning it's file devices (nsrstage -C) the machine will lock
up and spew errors to my console:

3w-xxxx: scsi1: Command failed: status =3D 0xc7, flags =3D 0x1b, unit #7.
3w-xxxx: scsi1: Command failed: status =3D 0xc7, flags =3D 0x1b, unit #7.
3w-xxxx: scsi1: Command failed: status =3D 0xc7, flags =3D 0x1b, unit #7.
3w-xxxx: scsi1: Command failed: status =3D 0xc7, flags =3D 0x1b, unit #7.
3w-xxxx: scsi1: Command failed: status =3D 0xc7, flags =3D 0x1b, unit #7.
3w-xxxx: scsi1: Command failed: status =3D 0xc7, flags =3D 0x1b, unit #7.
3w-xxxx: scsi1: Command failed: status =3D 0xc7, flags =3D 0x1b, unit #7.
3w-xxxx: scsi1: Command failed: status =3D 0xc7, flags =3D 0x1b, unit #7.
3w-xxxx: scsi1: Command failed: status =3D 0xc7, flags =3D 0x1b, unit #7.
3w-xxxx: scsi1: AEN: WARNING: ATA port timeout: Port #7.            =20
3w-xxxx: scsi1: AEN: WARNING: ATA port timeout: Port #7.
3w-xxxx: scsi1: AEN: WARNING: ATA port timeout: Port #7.
3w-xxxx: scsi1: AEN: WARNING: ATA port timeout: Port #7.
3w-xxxx: scsi1: AEN: WARNING: ATA port timeout: Port #7.
3w-xxxx: scsi1: AEN: WARNING: ATA port timeout: Port #7.
3w-xxxx: scsi1: AEN: WARNING: ATA port timeout: Port #7.
3w-xxxx: scsi1: AEN: WARNING: ATA port timeout: Port #7.

  This requires a hard reboot.  If I use the magic keys and reset it then
it goes down but doesn't come back up properly, usually dieing around
the LILO area, I believe the array or disks are left in an odd state.

  Is there a way to actually slow down the disk access/read/write other
than re-making the filesystems?  On the other systems the chunk size is
at either 32K or 128K.  On this one in particular the chunk size is
1024K which was determined by running a number of tests (bonnie, nfs
reads/writes) and was found to be about the fastest for our money's
worth.  The disk hangups didn't appear until just recently.  If there's
no other choise I can leave the disks as read only until the data rolls
off then remake them in 32 or 64K.

Any other thoughts?
  Robert

 =20

:wq!
---------------------------------------------------------------------------
Robert L. Harris                     | PGP Key ID: E344DA3B
                                         @ x-hkp://pgp.mit.edu=20
DISCLAIMER:
      These are MY OPINIONS ALONE.  I speak for no-one else.

Diagnosis: witzelsucht  =09

IPv6 =3D robert@ipv6.rdlg.net	http://ipv6.rdlg.net
IPv4 =3D robert@mail.rdlg.net	http://www.rdlg.net

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+X3Ov8+1vMONE2jsRAvZNAKDkhPZLzZR8Gbt0I0PUrRC9IH45bwCeLgPX
M39fcOoDP6zIU1Cn24rgzno=
=ckMc
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
