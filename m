Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266009AbUFOXBJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266009AbUFOXBJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Jun 2004 19:01:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266006AbUFOXBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Jun 2004 19:01:09 -0400
Received: from wblv-235-33.telkomadsl.co.za ([165.165.235.33]:45488 "EHLO
	gateway.lan") by vger.kernel.org with ESMTP id S266009AbUFOXBD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Jun 2004 19:01:03 -0400
Subject: Re: [PATCH 5/5] kbuild: external module build doc
From: Martin Schlemmer <azarah@nosferatu.za.org>
Reply-To: Martin Schlemmer <azarah@nosferatu.za.org>
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Jari Ruusu <jariruusu@users.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing Lists <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20040615195542.GE2310@mars.ravnborg.org>
References: <20040614204029.GA15243@mars.ravnborg.org>
	 <20040614204809.GF15243@mars.ravnborg.org>
	 <40CF4C48.5A317311@users.sourceforge.net>
	 <20040615195542.GE2310@mars.ravnborg.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-KUTdb0UbQntmdqh/VpYU"
Message-Id: <1087340413.9641.9.camel@nosferatu.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 16 Jun 2004 01:00:14 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-KUTdb0UbQntmdqh/VpYU
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-06-15 at 21:55, Sam Ravnborg wrote:

> > Sam, You don't seem to have any idea how much breakage you introduce if=
 you
> > insist on redirecting the 'build' symlink from source tree to object tr=
ee.
>=20
> No - and I still do not see it. Please explain how we can be backward
> compatible when vendors start utilising separate directories for src and =
output.
>=20
> Anyway, after I gave it some extra thoughs I concluded that
> /lib/modules/kernel-<version>/ was the wrong place to keep
> info about where to src for a given build is located.
> This information has to stay in the output directory.
>=20
> So what I will implement is that during the kernel build process
> (not the install part) a symlink named 'source' is placed
> in the root of the output directory - and links to the root of
> the kernel src used for building the kernel.
>=20
> Then /lib/modules/kernel-<version>/build/source will be where
> the source is located.
> And /lib/modules/kernel-<version>/build will point to the output files.
>=20
> If the vendor does not utilise separate src and output directories
> they will point to the same directory.
> If the vendor utilises separate output and source directories
> then thay will point in two different places.
>=20

Please have a look at any package out there (or 99% of them) that need
to figure out where the kernel _source_ is ... they all use something
like:

KERNEL_SRC=3D"/lib/modules/`uname -r`/build"

or

KERNEL_SRC=3D"$(readlink /lib/modules/`uname -r`/build)"

If you now change it to /lib/modules/`uname -r`/build/source, many will
break (depending if they might try things like looking if /usr/src/linux
is around), and all will have to add _another_ kludge to figure things
out.

Its a bad idea IMHO.


Cheers,

--=20
Martin Schlemmer

--=-KUTdb0UbQntmdqh/VpYU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAz399qburzKaJYLYRAlfSAJ454+49FwYWnHiaRreT0bwVz5xCpQCgm/c/
8E0ApbNAaIleY20GqtU1c/I=
=8Xz0
-----END PGP SIGNATURE-----

--=-KUTdb0UbQntmdqh/VpYU--

