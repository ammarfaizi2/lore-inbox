Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264699AbSLBRvc>; Mon, 2 Dec 2002 12:51:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264705AbSLBRvb>; Mon, 2 Dec 2002 12:51:31 -0500
Received: from viola.sinor.ru ([217.70.106.9]:986 "EHLO viola.sinor.ru")
	by vger.kernel.org with ESMTP id <S264699AbSLBRv3>;
	Mon, 2 Dec 2002 12:51:29 -0500
Date: Mon, 2 Dec 2002 23:50:40 +0600
From: "Andrey R. Urazov" <coola@ngs.ru>
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: a bug in autofs
Message-ID: <20021202175040.GA857@ktulu>
References: <20021201071612.GA936@ktulu> <1038799532.15370.301.camel@ixodes.goop.org> <20021202075725.GC1459@ktulu> <1038818346.3253.17.camel@ixodes.goop.org> <20021202151730.GB885@ktulu> <1038847726.2560.51.camel@ixodes.goop.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline
In-Reply-To: <1038847726.2560.51.camel@ixodes.goop.org>
User-Agent: Mutt/1.4i
X-PGP-public-key: pub 1024D/02B49FF2
X-PGP-fingerprint: A1CE D50E 0CF3 C0EF BA35  CBEC 87D7 4A2B 02B4 9FF2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 02, 2002 at 08:48:47AM -0800, Jeremy Fitzhardinge wrote:
> On Mon, 2002-12-02 at 07:17, Andrey R. Urazov wrote:
> > # $Id: auto.master,v 1.2 1997/10/06 21:52:03 hpa Exp $
> > # Sample auto.master file
> > # Format of this file:
> > # mountpoint map options
> > # For details of the format look at autofs(8).
> > /misc	/etc/auto.misc	--timeout=3D60
>=20
> OK, what's in auto.misc?
>=20
# $Id: auto.misc,v 1.2 1997/10/06 21:52:04 hpa Exp $
# This is an automounter map and it has the following format
# key [ -mount-options-separated-by-comma ] location
# Details may be found in the autofs(5) manpage

#cd		-fstype=3Diso9660,ro,nosuid,nodev	:/dev/cdrom

# the following entries are samples to pique your imagination
#linux		-ro,soft,intr		ftp.example.org:/pub/linux
floppy		-fstype=3Dauto,nosuid,noexec,noshowexec,gid=3D600,umask=3D002,codep=
age=3D866,quiet		:/dev/fd0
mirror		-fstype=3Dext3,defaults,grpid			:/dev/hdb1
mirrorfat 	-fstype=3Dvfat,nosuid,noexec,noshowexec,gid=3D600,umask=3D002,co=
depage=3D866,quiet		:/dev/hdb2
cdrom		-fstype=3Diso9660,nosuid,noexec		:/dev/cdrom
summer		-fstype=3Dntfs,nosuid,gid=3D600,umask=3D007,ro		:/dev/hda1
excg 		-fstype=3Dvfat,nosuid,noexec,noshowexec,gid=3D600,umask=3D002,codepa=
ge=3D866,quiet		:/dev/hda2
extra		-fstype=3Dauto,nosuid,noexec,noshowexec,gid=3D600,umask=3D002,codepa=
ge=3D866,quiet		:/dev/hdd1
#floppy		-fstype=3Dext2		:/dev/fd0
#e2floppy	-fstype=3Dext2		:/dev/fd0
#jaz		-fstype=3Dext2		:/dev/sdc1
#removable	-fstype=3Dext2		:/dev/hdd

/dev/cdrom is a link to /dev/scd0

> > Just tested that the system hangs when the autofs4 module is in use.
> > autofs (without 4) module does not cause any problems.
>=20
> Do you mean you're switching from the autofs4 kernel module with autofs4
> automount, or are you using the autofs4 kernel module with autofs3
> automount?
In both cases I use user level tools version 3.1.7.
>=20
> > What is characteristic is that before the system hangs I get numerous
> > messages reading `invalid seek on drive /dev/hdc' on my virtual
> > console.
>=20
> Can you post the exact messages?  Is there anything from automount in
> /var/log/messages?  Can you post those messages?
I misinformed you again :)
The message is different from those that was in my memory:

hdc: ATAPI reset complete=20
hdc: status error: status=3D0x00 { }
ide-scsi: Strange, packet command initiated yet DRQ isn't asserted

then I get an Oops message. I reproduced the bug twice this time and
I get two different oops messages. At least the call stacks of the two
were different since during second time the call stack was so large that
I didn't see anything else.

Best regards,
  Andrey Urazov
--=20
blithwapping:
	Using anything BUT a hammer to hammer a nail into the
	wall, such as shoes, lamp bases, doorstops, etc.
		-- "Sniglets", Rich Hall & Friends
--
lundi 02 d=E9cembre, 2002, 23:41:55 +0600 - Andrey R. Urazov (mailto:coola@=
ngs.ru)


--0OAP2g/MAC+5xKAE
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE9651vh9dKKwK0n/IRAni8AJsFasvvkNRDbiuqwA0YITaEsfM7XQCgrDKZ
2HkrAfelVXraqBsz5A2iQbM=
=QLdJ
-----END PGP SIGNATURE-----

--0OAP2g/MAC+5xKAE--
