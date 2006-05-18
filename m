Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751208AbWERJzx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbWERJzx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 05:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbWERJzw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 05:55:52 -0400
Received: from ozlabs.org ([203.10.76.45]:50323 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1751208AbWERJzw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 05:55:52 -0400
Subject: Re: [RFC/PATCH] Make printk work for really early debugging
From: Michael Ellerman <michael@ellerman.id.au>
Reply-To: michael@ellerman.id.au
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, benh@kernel.crashing.org
In-Reply-To: <20060518023449.4e697b96.akpm@osdl.org>
References: <20060518091410.CC527679F4@ozlabs.org>
	 <20060518023449.4e697b96.akpm@osdl.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-frK3bkT3LIjGRtp7fojy"
Date: Thu, 18 May 2006 19:55:50 +1000
Message-Id: <1147946150.7360.29.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-frK3bkT3LIjGRtp7fojy
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2006-05-18 at 02:34 -0700, Andrew Morton wrote:
> Michael Ellerman <michael@ellerman.id.au> wrote:
> >
> > Currently printk is no use for early debugging because it refuses to ac=
tually
> >  print anything to the console unless cpu_online(smp_processor_id()) is=
 true.
> >=20
> >  The stated explanation is that console drivers may require per-cpu res=
ources,
> >  or otherwise barf, because the system is not yet setup correctly. Fair=
 enough.
> >=20
> >  However some console drivers might be quite happy running early during=
 boot,
> >  in fact we have one, and so it'd be nice if printk understood that.
> >=20
> >  So I add a flag (which I would have called CON_BOOT, but that's taken)=
 called
> >  CON_ANYTIME, which indicates that a console is happy to be called anyt=
ime,
> >  even if the cpu is not yet online.
> >=20
> >  Tested on a Power 5 machine, with both a CON_ANYTIME driver and a bogu=
s
> >  console driver that BUG()s if called while offline. No problems AFAICT=
.
> >  Built for i386 UP & SMP.
>=20
> hm, OK.  But iirc is was just one silly ia64 console driver which had thi=
s
> problem.  It might be better to make the new behaviour be the default and=
 mark
> the ia64 driver CON_NEEDS_CPU_ONLINE or something.
>=20
> No?
>=20
> Or go through and audit the drivers and sprinkle CON_ANYTIME in all the
> safe ones, maybe.

Quite possibly, I started from the assumption that we liked the current
behaviour. Inverting the logic, ie. CON_NEEDS_CPU_ONLINE, would be ok
with me, but it would be a much more intrusive change. All of a sudden
we'll be calling into all sorts of drivers that we didn't previously.

I'll trawl through the console drivers tomorrow and see if I can guess
what percentage look like they will/won't work, then we can decide which
way to flip it.

cheers

--=20
Michael Ellerman
IBM OzLabs

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-frK3bkT3LIjGRtp7fojy
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEbESmdSjSd0sB4dIRAldTAJsG3ZRFdDMaDGti6bDdzj0BIHzGhwCfW1DT
VVXXSR4jyhLgn+Nr6kn111s=
=bTvg
-----END PGP SIGNATURE-----

--=-frK3bkT3LIjGRtp7fojy--

