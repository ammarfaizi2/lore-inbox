Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266379AbUAIBit (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 20:38:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266399AbUAIBit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 20:38:49 -0500
Received: from 216-229-91-229-empty.fidnet.com ([216.229.91.229]:50187 "EHLO
	mail.icequake.net") by vger.kernel.org with ESMTP id S266379AbUAIBiU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 20:38:20 -0500
Date: Thu, 8 Jan 2004 19:38:18 -0600
From: Ryan Underwood <nemesis-lists@icequake.net>
To: "Richard B. Johnson" <root@chaos.analogic.com>
Cc: Ryan Underwood <nemesis-lists@icequake.net>,
       Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: PCI parport irq sharing?
Message-ID: <20040109013818.GB26519@dbz.icequake.net>
Mail-Followup-To: "Richard B. Johnson" <root@chaos.analogic.com>,
	Ryan Underwood <nemesis-lists@icequake.net>,
	Linux kernel <linux-kernel@vger.kernel.org>
References: <20040108181615.GA20930@dbz.icequake.net> <Pine.LNX.4.53.0401081340240.25165@chaos>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1LKvkjL3sHcu1TtY"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.53.0401081340240.25165@chaos>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--1LKvkjL3sHcu1TtY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 08, 2004 at 02:08:19PM -0500, Richard B. Johnson wrote:
> >
> > parport0: PC-style at 0x3bc (0x7bc), irq 7, dma 3 [PCSPP,TRISTATE,COMPA=
T,ECP,DMA]
> > parport1: PC-style at 0xc400 (0xc800), irq 9, using FIFO [PCSPP,TRISTAT=
E,COMPAT,ECP]
> > parport1: irq 9 in use, resorting to polled operation
> > parport2: PC-style at 0xcc00 (0xd000) [PCSPP,TRISTATE]
> >
> > parport0 is the mb's builtin parallel port, and parport1/parport2 are
> > the two ports on the PCI card.  IRQ 9 is taken by USB already.  But
> > since it's a modern PCI card, it would stand to reason that it should be
> > able to share the IRQ with another PCI device, no?  Unfortunately, my
> > application requires interrupt-driven operation.
>=20
> To share interrupts requires that the interrupting device
> generate a level instead of an edge. The parallel ports
> that exist in "super I/O chips" and in bare boards, produce
> edges. If you have a special parallel port in a PCI slot, it
> should generate levels because the PCI specification demands
> that it does.
>=20
> Since IRQ7 (the dedicated, edge, ISA parallel port interrupt)
> should never go to any PCI slot, I don't see how it could
> ever report using that. Perhaps it's a bug or the BIOS allowed
> it to be configured that way (remove IRQ7 from the PCI bus).
> This should make something else show up on the PCI bus.
> Move the board to another slot and see if the shared problem
> still remains.

We might have talked past each other here.  The IRQ7 is okay, because
that's the motherboard's super I/O chip.  The PCI parallel card is
allocated IRQ9, which shares with USB and ACPI.  However, the parport_pc
driver doesn't seem to realize this is a PCI card and can share
interrupts, hence the "irq %d in use, resorting to polled..."  Worse,
even if I find a free IRQ, I still can't use both the PCI card's
parallel ports in interrupt-driven operation; as soon as one parport_pc
is enabled on that IRQ, then the second parport can't use that IRQ
anymore.  Like the board is conflicting with itself....

My question was whether or not IRQ sharing was possible with the basic
parport driver or not.  If not, would something like parport_serial help
me out here?  Though, this is a NetMos card:

00:08.0 Communication controller: NetMos Technology VScom 021H-EP2 2 port p=
arallel adaptor (rev 01)

and I don't think NetMos support has made it into parport_serial yet.

thanks,

--=20
Ryan Underwood, <nemesis@icequake.net>

--1LKvkjL3sHcu1TtY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQE//gYKIonHnh+67jkRAljtAJ9lgoivTYhcehsN1b72KT5V5l8jiACfZEBC
ROo7rWrpr/4IlXbyc3sYMI4=
=nTU1
-----END PGP SIGNATURE-----

--1LKvkjL3sHcu1TtY--
