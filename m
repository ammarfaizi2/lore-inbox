Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313743AbSGDVOD>; Thu, 4 Jul 2002 17:14:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313767AbSGDVOC>; Thu, 4 Jul 2002 17:14:02 -0400
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:529 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S313743AbSGDVOC>; Thu, 4 Jul 2002 17:14:02 -0400
Date: Thu, 4 Jul 2002 14:16:26 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: David Brownell <david-b@pacbell.net>
Cc: Manfred Spraul <manfred@colorfullife.com>,
       linux-usb-devel@lists.sourceforge.net, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] Re: usb storage cleanup
Message-ID: <20020704141626.E17360@one-eyed-alien.net>
Mail-Followup-To: David Brownell <david-b@pacbell.net>,
	Manfred Spraul <manfred@colorfullife.com>,
	linux-usb-devel@lists.sourceforge.net, greg@kroah.com,
	linux-kernel@vger.kernel.org
References: <3D236950.5020307@colorfullife.com> <20020703144329.D8033@one-eyed-alien.net> <3D237870.7010600@colorfullife.com> <20020703170521.E8033@one-eyed-alien.net> <3D248208.4060500@colorfullife.com> <20020704125012.C17360@one-eyed-alien.net> <3D24AEDA.9090100@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="xA/XKXTdy9G3iaIz"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3D24AEDA.9090100@pacbell.net>; from david-b@pacbell.net on Thu, Jul 04, 2002 at 01:23:54PM -0700
Organization: One Eyed Alien Networks
X-Copyright: (C) 2002 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--xA/XKXTdy9G3iaIz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Now... wait a second here....

You say the dirver "is supposed to wait until all urbs" are completed...
but we're talking about the case where the device is now gone...

So how do the urbs complete?  Something is causing them to complete when
the cable is removed -- that's the behavior I've observed, at least.

Matt

On Thu, Jul 04, 2002 at 01:23:54PM -0700, David Brownell wrote:
> >>Test case: user pulls out the usb cable while a transfer is in progress=
.=20
> >>urb submitted to the device, reply not yet received.
> >>Result: storage_disconnect() would hang for 20 seconds until=20
> >>command_abort() is called.
> >=20
> >=20
> > No, not quite.   The HCD accelerates the URBs to completion if the devi=
ce
> > is removed with an URB pending on it.  It therefore shouldn't hang for =
the
> > timeout -- if you're seeing this behavior, then the HCD is broken.
>=20
> Actually all of the interesting work is triggered by khubd,
> and then the device driver.
>=20
> Khubd calls usb_disconnect() for the device.  That disconnects
> each driver (which is supposed to wait until all urbs it's
> submitted have completed, and not submit any more URBS).
>=20
> Only at the very end of this does the HCD hear anything about
> devices going away.  If there's any URB still submitted at that
> point it's not a bug in the HCD at all ... but in a device
> driver that didn't implement disconnect() correctly.
>=20
> - Dave
>=20
>=20
>=20

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

Way to go, lava boy.
					-- Stef to Greg
User Friendly, 3/26/1998

--xA/XKXTdy9G3iaIz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9JLsqIjReC7bSPZARAoafAJ49I+rEB6QYuEoM8qalvOczuhmCIQCeJ2o/
vYhDxC1Gjd+rqSbklmbZrfA=
=nU96
-----END PGP SIGNATURE-----

--xA/XKXTdy9G3iaIz--
