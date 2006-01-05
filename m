Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751838AbWAERAA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751838AbWAERAA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 12:00:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751843AbWAEQ77
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 11:59:59 -0500
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:30870 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751838AbWAEQ76 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 11:59:58 -0500
Subject: Re: Apparent problems with interrupt latency with PCI2PCI bridges
	(register_serial(): autoconfig failed)
From: "Michael R. Head" <burner@suppressingfire.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1136398726.31979.29.camel@phoenix>
References: <1136398726.31979.29.camel@phoenix>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-MYSyoXUwky5Ho5cLE2NO"
Organization: GPG: http://www.suppressingfire.org/~burner/gpg.key.txt
	[0x4C9DA1D0]
Date: Thu, 05 Jan 2006 11:59:14 -0500
Message-Id: <1136480354.9411.26.camel@phoenix>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
X-Scanner: exiscan *1EuYSn-0000lo-00*Sb/REFI4K4o*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-MYSyoXUwky5Ho5cLE2NO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

In case anyone else ends up with this problem, here's how it's
resolving...=20

I've been told that this is a result of PCI interface controller on the
card (a PLX PCI9050) having trouble with PCI bridges. All of the cards
that I have been having trouble with use this interface controller, so
that seems to explain my problems.

On Wed, 2006-01-04 at 13:18 -0500, Michael R. Head wrote:
> Hello, I'm having some trouble with a number of PCI cards and several
> PCI bridges. In order to reduce the problem, I'm going to ask about 1
> specific card and one specific bridge.
>=20
> The hardware I'm working with is a P4 2.4Ghz machine in a 4U rackmount
> chassis. On board are 3 PCI slots connected to the main PCI bus and 9
> PCI slots connected to a bridge to the main PCI bus.
>=20
> The software I'm running is an up to date RHEL3 (kernel 2.4.21-37.EL),
> but I experience the same problems when I boot off an Ubuntu Breezy
> LiveCD (which uses 2.6.12).
>=20
> I have an 8 port RS232 card using 16550A UARTs (Sealevel Systems Inc
> Eight Port RS-232 Interface). When I plug it into the main PCI bus (#2),
> it works perfectly and I get ttyS4-11 working automatically and
> properly.
>=20
> However, when I put the card in a PCI slot on bus #3 (which is on the
> other side of a Pericom Semiconductor PCI to PCI Bridge), I see this
> during boot:
>=20
> $ dmesg | grep -2 serial
> ttyS3 at 0x02e8 (irq =3D 3) is 16550A
> register_serial(): autoconfig failed
> Real Time Clock Driver v1.10e
>=20
>=20
> When I plug it into a slot on bus #2, I get this from setserial:
> $ setserial -g /dev/ttyS4
> /dev/ttyS4, UART: 16550A, Port 0xd200, IRQ: 2
>=20
> When I plut the card into a slot on bus #3, setserial tells me this (by
> default);
> $ setserial -g /dev/ttyS4
> /dev/ttyS4, UART: unknown, Port: 0xc100, IRQ: 2
>=20
> If I attempt to reconfigure ttyS4 to have the settings from above, I get
> the dreaded "ttyS4: LSR safety check engaged!" and from then on, any
> access to /dev/ttyS4 results in "/dev/ttyS4: No such device".
>=20
>=20
>=20
> Now, I also have some other PCI cards that are having trouble with
> living on the other side of a PCI bridge, but their drivers are
> available separately from the kernel. I figure that if I can get the
> serial card working, then hopefully the rest will work, too.
>=20
> I also have an external 4U rackmount chassis containing 12 additional
> PCI slots that are connected via 4 Intel 21142 PCI-to-PCI bridges, and
> when I connect the serial card into any of those busses, I get the same
> problem.
>=20
>=20
> I've tried fiddling with all sorts of kernel PCI options at boot and
> fiddling with various setpci commands. Nothing seems to help. Any
> suggestions or information would be greatly appreciated.
>=20
> thanks,
> mike
>=20
--=20
Michael R. Head <burner@suppressingfire.org>
GPG: http://www.suppressingfire.org/~burner/gpg.key.txt [0x4C9DA1D0]

--=-MYSyoXUwky5Ho5cLE2NO
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDvVBiNXGzGEydodARAiumAJwKuU4Q4jApI4xyGGoh4+g5vw5Z/QCgk8gm
NcjHMmiXffeV4gOeVEljn0M=
=Lsvh
-----END PGP SIGNATURE-----

--=-MYSyoXUwky5Ho5cLE2NO--

