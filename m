Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278470AbRKNX1B>; Wed, 14 Nov 2001 18:27:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278633AbRKNX0v>; Wed, 14 Nov 2001 18:26:51 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:30709 "EHLO MVista.COM")
	by vger.kernel.org with ESMTP id <S278470AbRKNX0j>;
	Wed, 14 Nov 2001 18:26:39 -0500
Date: Wed, 14 Nov 2001 15:26:56 -0800
From: Paul Mundt <pmundt@mvista.com>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, linux-fbdev-devel@lists.sourceforge.net
Subject: [PATCH] fb_mmap() holding BKL
Message-ID: <20011114152656.A31149@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XsQoSWH+UP9D9v3l"
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Organization: MontaVista Software, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--XsQoSWH+UP9D9v3l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

Just a minor cleanup.. in the event of some sanity checking in fb_mmap(), t=
he
BKL is accidentally held on a return.. this trivial patch fixes this issue.
(Against 2.4.14).

Please apply.

Regards,

--=20
Paul Mundt <pmundt@mvista.com>
MontaVista Software, Inc.

--- linux/drivers/video/fbmem.c.orig	Wed Nov 14 15:17:40 2001
+++ linux/drivers/video/fbmem.c	Wed Nov 14 15:17:50 2001
@@ -563,8 +563,10 @@
 		/* memory mapped io */
 		off -=3D len;
 		fb->fb_get_var(&var, PROC_CONSOLE(info), info);
-		if (var.accel_flags)
+		if (var.accel_flags) {
+			unlock_kernel();
 			return -EINVAL;
+		}
 		start =3D fix.mmio_start;
 		len =3D PAGE_ALIGN((start & ~PAGE_MASK)+fix.mmio_len);
 	}

--XsQoSWH+UP9D9v3l
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.5 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjvy/b8ACgkQYLvqhoOEA4G0CwCeNsBRQYsr3dXwSwlqf/iHRZ21
GGEAn35/tK2fLx0kahmhVxsq0+t+K7cL
=vpnb
-----END PGP SIGNATURE-----

--XsQoSWH+UP9D9v3l--
