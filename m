Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263095AbRFECIV>; Mon, 4 Jun 2001 22:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263093AbRFECIL>; Mon, 4 Jun 2001 22:08:11 -0400
Received: from adsl-63-199-250-45.dsl.sndg02.pacbell.net ([63.199.250.45]:31496
	"EHLO ziggy.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id <S263095AbRFECIA>; Mon, 4 Jun 2001 22:08:00 -0400
Date: Mon, 4 Jun 2001 19:07:55 -0700
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
Subject: Re: Unit attention in USB storage
Message-ID: <20010604190755.A3629@one-eyed-alien.net>
Mail-Followup-To: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
	linux-usb-devel@lists.sourceforge.net
In-Reply-To: <UTC200106050158.DAA189320.aeb@vlet.cwi.nl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-md5;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <UTC200106050158.DAA189320.aeb@vlet.cwi.nl>; from Andries.Brouwer@cwi.nl on Tue, Jun 05, 2001 at 03:58:03AM +0200
Organization: One Eyed Alien Networks
X-Copyright: (C) 2001 Matthew Dharm, all rights reserved.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I suggest trying this with 2.4.5 -- several people report that kernel works
much better than previous ones with usb-storage.

While the debugging print might be useful... I think another approach might
be in order.  Can you send the data from /proc/bus/usb/devices for
analysis?

Matt

On Tue, Jun 05, 2001 at 03:58:03AM +0200, Andries.Brouwer@cwi.nl wrote:
> Last month my CF reader read CF cards happily.
> Now that I returned from Denmark, I find that it no longer works
> (with the same 2.4.3 kernel). Indeed, it is not properly detected.
>=20
> The reason seems to be slightly different timing at bootup -
> maybe because I connected a wheelmouse this time -
> and now this device comes with Unit Attention
> 	(code 70, key 6, ASC 28, ASCQ 0: not ready to ready transit)
> and this is regarded as an error return and the initial INQUIRY fails.
>=20
> Thus, since this code actually occurs in real life, we should
> probably add
>=20
> 	case 0x2800: what=3D"not ready to ready transtion (media change?)";
> 		break;
>=20
> in debug.c:usb_stor_show_sense().
> I have not really thought about the proper treatment of this Unit Attenti=
on.
> However, if one decides that really nothing at all is wrong when a device
> tells us that it is ready now, then
>=20
>                 if ((srb->sense_buffer[2] & 0xf) =3D=3D 0x6 /* unit atten=
tion */
>                     && srb->sense_buffer[12] =3D=3D 0x28
>                     && srb->sense_buffer[13] =3D=3D 0 /* not ready -> rea=
dy */)
>                         srb->result =3D GOOD << 1;
>=20
> is perhaps not too unreasonable. (This is in usb/storage/transport.c,
> usb_stor_invoke_transport(), at the end of the need autosense part.)
> Anyway, with this addition (to 2.4.3) all works for me again.
>=20
> Andries

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

Somebody call an exorcist!
					-- Dust Puppy
User Friendly, 5/16/1998

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE7HD77z64nssGU+ykRAnnwAKDFc3/k7E04ENE9W+zAtESj+VGDWgCgh0So
8YCwwyNli2K4VNhbqssfdLI=
=qqRo
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
