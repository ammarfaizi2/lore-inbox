Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932380AbVJ3WzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932380AbVJ3WzK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 17:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbVJ3WzK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 17:55:10 -0500
Received: from chilli.pcug.org.au ([203.10.76.44]:57527 "EHLO smtps.tip.net.au")
	by vger.kernel.org with ESMTP id S932380AbVJ3WzI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 17:55:08 -0500
Date: Mon, 31 Oct 2005 09:29:16 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Al Viro <viro@ftp.linux.org.uk>
Cc: alan@lxorguk.ukuu.org.uk, davej@redhat.com, kaos@ocs.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.14 assorted warnings
Message-Id: <20051031092916.249e88c9.sfr@canb.auug.org.au>
In-Reply-To: <20051030223204.GO7992@ftp.linux.org.uk>
References: <5455.1130484079@kao2.melbourne.sgi.com>
	<20051028073049.GA27389@redhat.com>
	<1130710531.32734.5.camel@localhost.localdomain>
	<20051030222543.GN7992@ftp.linux.org.uk>
	<20051030223204.GO7992@ftp.linux.org.uk>
X-Mailer: Sylpheed version 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Mon__31_Oct_2005_09_29_16_+1100_eeSP182YivZ5M.e="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Signature=_Mon__31_Oct_2005_09_29_16_+1100_eeSP182YivZ5M.e=
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Also, this test case:

------------------------------------------------------------
extern int f1(void);

static unsigned char f2(unsigned int *def)
{
	if (!f1())
		return 0;
	*def =3D 1;
	return 1;
}

unsigned char f3(unsigned char **eoc)
{
	unsigned int def;

	if (!f2(&def))
		return 0;
	if (def)
		*eoc =3D (unsigned char *)1;
	else
		*eoc =3D 0;
	return 1;
}

static int f4(unsigned int *def)
{
	if (!f1())
		return 0;
	*def =3D 1;
	return 1;
}

unsigned char f5(unsigned char **eoc)
{
	unsigned int def;

	if (!f4(&def))
		return 0;
	if (def)
		*eoc =3D (unsigned char *)1;
	else
		*eoc =3D 0;
	return 1;
}
------------------------------------------------------------

compiled with "gcc -Wall -O2" gives:
xx.c: In function 'f3':
xx.c:14: warning: 'def' may be used uninitialized in this function

but doesn't complain about the same code in f5.  The difference is that
f4 returns "int" while f2 returns "unsigned char".  This has apparently
been fixed in gcc mainline - the above comes from Debian unstables' gcc
(4.0.3 20051023 (prerelease) (Debian 4.0.2-3)).

Compiling with "gcc -Wall -O2 -fnoinline" suppresses the warning.

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Mon__31_Oct_2005_09_29_16_+1100_eeSP182YivZ5M.e=
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFDZUlFFdBgD/zoJvwRAh6kAKCSnb2PnoXYlhfEIx+adSro+oFCIgCfSUEB
re+TWH7od7s8Bksg+4IIyHM=
=a3AE
-----END PGP SIGNATURE-----

--Signature=_Mon__31_Oct_2005_09_29_16_+1100_eeSP182YivZ5M.e=--
