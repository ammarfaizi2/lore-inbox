Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133044AbRDLCyO>; Wed, 11 Apr 2001 22:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133045AbRDLCyE>; Wed, 11 Apr 2001 22:54:04 -0400
Received: from cc265407-a.hwrd1.md.home.com ([24.3.45.174]:4736 "EHLO
	athens.nanticoke.ellicott-city.md.us") by vger.kernel.org with ESMTP
	id <S133044AbRDLCx5>; Wed, 11 Apr 2001 22:53:57 -0400
Date: Wed, 11 Apr 2001 22:53:57 -0400
From: Tim Meushaw <meushaw@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Problem with 2.4.1/2.4.3 and CD-RW ide-scsi drive
Message-ID: <20010411225356.A574@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="VbJkn9YxBvnuCH5J"
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--VbJkn9YxBvnuCH5J
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi there.  I just got a new CD-RW drive and am trying to get it working
under Linux.  I've got the ide-scsi modules all loaded, but have weird
errors when trying to mount a disk.

Here are the messages from "dmesg" that I get when the ide-cd and
ide-scsi modules are loaded.  My DVD-ROM is /dev/hdc, and the CD-RW is
/dev/hdd (or /dev/sr0):

-----------------------------------------------------
hdc: ATAPI DVD-ROM drive, 512kB Cache, UDMA(33)
Uniform CD-ROM driver Revision: 3.12
ide-cd: ignoring drive hdd
scsi0 : SCSI host adapter emulation for IDE ATAPI devices
  Vendor: SONY      Model: CD-RW  CRX160E    Rev: 1.0e
  Type:   CD-ROM                             ANSI SCSI revision: 02
Detected scsi CD-ROM sr0 at scsi0, channel 0, id 0, lun 0
sr0: scsi3-mmc drive: 32x/32x writer cd/rw xa/form2 cdda tray
-----------------------------------------------------

So, it looks like the drive is attached to /dev/sr0 properly.  Then, I
run "cdrecord -scanbus" to make sure:

-----------------------------------------------------
Cdrecord 1.9 (i686-pc-linux-gnu) Copyright (C) 1995-2000 J=F6rg Schilling
Linux sg driver version: 3.1.17
Using libscg version 'schily-0.1'
scsibus0:
        0,0,0     0) 'SONY    ' 'CD-RW  CRX160E  ' '1.0e' Removable CD-ROM
-----------------------------------------------------

So, it REALLY looks like it's working.  However, here's what I get when
I try to mount an ordinary data CD:

-----------------------------------------------------
athens:~# mount -t iso9660 /dev/sr0 /cdrw
mount: block device /dev/sr0 is write-protected, mounting read-only
SCSI cdrom error : host 0 channel 0 id 0 lun 0 return code =3D 28000000
[valid=3D0] Info fld=3D0x0, Current sd0b:00: sense key Hardware Error
Additional sense indicates Logical unit communication CRC error (Ultra-DMA/=
32)
 I/O error: dev 0b:00, sector 64
isofs_read_super: bread failed, dev=3D0b:00, iso_blknum=3D16, block=3D32
mount: wrong fs type, bad option, bad superblock on /dev/sr0,
       or too many mounted file systems
-----------------------------------------------------

I've tried this with both kernel 2.4.1 and 2.4.3 and have the exact same
error.  I've also tried multiple data CDs and have the same messages.
The CD-RW is a Sony CRX-160E, plugged in to an Asus A7V motherboard (the
PCI bus is described by "lspci" as "VIA Technologies, Inc. VT8363/8365
[KT133/KM133 AGP]").  I'm not sure what other information I can provide,
but I'll be happy to give anything else that might be needed to help fix
this problem.

Thanks a lot!
Tim

--=20
Timothy A. Meushaw
meushaw@pobox.com
http://www.pobox.com/~meushaw/

--VbJkn9YxBvnuCH5J
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE61RjEMVO+gCLjJFkRAunTAJ48iSq5itBzlcP68XWja+Bpe2j7iQCdFMOj
hYfYW8eXvAdJ7sMxyv7Ts9U=
=8Yk8
-----END PGP SIGNATURE-----

--VbJkn9YxBvnuCH5J--
