Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286383AbSAAXaL>; Tue, 1 Jan 2002 18:30:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286382AbSAAX34>; Tue, 1 Jan 2002 18:29:56 -0500
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:22533 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S286362AbSAAX3E>; Tue, 1 Jan 2002 18:29:04 -0500
Date: Tue, 1 Jan 2002 15:28:59 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Jens Axboe <axboe@suse.de>
Cc: David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org,
        linux-usb-devel@lists.sourceforge.net, Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] Re: "sr: unaligned transfer" in 2.5.2-pre1
Message-ID: <20020101152859.D14915@one-eyed-alien.net>
Mail-Followup-To: Jens Axboe <axboe@suse.de>,
	David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org,
	linux-usb-devel@lists.sourceforge.net, Greg KH <greg@kroah.com>
In-Reply-To: <m2vgexzv90.fsf@ppro.localdomain> <20011223112249.B4493@kroah.com> <m23d1trr4w.fsf@pengo.localdomain> <20011230122756.L1821@suse.de> <20011230212700.B652@one-eyed-alien.net> <20011231125157.D1246@suse.de> <20011231145455.C6465@one-eyed-alien.net> <065e01c192fd$fe066e20$6800000a@brownell.org> <20020101233423.I16092@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="/3yNEOqWowh/8j+e"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020101233423.I16092@suse.de>; from axboe@suse.de on Tue, Jan 01, 2002 at 11:34:23PM +0100
Organization: One Eyed Alien Networks
X-Copyright: (C) 2002 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--/3yNEOqWowh/8j+e
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 01, 2002 at 11:34:23PM +0100, Jens Axboe wrote:
> On Tue, Jan 01 2002, David Brownell wrote:
> > Not that I've seen a writeup about highmem (linux/Documentation
> > doesn't seem to have one anyway) but if I infer correctly from that
> > DMA-mapping.txt writeup, URBs don't support it because there's no way
> > to specify buffers as a "struct page *" or an array of "struct
> > scatterlist".  That's the only way that document identifies to access
> > "highmem memory".

This sounds like another good reason to have URBs take scatterlists
directly, oddly enough. :)

> > > (1) Do the USB HCDs support highmem?  I seem to recall they do, but
> > > I'm not certain.
> >=20
> > If URBs can't describe highmem, the HCD's won't support them per se;
> > you'd have to turn highmem to "lowmem" or whatever it's called, and
> > then let the HCDs manage the lowmem-to-dma_addr_t mappings.
> >=20
> > Alternatively, in 2.5 we might add "highmem" support to USB.  Now that
> > I've looked at it a few minutes, I suspect we must -- just to support
> > block devices (usb-storage) fully.  Is there more to it than adding
>=20
> No, you can always ask to get pages low mem bounced. Highmem is no
> requirement, and if your device really can't support it there's no point
> in attempting to support it.

I presume there is some overhead in bouncing to lowmem?  I imagine that
highmem support for the HCDs wouldn't be that difficult -- they are just
PCI devices, after all.

I'd rather eliminate as much overhead as possible -- I already get
complaints from performance fanatics about the inability of usb-storage to
get past 92% bus saturation (sustained), and the problem will only get
worse on USB 2.0

> > page+offset as an alternative way to describe the transfer_buffer?
>=20
> no

Hrm... isn't that what one of the patches sent did?  Or does that only work
for lowmem allocations described by the structure?

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

Umm, these aren't the droids you're looking for.
					-- Bill Gates
User Friendly, 11/14/1998

--/3yNEOqWowh/8j+e
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8MkY7z64nssGU+ykRAtMPAKC5/7UQNmU/Oy2c2bTAwD+F6NWKFwCfWWN1
czCySgA3pBrwCUqAW6AoVbs=
=llvO
-----END PGP SIGNATURE-----

--/3yNEOqWowh/8j+e--
