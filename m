Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbTISHgG (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 03:36:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbTISHgG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 03:36:06 -0400
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:43502 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP id S261406AbTISHgC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 03:36:02 -0400
Subject: Re: [PATCH 2/13] use cpu_relax() in busy loop
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org, chas@cmf.nrl.navy.mil, torvalds@osdl.org
In-Reply-To: <20030918162748.F16499@osdlab.pdx.osdl.net>
References: <20030918162522.E16499@osdlab.pdx.osdl.net>
	 <20030918162748.F16499@osdlab.pdx.osdl.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-VHMfbDzQNiYtqhTq/Zt/"
Organization: Red Hat, Inc.
Message-Id: <1063956829.5394.1.camel@laptop.fenrus.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-6) 
Date: Fri, 19 Sep 2003 09:33:50 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-VHMfbDzQNiYtqhTq/Zt/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-09-19 at 01:27, Chris Wright wrote:
> [PATCH 2/13] use cpu_relax() in busy loop
>=20
> Replace busy loop nop with cpu_relax().
>=20
> =3D=3D=3D=3D=3D drivers/atm/fore200e.c 1.19 vs edited =3D=3D=3D=3D=3D
> --- 1.19/drivers/atm/fore200e.c	Tue Sep  2 11:07:59 2003
> +++ edited/drivers/atm/fore200e.c	Thu Sep 18 10:42:17 2003
> @@ -248,7 +248,8 @@
>  fore200e_spin(int msecs)
>  {
>      unsigned long timeout =3D jiffies + MSECS(msecs);
> -    while (time_before(jiffies, timeout));
> +    while (time_before(jiffies, timeout))
> +    	cpu_relax();
>  }


ehmmm how about making this use mdelay instead ?
(not to speak of maybe making it sleep, but that's a less obvious
transformation)

--=-VHMfbDzQNiYtqhTq/Zt/
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQA/arFdxULwo51rQBIRAohCAJ9UnL5BvPSz8p6/XEiXXzRY57w6TACgiHV5
v8Ef3ubjg323JH4QQxyuqW8=
=bqtG
-----END PGP SIGNATURE-----

--=-VHMfbDzQNiYtqhTq/Zt/--
