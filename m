Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278701AbRKMUJg>; Tue, 13 Nov 2001 15:09:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278714AbRKMUJS>; Tue, 13 Nov 2001 15:09:18 -0500
Received: from con-64-133-52-190-ria.sprinthome.com ([64.133.52.190]:29199
	"EHLO ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S278701AbRKMUJA>; Tue, 13 Nov 2001 15:09:00 -0500
Date: Tue, 13 Nov 2001 12:08:55 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Rob Turk <r.turk@chello.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: scsi_scan.c: emulate windows behavior
Message-ID: <20011113120855.A25014@one-eyed-alien.net>
Mail-Followup-To: Rob Turk <r.turk@chello.nl>, linux-kernel@vger.kernel.org
In-Reply-To: <20011113102106.A23110@one-eyed-alien.net> <9srtm6$8hf$1@ncc1701.cistron.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="RnlQjJ0d97Da+TV1"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <9srtm6$8hf$1@ncc1701.cistron.net>; from r.turk@chello.nl on Tue, Nov 13, 2001 at 08:49:09PM +0100
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--RnlQjJ0d97Da+TV1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Rob --

This patch doesn't prevent another application from getting more INQUIRY
bytes.  What it does change is how much data the SCSI scanning loop looks
for.  That data is requested, and then thrown away.  It's not kept around
for anything.

If it were kept, I'd agree with you.  But it's not.  Some useful data is
copied out of the INQUIRY result, and then the buffer is overwritten by the
next probing request.

I can't see any code in the SCSI scanning section that looks beyond the
first 36 bytes.

Also, some devices just die if the INQUIRY is anything but 36-bytes.  Since
all the data beyond the first 36 is considered vendor-specific, I would
expect a driver to _check_ the first 36 bytes to see if this is an
apropriate device, and then (and only then) request more data.

Matt

On Tue, Nov 13, 2001 at 08:49:09PM +0100, Rob Turk wrote:
> "Matthew Dharm" <mdharm-kernel@one-eyed-alien.net> wrote in message
> news:cistron.20011113102106.A23110@one-eyed-alien.net...
>=20
> >Attached is a one-liner patch to scsi_scan.c, which changes the length of
> >the INQUIRY data request from 255 bytes to 36 bytes.  This subtle change
> >makes Linux act more like Win/MacOS and other popular OSes, and reduces
> >incompatibility with a broad range of out-of-spec devices that will simp=
ly
> >die if asked for more than the required minimum of 36 bytes.
>=20
> >Matt
>=20
> Matt,
>=20
> Many devices have useful information in the bytes beyond 36. Media change=
rs from
> various vendors are starting to use byte 55 bit 0 to flag if a barcode sc=
anner
> is present. Other devices have revision levels and/or serial numbers ther=
e.
>=20
> Getting more than 36 bytes should not be a problem for any device. The ro=
ot
> problem seems to be that 255 is an odd number. On Wide-SCSI, a lot of dev=
ices
> have difficulty handling odd byte counts as they have to use additional
> messaging to flag the residue in the last 16-bit transfer. Also, the IDE-=
SCSI
> layer has trouble, as the IDE spec doesn't allow odd byte transfers at al=
l. I've
> experienced issues with IDE devices that had to have their firmware patch=
ed just
> to deal with the Linux odd-byte request. Maybe a better change would be t=
o use
> 64 or 128 byte requests. Your thoughts?
>=20
> Rob

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

It's not that hard.  No matter what the problem is, tell the customer=20
to reinstall Windows.
					-- Nurse
User Friendly, 3/22/1998

--RnlQjJ0d97Da+TV1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE78X3Xz64nssGU+ykRAnbMAJ94J2xxUuPlcgDSNGNi9dx9qmK5KwCgpEMD
hVNmNOLk9pPQs9nPFfT+dL4=
=azL1
-----END PGP SIGNATURE-----

--RnlQjJ0d97Da+TV1--
