Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265852AbTFSRQl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 13:16:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265853AbTFSRQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 13:16:37 -0400
Received: from adsl-67-124-159-170.dsl.pltn13.pacbell.net ([67.124.159.170]:2272
	"EHLO triplehelix.org") by vger.kernel.org with ESMTP
	id S265852AbTFSRQa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 13:16:30 -0400
Date: Thu, 19 Jun 2003 10:30:19 -0700
To: Magnus Solvang <magnus@solvang.net>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       kai.germaschewski@gmx.de, kkeil@suse.de
Subject: Re: isdn compile-errors (Linux 2.5.72)
Message-ID: <20030619173019.GA30548@triplehelix.org>
References: <20030619114807.GD3991@first.knowledge.no>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="A6N2fC+uXW/VQSAv"
Content-Disposition: inline
In-Reply-To: <20030619114807.GD3991@first.knowledge.no>
User-Agent: Mutt/1.5.4i
From: Joshua Kwan <joshk@triplehelix.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--A6N2fC+uXW/VQSAv
Content-Type: multipart/mixed; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline


--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 19, 2003 at 01:48:07PM +0200, Magnus Solvang wrote:
> drivers/isdn/i4l/isdn_tty.c: In function `isdn_tty_write':
> drivers/isdn/i4l/isdn_tty.c:1198: warning: unused variable `m'
*snip*
> drivers/isdn/i4l/isdn_tty.c: In function `isdn_tty_init':
> drivers/isdn/i4l/isdn_tty.c:2099: invalid type argument of `->'
> drivers/isdn/i4l/isdn_tty.c:2101: invalid type argument of `->'
> drivers/isdn/i4l/isdn_tty.c:2102: invalid type argument of `->'
*snip*
> drivers/isdn/i4l/isdn_tty.c: In function `isdn_tty_exit':
> drivers/isdn/i4l/isdn_tty.c:2121: invalid type argument of `->'
> drivers/isdn/i4l/isdn_tty.c:2122: invalid type argument of `->'
> drivers/isdn/i4l/isdn_tty.c:2123: invalid type argument of `->'

Attached patch should fix these, though I've not tested it.
(I hope I CC'd the right people.) Should apply against 2.5.72
vanilla.

-Josh

--=20
New PGP public key: 0x27AFC3EE

--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="isdn_not_pointer.patch"
Content-Transfer-Encoding: quoted-printable

diff -ur linux-2.5.72.v/drivers/isdn/i4l/isdn_tty.c linux/drivers/isdn/i4l/=
isdn_tty.c
--- linux-2.5.72.v/drivers/isdn/i4l/isdn_tty.c	2003-06-16 21:20:19.00000000=
0 -0700
+++ linux/drivers/isdn/i4l/isdn_tty.c	2003-06-19 10:26:13.000000000 -0700
@@ -1195,7 +1195,6 @@
 	int c;
 	int total =3D 0;
 	modem_info *info =3D (modem_info *) tty->driver_data;
-	atemu *m =3D &info->emu;
=20
 	if (isdn_tty_paranoia_check(info, tty->name, "isdn_tty_write"))
 		return 0;
@@ -2096,10 +2095,10 @@
 		kfree(info->xmit_buf - 4);
 	}
  err_unregister_tty:
-	tty_unregister_driver(&isdn_mdm->tty_modem);
+	tty_unregister_driver(&isdn_mdm.tty_modem);
  err:
-	put_tty_driver(&isdn_mdm->tty_modem);
-	isdn_mdm->tty_modem =3D NULL;
+	put_tty_driver(&isdn_mdm.tty_modem);
+	isdn_mdm.tty_modem =3D NULL;
 	return retval;
 }
=20
@@ -2118,9 +2117,9 @@
 #endif
 		kfree(info->xmit_buf - 4);
 	}
-	tty_unregister_driver(&isdn_mdm->tty_modem);
-	put_tty_driver(&isdn_mdm->tty_modem);
-	isdn_mdm->tty_modem =3D NULL;
+	tty_unregister_driver(&isdn_mdm.tty_modem);
+	put_tty_driver(&isdn_mdm.tty_modem);
+	isdn_mdm.tty_modem =3D NULL;
 }
=20
 /*

--r5Pyd7+fXNt84Ff3--

--A6N2fC+uXW/VQSAv
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+8fMrT2bz5yevw+4RAtFSAJ96LLsXCyXD0KBimXm5HJ+FvK3W9gCfSi0a
rExlhqnT3dyO7PkQ6Tqbk5I=
=jBqq
-----END PGP SIGNATURE-----

--A6N2fC+uXW/VQSAv--
