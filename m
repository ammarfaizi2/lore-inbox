Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129260AbQLRESo>; Sun, 17 Dec 2000 23:18:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129524AbQLRESe>; Sun, 17 Dec 2000 23:18:34 -0500
Received: from [216.120.107.189] ([216.120.107.189]:53262 "EHLO
	ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S129260AbQLRESS>; Sun, 17 Dec 2000 23:18:18 -0500
Date: Sun, 17 Dec 2000 19:47:37 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: set_rtc_mmss: can't update from 0 to 59
Message-ID: <20001217194737.C11947@one-eyed-alien.net>
Mail-Followup-To: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
In-Reply-To: <UTC200012172054.VAA173604.aeb@aak.cwi.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="MIdTMoZhcV1D07fI"
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <UTC200012172054.VAA173604.aeb@aak.cwi.nl>; from Andries.Brouwer@cwi.nl on Sun, Dec 17, 2000 at 09:54:18PM +0100
Organization: One Eyed Alien Networks
X-Copyright: (C) 2000 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--MIdTMoZhcV1D07fI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 17, 2000 at 09:54:18PM +0100, Andries.Brouwer@cwi.nl wrote:
> What architecture?

i386

> What kernel version?

2.4.0-test13-pre2, but this has been happening for a while.

> Are you in fact running xntpd?

Yes.

> > According to the notes in the code, this should work if my RTC
> > is less than 15 minutes off... which I can guarantee it is.
>=20
> Well, since you looked at the source:
> For some randomly chosen kernel version and architecture it does
>=20
>         if (abs(real_minutes - cmos_minutes) < 30) {
> 		update_cmos()
> 	} else {
> 		printk("set_rtc_mmss: can't update from %d to %d\n",
> 		       cmos_minutes, real_minutes);
> 	}
>=20
> so if your cmos time is 0.001 sec ahead of your system time
> then around the hour you'll see
> 	set_rtc_mmss: can't update from 0 to 59

Ahh... I think I see.  While the math says "if the diference between the
real time and the cmos time is less than 30 min", it doesn't recognize that
the time difference between 2:59 and 3:00 is only 1 min.

Hrm.. the logic to get this right is always the type of thing that gets
me... that's why I usually calculate things the UNIX way -- seconds since
an epoch.

> Of course, messing with the cmos clock at all was a rather bad idea,
> but that is a different discussion.

True enough...  but, the question is, how do we fix this?  Make the logic
more buff?  Or change the algorithm to use something like minutes since the
epoch?

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

We can customize our colonels.
					-- Tux
User Friendly, 12/1/1998

--MIdTMoZhcV1D07fI
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6PYjZz64nssGU+ykRAucWAJwPkI/8E9mSc08GII01eUWJY7aRuwCg0PRk
wMlRlwg/Lfq760phO7SwCaw=
=vKF4
-----END PGP SIGNATURE-----

--MIdTMoZhcV1D07fI--
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
