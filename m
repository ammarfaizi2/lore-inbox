Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262289AbSJJKc3>; Thu, 10 Oct 2002 06:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262290AbSJJKc3>; Thu, 10 Oct 2002 06:32:29 -0400
Received: from host213-121-110-54.in-addr.btopenworld.com ([213.121.110.54]:54433
	"EHLO mail.dark.lan") by vger.kernel.org with ESMTP
	id <S262289AbSJJKc2>; Thu, 10 Oct 2002 06:32:28 -0400
Subject: Re: [patch] tcp connection tracking 2.4.19
From: Gianni Tedesco <gianni@ecsc.co.uk>
To: Roberto Nibali <ratz@drugphish.ch>
Cc: Martin Renold <martinxyz@gmx.ch>, linux-kernel@vger.kernel.org
In-Reply-To: <3DA4668A.5070501@drugphish.ch>
References: <20021008205053.GA2621@old.homeip.net>
	 <3DA348EF.7060709@drugphish.ch> <1034166655.30384.13.camel@lemsip>
	 <3DA4668A.5070501@drugphish.ch>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-LTL0rdnx7bNXkjbQHNR0"
Organization: 
Message-Id: <1034246310.1489.74.camel@lemsip>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.1.99 (Preview Release)
Date: 10 Oct 2002 11:38:30 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-LTL0rdnx7bNXkjbQHNR0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2002-10-09 at 18:25, Roberto Nibali wrote:
> Hi,
>=20
> > "When syncookies are enabled the packets are still answered  and  this
> > value [tcp_max_syn_backlog] is effectively ignored." -- From tcp(7)
> > manpage.
>=20
> Fair enough. I thought that last time I checked with the code the SYN=20
> cookie functionality would only kick in _after_ the backlog queue is full=
.

It does. When using syn cookies you cant use some of the new advanced
features of tcp. Linux uses the backlog queue when not under attack.
When the queue overflows it just uses cookies - but can still accept
connections.

> > The whole point of syncookies is to negate the need for a backlog queue=
.
>=20
> Well, after a successful match of the MSS encoded part or the cookie,=20
> you add it back to the SYN queue. But yes, the backlog queue is indeed=20
> omited.
>=20
> > Or did I miss your point?
>=20
> Well, my point should have been stated more clearly. It is simply that=20
> SYN cookies do not prevent you from being SYN flooded. They provide you,=20
> from a user perspective view, a mean to still be able to log in onto=20
> your server under a SYN flood because you will send legitimate ACKs and=20
> because your connection will not be dropped.
>=20
> It doesn't prevent SYN flooding, although I just checked back with=20
> ../Documentation/networking/ip-sysctrl.txt:
> [snip]
> tcp_abort_on_overflow.
>          syncookies seriously violate TCP protocol, do not allow
>          to use TCP extensions, can result in serious degradation
>          of some services (f.e. SMTP relaying), visible not by you,
>          but your clients and relays, contacting you. While you see
>          synflood warnings in logs not being really flooded, your server
>          is seriously misconfigured.

I don't think these statements are entirely true. While it is true that
you can't use things like window scaling or SACK - syncookies 100%
successfully stop syn flood attacks.

The attack is that if you fill the syn backlog queue with bogus requests
then legitimate clients can no longer connect. The syn flood attack
isn't "your legitimate connections wont be able to use window scaling".

--=20
// Gianni Tedesco (gianni at ecsc dot co dot uk)
lynx --source www.scaramanga.co.uk/gianni-at-ecsc.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D

--=-LTL0rdnx7bNXkjbQHNR0
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA9pVilkbV2aYZGvn0RAjeRAJ4qqT/Wt7RNy3wnVgnneEt/G0+P1ACfXjqN
X1ew/ix80I9R+Z9CeRxzfNM=
=fVL9
-----END PGP SIGNATURE-----

--=-LTL0rdnx7bNXkjbQHNR0--

