Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263540AbUESKpM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263540AbUESKpM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 06:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263585AbUESKpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 06:45:12 -0400
Received: from mx1.actcom.co.il ([192.114.47.13]:60293 "EHLO
	smtp1.actcom.co.il") by vger.kernel.org with ESMTP id S263540AbUESKpD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 06:45:03 -0400
Date: Wed, 19 May 2004 13:43:40 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, rusty@rustcorp.com.au
Subject: Re: [PATCH] Remove bogus WARN_ON in futex_wait
Message-ID: <20040519104339.GG31630@mulix.org>
References: <20040519122350.2792e050.ak@suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DwoPkXS38qd3dnhB"
Content-Disposition: inline
In-Reply-To: <20040519122350.2792e050.ak@suse.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--DwoPkXS38qd3dnhB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 19, 2004 at 12:23:50PM +0200, Andi Kleen wrote:
>=20
> futex_wait goes to an interruptible sleep, but does a WARN_ON later
> if it wakes up early. But waking up early is totally legal, since
> the sleep is interruptible and any signal can wake it up.

That's not what the WARN_ON is saynig, unless I'm missing
something. It's checking if we were woken up early and there's no
signal pending for us.=20

Cheers,=20
Muli=20

> Remove the WARN_ON checking for that.
>=20
> diff -u linux/kernel/Makefile-o linux/kernel/Makefile
> diff -u linux/kernel/futex.c-o linux/kernel/futex.c
> --- linux/kernel/futex.c-o	2004-03-21 21:12:13.000000000 +0100
> +++ linux/kernel/futex.c	2004-05-19 10:01:02.000000000 +0200
> @@ -504,8 +504,6 @@
>  		return 0;
>  	if (time =3D=3D 0)
>  		return -ETIMEDOUT;
> -	/* A spurious wakeup should never happen. */
> -	WARN_ON(!signal_pending(current));
>  	return -EINTR;
> =20
>   out_unqueue:
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/


--DwoPkXS38qd3dnhB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAqzpbKRs727/VN8sRAhzOAJ4yEnrM42Klt/0m1a+VlVg3o907JACfR8DE
UYr3NRjfn4CjhPeMnSiDnlk=
=N5z6
-----END PGP SIGNATURE-----

--DwoPkXS38qd3dnhB--
