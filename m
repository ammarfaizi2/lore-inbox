Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261343AbVDDTV1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261343AbVDDTV1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 15:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261339AbVDDTV0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 15:21:26 -0400
Received: from multivac.one-eyed-alien.net ([64.169.228.101]:13185 "EHLO
	multivac.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S261343AbVDDTTs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 15:19:48 -0400
Date: Mon, 4 Apr 2005 12:19:42 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: "Richard B. Johnson" <linux-os@analogic.com>
Cc: Kernel Developer List <linux-kernel@vger.kernel.org>
Subject: Re: mmap() and ioctl()
Message-ID: <20050404191942.GB6464@one-eyed-alien.net>
Mail-Followup-To: "Richard B. Johnson" <linux-os@analogic.com>,
	Kernel Developer List <linux-kernel@vger.kernel.org>
References: <20050404182749.GA6464@one-eyed-alien.net> <Pine.LNX.4.61.0504041453440.5597@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oC1+HKm2/end4ao3"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0504041453440.5597@chaos.analogic.com>
User-Agent: Mutt/1.4.1i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2005 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oC1+HKm2/end4ao3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 04, 2005 at 03:02:26PM -0400, Richard B. Johnson wrote:
> On Mon, 4 Apr 2005, Matthew Dharm wrote:
>=20
> >This probably is a silly question, but....
> >
> >Is is possible to open a file, mmap() it into memory, then pass the addr=
ess
> >of that map via an ioctl() call to the kernel, which will copy_from_user=
()
> >that data?
> >
>=20
> Yes. A user-mode pointer, passed via ioctl() is valid in the kernel
> in the context of the user, i.e., during read() write() ioctl().
>=20
> However, it is not valid if it is accessed by some other process or
> an interrupt. In other words, you can't store it somewhere and
> access it later in some other context.

Right, I've got that part.  The plan has been to mmap(), ioctl(), and
inside the ioctl do a copy_from_user() into a kernel-context buffer.

> >Yeah, that's an odd concept, I know... I could always malloc() some
> >memory, read the file in, and then ioctl() it.  But, if I could get away
> >with a direct mmap(), that would be much better for me.
>=20
> Since you need to copy anyway, you could mmap() your kernel
> data (impliment mmap in your driver). Then you mmap both
> "files" the same way and copy to/from in user-mode.

That's an interesting concept, and one I'm not familiar with.  Any useful
pointers (beyond UTSL)?  I'll admit to being much more familiar with SCSI
and USB internals than I am with something like device-layer interfacing.

It sounds like you're saying that my driver can implement an mmap() method
(similar to the ioctl method), and then I can just mmap the source file and
the driver /dev node and do a memcpy() between them.=20

That's an interesting idea, but potentially not what I need.  The data
needs to go with some command information and a buffer to stuff the results
in.  This is basically a co-processor device I'm talking to.  The basic
data path here is from a file, through the driver, to a custom piece of
hardware (and back again).

Tho, anything that allows me to move the data from the disk up to a place
where I can pci_map_single() it faster is a Good Thing(tm).

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

Sir, for the hundreth time, we do NOT carry 600-round boxes of belt-fed=20
suction darts!
					-- Salesperson to Greg
User Friendly, 12/30/1997

--oC1+HKm2/end4ao3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFCUZNOIjReC7bSPZARAmFGAKCXFNBFxkx/aIxiO7I3gZnpA8RzdQCeM/q+
+8IaN90xuVXgPYcBJzTgIu8=
=XOwJ
-----END PGP SIGNATURE-----

--oC1+HKm2/end4ao3--
