Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262466AbVCXNky@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262466AbVCXNky (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 08:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262465AbVCXNky
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 08:40:54 -0500
Received: from dea.vocord.ru ([217.67.177.50]:27279 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262457AbVCXNk0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 08:40:26 -0500
Subject: Re: [PATCH] API for true Random Number Generators to add entropy
	(2.6.11)
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: David McCullough <davidm@snapgear.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, cryptoapi@lists.logix.cz,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       Herbert Xu <herbert@gondor.apana.org.au>
In-Reply-To: <20050324132342.GD7115@beast>
References: <20050315133644.GA25903@beast> <20050324042708.GA2806@beast>
	 <1111665551.23532.90.camel@uganda> <4242B712.50004@pobox.com>
	 <20050324132342.GD7115@beast>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-CcHHT4Pe1VAxgN4l99YF"
Organization: MIPT
Date: Thu, 24 Mar 2005 16:46:33 +0300
Message-Id: <1111671993.23532.115.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-1) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Thu, 24 Mar 2005 16:39:23 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-CcHHT4Pe1VAxgN4l99YF
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-03-24 at 23:23 +1000, David McCullough wrote:
> Jivin Jeff Garzik lays it down ...
> > Evgeniy Polyakov wrote:
> > >On Thu, 2005-03-24 at 14:27 +1000, David McCullough wrote:
> > >
> > >>Hi all,
> > >>
> > >>Here is a small patch for 2.6.11 that adds a routine:
> > >>
> > >>	add_true_randomness(__u32 *buf, int nwords);
> > >>
> > >>so that true random number generator device drivers can add a entropy
> > >>to the system.  Drivers that use this can be found in the latest rele=
ase
> > >>of ocf-linux,  an asynchronous crypto implementation for linux based =
on
> > >>the *BSD Cryptographic Framework.
> > >>
> > >>	http://ocf-linux.sourceforge.net/
> > >>
> > >>Adding this can dramatically improve the performance of /dev/random o=
n
> > >>small embedded systems which do not generate much entropy.
> > >
> > >
> > >People will not apply any kind of such changes.
> > >Both OCF and acrypto already handle all RNG cases - no need for any ki=
nd
> > >of userspace daemon or entropy (re)injection mechanism.
> > >Anyone who want to use HW randomness may use OCF/acrypto mechanism.
> > >For example here is patch to enable acrypto support for hw_random.c
> > >It is very simple and support only upto 4 bytes request, of course it
> > >is=20
> > >not interested for anyone, but it is only 2-minutes example:
> >=20
> > If you want to add entropy to the kernel entropy pool from hardware RNG=
,=20
> > you should use the userland daemon, which detects non-random (broken)=20
> > hardware and provides throttling, so that RNG data collection does not=20
> > consume 100% CPU.
> >=20
> > If you want to use the hardware RNG directly, it's simple:  just open=20
> > /dev/hw_random.
> >=20
> > Hardware RNG should not go kernel->kernel without adding FIPS tests and=
=20
> > such.
>=20
> For reference,  the RNG on the Safenet I am using this with is
> FIPS140 certified.  I believe the HIFN part  is also but I place the doc =
that
> says so.

At least HIFN 795x is certified.

Idea to validate entropy data is good in general,=20
but it should be implemented in a way allowing external both in-kernel
and userspace
processes to contribute data.
So for in-kernel use we need such a mechanism, and userspace gkernel
daemon
should use it(as the latest "step") too.

Your changes are correct, ioctl(RNDADDENTROPY) could even use it instead
of direct
add_entropy_words()/credit_entropy_store(), but without external entropy
contributors
it will not be applied by maintainers.

> Cheers,
> Davidm
>=20
--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-CcHHT4Pe1VAxgN4l99YF
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCQsS5IKTPhE+8wY0RAvQIAJ9k7AvtYM3NMaXJ56YdZgEIAuxlHACgiNtK
doJpgANgdvvTf4fBejJEHus=
=c2MR
-----END PGP SIGNATURE-----

--=-CcHHT4Pe1VAxgN4l99YF--

