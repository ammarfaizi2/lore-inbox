Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311403AbSCWWmu>; Sat, 23 Mar 2002 17:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311404AbSCWWml>; Sat, 23 Mar 2002 17:42:41 -0500
Received: from charger.oldcity.dca.net ([207.245.82.76]:40110 "EHLO
	charger.oldcity.dca.net") by vger.kernel.org with ESMTP
	id <S311403AbSCWWm3>; Sat, 23 Mar 2002 17:42:29 -0500
Date: Sat, 23 Mar 2002 17:44:33 -0500
From: christophe =?iso-8859-15?Q?barb=E9?= 
	<christophe.barbe.ml@online.fr>
To: Robert Love <rml@tech9.net>
Cc: Andrew Morton <akpm@zip.com.au>,
        christophe =?iso-8859-15?Q?barb=E9?= 
	<christophe.barbe.ml@online.fr>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 3c59x and resume
Message-ID: <20020323224433.GB11471@ufies.org>
Mail-Followup-To: Robert Love <rml@tech9.net>,
	Andrew Morton <akpm@zip.com.au>,
	christophe =?iso-8859-15?Q?barb=E9?= <christophe.barbe.ml@online.fr>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20020323161647.GA11471@ufies.org> <3C9CCBEB.D39465A6@zip.com.au> <1016914030.949.20.camel@phantasy>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4bRzO86E/ozDv8r1"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: debian SID Gnu/Linux 2.4.19-pre4 on i586
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4bRzO86E/ozDv8r1
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

With the 'everything is module' and 'everything is hotplug' approach in
mind (which is a appealing way and IMHO this is the way we are going),
I see two part for this problem:

=2E Persistence after plug out/plug in=20

=2E Persistence after suspend/resume

The first one is a userland problem. The card identification could be
based on the MAC address (for NICs at least, in the case of cardbus the
bus position has no real signification). This should then be the
responsibility of the userspace tool (hotplug) to indicate the correct
option for this card. The problem is when the module is already loaded,
the userspace tool has no way to indicate this option.

The second problem is a kernel problem. It seems not so difficult (as
soon as we have a way to identify each card, which is the case for
NICs) to keep in memory the options for further use.
We don't even need a hash here. We can keep in a fifo table the options
for each removed card and then when a card is inserted lookup with the
MAC address.

Clearly the vector of values for an option to control separately each
card is no more adapted to the today hardware.

As I see it what is missing is a way for hotplug to give some directives
(enable wol for this card) back to the kernel. Today this is possible
(done) for the first card for a given driver (via the module options).

Christophe


On Sat, Mar 23, 2002 at 03:06:49PM -0500, Robert Love wrote:
> On Sat, 2002-03-23 at 13:39, Andrew Morton wrote:
>=20
> > in modules.conf, and we really have eight NICS, and they're
> > being plugged and unplugged, how can we reliably associate
> > that option with the eight cards?  So the right option is
> > applied to each card eash time it's inserted?  Should the
> > option be associated with a card, or with a bus position?
>=20
> Ugh, not pretty.
>=20
> Associate it with the bus position I'd say?
>=20
> If we want a statically allocated array, create one of size N such that
> N is reasonably sane.  Then we can "hash" the bus position onto N ...
> something that basically maps the slot number onto N, slot number % N
> will do.  Dealing with collisions would be easy, but there really
> shouldn't be any in a sane configuration.
>=20
> Ideally we'd have a dynamically created array for the cards and hash
> into that, but, ugh, this is getting gross especially since 99% of us
> have one card and never remove it.
>=20
> 	Robert Love
>=20

--=20
Christophe Barb=E9 <christophe.barbe@ufies.org>
GnuPG FingerPrint: E0F6 FADF 2A5C F072 6AF8  F67A 8F45 2F1E D72C B41E

Cats are rather delicate creatures and they are subject to a good
many ailments, but I never heard of one who suffered from insomnia.
--Joseph Wood Krutch

--4bRzO86E/ozDv8r1
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Pour information voir http://www.gnupg.org

iD8DBQE8nQVRj0UvHtcstB4RAsspAJ933609ej8X/oMTtmmAMm/xQuWA+gCdH2wT
F9bdEBxXKcc6C9F7xXkEzgA=
=uuD6
-----END PGP SIGNATURE-----

--4bRzO86E/ozDv8r1--
