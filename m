Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262193AbTEOHCT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 May 2003 03:02:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262270AbTEOHCT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 May 2003 03:02:19 -0400
Received: from ziggy.one-eyed-alien.net ([64.169.228.100]:53004 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S262193AbTEOHCP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 May 2003 03:02:15 -0400
Date: Thu, 15 May 2003 00:14:59 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Greg KH <greg@kroah.com>
Cc: davej@codemonkey.org.uk, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: mysterious shifts in USB storage drivers.
Message-ID: <20030515001459.A2458@one-eyed-alien.net>
Mail-Followup-To: Greg KH <greg@kroah.com>, davej@codemonkey.org.uk,
	torvalds@transmeta.com, linux-kernel@vger.kernel.org
References: <200305150331.h4F3VHID000770@deviant.impure.org.uk> <20030515045637.GB5779@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030515045637.GB5779@kroah.com>; from greg@kroah.com on Wed, May 14, 2003 at 09:56:37PM -0700
Organization: One Eyed Alien Networks
X-Copyright: (C) 2003 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hrm... nothing in the logs, but I remember this.  Apparently, the
srb->result field actually requires this format.  If you look at other LLDD
code in linux/drivers/scsi/ you'll see that the << 1 is common.

This should be in 2.5... I thought it already was.

Matt

On Wed, May 14, 2003 at 09:56:37PM -0700, Greg KH wrote:
> On Thu, May 15, 2003 at 04:31:17AM +0100, davej@codemonkey.org.uk wrote:
> > These went into 2.4 over a year ago. Unfortunatly,
> > with no comments in the logs.
>=20
> My logs show this went into 2.4 with this comment:
>=20
>   usb-storage: ISD-200 fixes, more unusual devices, and many cleanups
>  =20
>   (o) Fix to ISD-200 driver to work on big-endian platforms, including PP=
C.
>       This has been in circulation for a while, and seems well-tested.
>   (o) Add several unusual_devs.h entries
>   (o) A couple more debugging improvements
>   (o) A slight improvement to the EXPERIMENTAL HP82xx driver, which should
>       help with newer units.
>   (o) A _major_ cleanup of error handling code throughout the driver.  No=
te
>       that this is in preparation to deploy the new error-handling state
>       machine (special thanks to Alan Sterm for this work).  Right now, t=
he
>       optimizations are simple and straightforward (elimination of redund=
ant
>       code paths, etc).  Nothing tremendous, but it looks kinda invasive.
>=20
> So this was a tiny part of a bigger patch.  I defer to Matt as to if
> this kind of change should be put into 2.5.
>=20
> thanks,
>=20
> greg k-h
>=20
> > diff -urpN --exclude-from=3D/home/davej/.exclude bk-linus/drivers/usb/s=
torage/datafab.c linux-2.5/drivers/usb/storage/datafab.c
> > --- bk-linus/drivers/usb/storage/datafab.c	2003-04-10 06:01:25.00000000=
0 +0100
> > +++ linux-2.5/drivers/usb/storage/datafab.c	2003-03-17 23:42:38.0000000=
00 +0000
> > @@ -670,7 +670,7 @@ int datafab_transport(Scsi_Cmnd * srb, s
> >  			srb->result =3D SUCCESS;
> >  		} else {
> >  			info->sense_key =3D UNIT_ATTENTION;
> > -			srb->result =3D CHECK_CONDITION << 1;
> > +			srb->result =3D CHECK_CONDITION;
> >  		}
> >  		return rc;
> >  	}
> > diff -urpN --exclude-from=3D/home/davej/.exclude bk-linus/drivers/usb/s=
torage/jumpshot.c linux-2.5/drivers/usb/storage/jumpshot.c
> > --- bk-linus/drivers/usb/storage/jumpshot.c	2003-04-10 06:01:25.0000000=
00 +0100
> > +++ linux-2.5/drivers/usb/storage/jumpshot.c	2003-03-17 23:42:38.000000=
000 +0000
> > @@ -611,7 +611,7 @@ int jumpshot_transport(Scsi_Cmnd * srb,=20
> >  			srb->result =3D SUCCESS;
> >  		} else {
> >  			info->sense_key =3D UNIT_ATTENTION;
> > -			srb->result =3D CHECK_CONDITION << 1;
> > +			srb->result =3D CHECK_CONDITION;
> >  		}
> >  		return rc;
> >  	}

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

Dudes! May the Open Source be with you.
					-- Eric S. Raymond
User Friendly, 12/3/1998

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+wz5zIjReC7bSPZARAoPSAKCxe75scrTDQjaF1udX9cX308yiHQCgsapK
EaHEOgA6o0hH0Q03R5+bn7w=
=5aqt
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
