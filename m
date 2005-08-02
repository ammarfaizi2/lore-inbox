Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261800AbVHBVq0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261800AbVHBVq0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Aug 2005 17:46:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbVHBVq0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Aug 2005 17:46:26 -0400
Received: from lug-owl.de ([195.71.106.12]:47811 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S261800AbVHBVqX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Aug 2005 17:46:23 -0400
Date: Tue, 2 Aug 2005 23:46:22 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] remove support for gcc < 3.2
Message-ID: <20050802214622.GD5787@lug-owl.de>
Mail-Followup-To: Adrian Bunk <bunk@stusta.de>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20050731222606.GL3608@stusta.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Km1U/tdNT/EmXiR1"
Content-Disposition: inline
In-Reply-To: <20050731222606.GL3608@stusta.de>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Km1U/tdNT/EmXiR1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2005-08-01 00:26:07 +0200, Adrian Bunk <bunk@stusta.de> wrote:
> This patch removes support for gcc < 3.2 .
>=20
> The advantages are:
> - reducing the number of supported gcc versions from 8 to 4 [1]
>   allows the removal of several #ifdef's and workarounds
[...]
> [1] support removed: 2.95, 2.96, 3.0, 3.1
>     still supported: 3.2, 3.3, 3.4, 4.0

This patch in mind, I built the vax-linux kernel again with gcc-HEAD
(gcc-4.1) and it blew off in:

$ make V=3D1 ARCH=3Dvax CROSS_COMPILE=3Dvax-linux- mopboot
[...]
  vax-linux-gcc -Wp,-MD,init/.initramfs.o.d  -nostdinc -isystem /home/jbgla=
w/vax-linux/scm/build-20050802-171439-vax-linux/install/usr/lib/gcc/vax-lin=
ux/4.1.0/include -D__KERNEL__ -Iinclude  -Wall -Wstrict-prototypes -Wno-tri=
graphs -fno-strict-aliasing -fno-common -ffreestanding -O1 -fomit-frame-poi=
nter -pipe -Wdeclaration-after-statement -Wno-pointer-sign    -DKBUILD_BASE=
NAME=3Dinitramfs -DKBUILD_MODNAME=3Dinitramfs -c -o init/initramfs.o init/i=
nitramfs.c
init/initramfs.c:10: error: message causes a section type conflict
init/initramfs.c:33: error: head causes a section type conflict
init/initramfs.c:80: error: ino causes a section type conflict
init/initramfs.c:80: error: major causes a section type conflict
[...]

Adding -fno-unit-at-a-time fixed this, but from what Google found, this
is actually a bug in the C sources: the __initdata variables are to be
put into a read-only segment but are missing a const qualifyer, so
-fno-unit-at-a-time seems to hide a bug here.

Could somebody comment on this? Or shall I open a bug report for GCC?

MfG, JBG

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=C3=BCrger" | im Internet! |   im Ira=
k!   O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--Km1U/tdNT/EmXiR1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFC7+muHb1edYOZ4bsRAinQAJ9SQsV4XlYJKVJHcqzl3WvDb42YeACfXWxX
QfLwp6uq8ib6h5ekeDDDeqI=
=iFaT
-----END PGP SIGNATURE-----

--Km1U/tdNT/EmXiR1--
