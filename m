Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262637AbUCKFfr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 00:35:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262658AbUCKFfr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 00:35:47 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:47238 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S262637AbUCKFfp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 00:35:45 -0500
Date: Thu, 11 Mar 2004 16:35:34 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       paulus@samba.org, linuxppc64-dev@lists.linuxppc.org
Subject: [PATCH] fix PPC64 iSeries virtual console devices
Message-Id: <20040311163534.7cef059b.sfr@canb.auug.org.au>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Thu__11_Mar_2004_16_35_34_+1100_g8prQScvDOdGyTWz"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Thu__11_Mar_2004_16_35_34_+1100_g8prQScvDOdGyTWz
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Hi Linus,

While playing with udev, I discovered that the virtual console
devices on iSeries had there minor numbers off by one i.e. /dev/tty1
was minor 2!

The following patch fixes this.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

diff -ruN 2.6.4/drivers/char/viocons.c 2.6.4.viocons/drivers/char/viocons.c
--- 2.6.4/drivers/char/viocons.c	2004-03-11 15:39:16.000000000 +1100
+++ 2.6.4.viocons/drivers/char/viocons.c	2004-03-11 16:06:46.000000000 +1100
@@ -1365,6 +1365,7 @@
 	viotty_driver->driver_name = "vioconsole";
 	viotty_driver->devfs_name = "vcs/";
 	viotty_driver->name = "tty";
+	viotty_driver->name_base = 1;
 	viotty_driver->major = TTY_MAJOR;
 	viotty_driver->minor_start = 1;
 	viotty_driver->type = TTY_DRIVER_TYPE_CONSOLE;

--Signature=_Thu__11_Mar_2004_16_35_34_+1100_g8prQScvDOdGyTWz
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAT/qrFG47PeJeR58RAqC8AKDDGQEdxDPeflRI0/A5w8gdS08QVwCgi2Xq
6amsMd4ELokTuF4WaXB6X54=
=m2Am
-----END PGP SIGNATURE-----

--Signature=_Thu__11_Mar_2004_16_35_34_+1100_g8prQScvDOdGyTWz--
