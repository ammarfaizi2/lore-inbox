Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265198AbTAJPUc>; Fri, 10 Jan 2003 10:20:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265201AbTAJPUc>; Fri, 10 Jan 2003 10:20:32 -0500
Received: from host217-36-81-41.in-addr.btopenworld.com ([217.36.81.41]:30664
	"EHLO mail.dark.lan") by vger.kernel.org with ESMTP
	id <S265198AbTAJPU2>; Fri, 10 Jan 2003 10:20:28 -0500
Subject: Re: Kernel hooks just to get rid of copy_[to/from]_user() and
	syscall overhead?
From: Gianni Tedesco <gianni@ecsc.co.uk>
To: Mihnea Balta <dark_lkml@mymail.ro>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200301101645.39535.dark_lkml@mymail.ro>
References: <200301101645.39535.dark_lkml@mymail.ro>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-BV3ZPaNC+ZVYC1KynZll"
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 10 Jan 2003 15:31:06 +0000
Message-Id: <1042212666.21822.32.camel@lemsip>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-BV3ZPaNC+ZVYC1KynZll
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2003-01-10 at 14:45, Mihnea Balta wrote:
> Hi,
>=20
> I have to implement a system which grabs udp packets off a gigabit connec=
tion,=20
> take some basic action based on what they contain, repack their data with=
 a=20
> custom protocol header and send them through a gigabit ethernet interface=
 on=20
> broadcast.
>=20
> I know how to do this in userspace, but I need to know if doing everyting=
 in=20
> the kernel would show a considerable speed improvement due to removing=20
> syscall and memory copy overhead. The system will be quite stressed, havi=
ng=20
> to deal with around 15-20000 packets/second.

mmap() packet socket interface eliminates the need for system calls when
traffic is coming in at a high rate.  The kernel -> user copy is also
eliminated, but its just replaced with a kernel -> kernel copy :P

You could perhaps also use linux socket filters to minimize the number
of packets you need to evaluate...

Check out this sample code: http://www.scaramanga.co.uk/code-fu/lincap.c

HTH

--=20
// Gianni Tedesco (gianni at scaramanga dot co dot uk)
lynx --source www.scaramanga.co.uk/gianni-at-ecsc.asc | gpg --import
8646BE7D: 6D9F 2287 870E A2C9 8F60 3A3C 91B5 7669 8646 BE7D

--=-BV3ZPaNC+ZVYC1KynZll
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA+Huc6kbV2aYZGvn0RAgMyAJ9k8b5dBs0pDKKxGcYcpRF4q38eTwCeMwSA
JK7JWpSaYKsenks8H4jXzQk=
=pfqa
-----END PGP SIGNATURE-----

--=-BV3ZPaNC+ZVYC1KynZll--

