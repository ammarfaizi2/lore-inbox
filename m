Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265628AbUAKBBz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jan 2004 20:01:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265630AbUAKBBz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jan 2004 20:01:55 -0500
Received: from multivac.one-eyed-alien.net ([64.169.228.101]:10162 "EHLO
	multivac.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S265628AbUAKBBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jan 2004 20:01:53 -0500
Date: Sat, 10 Jan 2004 17:01:43 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Oliver Neukum <oliver@neukum.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       USB Developers <linux-usb-devel@lists.sourceforge.net>,
       Greg KH <greg@kroah.com>
Subject: Re: [linux-usb-devel] Re: USB hangs
Message-ID: <20040111010143.GF16484@one-eyed-alien.net>
Mail-Followup-To: Oliver Neukum <oliver@neukum.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	USB Developers <linux-usb-devel@lists.sourceforge.net>,
	Greg KH <greg@kroah.com>
References: <1073779636.17720.3.camel@dhcp23.swansea.linux.org.uk> <20040111002304.GE16484@one-eyed-alien.net> <200401110149.34654.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="w3uUfsyyY1Pqa/ej"
Content-Disposition: inline
In-Reply-To: <200401110149.34654.oliver@neukum.org>
User-Agent: Mutt/1.4.1i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2004 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--w3uUfsyyY1Pqa/ej
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 11, 2004 at 01:49:34AM +0100, Oliver Neukum wrote:
> Am Sonntag, 11. Januar 2004 01:23 schrieb Matthew Dharm:
> > Where is USB kmalloc'ing with GFP_KERNEL?  I thought we tracked all tho=
se
> > down and eliminated them.
> >=20
>=20
> static int ohci_mem_init (struct ohci *ohci)
> {
> 	ohci->td_cache =3D pci_pool_create ("ohci_td", ohci->ohci_dev,
> 		sizeof (struct td),
> 		32 /* byte alignment */,
> 		0 /* no page-crossing issues */,
> 		GFP_KERNEL | OHCI_MEM_FLAGS);
> 	if (!ohci->td_cache)
> 		return -ENOMEM;
> 	ohci->dev_cache =3D pci_pool_create ("ohci_dev", ohci->ohci_dev,
> 		sizeof (struct ohci_device),
> 		16 /* byte alignment */,
> 		0 /* no page-crossing issues */,
> 		GFP_KERNEL | OHCI_MEM_FLAGS);
> 	if (!ohci->dev_cache)
> 		return -ENOMEM;
> 	return 0;
> }
>=20
> This one here looks dangerous.

I'll agree that it looks dangerous, tho pci_pool_create() is something I
know little about.

Is this 2.4 or 2.6 code here?

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

Okay, this isn't funny anymore! Let me down!  I'll tell Bill on you!!
					-- Microsoft Salesman
User Friendly, 4/1/1998

--w3uUfsyyY1Pqa/ej
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFAAKB3IjReC7bSPZARAkUNAKDNWuSE2LCwMlC32JmM1bLgRihI1gCeNvMR
tTPGV+0tgsH3cyiY6AHu9Co=
=LDS6
-----END PGP SIGNATURE-----

--w3uUfsyyY1Pqa/ej--
