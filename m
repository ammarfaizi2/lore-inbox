Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268430AbTANAmS>; Mon, 13 Jan 2003 19:42:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268444AbTANAmS>; Mon, 13 Jan 2003 19:42:18 -0500
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:60177 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S268430AbTANAmQ>; Mon, 13 Jan 2003 19:42:16 -0500
Date: Mon, 13 Jan 2003 16:51:02 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Patrick Mansfield <patmans@us.ibm.com>
Cc: Andries.Brouwer@cwi.nl, Greg KH <greg@kroah.com>, mochel@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: sysfs
Message-ID: <20030113165102.A26346@one-eyed-alien.net>
Mail-Followup-To: Patrick Mansfield <patmans@us.ibm.com>,
	Andries.Brouwer@cwi.nl, Greg KH <greg@kroah.com>, mochel@osdl.org,
	linux-kernel@vger.kernel.org
References: <UTC200301111443.h0BEhRZ06262.aeb@smtp.cwi.nl> <20030113162741.A18396@beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="ibTvN161/egqYuK8"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030113162741.A18396@beaverton.ibm.com>; from patmans@us.ibm.com on Mon, Jan 13, 2003 at 04:27:41PM -0800
Organization: One Eyed Alien Networks
X-Copyright: (C) 2003 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ibTvN161/egqYuK8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Really, we don't want to hang the device under USB... it's really an
emulated SCSI device.  Or, at least I think so.

Matt

On Mon, Jan 13, 2003 at 04:27:41PM -0800, Patrick Mansfield wrote:
> Andries -
>=20
> On Sat, Jan 11, 2003 at 03:43:27PM +0100, Andries.Brouwer@cwi.nl wrote:
> > Yesterday evening I wrote a trivial utility fd ("find device")
> > that gives the contents of sysfs. Mostly in order to see what
> > name the memory stick card reader has today.
> >=20
> > I wondered about several things.
> > Is there a description of the intended hierachy, so that one can
> > compare present facts with intention?
> >=20
> > In /sysfs/devices I see
> > 1:0:6:0  2:0:0:1  2:0:0:3  3:0:0:1  4:0:0:0  4:0:0:2   ide0  legacy  sys
> > 2:0:0:0  2:0:0:2  3:0:0:0  3:0:0:2  4:0:0:1  ide-scsi  ide1  pci0
> > many SCSI devices and some subdirectories.
> > Would it not be better to have subdirectories scsiN just like ideN?
> > One can have SCSI hosts, even when presently no devices are connected.
>=20
> It looks like there is a missing scsi_set_device() call in scsiglue.c,
> (similiar to what happens if we handled NULL dev pointer in scis_add_host)
> so all the usb scsi devices end up under /sysfs/devices.
>=20
> I don't have any usb mass storage devices, this patch against 2.5 bk
> compiles but otherwise is not tested. It should put the usb-scsi mass
> storage devices below the usb sysfs dev (I assume in your case under
> /sysfs/devices/pci0/00:07.2/usb1/1-2/1-2.4/1-2.4.4).
>=20
> Maybe Matthew or Greg can comment.
>=20
> --- 1.33/drivers/usb/storage/scsiglue.c	Sun Nov 10 09:49:52 2002
> +++ edited/drivers/usb/storage/scsiglue.c	Mon Jan 13 15:33:49 2003
> @@ -90,6 +90,7 @@
>  	if (us->host) {
>  		us->host->hostdata[0] =3D (unsigned long)us;
>  		us->host_no =3D us->host->host_no;
> +		scsi_set_device(us->host, &us->pusb_dev->dev);
>  		return 1;
>  	}
> =20
> -- Patrick Mansfield

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

It was a new hope.
					-- Dust Puppy
User Friendly, 12/25/1998

--ibTvN161/egqYuK8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+I171IjReC7bSPZARAsRYAJ9fYCX46xEMu8V2PUI9PDbOl4dVxwCgrn8X
/1IFxvD4lEi6Elptlb15YMA=
=Cu/+
-----END PGP SIGNATURE-----

--ibTvN161/egqYuK8--
