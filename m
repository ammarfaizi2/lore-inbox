Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264527AbTLLKuZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 05:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264531AbTLLKuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 05:50:25 -0500
Received: from zeus.eurotux.com ([194.38.142.74]:53977 "HELO zeus.eurotux.com")
	by vger.kernel.org with SMTP id S264527AbTLLKuL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 05:50:11 -0500
Subject: mylex/LSILOGIC's DAC960 trouble
From: Ricardo Manuel Oliveira <rmo@eurotux.com>
To: linux-kernel@vger.kernel.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-nfV5KTEDsVouRgiY5PQL"
Organization: Eurotux  =?ISO-8859-1?Q?=20Inform=C3=A1tica,?= SA
Message-Id: <1071226206.6368.24.camel@linus>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 12 Dec 2003 10:50:06 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-nfV5KTEDsVouRgiY5PQL
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

 I've been having trouble with one of my DAC960's RAID, which was in a
co-located server. It started by working perfectly, and all of the
sudden (within a 15 day period) our server simply died until rebooted.
The log analisys never gave us a clue about what the problem was, until
I got to the datacenter myself, to have a look.

 A couple shift+pageups after, I saw a bunch of lines from the DAC960
driver code telling me the disks were dead (logs below). Strangest
think, the disk enclosure lights did not indicate disk failure (they're
SEAGATE, SCA U160 drives) and after a quick'n'dirty reboot, everything
is back where it should be - and running perfectly.

 The RAID is in our lab now, and it has been running a stress test for
about 7 days. At last, we can see the problem reproduced. Here are some
status reports (some of which are quite strange - the status is still
OK):

zbr:~ # cat /proc/rd/status
OK
zbr:~ # cat /proc/rd/c0/current_status
***** DAC960 RAID Driver Version 2.4.20aa1 of 4 December 2002 *****
Copyright 1998-2001 by Leonard N. Zubkoff <lnz@dandelion.com>
Configuring Mylex AcceleRAID 160 PCI RAID Controller
  Firmware Version: 6.00-11, Channels: 1, Memory Size: 16MB
  PCI Bus: 2, Device: 12, Function: 1, I/O Address: Unassigned
  PCI Address: 0xEF000000 mapped at 0xD4856000, IRQ Channel: 5
  Controller Queue Depth: 512, Maximum Blocks per Command: 2048
  Driver Queue Depth: 511, Scatter/Gather Limit: 128 of 257 Segments
  Physical Devices:
    0:0  Vendor: SEAGATE   Model: ST318406LC        Revision: 0109
         Wide Synchronous at 20 MB/sec
         Serial Number: 3FE0VWHM0000223270XS
         Disk Status: Online, 35807232 blocks
         Errors - Parity: 127, Soft: 0, Hard: 0, Misc: 0
                  Timeouts: 0, Retries: 0, Aborts: 0, Predicted: 0
    0:1  Vendor: SEAGATE   Model: ST318406LC        Revision: 0109
         Wide Synchronous at 160 MB/sec
         Serial Number: 3FE0W65T000022329AXF
         Disk Status: Online, 35807232 blocks
         Errors - Parity: 7, Soft: 0, Hard: 0, Misc: 0
                  Timeouts: 0, Retries: 0, Aborts: 0, Predicted: 0
    0:2  Vendor: SEAGATE   Model: ST318406LC        Revision: 010A
         Wide Synchronous at 160 MB/sec
         Serial Number: 3FE205PF000023078YLA
         Disk Status: Online, 35807232 blocks
         Errors - Parity: 13, Soft: 0, Hard: 0, Misc: 0
                  Timeouts: 0, Retries: 0, Aborts: 0, Predicted: 0
    0:7  Vendor: MYLEX     Model: AcceleRAID 160    Revision: 0600
         Wide Synchronous at 160 MB/sec
         Serial Number:
  Logical Drives:
    /dev/rd/c0d0: RAID-5, Online, 71598080 blocks
                  Logical Device Initialized, BIOS Geometry: 255/63
                  Stripe Size: 64KB, Segment Size: 8KB
                  Read Cache Disabled, Write Cache Disabled
  No Rebuild or Consistency Check in Progress


Logs:


Dec 11 20:30:29 zbr kernel: DAC960#0: Physical Device 0:2 Sense Data
Received
Dec 11 20:30:29 zbr kernel: DAC960#0: Physical Device 0:2 Request Sense:
Sense Key =3D B, ASC =3D 48, ASCQ =3D 00
Dec 11 20:30:29 zbr kernel: DAC960#0: Physical Device 0:2 Request Sense:
Information =3D 00000000 00000000
Dec 11 20:30:30 zbr kernel: DAC960#0: Physical Device 0:1 Sense Data
Received
Dec 11 20:30:30 zbr kernel: DAC960#0: Physical Device 0:1 Request Sense:
Sense Key =3D B, ASC =3D 48, ASCQ =3D 00
Dec 11 20:30:30 zbr kernel: DAC960#0: Physical Device 0:1 Request Sense:
Information =3D 00000000 00000000
Dec 11 20:30:30 zbr kernel: DAC960#0: Physical Device 0:1 Sense Data
Received
Dec 11 20:30:30 zbr kernel: DAC960#0: Physical Device 0:1 Request Sense:
Sense Key =3D B, ASC =3D 48, ASCQ =3D 00
Dec 11 20:30:30 zbr kernel: DAC960#0: Physical Device 0:1 Request Sense:
Information =3D 00000000 00000000
Dec 11 20:30:30 zbr kernel: DAC960#0: Physical Device 0:0 Sense Data
Received
Dec 11 20:30:31 zbr kernel: DAC960#0: Physical Device 0:0 Request Sense:
Sense Key =3D B, ASC =3D 48, ASCQ =3D 00
Dec 11 20:30:31 zbr kernel: DAC960#0: Physical Device 0:0 Request Sense:
Information =3D 00000000 00000000
Dec 11 20:30:31 zbr kernel: DAC960#0: Physical Device 0:2 Sense Data
Received
Dec 11 20:30:32 zbr kernel: DAC960#0: Physical Device 0:2 Request Sense:
Sense Key =3D B, ASC =3D 48, ASCQ =3D 00
....
....
Dec 11 20:31:04 zbr kernel: DAC960#0: Physical Device 0:0 Sense Data
Received
Dec 11 20:31:04 zbr kernel: DAC960#0: Physical Device 0:0 Request Sense:
Sense Key =3D B, ASC =3D 47, ASCQ =3D 00
Dec 11 20:31:04 zbr kernel: DAC960#0: Physical Device 0:0 Request Sense:
Information =3D 00000000 00000000
Dec 11 20:31:04 zbr kernel: DAC960#0: Physical Device 0:0 Errors: Parity
=3D 43, Soft =3D 0, Hard =3D 0, Misc =3D 0
Dec 11 20:31:04 zbr kernel: DAC960#0: Physical Device 0:0 Errors:
Timeouts =3D 0,
Retries =3D 0, Aborts =3D 0, Predicted =3D 0
Dec 11 20:31:04 zbr kernel: DAC960#0: Physical Device 0:0 Sense Data
Received
Dec 11 20:31:04 zbr kernel: DAC960#0: Physical Device 0:0 Request Sense:
Sense Key =3D B, ASC =3D 47, ASCQ =3D 00
.....
.....
Dec 11 20:31:30 zbr kernel: DAC960#0: Physical Device 0:0 Request Sense:
Information =3D 00000000 00000000
Dec 11 20:31:30 zbr kernel: DAC960#0: Physical Device 0:0 Errors: Parity
=3D 127,
Soft =3D 0, Hard =3D 0, Misc =3D 0
Dec 11 20:31:30 zbr kernel: DAC960#0: Physical Device 0:0 Errors:
Timeouts =3D 0,
Retries =3D 0, Aborts =3D 0, Predicted =3D 0


 The disks are still mounted, but a ls simply hangs:

zbr:~ # mount
/dev/hda3 on / type ext2 (rw)
proc on /proc type proc (rw)
devpts on /dev/pts type devpts (rw,mode=3D0620,gid=3D5)
/dev/hda1 on /boot type ext2 (rw)
/dev/hda2 on /home type ext2 (rw)
shmfs on /dev/shm type shm (rw)
none on /proc/bus/usb type usbdevfs (rw)
/dev/rd/c0d0p3 on /mnt/linux type ext3 (rw)
/dev/rd/c0d0p1 on /mnt/linux/boot type ext3 (rw)
/dev/rd/c0d0p5 on /mnt/linux/tmp type ext3 (rw)
/dev/rd/c0d0p6 on /mnt/linux/var type ext3 (rw)
/dev/rd/c0d0p7 on /mnt/linux/servicos type ext3 (rw)
zbr:~ # cd /mnt/linux/
zbr:/mnt/linux # ls
(no output, simply hangs)


 We've checked the cables, the mylex card itself, everything seems to be
in order. I could bet a reasonable amount of money that after a reboot
everything will be just fine.

 Kernels tested:=20
stock 2.4.18
RH's 2.4.20

 Any help is greatly appreciated.

 Thanks in advance,
  Ricardo Oliveira

--=20
Ricardo Manuel Oliveira <rmo:eurotux.com>
Eurotux Inform=E1tica, SA

--=-nfV5KTEDsVouRgiY5PQL
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA/2Z1en3j8Jw0V3ScRAkGTAJ94bIgd4dwGw0ZkvRsWU1C5/b3UPACgktBj
gwMPu7Ft/S02jwJ+8EJ0p8c=
=FHG6
-----END PGP SIGNATURE-----

--=-nfV5KTEDsVouRgiY5PQL--

