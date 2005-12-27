Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932299AbVL0MVI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbVL0MVI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 07:21:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932301AbVL0MVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 07:21:08 -0500
Received: from pilet.ens-lyon.fr ([140.77.167.16]:1707 "EHLO pilet.ens-lyon.fr")
	by vger.kernel.org with ESMTP id S932299AbVL0MVG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 07:21:06 -0500
Date: Tue, 27 Dec 2005 13:14:20 +0100
From: Jules Villard <jvillard@ens-lyon.fr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Dave Airlie <airlied@linux.ie>
Subject: Re: Suspend to {mem,disk} broken in 2.6.15-rc6/rc7 on my T42
Message-ID: <20051227121420.GA20926@blatterie>
References: <20051226194527.GA3036@blatterie> <Pine.LNX.4.64.0512261545460.14098@g5.osdl.org> <1135648173.4780.18.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="zhXaljGHf11kAtnf"
Content-Disposition: inline
In-Reply-To: <1135648173.4780.18.camel@localhost.localdomain>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--zhXaljGHf11kAtnf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Le mar, 27 d=E9c 2005 12:49:33 +1100, Benjamin Herrenschmidt a =E9crit :
> Also, while we are at it, can you try this patch on top of current
> -git ? What I _think_ might be happening is that the X server is also
> trying to muck around with the card memory map and is forcing it back
> into a wrong setting that also happens to no longer match what the DRM
> wants to do and blows up. There are bugs all over the place in that code
> (and still some bugs in the DRM as well anyway). This patch attempts to
> avoid that by using the largest of the 2 values, which I think will
> cause it to behave as it used to for you and will still fix the problem
> with machines that have an aperture size smaller than the video memory.
>=20
> That might be good enough until I fully fix X and the DRM (work in progre=
ss
> but there are other "issues").
>=20
> Index: linux-work/drivers/char/drm/radeon_cp.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux-work.orig/drivers/char/drm/radeon_cp.c	2005-12-24 10:07:22.0000=
00000 +1100
> +++ linux-work/drivers/char/drm/radeon_cp.c	2005-12-27 12:48:02.000000000=
 +1100
> @@ -1312,7 +1312,7 @@
>  static int radeon_do_init_cp(drm_device_t * dev, drm_radeon_init_t * ini=
t)
>  {
>  	drm_radeon_private_t *dev_priv =3D dev->dev_private;
> -	unsigned int mem_size;
> +	unsigned int mem_size, aper_size;
> =20
>  	DRM_DEBUG("\n");
> =20
> @@ -1527,7 +1527,9 @@
>  	mem_size =3D RADEON_READ(RADEON_CONFIG_MEMSIZE);
>  	if (mem_size =3D=3D 0)
>  		mem_size =3D 0x800000;
> -	dev_priv->gart_vm_start =3D dev_priv->fb_location + mem_size;
> +	aper_size =3D max(RADEON_READ(RADEON_CONFIG_APER_SIZE), mem_size);
> +
> +	dev_priv->gart_vm_start =3D dev_priv->fb_location + aper_size;
> =20
>  #if __OS_HAS_AGP
>  	if (!dev_priv->is_pci)
>=20

Yes, (2.6.15-rc7-git1 + this patch) fixes it.

--zhXaljGHf11kAtnf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.7 (GNU/Linux)

iD8DBQFDsTAcpBRla5yeL58RAozzAJ9/QrOxW7UnPkDIvn0a96/xfCtNtgCgkuX9
fEf5LvtHZApIp4s7Im7b1Lc=
=jiZz
-----END PGP SIGNATURE-----

--zhXaljGHf11kAtnf--

