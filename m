Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262249AbULMMsW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262249AbULMMsW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 07:48:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262246AbULMMrr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 07:47:47 -0500
Received: from macedonia.mhl.tuc.gr ([147.27.3.60]:18111 "HELO
	macedonia.mhl.tuc.gr") by vger.kernel.org with SMTP id S262248AbULMMpj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 07:45:39 -0500
Subject: PCI interrupt lost
From: Dimitris Lampridis <labis@mhl.tuc.gr>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-WKHnZLYPq1alcHw0pWMZ"
Date: Mon, 13 Dec 2004 14:45:33 +0200
Message-Id: <1102941933.3415.14.camel@naousa.mhl.tuc.gr>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-WKHnZLYPq1alcHw0pWMZ
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,
I'm writing a device driver for an embedded USB controller (philips
ISP116x). I'm using the evaluation board provided by philips for my
work. This board is a PCI board featuring the Host Controller ISP1160
and a PCI bridge by PLX.

The bad news (for me) is that I don't get to see any interrupts from my
device.=20

The good news is that I've managed to narrow down the problem. Here is
my case:
1) The Host Controller is configured and operating and is producing
interrupts (I used a logic Analyzer and saw it happening).
2) The driver never services these interrupts. The exact behaviour is
dictated by the "trigger" setting of the INT pin. If it is
edge-triggered, the interrupts keep on coming from the HC. If it is
level-triggered, only one interrupt happens and since it is never
serviced, it keeps on forever, blocking any further signals.
3) The driver IS ABLE to service interrupts. The ISR is installed and
functioning (I was able to see that, when the device was sharing the IRQ
and the ISR was called only to return IRQ_NONE, nevertheless showing
that IF an interrupt was to be received, coming from the Host
Controller, the routine would be called, thus clearing the interrupt on
the controller).

So, to make things short, my device is generating interrupts, my code
has a functioning and registered interrupt routine (/proc/interrupts
agrees as well but interrupt count is 0 for the specific IRQ), but no
interrupt is ever received from the PCI card.

What is wrong here? I'm having trouble coming with any new ideas, so I
thought that maybe someone can help me.
I would appreciate any help, please CC me personally as I'm not yet
subscribed to the list, or find me at the linux-usb-devel list.

Thanx in advance,
--=20
Dimitris Lampridis <labis@mhl.tuc.gr>

--=-WKHnZLYPq1alcHw0pWMZ
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBBvY7tgMArLfy6HHMRAlNaAKCEbUHui4JCAV3+LHNmstR1P73VgwCfXYPF
V7payg8tLrDpVFwlfWR/z0Y=
=9xN2
-----END PGP SIGNATURE-----

--=-WKHnZLYPq1alcHw0pWMZ--

