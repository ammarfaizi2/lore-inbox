Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283234AbRLXWsg>; Mon, 24 Dec 2001 17:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283244AbRLXWs1>; Mon, 24 Dec 2001 17:48:27 -0500
Received: from host25.actarg.com ([209.180.91.25]:20486 "EHLO actarg.com")
	by vger.kernel.org with ESMTP id <S283234AbRLXWsT>;
	Mon, 24 Dec 2001 17:48:19 -0500
Message-ID: <3C27B0B0.4060500@actarg.com>
Date: Mon, 24 Dec 2001 15:48:16 -0700
From: Kyle <kyle@actarg.com>
Organization: Action Target Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6+) Gecko/20011218
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [Fwd: Re: SDDR-31, or possible kernel bug]
Content-Type: multipart/mixed;
 boundary="------------040909060002030605020809"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040909060002030605020809
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

I have a flash card which, when read, locks up linux hard.  Here's the 
particulars so far.  Is there anything I can do to help out kernel bug 
checking before I try to reformat this flash card?


--------------040909060002030605020809
Content-Type: message/rfc822;
 name="Re: SDDR-31, or possible kernel bug"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Re: SDDR-31, or possible kernel bug"

Return-Path: <mdharm@ziggy.one-eyed-alien.net>
Received: from pow.actarg.com (IDENT:root@pow.actarg.com [192.168.2.2])
	by actarg.com (8.9.3/8.9.3) with ESMTP id PAA23828
	for <kyle@tao.actarg.com>; Mon, 24 Dec 2001 15:03:36 -0700
Received: from ziggy.one-eyed-alien.net (IDENT:mdharm@ziggy.one-eyed-alien.net [64.169.228.100])
	by pow.actarg.com (8.11.6/8.11.6) with ESMTP id fBOM3Y419823
	for <kyle@actarg.com>; Mon, 24 Dec 2001 15:03:35 -0700
Received: (from mdharm@localhost)
	by ziggy.one-eyed-alien.net (8.9.3/8.9.3) id OAA11802
	for kyle@actarg.com; Mon, 24 Dec 2001 14:03:33 -0800
Date: Mon, 24 Dec 2001 14:03:33 -0800
From: Matthew Dharm <mdharm-usb@one-eyed-alien.net>
To: Kyle <kyle@actarg.com>
Subject: Re: SDDR-31, or possible kernel bug
Message-ID: <20011224140333.B11771@one-eyed-alien.net>
In-Reply-To: <3C23F6C9.5080802@actarg.com> <20011222005555.A21250@one-eyed-alien.net> <3C275BBF.6090003@actarg.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="EuxKj2iCbKjpUGkD"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C275BBF.6090003@actarg.com>; from kyle@actarg.com on Mon, Dec 24, 2001 at 09:45:51AM -0700
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.


--EuxKj2iCbKjpUGkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I suggest you contact linux-kernel@vger.kernel.org and see what they say.

Matt

On Mon, Dec 24, 2001 at 09:45:51AM -0700, Kyle wrote:
> Matthew Dharm wrote:
>=20
> >Yes, I'm still supporting it.
> >
> >Can you recompile your kernel with USB Mass Storage Verbose debugging
> >turned on?
> >
> Hmmm, I have an interesting new development.  I had previously been doing:
>=20
>     mount -t vfat /dev/sda1 /mnt/flash
>=20
> The device appeared to mount fine, but as soon as I would do:
>=20
>     find /mnt/flash
>=20
> the system will *hard* lock.  I just put the problem flash in a PCMCIA=20
> adapter and stuck it in my laptop.  It is recognized nicely on /dev/hde.=
=20
>  I do:
>=20
>     mount -t vfat /dev/hde1 /mnt/flash
>=20
> which works ok, but when I do:
>=20
>     find /mnt/flash
>=20
> the system hard locks just as before (but without usb being involved at=
=20
> all)...
>=20
> I looked in syslog and found:
>=20
> Dec 24 10:07:08 nb0 kernel:  hde: hde1
> Dec 24 10:07:08 nb0 kernel: FAT: bogus logical sector size 20487
> Dec 24 10:07:08 nb0 kernel: VFS: Can't find a valid FAT filesystem on=20
> dev 21:00.
> Dec 24 10:07:08 nb0 kernel:  hde: hde1
>=20
> I repeated the test and still got the hard lock, but the error messages=
=20
> about the FAT being messed up are not there.  So I looked back in=20
> earlier logs of when I had been trying to mount the usb flash reader and=
=20
> sure enough:  Even though later crashes had yielded no syslog messages,=
=20
> there were earlier ones that did.  Here's a section of syslog:
>=20
> Dec 21 19:29:49 nb0 syslogd 1.4.1: restart.
> Dec 21 19:34:44 nb0 su(pam_unix)[1239]: session opened for user root by=
=20
> kyle(uid=3D1000)
> Dec 21 19:42:46 nb0 apmd[699]: Battery: -0.055762 (0:18) 4294967295=20
> days, 4294967291:4294967244 (100% unknown)
> Dec 21 20:06:37 nb0 modprobe: modprobe: Can't locate module char-major-97
> Dec 21 20:06:37 nb0 last message repeated 3 times
> Dec 21 20:07:02 nb0 modprobe: modprobe: Can't locate module freedos
> Dec 21 20:07:09 nb0 modprobe: modprobe: Can't locate module freefat
> Dec 21 20:07:24 nb0 kernel: Attached scsi removable disk sda at scsi0,=20
> channel 0, id 0, lun 0
> Dec 21 20:07:24 nb0 kernel: usb-uhci.c: interrupt, status 3, frame# 228
> Dec 21 20:07:24 nb0 kernel: usb-uhci.c: interrupt, status 3, frame# 242
> Dec 21 20:07:24 nb0 kernel: usb-uhci.c: interrupt, status 3, frame# 256
> Dec 21 20:07:24 nb0 kernel: sda : READ CAPACITY failed.
> Dec 21 20:07:24 nb0 kernel: sda : status =3D 1, message =3D 00, host =3D =
0,=20
> driver =3D 08
> Dec 21 20:07:24 nb0 kernel: Current sd00:00: sense key Not Ready
> Dec 21 20:07:24 nb0 kernel: Additional sense indicates Medium not present
> Dec 21 20:07:24 nb0 kernel: sda : block size assumed to be 512 bytes,=20
> disk size 1GB.
> Dec 21 20:07:24 nb0 kernel:  sda: I/O error: dev 08:00, sector 0
> Dec 21 20:07:24 nb0 kernel:  unable to read partition table
> Dec 21 20:07:24 nb0 kernel: Device not ready.  Make sure there is a disc=
=20
> in the drive.
> Dec 21 20:07:24 nb0 kernel: usb-uhci.c: interrupt, status 3, frame# 292
> Dec 21 20:07:24 nb0 kernel: usb-uhci.c: interrupt, status 3, frame# 306
> Dec 21 20:07:24 nb0 kernel: usb-uhci.c: interrupt, status 3, frame# 320
> Dec 21 20:07:24 nb0 kernel: sda : READ CAPACITY failed.
> Dec 21 20:07:24 nb0 kernel: sda : status =3D 1, message =3D 00, host =3D =
0,=20
> driver =3D 08
> Dec 21 20:07:24 nb0 kernel: Current sd00:00: sense key Not Ready
> Dec 21 20:07:24 nb0 kernel: Additional sense indicates Medium not present
> Dec 21 20:07:24 nb0 kernel: sda : block size assumed to be 512 bytes,=20
> disk size 1GB.
> Dec 21 20:07:24 nb0 kernel:  sda: I/O error: dev 08:00, sector 0
> Dec 21 20:07:24 nb0 kernel:  unable to read partition table
> Dec 21 20:07:46 nb0 kernel: SCSI device sda: 125185 512-byte hdwr=20
> sectors (64 MB)
> Dec 21 20:07:46 nb0 kernel: sda: Write Protect is off
> Dec 21 20:07:46 nb0 kernel:  sda: sda1
> Dec 21 20:12:21 nb0 syslogd 1.4.1: restart.
>=20
> I don't understand why later attempts don't log to syslog, but it=20
> appears to me that there is data corruption of some kind in this=20
> particular flash card.  Every test that's failed had this card involved=
=20
> and other cards have not (yet) failed.
>=20
> I'm not sure if I should try reformatting the flash card or if we would=
=20
> lose a valuable chance to find a potential kernel problem.  Is the=20
> kernel expected to survive if I mount a corrupt filesystem?
>=20
> I realize this sounds like the problem is not in your driver, but do you=
=20
> have any suggestions?
>=20
> >
> >
> >On Fri, Dec 21, 2001 at 07:58:17PM -0700, Kyle wrote:
> >
> >>    Are you still supporting the usb-storage code?
> >>
> >>I have some of the SDDR-31 flash readers I'm using under Linux.  They=
=20
> >>seem to work most of the time but when I get a flash card with lots of=
=20
> >>pictures on it, I hard lock the machine when I try to browse the newly=
=20
> >>mounted filesystem.
> >>
> >>I'm running redhat 7.2 (2.4.9 stock kernel).
> >>
> >>Any ideas where to start looking?
> >>
> >
>=20
>=20

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

I think the problem is there's a nut loose on your keyboard.
					-- Greg to Customer
User Friendly, 1/5/1999=20

--EuxKj2iCbKjpUGkD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8J6Y1z64nssGU+ykRAjflAJ0cqnVNEQPbDW87vQsR5EHoZw3oXQCgrIW1
ZRDF468ZlUGw7olnIeASFV4=
=agiH
-----END PGP SIGNATURE-----

--EuxKj2iCbKjpUGkD--

--------------040909060002030605020809--

