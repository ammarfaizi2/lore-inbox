Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265315AbUEZGJl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265315AbUEZGJl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 02:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265312AbUEZGJl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 02:09:41 -0400
Received: from null.rsn.bth.se ([194.47.142.3]:64207 "EHLO null.rsn.bth.se")
	by vger.kernel.org with ESMTP id S265311AbUEZGJg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 02:09:36 -0400
Subject: Re: [PATCH 3/4] Consolidate sys32 select
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Arnd Bergmann <arnd@arndb.de>
Cc: =?iso-8859-1?Q? David_S=2E_Miller ?= <davem@redhat.com>,
       linux-kernel@vger.kernel.org, ultralinux@vger.kernel.org
In-Reply-To: <26879984$108552555440b3ce3274ba74.46765993@config21.schlund.de>
References: <26879984$108552555440b3ce3274ba74.46765993@config21.schlund.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-O5w4U+wR40VlljcC40Fp"
Message-Id: <1085551771.969.109.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 26 May 2004 08:09:31 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-O5w4U+wR40VlljcC40Fp
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2004-05-26 at 01:10, Arnd Bergmann wrote:
> Martin Josefsson <gandalf@wlug.westbo.se> schrieb am 26.05.2004,
> 00:29:13:
>=20
> > You mean in compat_sys_select() ?
> > compat_ptr() takes an u32 as argument, needs casting, ugly.
> > But you want it done that way?
>=20
> When using compat_ptr properly, you don't need any casts,
> see the patch below (the patch is probably messed up by my=20
> broken mailer, but you get the picture).

Yes,  my brain didn't go the extra distance, davem responded before I
could get to bed and I just had to respond :)

Your patch will fix the problem, I don't even need to test it.
Thanks, looking forward to see a fix in mainline :)

> =3D=3D=3D=3D=3D fs/compat.c 1.24 vs edited =3D=3D=3D=3D=3D
> --- 1.24/fs/compat.c	Sat May 22 06:31:47 2004
> +++ edited/fs/compat.c	Wed May 26 00:57:49 2004
> @@ -1300,13 +1300,15 @@
> =20
>  asmlinkage long
>  compat_sys_select(int n, compat_ulong_t __user *inp, compat_ulong_t
> __user *outp,
> -		compat_ulong_t __user *exp, struct compat_timeval __user *tvp)
> +		compat_ulong_t __user *exp, compat_uptr_t utv)
>  {
>  	fd_set_bits fds;
> +	struct compat_timeval __user *tvp;
>  	char *bits;
>  	long timeout;
>  	int ret, size, max_fdset;
> =20
> +	tvp =3D compat_ptr(utv);
>  	timeout =3D MAX_SCHEDULE_TIMEOUT;
>  	if (tvp) {
>  		time_t sec, usec;
--=20
/Martin

--=-O5w4U+wR40VlljcC40Fp
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAtDSbWm2vlfa207ERAgUBAKCQJe65Ix2fWrvj8HB/adXLkPuYMACfUSwG
T0nbXipob+aBCzSEe5plwzI=
=0RgW
-----END PGP SIGNATURE-----

--=-O5w4U+wR40VlljcC40Fp--
