Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265725AbTAJS3x>; Fri, 10 Jan 2003 13:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265786AbTAJS2m>; Fri, 10 Jan 2003 13:28:42 -0500
Received: from [193.158.237.250] ([193.158.237.250]:26504 "EHLO
	mail.intergenia.de") by vger.kernel.org with ESMTP
	id <S265711AbTAJS0d>; Fri, 10 Jan 2003 13:26:33 -0500
Date: Fri, 10 Jan 2003 19:35:01 +0100
Message-Id: <200301101835.h0AIZ1B04255@mail.intergenia.de>
To: <200301101645.39535.dark_lkml@mymail.ro>
From: Gianni Tedesco <gianni@ecsc.co.uk>
Subject: Re: Kernel hooks just to get rid of copy_[to/from]_user() and [rescued]
CC: linux-kernel@vger.kernel.org
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

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

