Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288963AbSA3IHp>; Wed, 30 Jan 2002 03:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288957AbSA3IHG>; Wed, 30 Jan 2002 03:07:06 -0500
Received: from point41.gts.donpac.ru ([213.59.116.41]:53266 "EHLO orbita1.ru")
	by vger.kernel.org with ESMTP id <S288956AbSA3IFw>;
	Wed, 30 Jan 2002 03:05:52 -0500
Date: Wed, 30 Jan 2002 11:09:28 +0300
From: Andrey Panin <pazke@orbita1.ru>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] fix sys_swapon() error handling in 2.5.2-dj6
Message-ID: <20020130110928.B251@pazke.ipt>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="w7PDEPdKQumQfZlR"
User-Agent: Mutt/1.0.1i
X-Uname: Linux pazke 2.4.13-ac7 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--w7PDEPdKQumQfZlR
Content-Type: multipart/mixed; boundary="Y7xTucakfITjPcLV"


--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable


Hi all,

error path in sys_swapon() can pass negative error code to filp_close()=20
which generates an oops, oneliner patch attached.

Best regards.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: wwwkeys.eu.pgp.net
--Y7xTucakfITjPcLV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-swapon

diff -urN -X /usr/dontdiff /linux.vanilla/mm/swapfile.c /linux/mm/swapfile.c
--- /linux.vanilla/mm/swapfile.c	Wed Jan 30 01:07:49 2002
+++ /linux/mm/swapfile.c	Tue Jan 29 21:23:46 2002
@@ -1073,7 +1073,7 @@
 	swap_list_unlock();
 	if (swap_map)
 		vfree(swap_map);
-	if (swap_file)
+	if (swap_file && !IS_ERR(swap_file))
 		filp_close(swap_file, NULL);
 out:
 	if (swap_header)

--Y7xTucakfITjPcLV--

--w7PDEPdKQumQfZlR
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.1 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8V6o4Bm4rlNOo3YgRAvsEAJ9HUqAA3SsN5MUu1sJs8+/eq55sAACeOYqr
1mf0FeQg0Ev117FpGsw760s=
=V0ca
-----END PGP SIGNATURE-----

--w7PDEPdKQumQfZlR--
