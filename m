Return-Path: <linux-kernel-owner+w=401wt.eu-S1750721AbXALL5i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750721AbXALL5i (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 06:57:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbXALL5i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 06:57:38 -0500
Received: from mail.phnxsoft.com ([195.227.45.4]:3254 "EHLO
	posthamster.phnxsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750721AbXALL5h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 06:57:37 -0500
Message-ID: <45A77726.2030605@imap.cc>
Date: Fri, 12 Jan 2007 12:55:18 +0100
From: Tilman Schmidt <tilman@imap.cc>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de-AT; rv:1.8.0.9) Gecko/20061211 SeaMonkey/1.0.7 Mnenhy/0.7.4.666
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Suparna Bhattacharya <suparna@in.ibm.com>
Subject: spurious sparse warnings from linux/aio.h (was: 2.6.20-rc4-mm1)
References: <20070111222627.66bb75ab.akpm@osdl.org>
In-Reply-To: <20070111222627.66bb75ab.akpm@osdl.org>
X-Enigmail-Version: 0.94.1.2
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig8990D71D67EA2E2F33C0407A"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8990D71D67EA2E2F33C0407A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Andrew Morton schrieb:
> - Merged the "filesystem AIO patches".

This construct:

> --- linux-2.6.20-rc4/include/linux/aio.h        2007-01-06 23:34:08.000=
000000 -0800
> +++ devel/include/linux/aio.h   2007-01-11 21:36:16.000000000 -0800

> @@ -237,7 +243,8 @@ do {                                               =
                         \
>         }                                                              =
 \
>  } while (0)
>=20
> -#define io_wait_to_kiocb(wait) container_of(wait, struct kiocb, ki_wai=
t)
> +#define io_wait_to_kiocb(io_wait) container_of(container_of(io_wait,  =
 \
> +       struct wait_bit_queue, wait), struct kiocb, ki_wait)
>=20
>  #include <linux/aio_abi.h>
>=20

causes a sparse warning:

> include/linux/sched.h:1313:29: warning: symbol '__mptr' shadows an earl=
ier one
> include/linux/sched.h:1313:29: originally declared here

for every source file referencing <linux/sched.h>.
Could that be avoided please?

Thanks
Tilman

--=20
Tilman Schmidt                    E-Mail: tilman@imap.cc
Bonn, Germany
Diese Nachricht besteht zu 100% aus wiederverwerteten Bits.
Unge=F6ffnet mindestens haltbar bis: (siehe R=FCckseite)


--------------enig8990D71D67EA2E2F33C0407A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (MingW32)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFFp3c1MdB4Whm86/kRAs4GAJ4y/tcPkBMCjM5RzN6K66x6LS4MFACfSYaO
CI+QH/GUSqGBcRRAWq/bwUs=
=TNRn
-----END PGP SIGNATURE-----

--------------enig8990D71D67EA2E2F33C0407A--
