Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266999AbSLWXJz>; Mon, 23 Dec 2002 18:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267001AbSLWXJz>; Mon, 23 Dec 2002 18:09:55 -0500
Received: from pacman.mweb.co.za ([196.2.45.77]:64402 "EHLO pacman.mweb.co.za")
	by vger.kernel.org with ESMTP id <S266999AbSLWXJx>;
	Mon, 23 Dec 2002 18:09:53 -0500
Subject: Re: nforce2 and agpgart
From: Bongani Hlope <bonganilinux@mweb.co.za>
To: "Carl D. Blake" <carl@boeckeler.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1040683214.4447.7.camel@vulcan>
References: <1040669417.4563.24.camel@vulcan>
	 <1040678186.2237.4.camel@localhost.localdomain>
	 <1040683214.4447.7.camel@vulcan>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-4+klkP5mqty6VpcScBZG"
Organization: 
Message-Id: <1040685553.2739.30.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1-1mdk 
Date: 24 Dec 2002 01:19:13 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-4+klkP5mqty6VpcScBZG
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2002-12-24 at 00:40, Carl D. Blake wrote:
> On Mon, 2002-12-23 at 14:16, Bongani Hlope wrote:
> > On Mon, 2002-12-23 at 20:50, Carl D. Blake wrote:
> > > I'm having trouble getting agpgart support to work with an nforce2
> > > chipset.  Is this supported on any kernels?  I'm running a Redhat 7.1
> > > system with Redhat's 2.4.9-21 kernel.
> >=20
> > Try to use a newer kernel from Redhat, because that kernel was around
> > looong before nforce was released. IIRC support for nforce2 was added
> > around 2.4.19=20
> >=20
>=20
> I just upgraded to the 2.4.18 kernel provided by Redhat and it didn't
> make any difference.  The message I get in dmesg is:
>=20
> Linux agpgart interface v0.99 (c) Jeff Hartmann
> agpgart: Maximum main memory to use for agp memory: 439M
> agpgart: unsupported bridge
> agpgart: no supported devices found.
>=20
> You suggested trying 2.4.19, so I downloaded kernel 2.4.20 from
> kernel.org and compared its agp code (drivers/char/agp) with the code in
> 2.4.18.  There are a few differences - such as supporting AMD 8151 - but
> nothing that indicates improved support for agpgart on the nforce2
> chipset.  The changelog for 2.4.20 indicated some added support for the
> nforce2 chipset, but that seems to be support for the audio and network
> portions of the chipset, not agp.  I was able to incorporate the audio
> changes manually for kernel 2.4.18 by using Nvidia's patches, but I
> can't get agp to work.
>=20
> Any other suggestions?  Thanks for your help.

Disclaimer at the bottom. ;)

It was once posted on this list that the NForce is similar to some
existing hardware. hence the sound driver uses the Intel i810 audio
driver. I guess if you can search through the archive you might find
that discussion. If you do find it and _are_ clued-up enough, then you
can look at drivers/char/agp/agpgart_be.c approximately line 3900 they
start defining which drivers to use for which bus.

So you need to
1. Find the id for the AGP bus for the NForce and define it in agp.h
(lspci should do the trick IIRC on my PC 00:01.0 is the agp bus)
2. Find out which hardware the bus is similar to, then add the support
for the NForce using the setup for that driver
e.g.

agp.h

add
#ifndef PCI_DEVICE_ID_NVIDIA_NFORCORCE_2   //I'm not sure about the
naming standard
#define PCI_DEVICE_ID_NVIDIA_NFORCORCE_2	0x(Hex value from lspci)
#endif

the in agpgart_be.c

add (for example lets say the bus is similar to Intel's i860 agp bus
then)

#ifdef CONFIG_AGP_INTEL
...

{ PCI_DEVICE_ID_NVIDIA_NFORCORCE_2,
                PCI_VENDOR_ID_NVIDIA,
                INTEL_I860,
                "NVidia",
                "NForce2",
                intel_860_setup },

....
#endif /* CONFIG_AGP_INTEL */

DISCLAIMER : I do not know anything about the agp code, except for what
I have read when trying to find a solution for you. The examples above
are from what my eyes came across at 1:00 am without prio knowledge to
the agp code. So if you implement these examples you do it at you own
(and maybe your pets) risk. The examples come with.... you should now
how the rest goes ;)=20

--=20
For future reference - don't anybody else try to send patches as vi
scripts, please. Yes, it's manly, but let's face it, so is
bungee-jumping with the cord tied to your testicles.

                -- Linus

--=-4+klkP5mqty6VpcScBZG
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQA+B5nwZMVU7+/5Em8RAmcLAKDWLe7gDBd/vFndieNRgYro1P15BwCff471
xdWk9wiVXV6UBpPpq5b4Ek0=
=9n9+
-----END PGP SIGNATURE-----

--=-4+klkP5mqty6VpcScBZG--

