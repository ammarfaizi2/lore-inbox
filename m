Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277777AbRJRQA2>; Thu, 18 Oct 2001 12:00:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277733AbRJRQAT>; Thu, 18 Oct 2001 12:00:19 -0400
Received: from adsl-64-109-204-69.milwaukee.wi.ameritech.net ([64.109.204.69]:29174
	"HELO alphaflight.d6.dnsalias.org") by vger.kernel.org with SMTP
	id <S277730AbRJRQAI>; Thu, 18 Oct 2001 12:00:08 -0400
Date: Thu, 18 Oct 2001 11:00:09 -0500
From: "M. R. Brown" <mrbrown@0xd6.org>
To: Greg Boyce <gboyce@rakis.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Input on the Non-GPL Modules
Message-ID: <20011018110009.K22296@0xd6.org>
In-Reply-To: <Pine.LNX.4.21.0110181113020.9058-100000@wyrm.rakis.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CxDuMX1Cv2n9FQfo"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0110181113020.9058-100000@wyrm.rakis.net>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--CxDuMX1Cv2n9FQfo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Greg Boyce <gboyce@rakis.net> on Thu, Oct 18, 2001:

>=20
> However, with the addition of GPL only symbols, you add motivation for
> conning.  Not by end users, but by the developers of binary only
> modules.  If they export the GPL license symbol, they gain access to
> kernel symbols that they may want to use.  Since no code is actually being
> stolen, would this kind of trick actually cause a licensing violation?
>=20

Yeah, but the GPL requires availability of source, so I don't see how they
could get around that (it would no longer be a closed-source module and mig=
ht
as well be GPL'd).

Hmm, does MODULE_LICENSE() actually state that the module is covered under
the GPL?  If not, could something like this work?

--- module.h.orig	Thu Oct 18 10:56:09 2001
+++ module.h	Thu Oct 18 10:58:43 2001
@@ -286,7 +286,11 @@
 =20
 #define MODULE_LICENSE(license) 	\
 static const char __module_license[] __attribute__((section(".modinfo"))) =
=3D   \
-"license=3D" license
+"license=3D" license; \
+static const char __module_license_blurb[] __attribute__((section(".modinf=
o"))) =3D \
+"license_blurb=3DThis module is covered under the GPL v2 or any later vers=
ion. " \
+"Please see the file COPYING in the toplevel directory of the source archi=
ve " \
+"of this module."
=20
 /* Define the module variable, and usage macros.  */
 extern struct module __this_module;


Of course this can still be circumvented by removing that string from
include/linux/module.h, but you'd still be able to identify renegade
modules, since they perpetrate as GPL'd modules.

M. R.

--CxDuMX1Cv2n9FQfo
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iD8DBQE7zvyJaK6pP/GNw0URAj7KAKCudUmR63wJPGDniSypcEC7bUBOKgCeI2NA
LWXmpVENWTG2P+GUTOyTERk=
=Vm/z
-----END PGP SIGNATURE-----

--CxDuMX1Cv2n9FQfo--
