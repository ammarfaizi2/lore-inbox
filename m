Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263388AbUAISnN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 13:43:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263173AbUAISlr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 13:41:47 -0500
Received: from smtp2.clear.net.nz ([203.97.37.27]:17072 "EHLO
	smtp2.clear.net.nz") by vger.kernel.org with ESMTP id S263130AbUAISkX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 13:40:23 -0500
Date: Sat, 10 Jan 2004 07:33:05 +1300
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Subject: PATCH 1/2: Make gotoxy & siblings use unsigned variables
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reply-to: ncunningham@users.sourceforge.net
Message-id: <1073672901.2069.15.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: multipart/signed; boundary="=-y4JHp6ZkmNdQkXgMuoNK";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-y4JHp6ZkmNdQkXgMuoNK
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

This patch makes console X and Y coordinates unsigned, rather than
signed. Issues with wide (> 128 char?) consoles, seen when developing
Software Suspend's 'nice display' are thus fixed. A brief examination of
related code showed that this use of signed variables was the exception
rather than the rule.

Regards,

Nigel

diff -ruN linux-2.6.1-rc3/drivers/char/vt.c console-patch-1/drivers/char/vt=
.c
--- linux-2.6.1-rc3/drivers/char/vt.c	2004-01-09 14:24:45.000000000 +1300
+++ console-patch-1/drivers/char/vt.c	2004-01-10 07:17:08.000000000 +1300
@@ -149,7 +149,7 @@
 static void vc_init(unsigned int console, unsigned int rows,
 		    unsigned int cols, int do_clear);
 static void blank_screen(unsigned long dummy);
-static void gotoxy(int currcons, int new_x, int new_y);
+static void gotoxy(int currcons, unsigned int new_x, unsigned int new_y);
 static void save_cur(int currcons);
 static void reset_terminal(int currcons, int do_clear);
 static void con_flush_chars(struct tty_struct *tty);
@@ -859,9 +859,9 @@
  * might also be negative. If the given position is out of
  * bounds, the cursor is placed at the nearest margin.
  */
-static void gotoxy(int currcons, int new_x, int new_y)
+static void gotoxy(int currcons, unsigned int new_x, unsigned int new_y)
 {
-	int min_y, max_y;
+	unsigned int min_y, max_y;
=20
 	if (new_x < 0)
 		x =3D 0;
@@ -888,7 +888,7 @@
 }
=20
 /* for absolute user moves, when decom is set */
-static void gotoxay(int currcons, int new_x, int new_y)
+static void gotoxay(int currcons, unsigned int new_x, unsigned int new_y)
 {
 	gotoxy(currcons, new_x, decom ? (top+new_y) : new_y);
 }
@@ -2996,13 +2996,13 @@
 	return screenpos(currcons, 2 * w_offset, viewed);
 }
=20
-void getconsxy(int currcons, char *p)
+void getconsxy(int currcons, unsigned char *p)
 {
 	p[0] =3D x;
 	p[1] =3D y;
 }
=20
-void putconsxy(int currcons, char *p)
+void putconsxy(int currcons, unsigned char *p)
 {
 	gotoxy(currcons, p[0], p[1]);
 	set_cursor(currcons);
diff -ruN linux-2.6.1-rc3/include/linux/selection.h console-patch-1/include=
/linux/selection.h
--- linux-2.6.1-rc3/include/linux/selection.h	2004-01-09 14:22:25.000000000=
 +1300
+++ console-patch-1/include/linux/selection.h	2004-01-10 07:17:08.000000000=
 +1300
@@ -36,8 +36,8 @@
 extern void complement_pos(int currcons, int offset);
 extern void invert_screen(int currcons, int offset, int count, int shift);
=20
-extern void getconsxy(int currcons, char *p);
-extern void putconsxy(int currcons, char *p);
+extern void getconsxy(int currcons, unsigned char *p);
+extern void putconsxy(int currcons, unsigned char *p);
=20
 extern u16 vcs_scr_readw(int currcons, const u16 *org);
 extern void vcs_scr_writew(int currcons, u16 val, u16 *org);

--=20
My work on Software Suspend is graciously brought to you by
LinuxFund.org.

--=-y4JHp6ZkmNdQkXgMuoNK
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA//vLEVfpQGcyBBWkRAj3CAKCdGWKGVk+3a4McINVPQpFZYWiHnACfexsi
7mQWTGEwhKv/R+MBBnivmLI=
=+etF
-----END PGP SIGNATURE-----

--=-y4JHp6ZkmNdQkXgMuoNK--

