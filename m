Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263163AbVCXNCr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263163AbVCXNCr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 08:02:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263161AbVCXNCq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 08:02:46 -0500
Received: from dea.vocord.ru ([217.67.177.50]:20609 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S263159AbVCXNCU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 08:02:20 -0500
Subject: Re: [PATCH] API for true Random Number Generators to add entropy
	(2.6.11)
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Jeff Garzik <jgarzik@pobox.com>
Cc: David McCullough <davidm@snapgear.com>, cryptoapi@lists.logix.cz,
       linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       Herbert Xu <herbert@gondor.apana.org.au>
In-Reply-To: <4242B712.50004@pobox.com>
References: <20050315133644.GA25903@beast>  <20050324042708.GA2806@beast>
	 <1111665551.23532.90.camel@uganda>  <4242B712.50004@pobox.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-3eAGweWr/GdZnOOn6YrU"
Organization: MIPT
Date: Thu, 24 Mar 2005 16:08:27 +0300
Message-Id: <1111669707.23532.100.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-1) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Thu, 24 Mar 2005 16:01:16 +0300 (MSK)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-3eAGweWr/GdZnOOn6YrU
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2005-03-24 at 07:48 -0500, Jeff Garzik wrote:
> Evgeniy Polyakov wrote:
> > On Thu, 2005-03-24 at 14:27 +1000, David McCullough wrote:
> >=20
> >>Hi all,
> >>
> >>Here is a small patch for 2.6.11 that adds a routine:
> >>
> >>	add_true_randomness(__u32 *buf, int nwords);
> >>
> >>so that true random number generator device drivers can add a entropy
> >>to the system.  Drivers that use this can be found in the latest releas=
e
> >>of ocf-linux,  an asynchronous crypto implementation for linux based on
> >>the *BSD Cryptographic Framework.
> >>
> >>	http://ocf-linux.sourceforge.net/
> >>
> >>Adding this can dramatically improve the performance of /dev/random on
> >>small embedded systems which do not generate much entropy.
> >=20
> >=20
> > People will not apply any kind of such changes.
> > Both OCF and acrypto already handle all RNG cases - no need for any kin=
d
> > of userspace daemon or entropy (re)injection mechanism.
> > Anyone who want to use HW randomness may use OCF/acrypto mechanism.
> > For example here is patch to enable acrypto support for hw_random.c
> > It is very simple and support only upto 4 bytes request, of course it
> > is=20
> > not interested for anyone, but it is only 2-minutes example:
>=20
> If you want to add entropy to the kernel entropy pool from hardware RNG,=20
> you should use the userland daemon, which detects non-random (broken)=20
> hardware and provides throttling, so that RNG data collection does not=20
> consume 100% CPU.
>=20
> If you want to use the hardware RNG directly, it's simple:  just open=20
> /dev/hw_random.
>=20
> Hardware RNG should not go kernel->kernel without adding FIPS tests and=20
> such.

hw_random can not and will not support HIFN, freescale, ixp and=20
great majority of the existing and future HW crypto devices.
I mean that userspace daemon(or any other one) which want to contribute
entropy
should use crypto framwork to obtain all it's data, but not different
access methods for each separate driver.

> 	Jeff

--=20
        Evgeniy Polyakov

Crash is better than data corruption -- Arthur Grabowski

--=-3eAGweWr/GdZnOOn6YrU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBCQrvLIKTPhE+8wY0RAlIzAJ4u2DBKnAmTMThtu5MVr5cngUTVlgCeM/y3
/pjniENLeMzETvXkgZSkF4g=
=u8ZX
-----END PGP SIGNATURE-----

--=-3eAGweWr/GdZnOOn6YrU--

