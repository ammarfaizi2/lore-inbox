Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264446AbTLVRZE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 12:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264445AbTLVRZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 12:25:04 -0500
Received: from zero.voxel.net ([209.123.232.253]:45548 "EHLO zero.voxel.net")
	by vger.kernel.org with ESMTP id S264446AbTLVRY7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 12:24:59 -0500
Subject: Re: [PATCH] CONFIG_PCMCIA_PROBE fix
From: Andres Salomon <dilinger@voxel.net>
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <20031222094829.B13978@flint.arm.linux.org.uk>
References: <1072072123.27831.6.camel@spiral.internal>
	 <20031222094829.B13978@flint.arm.linux.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-7joWsOV6Rkpy+aX3FN3B"
Message-Id: <1072113521.919.6.camel@spiral.internal>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 22 Dec 2003 12:18:42 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-7joWsOV6Rkpy+aX3FN3B
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2003-12-22 at 04:48, Russell King wrote:
> On Mon, Dec 22, 2003 at 12:48:44AM -0500, Andres Salomon wrote:
> > Some time ago, Russell King submitted a patch to use CONFIG_PCMCIA_PROB=
E
> > instead of CONFIG_ISA in pcmcia probing code.  Unfortunately,
> > CONFIG_PCMCIA_PROBE still is only set if CONFIG_ISA is set.  This means
> > that if ISA isn't enabled, certain things break in 2.6; for example, my
> > pcmcia nic/modem (using pcnet_cs/serial_cs).  These worked fine in 2.4;
> > I tracked the behavior to the fact that if irq_mask is set on a pcmcia
> > socket (instead of pci_irq), and PCMCIA_PROBE isn't set,
> > pcmcia_request_irq refuses to assign an irq.  Most of the pcmcia bridge=
s
> > appear to set an irq_mask, so the attached patch changes Kconfig to set
> > CONFIG_PCMCIA_PROBE if any of those bridges are selected.
> >=20
> > Please apply this (or an alternative fix), as it fixes a 2.6 regression
> > in pcmcia functionality.
>=20
> Please don't.  David Hinds has a better fix for this, which changes
> the way we handle the allocation of IRQs.  David's change is all
> round a far better way to handle the problem - if all ISA interrupts
> are used or unavailable, we fall back to using the PCI interrupt
> instead.
>=20
> Please also note that there /is/ a PCMCIA list which patches should
> be forwarded to - linux-pcmcia which is at lists.infradead.org

Please put the list in the MAINTAINERS file; right now,=20
linux-kernel@vger.kernel.org is listed as the relevant list.



--=-7joWsOV6Rkpy+aX3FN3B
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/5ydw78o9R9NraMQRAj9vAJ9Rr/bzmCEvx3ccB74EZradQsSuUwCcCrd/
WmkFEVJJxCg2LeUXRdkbFYQ=
=xnJu
-----END PGP SIGNATURE-----

--=-7joWsOV6Rkpy+aX3FN3B--

