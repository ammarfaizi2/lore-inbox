Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262189AbVANWhZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262189AbVANWhZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Jan 2005 17:37:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbVANWhZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Jan 2005 17:37:25 -0500
Received: from multivac.one-eyed-alien.net ([64.169.228.101]:48033 "EHLO
	multivac.one-eyed-alien.net") by vger.kernel.org with ESMTP
	id S262189AbVANWhN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Jan 2005 17:37:13 -0500
Date: Fri, 14 Jan 2005 14:37:12 -0800
From: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
To: Enrico Bartky <DOSProfi@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: lspci != scanpci !?
Message-ID: <20050114223712.GA26009@one-eyed-alien.net>
Mail-Followup-To: Enrico Bartky <DOSProfi@web.de>,
	linux-kernel@vger.kernel.org
References: <003d01c4fa7b$983b21b0$0c00a8c0@amd64>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SUOF0GtieIMvvwua"
Content-Disposition: inline
In-Reply-To: <003d01c4fa7b$983b21b0$0c00a8c0@amd64>
User-Agent: Mutt/1.4.1i
Organization: One Eyed Alien Networks
X-Copyright: (C) 2005 Matthew Dharm, all rights reserved.
X-Message-Flag: Get a real e-mail client.  http://www.mutt.org/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--SUOF0GtieIMvvwua
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 14, 2005 at 09:57:00PM +0100, Enrico Bartky wrote:
> Hello,
>=20
> I have a Gigabyte GA-5AA Board with ALi Aladdin IV Chipset ( 1533, 1541 )=
. I
> tried to get the smbus to work, but Gigabyte have disabled it and I can't
> activate it in the BIOS. I use kernel 2.6.10 and looked at the m7101-hotp=
lug
> for kernel 2.4-module from lm_sensors. I added the following to
> drivers/pci/quirks.c:
>=20
> ....
> /* ALi 1533 fixup to enable the M7101 SMBus Controller
> * ported from prog/hotplug of the lm_sensors
> * package
> */
> static void __devinit quirk_ali1533_smbus(struct pci_dev *dev)
> {
> u8 val =3D 0;
>=20
> pci_read_config_byte ( dev, 0x5F, &val );
> if ( val & 0x4 )
> {
> pci_write_config_byte ( dev, 0x5F, val & 0xFB );
> }
> }
> DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_AL, PCI_DEVICE_ID_AL_M1533,
> quirk_ali1533_smbus );
> ....
>=20
> Now the scanpci command shows the M7101 BUT lspci and /proc/pci,
> /proc/bus/pci, /sys/bus/pci NOT. What can I do? Is there anything like a
> "update_pci" command?

I think there is a kernel command-line parameter you can use to tell the
kernel to ignore the BIOS-supplied PCI map and generate it's own via
scanning (ala what scanpci does).

Matt

--=20
Matthew Dharm                              Home: mdharm-usb@one-eyed-alien.=
net=20
Maintainer, Linux USB Mass Storage Driver

Department of Justice agent.  I have come to purify the flock.
					-- DOJ agent
User Friendly, 5/22/1998

--SUOF0GtieIMvvwua
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQFB6EmYIjReC7bSPZARAntsAKCYrxLQgm8Rb9S9Htx8I7bUrA1DQQCfYnlN
7ZnUzV6+FF0OV7eW1RJkLWo=
=RV/q
-----END PGP SIGNATURE-----

--SUOF0GtieIMvvwua--
