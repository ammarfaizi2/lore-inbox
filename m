Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312543AbSCYU1i>; Mon, 25 Mar 2002 15:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312547AbSCYU13>; Mon, 25 Mar 2002 15:27:29 -0500
Received: from charger.oldcity.dca.net ([207.245.82.76]:50324 "EHLO
	charger.oldcity.dca.net") by vger.kernel.org with ESMTP
	id <S312543AbSCYU1X>; Mon, 25 Mar 2002 15:27:23 -0500
Date: Mon, 25 Mar 2002 15:27:16 -0500
From: christophe =?iso-8859-15?Q?barb=E9?= 
	<christophe.barbe.ml@online.fr>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 3c59x and resume
Message-ID: <20020325202716.GI1853@ufies.org>
Mail-Followup-To: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20020323161647.GA11471@ufies.org> <3C9CCBEB.D39465A6@zip.com.au> <1016914030.949.20.camel@phantasy> <20020323224433.GB11471@ufies.org> <20020324080729.GD16785@kroah.com> <20020324142545.GC20703@ufies.org> <20020325180133.GB28629@kroah.com> <20020325181956.GE1853@ufies.org> <20020325191127.GC29011@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Op27XXJsWz80g3oF"
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: debian SID Gnu/Linux 2.4.19-pre4 on i586
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Op27XXJsWz80g3oF
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2002 at 11:11:27AM -0800, Greg KH wrote:
> On Mon, Mar 25, 2002 at 01:19:56PM -0500, christophe barb=E9 wrote:
> >=20
> > Ok I understand that but hotplug has no way to influence the way the
> > device is treated by the driver. The only way I can see is via the /proc
> > interface, but at least it is not possible with this driver.
>=20
> Not true.  The link I pointed to changes the way the "ethX" names are
> assigned to the device based on MAC addresses.  So that's just one way
> to influence the way a device is treated by a driver.
>=20
> >=20
> > > > The problem here is not to give the same interface to a given NIC. =
The
> > > > problem is to give the same options to a given NIC. But a solution =
can
> > > > simply be to set the option from hotplug using the proc interface. =
The
> > > > 3c59x doesn't support that for wol but that can be changed.
> > >=20
> > > Understood.
> >=20
> > So do you agree that something is missing here ?
>=20
> Yes I do.  See below for more.
>=20
> > > > > And why is there a limitation of only 8 devices?  Why not do what=
 all
> > > > > USB drivers do, and just create the structure that you need to us=
e at
> > > > > probe() time, and destroy it at remove() time?
> > > >=20
> > > > This is an implementation issue which is not really important. It c=
omes
> > > > from Donald Becker. Your dynamic structure doesn't solve the problem
> > > > 'which options for which cards', does it ?=20
> > >=20
> > > No, but it solves the problem, "only 8 devices max", and "what to do
> > > when a card is removed and then plugged back in."  Both seems like go=
od
> > > things to fix in the driver :)
> >=20
> > I have not checked the module loading code but is it possible to define
> > for an option a vector with an undefined size ? Or do you consider that
> > all devices use the same option ? (the vortex driver is only limited to
> > 8 cards for the options passed by modutils)
>=20
> Ok, in looking more at the 3c59x driver's module parameters, I see your
> main problem.  You are relying on module wide options to effect
> different cards in a system.  And these different cards could need
> different options, right?

Yes. I don't have this problem. I am a mobile user of this driver
(hotplug and power-management) and the driver was done with other things
in mind. The good thing is that both views seems to converge today.
I am looking for a clean fix. As I see it, the vector of options is a
mistake. We should be able to give a default value for an option with
modutils but for more complicate configuration a userland tool should be
able to decide the correct options for a given device. This is a
generalisation to what hotplug does.

> If so, yes this is a problem as you have outlined.  Might I suggest a
> driverfs entry for the device?  That way every point in the device tree
> could have those options be unique for the different device?  This could
> also be done like you said above, with a /proc entry (but we are moving
> away from /proc entries, remember? :)

Yes I remember even if I am not yet convinced.=20

> Then when /sbin/hotplug is run when your network device is brought up,
> it could find the driverfs entry for your device and initialize it with
> the proper options (full_duplex, hw_checksums, etc.)
>=20
> > Could you point me to a specific usb driver ?
>=20
> In the drivers/usb directory, the following are network drivers:
> 	CDCEther.c
> 	catc.c
> 	kaweth.c
> 	pegasus.c
> 	usbnet.c

I will have a look. Thanks.

> > How is solved the "what to do when a card is removed and then plugged
> > back in." problem ? By keeping the entry for further use ?=20
>=20
> No, all of the information is deleted when a device is removed.  When a
> device is inserted again, a structure is created again.  They do not
> remember information about the device across removals.

So this particular problem is not solved in the usb drivers ?

Christophe

> Hope this helps,
>=20
> greg k-h
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Christophe Barb=E9 <christophe.barbe@ufies.org>
GnuPG FingerPrint: E0F6 FADF 2A5C F072 6AF8  F67A 8F45 2F1E D72C B41E

There's no sense in being precise when you don't even know what you're
talking about. -- John von Neumann

--Op27XXJsWz80g3oF
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: Pour information voir http://www.gnupg.org

iD8DBQE8n4gjj0UvHtcstB4RAlhrAKCAi10xd679t6YmTv2TzNMMm918GgCfePHq
sEAhp4IG5GjbOWkj090Ej74=
=ih9y
-----END PGP SIGNATURE-----

--Op27XXJsWz80g3oF--
