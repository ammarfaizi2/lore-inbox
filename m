Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263002AbUANTOz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 14:14:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262888AbUANTNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 14:13:50 -0500
Received: from smtp02.web.de ([217.72.192.151]:47367 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S262683AbUANTMh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 14:12:37 -0500
From: Thomas Schlichter <thomas.schlichter@web.de>
To: Andrew Morton <akpm@osdl.org>, Russell King <rmk+lkml@arm.linux.org.uk>
Subject: Re: 2.6.1-mm3
Date: Wed, 14 Jan 2004 20:12:01 +0100
User-Agent: KMail/1.5.4
References: <20040114014846.78e1a31b.akpm@osdl.org>
In-Reply-To: <20040114014846.78e1a31b.akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-03=_BSZBA6wgnbQ7Nx+";
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200401142012.01649.thomas.schlichter@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-03=_BSZBA6wgnbQ7Nx+
Content-Type: multipart/mixed;
  boundary="Boundary-01=_BSZBAjGzyMjP+7Y"
Content-Transfer-Encoding: 7bit
Content-Description: signed data
Content-Disposition: inline

--Boundary-01=_BSZBAjGzyMjP+7Y
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Description: body text
Content-Disposition: inline

Hi,

the patch "serial-03-fixups.patch" introduced following compile error:

  CC [M]  drivers/char/moxa.o
drivers/char/moxa.c: In function `moxa_tiocmget':
drivers/char/moxa.c:754: error: `port' undeclared (first use in this functi=
on)
drivers/char/moxa.c:754: error: (Each undeclared identifier is reported onl=
y=20
once
drivers/char/moxa.c:754: error: for each function it appears in.)
drivers/char/moxa.c: In function `moxa_tiocmset':
drivers/char/moxa.c:779: error: `port' undeclared (first use in this functi=
on)

The attached patch fixes it...

  Thomas Schlichter

--Boundary-01=_BSZBAjGzyMjP+7Y
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="fix_moxa.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline;
	filename="fix_moxa.diff"

=2D-- linux-2.6.1-mm3/drivers/char/moxa.c.orig	2004-01-14 19:04:43.66355645=
6 +0100
+++ linux-2.6.1-mm3/drivers/char/moxa.c	2004-01-14 19:18:54.179258416 +0100
@@ -749,6 +749,7 @@
 static int moxa_tiocmget(struct tty_struct *tty, struct file *file)
 {
 	struct moxa_str *ch =3D (struct moxa_str *) tty->driver_data;
+	register int port;
 	int flag =3D 0, dtr, rts;
=20
 	port =3D PORTNO(tty);
@@ -774,6 +775,7 @@
 			 unsigned int set, unsigned int clear)
 {
 	struct moxa_str *ch =3D (struct moxa_str *) tty->driver_data;
+	register int port;
 	int flag =3D 0, dtr, rts;
=20
 	port =3D PORTNO(tty);

--Boundary-01=_BSZBAjGzyMjP+7Y--

--Boundary-03=_BSZBA6wgnbQ7Nx+
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQBABZSBYAiN+WRIZzQRAuWUAJ4qm0CU+YUduhlQNYOyi+hqQO3rHACgivP/
zMK1aW1puz/8SeGKqr7c6JU=
=bm7N
-----END PGP SIGNATURE-----

--Boundary-03=_BSZBA6wgnbQ7Nx+--

