Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263804AbUFRVeO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263804AbUFRVeO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 17:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263802AbUFRVdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 17:33:49 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:15323 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S263850AbUFRVcy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 17:32:54 -0400
Date: Fri, 18 Jun 2004 23:32:52 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Stop printk printing non-printable chars
Message-ID: <20040618213252.GS20632@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20040618205355.GA5286@newtoncomputing.co.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gcG8G892UcBLaolp"
Content-Disposition: inline
In-Reply-To: <20040618205355.GA5286@newtoncomputing.co.uk>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gcG8G892UcBLaolp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-06-18 21:53:55 +0100, matthew-lkml@newtoncomputing.co.uk <matt=
hew-lkml@newtoncomputing.co.uk>
wrote in message <20040618205355.GA5286@newtoncomputing.co.uk>:

> The main problem seems to be in ACPI, but I don't see any reason for

Right.

> printk to even consider printing _any_ non-printable characters at all.

It's dandy if you pump out some data via serial link.

> It makes all characters out of the range 32..126 (except for newline)
> print as a '?'.

I don't see why that's needed. I'd say let's better fix ACPI to put
those strings as a hexdump or something like that.

>  #include <linux/kernel.h>
> @@ -538,7 +540,11 @@
>  			}
>  			log_level_unknown =3D 0;
>  		}
> -		emit_log_char(*p);
> +		if (p[0] !=3D '\n' && (p[0] < 32 || p[0] > 126)) {
> +			emit_log_char('?');
> +		} else {
> +			emit_log_char(*p);
> +		}
>  		if (*p =3D=3D '\n')
>  			log_level_unknown =3D 1;
>  	}

So you're ripping off something that could be a nice feature and place
some slow path. By the way, why do you use 'p[0]' instead of '*p'?

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--gcG8G892UcBLaolp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA01+EHb1edYOZ4bsRAtj+AJwMEEg5i+eu3PdCbAk52j5DIoWfYQCcCWGC
vGlVd+2XhIg5r1nvXLlTd9c=
=jHj9
-----END PGP SIGNATURE-----

--gcG8G892UcBLaolp--
