Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932191AbWEGQYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbWEGQYY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 May 2006 12:24:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932193AbWEGQYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 May 2006 12:24:24 -0400
Received: from master.altlinux.org ([62.118.250.235]:45072 "EHLO
	master.altlinux.org") by vger.kernel.org with ESMTP id S932191AbWEGQYX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 May 2006 12:24:23 -0400
Date: Sun, 7 May 2006 20:24:16 +0400
From: Sergey Vlasov <vsu@altlinux.ru>
To: Michael Buesch <mb@bu3sch.de>
Cc: akpm@osdl.org, Deepak Saxena <dsaxena@plexity.net>,
       bcm43xx-dev@lists.berlios.de, linux-kernel@vger.kernel.org
Subject: Re: [patch 3/6] New Generic HW RNG (#2)
Message-ID: <20060507162416.GD14704@procyon.home>
References: <20060507143806.465264000@pc1> <20060507144257.311084000@pc1> <20060507152206.GC14704@procyon.home> <200605071739.44443.mb@bu3sch.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gE7i1rD7pdK0Ng3j"
Content-Disposition: inline
In-Reply-To: <200605071739.44443.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gE7i1rD7pdK0Ng3j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 07, 2006 at 05:39:44PM +0200, Michael Buesch wrote:
> On Sunday 07 May 2006 17:22, you wrote:
> > On Sun, May 07, 2006 at 04:38:09PM +0200, Michael Buesch wrote:
> > > Add a driver for the x86 RNG.
> > > This driver is ported from the old hw_random.c
> > >=20
> > [skip]
> > > +static int __init intel_init(struct hwrng *rng)
> >=20
> > Cannot be __init anymore - now rng->init could be called at any time.
>=20
> Sure, will fix this.
>=20
> > Also, there is another problem with putting this function into
> > rng->init - if another RNG has been registered when this module is
> > loaded, ->init will not be called during hwrng_register(), so the
> > module load will succeed even if the chipset does not have RNG
> > hardware.
>=20
> Ok, I see. The question is, are we going to hwrng_register() the
> intel, althought there is no device? We check for the PCI IDs.

Most Intel chipset do not really have the hardware RNG - PCI ID
matches, but the check for INTEL_RNG_PRESENT bit in intel_init()
fails.  (In fact, I have not ever seen a board which had that RNG.)

[skip]

> Ah, and I found another bug in hwrng_unregister:
> 	current_rng =3D list_entry(rng_list.prev, struct hwrng, list);
> current_rng->init() should be called here (if nonNULL). If that fails
> current_rng =3D NULL;

All that logic in hwrng_register() and hwrng_unregister() looks overly
complex.  Maybe we should just register the miscdevice
unconditionally, and make it return -ENODEV from open() if no RNG is
registered?

--gE7i1rD7pdK0Ng3j
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQFEXh8wW82GfkQfsqIRAu+rAJ9molAE243PBxepjp0XC9ITIQW1lwCfSj/9
1dZsZXs4iYu/wqUDK9n9+GE=
=RTVQ
-----END PGP SIGNATURE-----

--gE7i1rD7pdK0Ng3j--
