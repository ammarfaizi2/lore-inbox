Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262338AbTHUBz7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 21:55:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262358AbTHUBz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 21:55:59 -0400
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:32775 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S262338AbTHUBzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 21:55:55 -0400
Date: Wed, 20 Aug 2003 18:55:50 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.idv.uni.linz.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: usb-storage: how to ruin your hardware(?)
Message-ID: <20030820185550.A24579@one-eyed-alien.net>
Mail-Followup-To: "H.Rosmanith (Kernel Mailing List)" <kernel@wildsau.idv.uni.linz.at>,
	linux-kernel@vger.kernel.org
References: <200308210134.h7L1YmRE011754@wildsau.idv.uni.linz.at>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200308210134.h7L1YmRE011754@wildsau.idv.uni.linz.at>; from kernel@wildsau.idv.uni.linz.at on Thu, Aug 21, 2003 at 03:34:48AM +0200
Organization: One Eyed Alien Networks
X-Copyright: (C) 2003 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

For the vast majority of USB storage devices, it's not possible to kill the
device like you did.

It looks like the device firmware needs certain data on the first sector to
operate.  The usb-storage communication is working just fine, but the
device is refusing commands.

Likely, the unit is unrecoverable unless you can figure out the magic that
the manufacturer uses to write that beginning few sectors of data.

Matt

P.S.  I commonly put ext2/3 filesystems on my CF cards without any
problems.

P.P.S. The 'strange partition table' you saw probably wasn't a partition
table at all -- it was likely the start of a VFAT filesystem.  I'm guessing
that if you had just mounted /dev/sda (notice no partition number!), it
would have worked.

On Thu, Aug 21, 2003 at 03:34:48AM +0200, H.Rosmanith (Kernel Mailing List)=
 wrote:
>=20
> hi,
>=20
> just today, I bought an "USB BAR", a 128MB flash disk. I managed to make
> the device unusable and only get scsi-errors from it.
>=20
> what I did:
> the flask disk came with a strange partition table, and fdisk told about
> partition not ending on boundaries. so I just deleted the partitions and
> put a new one it, spanning the whole flask disk. then I mke2fs /dev/sda1
> it, which seemed fine. as next step I wanted to install lilo on the
> flask disk, because some boards can boot from USB and I wanted a
> bootable linux on the "USB BAR".
>=20
> now lilo complained about that it would write into the partition table?
> why that?! quite strange!
>=20
> this puzzled me - after all, the device should behave like
> a standard scsi-device. so I just played around with /dev/sda, copying
> the first 512 byte from /dev/hda to it and installed lilo then. then I
> deleted everything again, copied /dev/zero (512 byte) to /dev/sda,
> repartitioned, re-mke2fsd etc. etc...
>=20
> and now all I ever see from the device are scsi-errors, like these:
>=20
>     : Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00
>     :                0x00 0x00 0x11 0x00 0x00 0x00 0x00 0x00
>     : I/O error: dev 08:00, sector 0
>=20
> no matter what I try. I cant even clear this sector by dd if=3D/dev/zero
> of=3D/dev/sda bs=3D512 count=3D1. I even booted the laptop of my collegue,
> who has winXP on it, and tried to "format f:" (f: is usb removeable devic=
e),
> but winXP quits with "error in IOCTL".
>=20
> kernel version is 2.4.21.
>=20
> root@themroc:/proc/scsi# cat /scsi=20
> Attached devices:=20
> Host: scsi0 Channel: 00 Id: 00 Lun: 00
>   Vendor: Prolific Model: UsbFlashDisk     Rev: PROL
>   Type:   Direct-Access                    ANSI SCSI revision: 02
> root@themroc:/proc/scsi# cat usb-storage-0/0=20
>    Host scsi0: usb-storage
>        Vendor: Prolific Technology Inc.
>       Product: USB_Storage
> Serial Number: None
>      Protocol: 8070i
>     Transport: Bulk
>          GUID: 067b25170000000000000000
>      Attached: Yes
>=20
> root@themroc:/proc/scsi# dmesg
> usb-storage: act_altsettting is 0
> usb-storage: id_index calculated to be: 94
> usb-storage: Array length appears to be: 97
> usb-storage: USB Mass Storage device detected
> usb-storage: Endpoints: In: 0xcdb29b94 Out: 0xcdb29b80 Int: 0x00000000 (P=
eriod 0)
> usb-storage: Found existing GUID 067b25170000000000000000
> WARNING: USB Mass Storage data integrity not assured
> USB Mass Storage device found at 3
>=20
> now, say I make "dd if=3D/dev/zero of=3D/dev/sda bs=3D512 count=3D1", thi=
s will
> produce:
>=20
> root@themroc:/proc/scsi# dd if=3D/dev/zero of=3D/dev/sda bs=3D512 count=
=3D1
> dd: writing `/dev/sda': Input/output error
> 1+0 records in
> 0+0 records out
> root@themroc:/proc/scsi# dmesg
> ....
> usb-storage: Bulk status Sig 0x53425355 T 0x26 R 1024 Stat 0x1
> usb-storage: -- transport indicates command failure
> usb-storage: Issuing auto-REQUEST_SENSE
> usb-storage: Bulk command S 0x43425355 T 0x27 Trg 0 LUN 0 L 18 F 128 CL 12
> usb-storage: Bulk command transfer result=3D0
> usb-storage: usb_stor_transfer_partial(): xfer 18 bytes
> usb-storage: usb_stor_bulk_msg() returned 0 xferred 18/18
> usb-storage: usb_stor_transfer_partial(): transfer complete
> usb-storage: Bulk data transfer result 0x0
> usb-storage: Attempting to get CSW...
> usb-storage: Bulk status result =3D 0
> usb-storage: Bulk status Sig 0x53425355 T 0x27 R 0 Stat 0x0
> usb-storage: -- Result from auto-sense is 0
> usb-storage: -- code: 0x70, key: 0x3, ASC: 0x11, ASCQ: 0x0
> usb-storage: Medium Error: (unknown ASC/ASCQ)
> usb-storage: scsi cmd done, result=3D0x2
> usb-storage: *** thread sleeping.
> scsi0: ERROR on channel 0, id 0, lun 0, CDB: 0x28 00 00 00 00 00 00 00 02=
 00=20
> Current sd08:00: sns =3D 70  3
> ASC=3D11 ASCQ=3D 0
> Raw sense data:0x70 0x00 0x03 0x00 0x00 0x00 0x00 0x0a 0x00 0x00 0x00 0x0=
0 0x11=20
> 0x00 0x00 0x00 0x00 0x00=20
>  I/O error: dev 08:00, sector 0
>=20
>=20
>=20
> oops, a Medium Error :-(
>=20
> so it's possible to ruin your "USB BAR" flash disk by simply dumping some
> random data to /dev/sda, sector 0? not good... I've heard so that e.g.
> mke2fs on a compat flash will kill the compact flash, but I've always
> been wondering if this is true. now I have the proof ...
>=20
> is there any way to recover the medium?
>=20
> thanks in advance,
> h.rosmanith
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

It was a new hope.
					-- Dust Puppy
User Friendly, 12/25/1998

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE/RCamIjReC7bSPZARAklyAJ98SUNyalm2l+/w/zacFoaogyN11ACgk+Rm
wVy08BSVtOED4a+Fc78vKjo=
=hH9+
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
