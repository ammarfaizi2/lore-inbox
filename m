Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265900AbUHMPGO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265900AbUHMPGO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 11:06:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265909AbUHMPGO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 11:06:14 -0400
Received: from dea.vocord.ru ([194.220.215.4]:53406 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S265900AbUHMPGJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 11:06:09 -0400
Subject: Re: [2.6 patch] let W1 select NET
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Cornelia Huck <kernel@cornelia-huck.de>
Cc: Adrian Bunk <bunk@fs.tum.de>, Roman Zippel <zippel@linux-m68k.org>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20040813155233.04ccac4a@gondolin.boeblingen.de.ibm.com>
References: <20040813101717.GS13377@fs.tum.de>
	 <Pine.LNX.4.58.0408131231480.20635@scrub.home>
	 <20040813105412.GW13377@fs.tum.de>
	 <20040813155233.04ccac4a@gondolin.boeblingen.de.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-q9YKK9qGKowPifrnyRYu"
Organization: MIPT
Message-Id: <1092409800.12729.454.camel@uganda>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 13 Aug 2004 19:10:00 +0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-q9YKK9qGKowPifrnyRYu
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-08-13 at 17:52, Cornelia Huck wrote:
> On Fri, 13 Aug 2004 12:54:12 +0200
> Adrian Bunk <bunk@fs.tum.de> wrote:
>=20
> > It's also relatively safe since NET itself doesn't has any
> > dependencies.
>=20
> Otherwise, this would be problematic. Consider the following:
>=20
> config FOO
>         bool "foo"
>         select BAR
>=20
> config BAR
>         bool
>         depends on BAZ
>=20
> config BAZ
>         bool
>         default n
>=20
> You can select FOO, which will select BAR. In your config, you'll end up =
with
> CONFIG_FOO=3Dy
> CONFIG_BAR=3Dy
> # CONFIG_BAZ is not set
>=20
> (similar result if you don't specify BAZ at all), which would get you int=
o trouble. (I saw this while looking into what happens if s390 uses drivers=
/Kconfig, and got a headache why some stuff was selected by
> allyesconfig that depended on pci).
>=20
> Question: Is this a bug or a feature? If the latter, select should probab=
ly not be used on anything that has dependencies...

It is just not a good example.
In other words - it is bad config dependencies.
You just caught error.
Not very good example with depends:

config A
	depends on B
config B
	depends on C
config C
	depends on A

Just do not create wrong dependencies - although it sounds like "do not
create deadlocks".

> Regards,
> Cornelia
--=20
	Evgeniy Polyakov ( s0mbre )

Crash is better than data corruption. -- Art Grabowski

--=-q9YKK9qGKowPifrnyRYu
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBHNnIIKTPhE+8wY0RAti5AJ9qCbjblVOZVdXA9Z1dRNs+ZnAABQCfb0Ta
8wdUBJOPAxa7cQ0f48XLfzM=
=85rz
-----END PGP SIGNATURE-----

--=-q9YKK9qGKowPifrnyRYu--

