Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312570AbSCYU6n>; Mon, 25 Mar 2002 15:58:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312573AbSCYU6e>; Mon, 25 Mar 2002 15:58:34 -0500
Received: from charger.oldcity.dca.net ([207.245.82.76]:5542 "EHLO
	charger.oldcity.dca.net") by vger.kernel.org with ESMTP
	id <S312570AbSCYU6O>; Mon, 25 Mar 2002 15:58:14 -0500
Date: Mon, 25 Mar 2002 15:58:07 -0500
From: christophe =?iso-8859-15?Q?barb=E9?= 
	<christophe.barbe.ml@online.fr>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 3c59x and resume
Message-ID: <20020325205807.GK1853@ufies.org>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20020323161647.GA11471@ufies.org> <3C9CCBEB.D39465A6@zip.com.au> <1016914030.949.20.camel@phantasy> <20020323224433.GB11471@ufies.org> <20020324080729.GD16785@kroah.com> <20020324142545.GC20703@ufies.org> <20020325180133.GB28629@kroah.com> <20020325181956.GE1853@ufies.org> <20020325191127.GC29011@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YZQs1kEQY307C4ut"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: debian SID Gnu/Linux 2.4.19-pre4 on i586
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--YZQs1kEQY307C4ut
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2002 at 11:11:27AM -0800, Greg KH wrote:
> > Could you point me to a specific usb driver ?
>=20
> In the drivers/usb directory, the following are network drivers:
> 	CDCEther.c
> 	catc.c
> 	kaweth.c
> 	pegasus.c
> 	usbnet.c

$ grep MODULE_PARM CDCEther.c catc.c kaweth.c pegasus.c usbnet.c
CDCEther.c:MODULE_PARM (multicast_filter_limit, "i");
CDCEther.c:MODULE_PARM_DESC (multicast_filter_limit, "CDCEther maximum numb=
er of filtered multicast addresses");
pegasus.c:MODULE_PARM(loopback, "i");
pegasus.c:MODULE_PARM(mii_mode, "i");
pegasus.c:MODULE_PARM_DESC(loopback, "Enable MAC loopback mode (bit 0)");
pegasus.c:MODULE_PARM_DESC(mii_mode, "Enable HomePNA mode (bit 0),default=
=3DMII mode =3D 0");

Note that this is exactly what I think.
Each option is defined with a unique value used for all devices.

/usr/src/linux/drivers/usb$ grep MODULE_PARM ../net/3c59x.c                =
    =20
MODULE_PARM(debug, "i");
=2E..
MODULE_PARM(enable_wol, "1-" __MODULE_STRING(8) "i");
MODULE_PARM(rx_copybreak, "i");
=2E..

In a sense the vortex is more flexible. Most options are defined by a
single value but for a few you can pass a vector.=20
NOTE that the 8 limit is only in the MODULE_PARM lines.

But this flexibility is no more adapted.=20

$ man nameif
=2E..
DESCRIPTION
       nameif  renames network interfaces based on mac addresses.
       When no arguments are given /etc/mactab is read. Each line

nameif solved a problem but not during the device activation (this is
the difference between rename and name). Would not it be possible to add
to hotplug a way to give back some advices to the kernel.

kernel -> hotplug : I am going to insert this device.
hotplug -> kernel : ok but use this options optionA,optionB,...

You can then still use nameif during the register phase or eventually
pass a directive earlier to avoid possible races.

Christophe

--=20
Christophe Barb=E9 <christophe.barbe@ufies.org>
GnuPG FingerPrint: E0F6 FADF 2A5C F072 6AF8  F67A 8F45 2F1E D72C B41E

L'experience, c'est une connerie par jour mais jamais la m=EAme.

--YZQs1kEQY307C4ut
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Pour information voir http://www.gnupg.org

iD8DBQE8n49fj0UvHtcstB4RAoXxAJ9PU4EX037fz2Jxno6crofsXgWhvgCeLKxh
NMpVN9OhKfZoySsQT5tngaA=
=chZc
-----END PGP SIGNATURE-----

--YZQs1kEQY307C4ut--
