Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932330AbVKXUsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932330AbVKXUsx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 15:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932655AbVKXUsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 15:48:53 -0500
Received: from ganesha.gnumonks.org ([213.95.27.120]:24727 "EHLO
	ganesha.gnumonks.org") by vger.kernel.org with ESMTP
	id S932330AbVKXUsw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 15:48:52 -0500
Date: Thu, 24 Nov 2005 21:48:50 +0100
From: Harald Welte <laforge@gnumonks.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] kill_proc_info_as_uid: don't use hardcoded constants
Message-ID: <20051124204850.GC31478@sunbeam.de.gnumonks.org>
References: <43847B85.4B97A782@tv-sign.ru>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GjURNDUNzbeh/2H4"
Content-Disposition: inline
In-Reply-To: <43847B85.4B97A782@tv-sign.ru>
User-Agent: mutt-ng devel-20050619 (Debian)
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--GjURNDUNzbeh/2H4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 23, 2005 at 05:24:05PM +0300, Oleg Nesterov wrote:
> Use symbolic names instead of hardcoded constants.

I'm more than happy with that.  Seems like the original code in
check_kill_permission() was changed in a similar way after I made that
_as_uid() function.

I don't think that I am a person with any say in the signal.c code,but
in case of doubt:

Acked-by: Harald Welte <laforge@gnumonks.org>

> Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>
>=20
> --- 2.6.15-rc2/kernel/signal.c~1_KUID	2005-11-22 19:35:52.000000000 +0300
> +++ 2.6.15-rc2/kernel/signal.c	2005-11-23 19:17:35.000000000 +0300
> @@ -1163,8 +1163,7 @@ int kill_proc_info_as_uid(int sig, struc
>  		ret =3D -ESRCH;
>  		goto out_unlock;
>  	}
> -	if ((!info || ((unsigned long)info !=3D 1 &&
> -			(unsigned long)info !=3D 2 && SI_FROMUSER(info)))
> +	if ((info =3D=3D SEND_SIG_NOINFO || (!is_si_special(info) && SI_FROMUSE=
R(info)))
>  	    && (euid !=3D p->suid) && (euid !=3D p->uid)
>  	    && (uid !=3D p->suid) && (uid !=3D p->uid)) {
>  		ret =3D -EPERM;

--=20
- Harald Welte <laforge@gnumonks.org>          	        http://gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)

--GjURNDUNzbeh/2H4
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDhicyXaXGVTD0i/8RAnByAKCYHwRI/DRTRHqme/zJ6nC5QvMrnQCfakjh
GRqx6zZ0hoRLgZ6n8W0SwG0=
=yYVg
-----END PGP SIGNATURE-----

--GjURNDUNzbeh/2H4--
