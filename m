Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274757AbRJQGYi>; Wed, 17 Oct 2001 02:24:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274752AbRJQGY3>; Wed, 17 Oct 2001 02:24:29 -0400
Received: from con-64-133-52-190-ria.sprinthome.com ([64.133.52.190]:42244
	"EHLO ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S274749AbRJQGY0>; Wed, 17 Oct 2001 02:24:26 -0400
Date: Tue, 16 Oct 2001 23:24:52 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Jan Niehusmann <jan@gondor.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Oops in usb-storage.c
Message-ID: <20011016232452.A22978@one-eyed-alien.net>
Mail-Followup-To: Jan Niehusmann <jan@gondor.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011017005822.A2161@gondor.com> <20011016175640.A18541@one-eyed-alien.net> <20011017031113.A3072@gondor.com> <20011016183243.B18541@one-eyed-alien.net> <20011017034410.A3722@gondor.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011017034410.A3722@gondor.com>; from jan@gondor.com on Wed, Oct 17, 2001 at 03:44:10AM +0200
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Ahh... you've never used cdrecord -scanbus

Technically, as long as the system believes that the target exists (i.e.
you haven't unloaded your SCSI driver module), the target is required to
respond to an INQUIRY command.  So, if you boot with the scanner on, and
then turn it off, you've got a problem.

What you say about behavior is correct, but it's just another symptom.  If
you run cdrecord -scanbus with a disconnected USB device, it just gives you
garbage, which is bad also.

Matt

On Wed, Oct 17, 2001 at 03:44:10AM +0200, Jan Niehusmann wrote:
> On Tue, Oct 16, 2001 at 06:32:43PM -0700, Matthew Dharm wrote:
> > No, I think something different is best.
> >=20
> > Your first change to push the US_FL_FIX_INQUIRY code down after the test
> > for pusb_dev is good.. but, in the case where that pointer is bad, we n=
eed
> > to cook up something totally fake, like INQUIRY data that says
> > "DISCONNECTED" "USB-STORAGE DEVICE" or somesuch.....
>=20
> Then I don't understand why we have to answer the INQUIRY at all.=20
> This could as well be a disconnected / turned off external scsi=20
> device. I often turn off my external scsi scanner while the system
> is running, without a problem up to now. The scanner surely doesn't
> answer to INQUIRYs when it's turned off...
>=20
> By the way - a device not needing the US_FL_FIX_INQUIRY code wouldn't
> answer to INQUIRYs either, when it's disconnected. So the patch I sent
> first gives the same behaviour for devices with and without=20
> US_FL_FIX_INQUIRY set.
>=20
> Jan
>=20
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

E:  You run this ship with Windows?!  YOU IDIOT!
L:  Give me a break, it came bundled with the computer!
					-- ESR and Lan Solaris
User Friendly, 12/8/1998

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7zSQ0z64nssGU+ykRAmglAKCTOlJXbG25dUDOVMEKIWoVpJHvsgCfTioY
DUzx3MgSHud5Lqj1duzD9OI=
=Ep3C
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
