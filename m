Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130616AbRCFM3p>; Tue, 6 Mar 2001 07:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130636AbRCFM3f>; Tue, 6 Mar 2001 07:29:35 -0500
Received: from orbita.don.sitek.net ([213.24.25.98]:32786 "EHLO
	orbita.don.sitek.net") by vger.kernel.org with ESMTP
	id <S130616AbRCFM3Y>; Tue, 6 Mar 2001 07:29:24 -0500
Date: Tue, 6 Mar 2001 15:28:47 +0300
From: Andrey Panin <pazke@orbita.don.sitek.net>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] bug in /drivers/char/epca.c
Message-ID: <20010306152847.A30541@debian>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
User-Agent: Mutt/1.0.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--TRYliJ5NKNqkz5bu
Content-Type: multipart/mixed; boundary="+QahgC5+KEYLbs62"


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable


Hi all,

this patch fixes bug in Digi epca.c driver. This driver calls=20
tty_register_driver() 3 times and tty_unregister_driver() 2 times.=20
This bug causes hang on module unload.

Also a question: somebody knows why this driver scans PCI devices before
registering tty drivers? It makes impossible to remove panic() calls easily.

Best regards.

--=20
Andrey Panin            | Embedded systems software engineer
pazke@orbita1.ru        | PGP key: http://www.orbita1.ru/~pazke/AndreyPanin=
.asc
--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-epca
Content-Transfer-Encoding: quoted-printable

diff -ur linux.vanilla/drivers/char/epca.c linux/drivers/char/epca.c
--- linux.vanilla/drivers/char/epca.c	Mon Mar  5 12:01:51 2001
+++ linux/drivers/char/epca.c	Tue Mar  6 13:37:58 2001
@@ -1574,7 +1574,8 @@
 	cli();
=20
 	if ((tty_unregister_driver(&pc_driver)) || =20
-	    (tty_unregister_driver(&pc_callout)))
+	    (tty_unregister_driver(&pc_callout)) ||
+	    (tty_unregister_driver(&pc_info)))
 	{
 		printk(KERN_WARNING "<Error> - DIGI : cleanup_module failed to un-regist=
er tty driver\n");
 		restore_flags(flags);

--+QahgC5+KEYLbs62--

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.4 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE6pNf/Bm4rlNOo3YgRAvBFAJ4uct+jL010/p2aUda8CyDukdxPyQCdG3Jc
P2kT6gZpZOqnsxZ+/5yxu68=
=4CNU
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--
