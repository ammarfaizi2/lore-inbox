Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261268AbVB0UqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261268AbVB0UqF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Feb 2005 15:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261273AbVB0UqE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Feb 2005 15:46:04 -0500
Received: from multivac.one-eyed-alien.net ([64.169.228.101]:59591 "EHLO
	multivac.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S261268AbVB0Upw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Feb 2005 15:45:52 -0500
Date: Sun, 27 Feb 2005 12:45:24 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: pmarques@grupopie.com
Cc: linux-kernel@vger.kernel.org, perex@suse.cz
Subject: Re: sizeof(ptr) or sizeof(*ptr)?
Message-ID: <20050227204524.GA29026@one-eyed-alien.net>
Mail-Followup-To: pmarques@grupopie.com, linux-kernel@vger.kernel.org,
	perex@suse.cz
References: <1109535904.42222ca0b0b78@webmail.grupopie.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <1109535904.42222ca0b0b78@webmail.grupopie.com>
User-Agent: Mutt/1.4.1i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2005 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 27, 2005 at 08:25:04PM +0000, pmarques@grupopie.com wrote:
> I decided to tweak sparse to give warnings on sizeof(pointer), so that I =
could
> check for other cases like this. The tweak was a very crude hack that I'm=
 not
> proud of, and I am still trying to make it more reliable.
>=20
> So far I found 2 interesting cases (in 2.6.11-rc5). I'm not sure they are=
 bugs,
> but they sure look suspicious.
>=20
> 1: drivers/usb/storage/usb.c:788
>=20
> 	/*
> 	 * Since this is a new device, we need to register a SCSI
> 	 * host definition with the higher SCSI layers.
> 	 */
> 	us->host =3D scsi_host_alloc(&usb_stor_host_template, sizeof(us));
> 	if (!us->host) {
> 		printk(KERN_WARNING USB_STORAGE
> 			"Unable to allocate the scsi host\n");
> 		return -EBUSY;
> 	}
>=20
> "us" is a "struct us_data *". It seems pretty weird that we're allocating
> something the size of a pointer, and then waste a pointer to keep the add=
ress
> where it is allocated. So maybe this should be:
>=20
> 	us->host =3D scsi_host_alloc(&usb_stor_host_template, sizeof(*us));

This is actually correct as-is.  We're allocating a host, and asking for
the sizeof(pointer) in the 'extra storage' section.  We then store the
pointer (not what it points to) in the extra storage section a few lines do=
wn.

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

S:  Another stupid question?
G:  There's no such thing as a stupid question, only stupid people.
					-- Stef and Greg
User Friendly, 7/15/1998

--vtzGhvizbBRQ85DL
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFCIjFkIjReC7bSPZARAo1mAKC9Z+6YdcxhvYU2SnrYCNP7O6swAACeK2NJ
Glgcs+eonI3EN56xDqUSJSA=
=M3VF
-----END PGP SIGNATURE-----

--vtzGhvizbBRQ85DL--
