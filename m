Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262901AbUANTNR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 14:13:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262446AbUANTMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 14:12:47 -0500
Received: from smtp04.web.de ([217.72.192.208]:36123 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S262360AbUANTMb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 14:12:31 -0500
From: Thomas Schlichter <thomas.schlichter@web.de>
To: Andrew Morton <akpm@osdl.org>, Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: 2.6.1-mm3
Date: Wed, 14 Jan 2004 20:12:11 +0100
User-Agent: KMail/1.5.4
References: <20040114014846.78e1a31b.akpm@osdl.org>
In-Reply-To: <20040114014846.78e1a31b.akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-03=_LSZBAxZen3YomyA";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200401142012.11502.thomas.schlichter@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-03=_LSZBAxZen3YomyA
Content-Type: multipart/mixed;
  boundary="Boundary-01=_LSZBA4sEKkjGIfg"
Content-Transfer-Encoding: 7bit
Content-Description: signed data
Content-Disposition: inline

--Boundary-01=_LSZBA4sEKkjGIfg
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: body text
Content-Disposition: inline

Hi,

the patch "serial-02-fixups.patch" introduced following compile error:

  CC [M]  drivers/char/sx.o
drivers/char/sx.c: In function `sx_tiocmset':
drivers/char/sx.c:1761: error: `dtr' undeclared (first use in this function)
drivers/char/sx.c:1761: error: (Each undeclared identifier is reported only=
=20
once
drivers/char/sx.c:1761: error: for each function it appears in.)
drivers/char/sx.c:1756: Warnung: unused variable `cts'

The attached patch fixes it...

   Thomas Schlichter

--Boundary-01=_LSZBA4sEKkjGIfg
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="fix_sx.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="fix_sx.diff"

=2D-- linux-2.6.1-mm3/drivers/char/sx.c.orig	2004-01-14 19:33:13.367641928 =
+0100
+++ linux-2.6.1-mm3/drivers/char/sx.c	2004-01-14 19:35:06.915380048 +0100
@@ -1753,7 +1753,7 @@
 		       unsigned int set, unsigned int clear)
 {
 	struct sx_port *port =3D tty->driver_data;
=2D	int rts =3D -1, cts =3D -1;
+	int rts =3D -1, dtr =3D -1;
=20
 	if (set & TIOCM_RTS)
 		rts =3D 1;

--Boundary-01=_LSZBA4sEKkjGIfg--

--Boundary-03=_LSZBAxZen3YomyA
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQBABZSLYAiN+WRIZzQRAkd+AJ4lxVZpTOIX51TM2LEuwwbcsDk/0wCfYgF4
dvd+Ne3viYkF7jSL1mI+s1w=
=WwN/
-----END PGP SIGNATURE-----

--Boundary-03=_LSZBAxZen3YomyA--

