Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262652AbVAPX4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbVAPX4x (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 18:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262653AbVAPX4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 18:56:52 -0500
Received: from note.orchestra.cse.unsw.EDU.AU ([129.94.242.24]:44754 "EHLO
	note.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with ESMTP
	id S262652AbVAPX4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 18:56:47 -0500
From: Ian Wienand <ianw@gelato.unsw.edu.au>
To: mingo@elte.hu, linux-kernel@vger.kernel.org
Date: Mon, 17 Jan 2005 10:56:37 +1100
Subject: Typo in BUILD_LOCK_OPS in spinlock.c causes preempt build failure
Message-ID: <20050116235637.GD20009@cse.unsw.EDU.AU>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AbQceqfdZEv+FvjW"
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--AbQceqfdZEv+FvjW
Content-Type: multipart/mixed; boundary="B4IIlcmfBL/1gGOG"
Content-Disposition: inline


--B4IIlcmfBL/1gGOG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Our auto kernel build (http://www.gelato.unsw.edu.au/kerncomp/) was
dying with preempt turned on with latest BK; BUILD_LOCK_OPS is using a
spinlock function for a rwlock.

Thanks,

-i
ianw@gelato.unsw.edu.au
http://www.gelato.unsw.edu.au

--B4IIlcmfBL/1gGOG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="spinlock.c.diff"

===== kernel/spinlock.c 1.4 vs edited =====
--- 1.4/kernel/spinlock.c	2005-01-15 11:00:00 +11:00
+++ edited/kernel/spinlock.c	2005-01-17 10:43:44 +11:00
@@ -248,7 +248,7 @@
  */
 BUILD_LOCK_OPS(spin, spinlock_t, spin_is_locked);
 BUILD_LOCK_OPS(read, rwlock_t, rwlock_is_locked);
-BUILD_LOCK_OPS(write, rwlock_t, spin_is_locked);
+BUILD_LOCK_OPS(write, rwlock_t, rwlock_is_locked);
 
 #endif /* CONFIG_PREEMPT */
 

--B4IIlcmfBL/1gGOG--

--AbQceqfdZEv+FvjW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFB6v81WDlSU/gp6ecRAjQDAKDnEVOPwADYb9pqRpZeRYo7uCah5ACfaVAh
YW3uZ41zmVeIzZUTyV2+tFY=
=sNc4
-----END PGP SIGNATURE-----

--AbQceqfdZEv+FvjW--
