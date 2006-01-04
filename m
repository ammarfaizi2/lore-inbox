Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965182AbWADSTc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965182AbWADSTc (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 13:19:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965253AbWADSTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 13:19:32 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:4600 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S965182AbWADSTa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 13:19:30 -0500
Subject: Apparent problems with interrupt latency with PCI2PCI bridges
	(register_serial(): autoconfig failed)
From: "Michael R. Head" <burner@suppressingfire.org>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-Ikma9o/xpRfOma9JEEb2"
Organization: GPG: http://www.suppressingfire.org/~burner/gpg.key.txt
	[0x4C9DA1D0]
Date: Wed, 04 Jan 2006 13:18:46 -0500
Message-Id: <1136398726.31979.29.camel@phoenix>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
X-Scanner: exiscan *1EuDED-0006jG-00*8hv682xrt1k*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Ikma9o/xpRfOma9JEEb2
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello, I'm having some trouble with a number of PCI cards and several
PCI bridges. In order to reduce the problem, I'm going to ask about 1
specific card and one specific bridge.

The hardware I'm working with is a P4 2.4Ghz machine in a 4U rackmount
chassis. On board are 3 PCI slots connected to the main PCI bus and 9
PCI slots connected to a bridge to the main PCI bus.

The software I'm running is an up to date RHEL3 (kernel 2.4.21-37.EL),
but I experience the same problems when I boot off an Ubuntu Breezy
LiveCD (which uses 2.6.12).

I have an 8 port RS232 card using 16550A UARTs (Sealevel Systems Inc
Eight Port RS-232 Interface). When I plug it into the main PCI bus (#2),
it works perfectly and I get ttyS4-11 working automatically and
properly.

However, when I put the card in a PCI slot on bus #3 (which is on the
other side of a Pericom Semiconductor PCI to PCI Bridge), I see this
during boot:

$ dmesg | grep -2 serial
ttyS3 at 0x02e8 (irq =3D 3) is 16550A
register_serial(): autoconfig failed
Real Time Clock Driver v1.10e


When I plug it into a slot on bus #2, I get this from setserial:
$ setserial -g /dev/ttyS4
/dev/ttyS4, UART: 16550A, Port 0xd200, IRQ: 2

When I plut the card into a slot on bus #3, setserial tells me this (by
default);
$ setserial -g /dev/ttyS4
/dev/ttyS4, UART: unknown, Port: 0xc100, IRQ: 2

If I attempt to reconfigure ttyS4 to have the settings from above, I get
the dreaded "ttyS4: LSR safety check engaged!" and from then on, any
access to /dev/ttyS4 results in "/dev/ttyS4: No such device".



Now, I also have some other PCI cards that are having trouble with
living on the other side of a PCI bridge, but their drivers are
available separately from the kernel. I figure that if I can get the
serial card working, then hopefully the rest will work, too.

I also have an external 4U rackmount chassis containing 12 additional
PCI slots that are connected via 4 Intel 21142 PCI-to-PCI bridges, and
when I connect the serial card into any of those busses, I get the same
problem.


I've tried fiddling with all sorts of kernel PCI options at boot and
fiddling with various setpci commands. Nothing seems to help. Any
suggestions or information would be greatly appreciated.

thanks,
mike

--=20
Michael R. Head <burner@suppressingfire.org>
GPG: http://www.suppressingfire.org/~burner/gpg.key.txt [0x4C9DA1D0]


--=-Ikma9o/xpRfOma9JEEb2
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDvBGGNXGzGEydodARAt8MAJsHgI3FHzK5GljXGhEtkvRPPGDstgCfWtU8
pK6W6G9FHbYDLXXorosDMAY=
=tPIX
-----END PGP SIGNATURE-----

--=-Ikma9o/xpRfOma9JEEb2--

