Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283671AbRLEBik>; Tue, 4 Dec 2001 20:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283674AbRLEBia>; Tue, 4 Dec 2001 20:38:30 -0500
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:12296 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S283671AbRLEBiZ>; Tue, 4 Dec 2001 20:38:25 -0500
Date: Tue, 4 Dec 2001 17:38:19 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Jeremy Puhlman <jpuhlman@mvista.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Endianness-aware mkcramfs
Message-ID: <20011204173819.C29968@one-eyed-alien.net>
Mail-Followup-To: Jeremy Puhlman <jpuhlman@mvista.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3C0BD8FD.F9F94BE0@mvista.com> <3C0CB59B.EEA251AB@lightning.ch> <9uj5fb$1fm$1@cesium.transmeta.com> <20011205013630.C717@nightmaster.csn.tu-chemnitz.de> <3C0D6CB6.7000905@zytor.com> <20011204164941.A29968@one-eyed-alien.net> <20011204170235.M25671@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="9Ek0hoCL9XbhcSqy"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011204170235.M25671@mvista.com>; from jpuhlman@mvista.com on Tue, Dec 04, 2001 at 05:02:35PM -0800
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--9Ek0hoCL9XbhcSqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 04, 2001 at 05:02:35PM -0800, Jeremy Puhlman wrote:
> On Tue, Dec 04, 2001 at 04:49:41PM -0800, Matthew Dharm wrote:
> > There is another argument for supporting both endiannesses....
> >=20
> > Consider an embedded system which can be run in either endianness.  Sou=
nds
> > silly?  MIPS processors can run big or little endian, and many people
> > routinely switch between them.
> Yes but typically this also includes a step of reflashing firmware or
> swaping of firmware...So it would not be unrealistic to swap out the
> filesystem as well...

Not necessarily.  Consider a configuration where the kernel comes in over a
network, but each board contains board-specific configuration data in
flash.  Reflashing isn't likely.

And yes, people do that.  I have a day job in the single-board-computer
industry.

> Since in a deployment situation you will always be sticking with one endi=
anness=20
> it makes sense that you would want the most speed for your buck...Since f=
lash=20
> filesystems are slow to begin with also adding in the decompression
> hit you get from cramfs...it would seem to me that adding in le<->be
> would just add to its speed reduction....That would seem to be a good
> place to trim the fat so to speak...

The speed reduction is going to be minimal.  Implement it via macros, like
it's done everywhere else.  If the endianness is one way, the macros get
optimized away.  If it's the other way, then they convert into an inlined
byte swap.

Yes, there can be a small performance hit, but it's absolutely tiny.

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

It was a new hope.
					-- Dust Puppy
User Friendly, 12/25/1998

--9Ek0hoCL9XbhcSqy
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8DXqLz64nssGU+ykRAsXxAKDFHmur8zchKcUbG8czkhZyw8yFQgCbBqhZ
8/t/uFaW3MFqjmmBsC72aPo=
=2ula
-----END PGP SIGNATURE-----

--9Ek0hoCL9XbhcSqy--
