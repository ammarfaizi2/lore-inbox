Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263262AbTIAUYQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 16:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263263AbTIAUYQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 16:24:16 -0400
Received: from [165.165.196.206] ([165.165.196.206]:34469 "EHLO nosferatu.lan")
	by vger.kernel.org with ESMTP id S263262AbTIAUYK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 16:24:10 -0400
Subject: Re: 2.6.0-test4-mm3
From: Martin Schlemmer <azarah@gentoo.org>
Reply-To: azarah@gentoo.org
To: Valdis.Kletnieks@vt.edu
Cc: Boszormenyi Zoltan <zboszor@freemail.hu>, Andrew Morton <akpm@osdl.org>,
       KML <linux-kernel@vger.kernel.org>
In-Reply-To: <200308291553.h7TFrcGG009390@turing-police.cc.vt.edu>
References: <3F4F22D3.9080104@freemail.hu>
	 <200308291300.h7TD049n022785@turing-police.cc.vt.edu>
	 <1062168946.19599.114.camel@workshop.saharacpt.lan>
	 <200308291553.h7TFrcGG009390@turing-police.cc.vt.edu>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-13743JrBwJf1hpYurBty"
Message-Id: <1062447809.5275.7.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 01 Sep 2003 22:23:30 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-13743JrBwJf1hpYurBty
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-08-29 at 17:53, Valdis.Kletnieks@vt.edu wrote:
> On Fri, 29 Aug 2003 16:55:47 +0200, Martin Schlemmer said:
>=20
> > Cannot think of one that is known.  An quick solution
> > your (and not RH) side, might be something like below.
>=20
> What about something like this instead?  I tested it with the module-init=
-tools
> and stock RH9 depmods...
>=20
> Only complain if the depmod actually fails:
>=20
> --- Makefile.hold	2003-08-27 01:52:20.000000000 -0400
> +++ Makefile	2003-08-29 11:52:15.542286300 -0400
> @@ -209,7 +209,7 @@
>  RPM 		:=3D $(shell if [ -x "/usr/bin/rpmbuild" ]; then echo rpmbuild; \
>  		    	else echo rpm; fi)
>  GENKSYMS	=3D scripts/genksyms/genksyms
> -DEPMOD		=3D /sbin/depmod
> +DEPMOD		=3D /sbin/depmod.old
>  KALLSYMS	=3D scripts/kallsyms
>  PERL		=3D perl
>  CHECK		=3D sparse
> @@ -612,7 +612,14 @@
>  endif
>  .PHONY: _modinst_post
>  _modinst_post: _modinst_
> -	if [ -r System.map ]; then $(DEPMOD) -ae -F System.map $(depmod_opts) $=
(KERNELRELEASE); fi
> +	@if [ -r System.map ]; then \
> +		if ! $(DEPMOD) -ae -F System.map $(depmod_opts) $(KERNELRELEASE)   ; t=
hen \
> +			echo "*** Depmod failed!!!"; \
> +			echo "*** You may need to install a current version of module-init-to=
ols"; \
> +			echo "*** See http://www.codemonkey.org.uk/post-halloween-2.5.txt"; \
> +			exit 1; \
> +	 	fi \
> +	fi
> =20
>  else # CONFIG_MODULES

Hmm, this will only work with RH based systems (not using here).  I
think the best way is how Andrew did it to just warn if depmod fails.
You may agree to disagree if need be :)


Regards,

--=20

Martin Schlemmer




--=-13743JrBwJf1hpYurBty
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/U6rBqburzKaJYLYRAm9DAJsF2YZNtX4QVYKASXPosn53AD6J3gCeJ7P7
TdhztTDruqJBk7sBzxBkmJA=
=/klt
-----END PGP SIGNATURE-----

--=-13743JrBwJf1hpYurBty--

