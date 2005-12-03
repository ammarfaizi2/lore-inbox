Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751097AbVLCA6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbVLCA6u (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 19:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbVLCA6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 19:58:50 -0500
Received: from zlynx.org ([199.45.143.209]:19470 "EHLO 199.45.143.209")
	by vger.kernel.org with ESMTP id S1751097AbVLCA6t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 19:58:49 -0500
Subject: Re: Add tainting for proprietary helper modules.
From: Zan Lynx <zlynx@acm.org>
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20051203004102.GA2923@redhat.com>
References: <20051203004102.GA2923@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ZAMTTHfqZ3vN62n4Ewfy"
Date: Fri, 02 Dec 2005 17:58:36 -0700
Message-Id: <1133571516.4950.8.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ZAMTTHfqZ3vN62n4Ewfy
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2005-12-02 at 19:41 -0500, Dave Jones wrote:
> Kernels that have had Windows drivers loaded into them are undebuggable.
> I've wasted a number of hours chasing bugs filed in Fedora bugzilla
> only to find out much later that the user had used such 'helpers',
> and their problems were unreproducable without them loaded.
>=20
> Acked-by: Arjan van de Ven <arjan@infradead.org>
> Signed-off-by: Dave Jones <davej@redhat.com>
>=20
> --- linux-2.6.14/kernel/module.c~	2005-11-29 16:44:00.000000000 -0500
> +++ linux-2.6.14/kernel/module.c	2005-11-29 17:03:55.000000000 -0500
> @@ -1723,6 +1723,11 @@ static struct module *load_module(void _
>  	/* Set up license info based on the info section */
>  	set_license(mod, get_modinfo(sechdrs, infoindex, "license"));
> =20
> +	if (strcmp(mod->name, "ndiswrapper") =3D=3D 0)
> +		add_taint(TAINT_PROPRIETARY_MODULE);
> +	if (strcmp(mod->name, "driverloader") =3D=3D 0)
> +		add_taint(TAINT_PROPRIETARY_MODULE);
> +
>  #ifdef CONFIG_MODULE_UNLOAD
>  	/* Set up MODINFO_ATTR fields */
>  	setup_modinfo(mod, sechdrs, infoindex);

ndiswrapper adds taint already, in load_ndis_driver().
--=20
Zan Lynx <zlynx@acm.org>

--=-ZAMTTHfqZ3vN62n4Ewfy
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQBDkO28G8fHaOLTWwgRAv82AJ4m2PQfwdjx/6/Ymbw7bvV7o2zE/ACfXHt4
VWBm1Gpz9o/iJ0ddZscgFXQ=
=acH8
-----END PGP SIGNATURE-----

--=-ZAMTTHfqZ3vN62n4Ewfy--

