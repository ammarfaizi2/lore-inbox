Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262419AbUKWKbp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262419AbUKWKbp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 05:31:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262264AbUKWKbp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 05:31:45 -0500
Received: from dea.vocord.ru ([217.67.177.50]:52972 "EHLO vocord.com")
	by vger.kernel.org with ESMTP id S262442AbUKWKbY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 05:31:24 -0500
Subject: Re: drivers/w1/: why is dscore.c not ds9490r.c ?
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Reply-To: johnpol@2ka.mipt.ru
To: Adrian Bunk <bunk@stusta.de>
Cc: sensors@stimpy.netroedge.com, linux-kernel@vger.kernel.org
In-Reply-To: <20041123002028.GN19419@stusta.de>
References: <20041121220251.GE13254@stusta.de>
	 <1101108672.2843.55.camel@uganda> <20041122133344.GA19419@stusta.de>
	 <1101140745.9784.7.camel@uganda> <20041122165145.GH19419@stusta.de>
	 <1101143109.9784.9.camel@uganda> <20041122171956.GI19419@stusta.de>
	 <1101145020.9784.17.camel@uganda>  <20041123002028.GN19419@stusta.de>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-fYROTLFazouhoasHM8BS"
Organization: MIPT
Date: Tue, 23 Nov 2004 13:34:12 +0300
Message-Id: <1101206052.9784.26.camel@uganda>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.4 (vocord.com [192.168.0.1]); Tue, 23 Nov 2004 10:29:58 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fYROTLFazouhoasHM8BS
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2004-11-23 at 01:20 +0100, Adrian Bunk wrote:
> On Mon, Nov 22, 2004 at 08:37:00PM +0300, Evgeniy Polyakov wrote:
> > On Mon, 2004-11-22 at 18:19 +0100, Adrian Bunk wrote:
> > > On Mon, Nov 22, 2004 at 08:05:09PM +0300, Evgeniy Polyakov wrote:
> > > > On Mon, 2004-11-22 at 17:51 +0100, Adrian Bunk wrote:
> > > > > On Mon, Nov 22, 2004 at 07:25:45PM +0300, Evgeniy Polyakov wrote:
> > > > > >=20
> > > > > > > How would a different w1 bus master chip look like in=20
> > > > > > > drivers/w1/Makefile?
> > > > > >=20
> > > > > > obj-m: proprietary_module.o
> > > > > > proprietary_module-objs: dscore.o proprietary_module_init.o
> > > > > >=20
> > > > > > Actually it will live outside the kernel tree, but will require=
 ds2490
> > > > > > driver.
> > > > > > It could be called ds2490.c but I think dscore is better name.
> > > > >=20
> > > > > Why are you talking about proprietary modules living outside the =
kernel=20
> > > > > tree?
> > > > >=20
> > > > > The only interesting case is the one of modules shipped with the =
kernel.
> > > > > And for them, this will break at link time if two such modules ar=
e=20
> > > > > included statically into the kernel.
> > > >=20
> > > > If we _currently_ do not have any open hw/module that depends on ds=
2490
> > > > core then it does not
> > > > mean that tomorrow noone will add it.
> > >=20
> > > Once again:
> > >   _this will break at link time if two such modules are included=20
> > >    statically into the kernel_
> > >=20
> > > obj-$(CONFIG_W1_DS9490)         +=3D ds9490r.o=20
> > > ds9490r-objs    :=3D dscore.o
> > >=20
> > > obj-$(CONFIG_W1_FOO)         +=3D foo.o=20
> > > foo-objs    :=3D dscore.o
> > >=20
> >=20
> > that should be follwing:
> >=20
> > Kconfig:
> > foo depends on ds9490r
> >=20
> > obj-$() +=3D foo.o
> > foo-objs :=3D foo_1.o foo_2.o
> >=20
> > It just happened that ds9490r does not need any other parts but
> > dscore.o.
> > That is why ds9490r.o have only dscore.o in it's dependency.
>=20
> If foo_1 or foo_2 is dscore, you get exactly the compile breakage I=20
> described.

foo_1 and foo_2 will not be dscore, since foo depends on ds9490 and thus
dscore must be already built.
It looks like you were confused by dscore vs. ds9490 names. Probably it
was not a good idea to
call it in a such way, but it was done and it works.

> > > This will break with CONFIG_W1_DS9490=3Dy and CONFIG_W1_FOO=3Dy.
> > >=20
> > >=20
> > > That drivers/w1/ contains many EXPORT_SYMBOL's with no in-kernel user=
s=20
> > > is a different issue I might send a separate patch for (that besides=20
> > > proprietary modules there might come some day open source drivers usi=
ng=20
> > > them is not a reason).
> >=20
> > Why remove existing non disturbing set of exported functions?
> > Are they violate some unknown issues?
>=20
> If an export is currently unused, there's no need to export it.
>=20
> If an export is only used for proprietary modules, that's a reason for=20
> an immediate removal of this export.

Sigh. It can be used by anyone who want to use it.
I will take more carefull look at it later, thank you.

> cu
> Adrian
>=20
--=20

--=-fYROTLFazouhoasHM8BS
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBoxIkIKTPhE+8wY0RAtnIAJ49CNLy1U2YVA/rgstKX/1LtMerhwCfUimw
ZCJz9wS+3c7nYwGnRVfWUT4=
=j+Xf
-----END PGP SIGNATURE-----

--=-fYROTLFazouhoasHM8BS--

