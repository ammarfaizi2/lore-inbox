Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263130AbUAISnb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 13:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263173AbUAISnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 13:43:31 -0500
Received: from smtp1.clear.net.nz ([203.97.33.27]:34538 "EHLO
	smtp1.clear.net.nz") by vger.kernel.org with ESMTP id S263130AbUAISmf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 13:42:35 -0500
Date: Sat, 10 Jan 2004 07:33:15 +1300
From: Nigel Cunningham <ncunningham@users.sourceforge.net>
Subject: PATCH 2/2: Export console functions for use in Software Suspend.
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Reply-to: ncunningham@users.sourceforge.net
Message-id: <1073673182.2069.21.camel@laptop-linux>
MIME-version: 1.0
X-Mailer: Ximian Evolution 1.4.4-8mdk
Content-type: multipart/signed; boundary="=-zvJUVlCKbIQ/q2O5FXMw";
 protocol="application/pgp-signature"; micalg=pgp-sha1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-zvJUVlCKbIQ/q2O5FXMw
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi.

To implement a 'nice display' for Software Suspend, these functions
needed to be exported.

Regards,

Nigel

diff -ruN console-patch-1/drivers/char/vt.c console-patch-2/drivers/char/vt=
.c
--- console-patch-1/drivers/char/vt.c	2004-01-10 07:17:08.000000000 +1300
+++ console-patch-2/drivers/char/vt.c	2004-01-10 07:17:47.000000000 +1300
@@ -149,13 +149,13 @@
 static void vc_init(unsigned int console, unsigned int rows,
 		    unsigned int cols, int do_clear);
 static void blank_screen(unsigned long dummy);
-static void gotoxy(int currcons, unsigned int new_x, unsigned int new_y);
+void gotoxy(int currcons, unsigned int new_x, unsigned int new_y);
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
-static void gotoxy(int currcons, unsigned int new_x, unsigned int new_y)
+void gotoxy(int currcons, unsigned int new_x, unsigned int new_y)
 {
 	unsigned int min_y, max_y;
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
diff -ruN console-patch-1/include/linux/selection.h console-patch-2/include=
/linux/selection.h
--- console-patch-1/include/linux/selection.h	2004-01-10 07:17:08.000000000=
 +1300
+++ console-patch-2/include/linux/selection.h	2004-01-10 07:32:06.000000000=
 +1300
@@ -2,6 +2,7 @@
  * selection.h
  *
  * Interface between console.c, tty_io.c, vt.c, vc_screen.c and selection.=
c
+ * Also used by Software Suspend for its 'nice display'.
  */
=20
 #ifndef _LINUX_SELECTION_H_
@@ -42,4 +43,7 @@
 extern u16 vcs_scr_readw(int currcons, const u16 *org);
 extern void vcs_scr_writew(int currcons, u16 val, u16 *org);
=20
+extern void gotoxy(int currcons, unsigned int new_x, unsigned int new_y);
+extern void reset_terminal(int currcons, int do_clear);
+extern void hide_cursor(int currcons);
 #endif

--=20
My work on Software Suspend is graciously brought to you by
LinuxFund.org.

--=-zvJUVlCKbIQ/q2O5FXMw
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA//vPeVfpQGcyBBWkRApPKAJ0UXTyjyAQ+hEsRGd4gFb532cMJ7wCfe7KB
ZM1cERIcshLU2t/c8sQN1ns=
=vMnd
-----END PGP SIGNATURE-----

--=-zvJUVlCKbIQ/q2O5FXMw--

