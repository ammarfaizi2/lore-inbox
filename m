Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265969AbUAVIJ0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 03:09:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265983AbUAVIJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 03:09:25 -0500
Received: from smtp1.clear.net.nz ([203.97.33.27]:14316 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S265969AbUAVIJQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 03:09:16 -0500
Date: Thu, 22 Jan 2004 21:12:00 +1300
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Subject: PATCH: Export console functions for use by Software Suspend nice
	display
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Reply-to: ncunningham@users.sourceforge.net
Message-id: <1074757083.1943.37.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: multipart/signed; boundary="=-zzsKgz1cqSfHSf6eICdj";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zzsKgz1cqSfHSf6eICdj
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi.

Here's a second patch; this exports gotoxy, reset_terminal, hide_cursor,
getconsxy and putconsxy for use in Software Suspend's nice display.


diff -ruN linux-2.6.1/drivers/char/vt.c software-suspend-linux-2.6.1-rev3/d=
rivers/char/vt.c
--- linux-2.6.1/drivers/char/vt.c	2004-01-13 16:22:58.000000000 +1300
+++ software-suspend-linux-2.6.1-rev3/drivers/char/vt.c	2004-01-22 17:39:08=
.000000000 +1300
@@ -149,13 +149,13 @@
 static void vc_init(unsigned int console, unsigned int rows,
 		    unsigned int cols, int do_clear);
 static void blank_screen(unsigned long dummy);
-static void gotoxy(int currcons, int new_x, int new_y);
+void gotoxy(int currcons, int new_x, int new_y);
 static void save_cur(int currcons);
-static void reset_terminal(int currcons, int do_clear);
+void reset_terminal(int currcons, int do_clear);
 static void con_flush_chars(struct tty_struct *tty);
 static void set_vesa_blanking(unsigned long arg);
 static void set_cursor(int currcons);
-static void hide_cursor(int currcons);
+void hide_cursor(int currcons);
 static void unblank_screen_t(unsigned long dummy);
 static void console_callback(void *ignored);
=20
@@ -530,7 +530,7 @@
 		sw->con_putc(vc_cons[currcons].d, i, y, x);
 }
=20
-static void hide_cursor(int currcons)
+void hide_cursor(int currcons)
 {
 	if (currcons =3D=3D sel_cons)
 		clear_selection();
@@ -859,7 +859,7 @@
  * might also be negative. If the given position is out of
  * bounds, the cursor is placed at the nearest margin.
  */
-static void gotoxy(int currcons, int new_x, int new_y)
+void gotoxy(int currcons, int new_x, int new_y)
 {
 	int min_y, max_y;
=20
@@ -1403,7 +1403,7 @@
 	ESpalette };
=20
 /* console_sem is held (except via vc_init()) */
-static void reset_terminal(int currcons, int do_clear)
+void reset_terminal(int currcons, int do_clear)
 {
 	top		=3D 0;
 	bottom		=3D video_num_lines;
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

--=20
My work on Software Suspend is graciously brought to you by
LinuxFund.org.

--=-zzsKgz1cqSfHSf6eICdj
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQBAD33bVfpQGcyBBWkRAqYJAJ9+QuysArzGknU39VcfdmJuzryVCwCfa4aG
H/7NfExHZ4PRvOCZB1FQ3Jo=
=esGa
-----END PGP SIGNATURE-----

--=-zzsKgz1cqSfHSf6eICdj--

