Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262400AbTFTF40 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jun 2003 01:56:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262403AbTFTF40
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jun 2003 01:56:26 -0400
Received: from p164.ats40.donpac.ru ([217.107.128.164]:36294 "EHLO donpac.ru")
	by vger.kernel.org with ESMTP id S262400AbTFTF4Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jun 2003 01:56:24 -0400
Date: Fri, 20 Jun 2003 10:10:20 +0400
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PnP Changes for 2.5.72
Message-ID: <20030620061020.GC786@pazke>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030618234418.GC333@neo.rr.com> <20030619093632.A29602@flint.arm.linux.org.uk> <20030619234249.GA31392@neo.rr.com> <20030620065547.B7431@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jousvV0MzM2p6OtC"
Content-Disposition: inline
In-Reply-To: <20030620065547.B7431@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.4i
From: Andrey Panin <pazke@donpac.ru>
X-Spam-Score: -11.7 (-----------)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--jousvV0MzM2p6OtC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 171, 06 20, 2003 at 06:55:47AM +0100, Russell King wrote:
> On Thu, Jun 19, 2003 at 11:42:49PM +0000, Adam Belay wrote:
> > I removed avoid_irq_share because the current pnp code, like the previo=
us, does=20
> > not allow irq sharing.  Also it corrupts the device rule structure by r=
eplacing=20
> > it with modified values that may not apply after devices are disabled e=
tc.
> > Is there a set of conditions I could follow to determine if a serial pn=
p device=20
> > is capable of irq sharing, and also with which other devices can a capa=
ble=20
> > device share an irq?  If so, I could have the resource manager handle t=
his type=20
> > of situation when few irqs are available.
>=20
> The problem is one of a lack of historical information on why it was
> added.  The driver itself allows serial ports to share interrupts between
> themselves.  Maybe tytso knows why the "Rockwell 56K ACF II Fax+Data+Voice
> Modem" is unable to share IRQs?

It was me who added this crappy quirk.

My ELine modem which identified itself "Rockwell 56K ACF II Fax+Data+Voice =
Modem"
was going mad when its IRQ was shared with any device. So I decided to add =
this
quirk.

Personally I think that ISA IRQ sharing should be absolutely last resort te=
chnic,
because ISA bus was never designed to support IRQ sharing sanely. If you ha=
ve to
enable ISA PnP device and do not have enough IRQ, you must print BIG FAT WA=
RNING
before doing this. May be kernel config options must be added for brave guys
wanting to use ISA IRQ sharing.

--=20
Andrey Panin		| Linux and UNIX system administrator
pazke@donpac.ru		| PGP key: wwwkeys.pgp.net

--jousvV0MzM2p6OtC
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE+8qVMby9O0+A2ZecRAjOuAJ926pSMLYzKylHPYcKJmu9Dgg0eKgCgzqc/
RmB9Oj9W9Vj9M+G5nTJ8Fhc=
=mHO7
-----END PGP SIGNATURE-----

--jousvV0MzM2p6OtC--
