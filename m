Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312485AbSCYSUS>; Mon, 25 Mar 2002 13:20:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312487AbSCYSUJ>; Mon, 25 Mar 2002 13:20:09 -0500
Received: from charger.oldcity.dca.net ([207.245.82.76]:49596 "EHLO
	charger.oldcity.dca.net") by vger.kernel.org with ESMTP
	id <S312485AbSCYSUD>; Mon, 25 Mar 2002 13:20:03 -0500
Date: Mon, 25 Mar 2002 13:19:56 -0500
From: christophe =?iso-8859-15?Q?barb=E9?= 
	<christophe.barbe.ml@online.fr>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 3c59x and resume
Message-ID: <20020325181956.GE1853@ufies.org>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20020323161647.GA11471@ufies.org> <3C9CCBEB.D39465A6@zip.com.au> <1016914030.949.20.camel@phantasy> <20020323224433.GB11471@ufies.org> <20020324080729.GD16785@kroah.com> <20020324142545.GC20703@ufies.org> <20020325180133.GB28629@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ey/N+yb7u/X9mFhi"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: debian SID Gnu/Linux 2.4.19-pre4 on i586
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ey/N+yb7u/X9mFhi
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2002 at 10:01:33AM -0800, Greg KH wrote:
> On Sun, Mar 24, 2002 at 09:25:45AM -0500, christophe barb=E9 wrote:
> > On Sun, Mar 24, 2002 at 12:07:29AM -0800, Greg KH wrote:
> > > On Sat, Mar 23, 2002 at 05:44:33PM -0500, christophe barb=E9 wrote:
> > > > With the 'everything is module' and 'everything is hotplug' approac=
h in
> > > > mind (which is a appealing way and IMHO this is the way we are goin=
g),
> > > > I see two part for this problem:
> > > >=20
> > > > . Persistence after plug out/plug in=20
> > > >=20
> > > > . Persistence after suspend/resume
> > > >=20
> > > > The first one is a userland problem. The card identification could =
be
> > > > based on the MAC address (for NICs at least, in the case of cardbus=
 the
> > > > bus position has no real signification). This should then be the
> > > > responsibility of the userspace tool (hotplug) to indicate the corr=
ect
> > > > option for this card. The problem is when the module is already loa=
ded,
> > > > the userspace tool has no way to indicate this option.
> > >=20
> > > Untrue.  See
> > > 	http://www.kroah.com/linux/hotplug/ols_2001_hotplug_talk/html/mgp000=
14.html
> > > for a 6 line version of /sbin/hotplug that always assigns the same
> > > "ethX" value to the same MAC address.  I think the patch to nameif has
> > > gone in to support this, but I'm not sure.
> >=20
> > Untrue what ? The persistence after plug out/in ?
>=20
> No, the sentence, "The problem is when the module is already loaded..."
> /sbin/hotplug gets called when the network device is started up, it
> doesn't only get called before the module is loaded.

Ok I understand that but hotplug has no way to influence the way the
device is treated by the driver. The only way I can see is via the /proc
interface, but at least it is not possible with this driver.

> > The problem here is not to give the same interface to a given NIC. The
> > problem is to give the same options to a given NIC. But a solution can
> > simply be to set the option from hotplug using the proc interface. The
> > 3c59x doesn't support that for wol but that can be changed.
>=20
> Understood.

So do you agree that something is missing here ?

>=20
> > > And why is there a limitation of only 8 devices?  Why not do what all
> > > USB drivers do, and just create the structure that you need to use at
> > > probe() time, and destroy it at remove() time?
> >=20
> > This is an implementation issue which is not really important. It comes
> > from Donald Becker. Your dynamic structure doesn't solve the problem
> > 'which options for which cards', does it ?=20
>=20
> No, but it solves the problem, "only 8 devices max", and "what to do
> when a card is removed and then plugged back in."  Both seems like good
> things to fix in the driver :)

I have not checked the module loading code but is it possible to define
for an option a vector with an undefined size ? Or do you consider that
all devices use the same option ? (the vortex driver is only limited to
8 cards for the options passed by modutils)

Could you point me to a specific usb driver ?

How is solved the "what to do when a card is removed and then plugged
back in." problem ? By keeping the entry for further use ?=20

Christophe

> thanks,
>=20
> greg k-h

--=20
Christophe Barb=E9 <christophe.barbe@ufies.org>
GnuPG FingerPrint: E0F6 FADF 2A5C F072 6AF8  F67A 8F45 2F1E D72C B41E

There's no sense in being precise when you don't even know what you're
talking about. -- John von Neumann

--ey/N+yb7u/X9mFhi
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Pour information voir http://www.gnupg.org

iD8DBQE8n2pMj0UvHtcstB4RAiuxAKCN15h7EzE7o7fKh1xe3SnSl1WUEACfZNv+
E0jk5sEMhe4pbG1vJ92lDz4=
=yK5J
-----END PGP SIGNATURE-----

--ey/N+yb7u/X9mFhi--
