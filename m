Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290592AbSB0Alv>; Tue, 26 Feb 2002 19:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290593AbSB0Ald>; Tue, 26 Feb 2002 19:41:33 -0500
Received: from charger.oldcity.dca.net ([207.245.82.76]:3223 "EHLO
	charger.oldcity.dca.net") by vger.kernel.org with ESMTP
	id <S287045AbSB0AlU>; Tue, 26 Feb 2002 19:41:20 -0500
Date: Tue, 26 Feb 2002 19:41:13 -0500
From: christophe =?iso-8859-15?Q?barb=E9?= 
	<christophe.barbe.ml@online.fr>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 3c59x and cardbus
Message-ID: <20020227004113.GN803@ufies.org>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.30.0202270126570.28095-100000@balu> <Pine.LNX.4.21.0202261932330.14013-100000@ns>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SqfawxHnX56H7Ukl"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0202261932330.14013-100000@ns>
User-Agent: Mutt/1.3.27i
X-Operating-System: debian SID Gnu/Linux 2.4.18 on i586
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SqfawxHnX56H7Ukl
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 26, 2002 at 07:32:59PM -0500, nick@snowman.net wrote:
> I've gotten this exact same error on various 3c905x cards.  What it
> usually means for me is IRQ problems of some type.
> 	Nick
>=20

This is a timeout for a tx packet.
Each time you have a problem with a network card, you will see a tx
timeout. This is a result not a cause.
So I guess that you have NOT the same problem expecially if it's IRD
related.

Christophe

> On Wed, 27 Feb 2002, Pozsar Balazs wrote:
>=20
> >=20
> > I get very similar error if I remove the module and then reload it (rmm=
od
> > followed by a modprobe). So once I rmmod it, It will never be usable ag=
ain
> > until i reboot.
> >=20
> > I have to pci 3com 905's, I can send the pci id's if those matters
> > tomorrow.
> >=20
> >=20
> > On Tue, 26 Feb 2002, christophe [iso-8859-15] barb=E9 wrote:
> >=20
> > > Now that the forget_option bug is solved I have the following :
> > >
> > > Each time I suspend, the card resume in a bad state but return in a g=
ood
> > > state after that :
> > >
> > > NETDEV WATCHDOG: eth0: transmit timed out
> > > eth0: transmit timed out, tx_status 00 status e000.
> > >   diagnostics: net 0ee0 media 8800 dma 000000a0.
> > >   Flags; bus-master 1, dirty 20(4) current 36(4)
> > >   Transmit list 00af8300 vs. c0af8300.
> > >   0: @c0af8200  length 80000062 status 00000062
> > >   1: @c0af8240  length 80000062 status 00000062
> > >   2: @c0af8280  length 80000062 status 80000062
> > >   3: @c0af82c0  length 80000062 status 80000062
> > >   4: @c0af8300  length 80000062 status 00000062
> > >   5: @c0af8340  length 8000003c status 0000003c
> > >   6: @c0af8380  length 80000062 status 00000062
> > >   7: @c0af83c0  length 80000062 status 00000062
> > >   8: @c0af8400  length 8000003c status 0000003c
> > >   9: @c0af8440  length 80000062 status 00000062
> > >   10: @c0af8480  length 80000062 status 00000062
> > >   11: @c0af84c0  length 80000036 status 00000036
> > >   12: @c0af8500  length 80000062 status 00000062
> > >   13: @c0af8540  length 80000062 status 00000062
> > >   14: @c0af8580  length 80000062 status 00000062
> > >   15: @c0af85c0  length 80000062 status 00000062
> > > eth0: Resetting the Tx ring pointer.
> > >
> > > The tx ring seems to be in a good state, no ?
> > >
> > > Christophe
> > >
> > > On Tue, Feb 26, 2002 at 01:59:07PM -0500, christophe barb=E9 wrote:
> > > > Thank you, I have done something similar and that solve it in my ca=
se at
> > > > least. This driver was clearly not designed for cardbus.
> > > >
> > > > I am still looking for my resume/suspend problem.
> > > > Hope to find the solution soon.
> > > >
> > > > Christophe
> > > >
> > > > On Tue, Feb 26, 2002 at 10:51:08AM -0800, Andrew Morton wrote:
> > > > > christophe barb=E9 wrote:
> > > > > >
> > > > > > Ok I have found why.
> > > > > > When I resinsert the card, the driver give it a new id (this dr=
iver
> > > > > > supports multiple cards) and the option as I set it is only def=
ined for
> > > > > > the card #0. I would expect that the driver give the same id ba=
ck.
> > > > > >
> > > > >
> > > > > hrm.  OK, hotplugging and slot-positional module parameters weren=
't
> > > > > designed to live together.
> > > > >
> > > > > This should fix it for single cards.   For multiple cards, you'll
> > > > > have to make sure you eject them in reverse scan order :)
> > > > >
> > > > > Index: drivers/net/3c59x.c
> > > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > > > RCS file: /opt/cvs/lk/drivers/net/3c59x.c,v
> > > > > retrieving revision 1.74.2.7
> > > > > diff -u -r1.74.2.7 3c59x.c
> > > > > --- drivers/net/3c59x.c	2002/02/13 21:03:03	1.74.2.7
> > > > > +++ drivers/net/3c59x.c	2002/02/26 18:49:24
> > > > > @@ -2898,6 +2898,9 @@
> > > > >  		BUG();
> > > > >  	}
> > > > >
> > > > > +	if (vp->card_idx =3D=3D vortex_cards_found)
> > > > > +		vortex_cards_found--;
> > > > > +
> > > > >  	vp =3D dev->priv;
> > > > >
> > > > >  	/* AKPM: FIXME: we should have
> > > > >
> > > > >
> > > > > -
> > > >
> > > > --
> > > > Christophe Barb=E9 <christophe.barbe@ufies.org>
> > > > GnuPG FingerPrint: E0F6 FADF 2A5C F072 6AF8  F67A 8F45 2F1E D72C B4=
1E
> > > >
> > > > Imagination is more important than knowledge.
> > > >    Albert Einstein, On Science
> > >
> > >
> > >
> > > --
> > > Christophe Barb=E9 <christophe.barbe@ufies.org>
> > > GnuPG FingerPrint: E0F6 FADF 2A5C F072 6AF8  F67A 8F45 2F1E D72C B41E
> > >
> > > Imagination is more important than knowledge.
> > >    Albert Einstein, On Science
> > >
> >=20
> > --=20
> > pozsy
> >=20
> > -
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> >=20
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Christophe Barb=E9 <christophe.barbe@ufies.org>
GnuPG FingerPrint: E0F6 FADF 2A5C F072 6AF8  F67A 8F45 2F1E D72C B41E

L'experience, c'est une connerie par jour mais jamais la m=EAme.

--SqfawxHnX56H7Ukl
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Pour information voir http://www.gnupg.org

iD8DBQE8fCspj0UvHtcstB4RAoIvAJ4pMPtBCk4V2PvItKGzxSGn23fjkgCfZO0s
ptQeAF1CPBVGcBr4RfWOXfQ=
=mYy7
-----END PGP SIGNATURE-----

--SqfawxHnX56H7Ukl--
