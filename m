Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265747AbRGFBuI>; Thu, 5 Jul 2001 21:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265743AbRGFBt7>; Thu, 5 Jul 2001 21:49:59 -0400
Received: from admin.cgocable.net ([24.226.1.21]:27784 "EHLO
	admin.cgocable.net") by vger.kernel.org with ESMTP
	id <S265747AbRGFBtt>; Thu, 5 Jul 2001 21:49:49 -0400
Date: Thu, 5 Jul 2001 21:49:08 -0400
From: Michael Gold <mgold@scs.carleton.ca>
To: vojtech@suse.cz
Cc: linux-joystick@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: [PATCH] gamecon.c: Fix for SNES controllers
Message-ID: <20010705214908.B1943@linux.box>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nFreZHaLTZJo0R7j"
Content-Disposition: inline
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--nFreZHaLTZJo0R7j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In kernel 2.4.4, a change was made to gamecon.c that causes problems
with Super Nintendo controllers. The directional pad no longer works
correctly - only the up and left directions work. The following patch
fixes the problem by reversing the change. It applies cleanly to
kernels 2.4.4, 2.4.5, and 2.4.6.

--- linux-2.4.4-orig/drivers/char/joystick/gamecon.c	Wed Apr 11 22:02:30 20=
01
+++ linux-2.4.4/drivers/char/joystick/gamecon.c	Sat May 26 03:57:13 2001
@@ -345,8 +345,8 @@
 			s =3D gc_status_bit[i];
=20
 			if (s & (gc->pads[GC_NES] | gc->pads[GC_SNES])) {
-				input_report_abs(dev + i, ABS_X, ! - !(s & data[6]) - !(s & data[7]));
-				input_report_abs(dev + i, ABS_Y, ! - !(s & data[4]) - !(s & data[5]));
+				input_report_abs(dev + i, ABS_X, !!(s & data[7]) - !!(s & data[6]));
+				input_report_abs(dev + i, ABS_Y, !!(s & data[5]) - !!(s & data[4]));
 			}
=20
 			if (s & gc->pads[GC_NES])


--nFreZHaLTZJo0R7j
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjtFGRQACgkQ3Czq7jBypabXBACfWDbgpvadvGpFMneMfIZdyTZV
g7kAoIelUQSMNuErvIFXEDRkcEcTlMeF
=dpoH
-----END PGP SIGNATURE-----

--nFreZHaLTZJo0R7j--
