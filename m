Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266057AbTLISf2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 13:35:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266102AbTLISf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 13:35:28 -0500
Received: from null.rsn.bth.se ([194.47.142.3]:6865 "EHLO null.rsn.bth.se")
	by vger.kernel.org with ESMTP id S266057AbTLISfL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 13:35:11 -0500
Subject: Re: Kernelpanic in 2.43
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Ulrich Mensfeld <koalasoft@gmx.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <8zZPc72uGbB@koalasoft>
References: <8zZPc72uGbB@koalasoft>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-fyR8KEd66WlY7m1iCHkH"
Message-Id: <1070994906.813.18.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 09 Dec 2003 19:35:07 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-fyR8KEd66WlY7m1iCHkH
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2003-12-09 at 01:00, Ulrich Mensfeld wrote:
> Hallo,
> don't know, whom to adress.
>=20
> I've following problem: Every Linux-Kernel above 2.4.22 crashes with =20
> capslock and scrolllock blinking, nothing in the message-log, and all i =20
> can do is magic-sysreq and boot.
>=20
> The problem seems to be reproducable: It seems to occur, when my son want=
s =20
> to use my pc as a router to the internet. So for detail:
>=20
> My pc acts as a dsl-router  on "half"demand with packtfiltering and masq =
=20
> (ipchains) for 2 windows-pcs.
> "Half"demand means, my son has to make a "ping 10.0.0.2" to open an =20
> outgoing connection, to prevent a bunch of windows tools opening unwanted=
 =20
> connections using "DoD".

This is a known bug :(

you have three choices:

1. Switch to iptables instead of ipchains.

2. Use 2.4.23-bk instead.

3. Apply the patch below.

--- linux.old/net/ipv4/netfilter/ip_fw_compat_masq.c	2002-11-29 05:22:53.00=
0000000 +0530
+++ linux/net/ipv4/netfilter/ip_fw_compat_masq.c	2003-12-04 14:54:06.000000=
000 +0530
@@ -91,9 +91,6 @@
 			WRITE_UNLOCK(&ip_nat_lock);
 			return ret;
 		}
-
-		place_in_hashes(ct, info);
-		info->initialized =3D 1;
 	} else
 		DEBUGP("Masquerading already done on this conn.\n");
 	WRITE_UNLOCK(&ip_nat_lock);

--=20
/Martin

--=-fyR8KEd66WlY7m1iCHkH
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/1hXaWm2vlfa207ERAkaAAKCx40Mhtk+3HKzk51+shbpA9f1ftQCeLh3q
/VCPP9ncPZVYn7GNxEjKVio=
=gk1A
-----END PGP SIGNATURE-----

--=-fyR8KEd66WlY7m1iCHkH--
