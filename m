Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262918AbTI2JHZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Sep 2003 05:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262921AbTI2JHZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Sep 2003 05:07:25 -0400
Received: from smtp.actcom.co.il ([192.114.47.13]:50861 "EHLO
	smtp1.actcom.net.il") by vger.kernel.org with ESMTP id S262918AbTI2JHX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Sep 2003 05:07:23 -0400
Date: Mon, 29 Sep 2003 12:06:30 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Jamie Lokier <jamie@shareable.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] document optimizing macro for translating PROT_ to VM_ bits
Message-ID: <20030929090629.GF29313@actcom.co.il>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tmoQ0UElFV5VgXgH"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tmoQ0UElFV5VgXgH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In continuation to the thread at
http://marc.theaimsgroup.com/?l=3Dlinux-kernel&m=3D3D106270456516176&w=3D2 =
wrt
translating PROT_(censored) bits to VM_(censored) bits, here's a small
comment only patch to document the optimizing macro Jamie's patch
used. Against 2.6.0-t6, but should apply to anything
recent. Compiles.

Cheers,
Muli

--- linux-2.5/include/linux/mman.h	Sun Sep  7 10:05:18 2003
+++ optimizing-macro-2.6.0-t6/include/linux/mman.h	Mon Sep 29 11:53:12 2003
@@ -28,7 +28,10 @@
 	vm_acct_memory(-pages);
 }
=20
-/* Optimisation macro. */
+/* Optimisation macro, used to be defined as: */
+/* ((bit1 =3D=3D bit2) ? (x & bit1) : (x & bit1) ? bit2 : 0) */=20
+/* but this version is faster */=20
+/* "check if bit1 is on in 'x'. If it is, return bit2" */=20
 #define _calc_vm_trans(x,bit1,bit2) \
   ((bit1) <=3D (bit2) ? ((x) & (bit1)) * ((bit2) / (bit1)) \
    : ((x) & (bit1)) / ((bit1) / (bit2)))

--=20
Muli Ben-Yehuda
http://www.mulix.org


--tmoQ0UElFV5VgXgH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/d/YUKRs727/VN8sRAmmfAJ0YIsQgNTIdLimz/XWwtnSjeI7BXQCgtcl9
4zQvADs2Xhb3QWlZMiCX7eU=
=fnIn
-----END PGP SIGNATURE-----

--tmoQ0UElFV5VgXgH--
