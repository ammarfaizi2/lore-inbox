Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292637AbSBZSRV>; Tue, 26 Feb 2002 13:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292638AbSBZSRP>; Tue, 26 Feb 2002 13:17:15 -0500
Received: from charger.oldcity.dca.net ([207.245.82.76]:17068 "EHLO
	charger.oldcity.dca.net") by vger.kernel.org with ESMTP
	id <S292612AbSBZSPR>; Tue, 26 Feb 2002 13:15:17 -0500
Date: Tue, 26 Feb 2002 13:15:11 -0500
From: christophe =?iso-8859-15?Q?barb=E9?= 
	<christophe.barbe.ml@online.fr>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 3c59x and cardbus
Message-ID: <20020226181510.GF803@ufies.org>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20020226173038.GD803@ufies.org> <3C7BC897.8D607D08@zip.com.au> <20020226175819.GE803@ufies.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oPmsXEqKQNHCSXW7"
Content-Disposition: inline
In-Reply-To: <20020226175819.GE803@ufies.org>
User-Agent: Mutt/1.3.27i
X-Operating-System: debian SID Gnu/Linux 2.4.18 on i586
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--oPmsXEqKQNHCSXW7
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Ok I have found why.
When I resinsert the card, the driver give it a new id (this driver
supports multiple cards) and the option as I set it is only defined for
the card #0. I would expect that the driver give the same id back.

Christophe

On Tue, Feb 26, 2002 at 12:58:19PM -0500, christophe barb=E9 wrote:
> On Tue, Feb 26, 2002 at 09:40:39AM -0800, Andrew Morton wrote:
> > christophe barb=E9 wrote:
> > >=20
> > > When you remove a 3c59x-based cardbus, the fonction vortex_remove_one
> > > is called and this function end with kfree(dev).
> > >=20
> > > I was looking why enable_wol loose its value after a remove/insert cy=
cle
> > > but this value is store in the private part of dev so it's free with
> > > dev.
> > >=20
> > > The driver is not unloaded during the remove/insert cycle so it's a
> > > kernel space problem.
> >=20
> > Yes, all driver state is destroyed when the hardware is removed.
> > Look at it the other way: if this was not done, the driver would
> > have a memory leak.
>=20
> Yes but as I said the driver is not unloaded.
> So when I reinsert the card the kernel himself take care of it (no way
> to give an option) but the result is that the enable_wol is lost.
>=20
> >=20
> > I guess it would be possible to retain some state across insertion
> > cycles, keyed off the MAC address or something.  What's it needed
> > for?
> >=20
> >=20
> > -
>=20
> --=20
> Christophe Barb=E9 <christophe.barbe@ufies.org>
> GnuPG FingerPrint: E0F6 FADF 2A5C F072 6AF8  F67A 8F45 2F1E D72C B41E
>=20
> Cats seem go on the principle that it never does any harm to ask for
> what you want. --Joseph Wood Krutch



--=20
Christophe Barb=E9 <christophe.barbe@ufies.org>
GnuPG FingerPrint: E0F6 FADF 2A5C F072 6AF8  F67A 8F45 2F1E D72C B41E

In a cat's eye, all things belong to cats.
--English proverb

--oPmsXEqKQNHCSXW7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Pour information voir http://www.gnupg.org

iD8DBQE8e9Cuj0UvHtcstB4RAi3BAKCYnBQqJ87FdGrRRh0stqfZufKKdwCeJx0a
SsER7KtGnRYC8SEB8WwF740=
=gsWy
-----END PGP SIGNATURE-----

--oPmsXEqKQNHCSXW7--
