Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264915AbTB0NKb>; Thu, 27 Feb 2003 08:10:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264919AbTB0NKa>; Thu, 27 Feb 2003 08:10:30 -0500
Received: from host217-36-80-42.in-addr.btopenworld.com ([217.36.80.42]:145
	"EHLO mail.dark.lan") by vger.kernel.org with ESMTP
	id <S264915AbTB0NK3>; Thu, 27 Feb 2003 08:10:29 -0500
Subject: Re: preventing route cache overflow
From: Gianni Tedesco <gianni@ecsc.co.uk>
To: Patrick Michael Kane <modus-linux-kernel@pr.es.to>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030227045017.A11619@pr.es.to>
References: <20030227045017.A11619@pr.es.to>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-M13JLEXiPKSMxcn8wMYU"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 27 Feb 2003 13:21:14 +0000
Message-Id: <1046352074.28559.20.camel@lemsip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-M13JLEXiPKSMxcn8wMYU
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Thu, 2003-02-27 at 12:50, Patrick Michael Kane wrote:
> We recently had a server come under attack.  Some script monkeys
> started generating a bunch of pings and SYNs from a huge variety of
> spoofed addresses (mostly in 43.0.0.0/8 and 44.0.0.0/8, for those that
> are interested).
>=20
> There were so many forged packets that the destination cache began to
> overflow hundreds or thousands of times per second ("kernel: dst cache
> overflow").  This had a huge negative impact on server performance.

Was this just syslog doing lots of write()+fsync() ? What kernel
version?

You should not get those messages that often in your logs, they should
be ratelimited:

linux-2.4.19/net/ipv4/route.c:598:
        if (net_ratelimit())
                printk(KERN_WARNING "dst cache overflow\n");

--=20
// Gianni Tedesco (gianni at scaramanga dot co dot uk)
lynx --source www.scaramanga.co.uk/gianni-at-ecsc.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D

--=-M13JLEXiPKSMxcn8wMYU
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA+XhDKkbV2aYZGvn0RAuu5AJ9xWDw9WveJzgoeaxN9W3ZsvbLwTQCfYaXl
pYYWRaUQWou39+mO7vLtikw=
=oFKu
-----END PGP SIGNATURE-----

--=-M13JLEXiPKSMxcn8wMYU--

