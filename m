Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261812AbTLLTAV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 14:00:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261827AbTLLTAV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 14:00:21 -0500
Received: from fed1mtao02.cox.net ([68.6.19.243]:40141 "EHLO
	fed1mtao02.cox.net") by vger.kernel.org with ESMTP id S261812AbTLLTAO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 14:00:14 -0500
Date: Fri, 12 Dec 2003 12:00:12 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Russell King <rmk@arm.linux.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Fix a problem with 8250 UARTs on PPC
Message-ID: <20031212190012.GT23731@stop.crashing.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello.  As part of the patch I sent that went into 2.6.0-test7 (Nat Semi
SuperI/O chips on PPCs at least have a number of different divisors),
the following should have been done as well, but wasn't.  If we don't
change the divisor, we don't want to change what we claim as the uart
clock either.  Without this I don't get a usable serial console on my
Motorola Sandpoint.

--- 1.41/drivers/serial/8250.c	Tue Oct 21 22:10:07 2003
+++ edited/drivers/serial/8250.c	Fri Dec 12 11:57:13 2003
@@ -530,10 +530,10 @@
 			status1 |=3D 0x10;  /* 1.625 divisor for baud_base --> 921600 */
 			serial_outp(up, 0x04, status1);
 			serial_outp(up, UART_LCR, 0);
+			up->port.uartclk =3D 921600*16;
 #endif
=20
 			up->port.type =3D PORT_NS16550A;
-			up->port.uartclk =3D 921600*16;
 			return;
 		}
 	}

--=20
Tom Rini
http://gate.crashing.org/~trini/

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/2hA8dZngf2G4WwMRApl/AJ9D49bf/1KBC1EUfoC30e5XdOAffACbBixn
cwxK6GlzVWqvBHE0iAijE4k=
=nkS3
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
