Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130921AbRBMJ2U>; Tue, 13 Feb 2001 04:28:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131028AbRBMJ2L>; Tue, 13 Feb 2001 04:28:11 -0500
Received: from orbita.don.sitek.net ([213.24.25.98]:17420 "EHLO
	orbita.don.sitek.net") by vger.kernel.org with ESMTP
	id <S130921AbRBMJ15>; Tue, 13 Feb 2001 04:27:57 -0500
Date: Tue, 13 Feb 2001 12:44:00 +0300
From: Andrey Panin <pazke@orbita.don.sitek.net>
To: Brian Gerst <bgerst@didntduck.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IRQ conflicts
Message-ID: <20010213124400.A1860@debian>
Mail-Followup-To: Brian Gerst <bgerst@didntduck.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E14RfhV-0002A1-00@the-village.bc.nu> <3A85D79C.3DE3A527@didntduck.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HcAYCG3uE/tztfnV"
User-Agent: Mutt/1.0.1i
In-Reply-To: <3A85D79C.3DE3A527@didntduck.org>; from bgerst@didntduck.org on Sat, Feb 10, 2001 at 07:06:52PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable

On Sat, Feb 10, 2001 at 07:06:52PM -0500, Brian Gerst wrote:
> Alan Cox wrote:
> >=20
> > > <SoundBlaster EMU8000 (RAM2048k)>
> > > ACPI: Core Subsystem version [20010208]
> > > ACPI: SCI (IRQ9) allocation failed
> > > ACPI: Subsystem enable failed
> > > Trying to free free IRQ9
> >=20
> > That seems to indicate acpi is freeing a free irq. Turn ACPI off. Its a
> > good bet it will fix any random irq/driver problem right now
>=20
> Looking at this a bit further, I realised that when the sound driver was
> compiled in the kernel, it is initialised before ACPI.  The BIOS has
> assigned IRQ9 to ACPI, but the PCI code does not know this because of:
>=20
> PCI: 00:07.3: class 604 doesn't match header type 00. Ignoring class.=20
>=20
> The ISAPnP code then assigns IRQ9 to the sound card, causing the ACPI
> code to fail to allocate it.  If I compile sound as a module then the
> ACPI driver grabs IRQ9 and the sound get IRQ7.
>=20

Hi Brian,

please test this patch with ACPI enabled and sound driver compiled in kerne=
l.
IMHO it should fix this problem.

Best regards.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc
--HcAYCG3uE/tztfnV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6iQHgBm4rlNOo3YgRAix/AJ9TrVvnW1Sh1WUW33IBu/ydqLZDmwCfQsC7
+MiPGn6tiUH3IcsbYaBPG4U=
=yY+P
-----END PGP SIGNATURE-----

--HcAYCG3uE/tztfnV--
