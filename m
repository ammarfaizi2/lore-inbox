Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317473AbSHHMDG>; Thu, 8 Aug 2002 08:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317498AbSHHMDG>; Thu, 8 Aug 2002 08:03:06 -0400
Received: from coruscant.franken.de ([193.174.159.226]:21729 "EHLO
	coruscant.gnumonks.org") by vger.kernel.org with ESMTP
	id <S317473AbSHHMDF>; Thu, 8 Aug 2002 08:03:05 -0400
Date: Thu, 8 Aug 2002 14:06:32 +0200
From: Harald Welte <laforge@gnumonks.org>
To: Andi Kleen <ak@suse.de>
Cc: David Miller <davem@redhat.com>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix HIPQUAD macro in kernel.h
Message-ID: <20020808140632.I11828@sunbeam.de.gnumonks.org>
References: <20020808133112.E11828@sunbeam.de.gnumonks.org> <20020808134113.A2552@wotan.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tB3UQx9o7itSJcWB"
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20020808134113.A2552@wotan.suse.de>; from ak@suse.de on Thu, Aug 08, 2002 at 01:41:13PM +0200
X-Operating-System: Linux sunbeam.de.gnumonks.org 2.4.19-pre10-newnat-pptp
X-Date: Today is Boomtime, the 71st day of Confusion in the YOLD 3168
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tB3UQx9o7itSJcWB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 08, 2002 at 01:41:13PM +0200, Andi Kleen wrote:
> On Thu, Aug 08, 2002 at 01:31:12PM +0200, Harald Welte wrote:
> > Hi Dave!
> >=20
> > Below is a fix for the HIPQUAD macro in kernel.h.  The macro is current=
ly
> > not endian-aware - it just assumes running on a little-endian machine.
> >=20
> > If you don't like the #ifdefs in kernel.h, the macros could be moved in=
to=20
> > include/linux/byteorder/.
> >=20
> > Please apply, thanks
>=20
> That change is wrong. IP address should be always in network order (=3DBE=
)=20
> while in kernel.

well, there is for example a short codepath in ip_conntrack_irc.c, where
the ip address is parsed from the packet payload (after which it is present
in host byte order).  Before it is written to the apropriate data structure=
s,
we convert it to network byte order.  And just before this happens,
there are debug printk's which use HIPQUAD.

What is the point of providing two macros (HIPQUAD and NIPQUAD), if
one of them does only work on little-endian.  I would understand your point
if th HIPQUAD macro wasn't present at all (and only NIPQUAD existed).

I assumed that NIPQUAD does parse an ip address in network byte order,
and HIPQUAD in host byte order.  If they are really meant for little or
big endian, they should be renamed to BEIPQUAD and LEIPQUAD.

> -Andi

--=20
Live long and prosper
- Harald Welte / laforge@gnumonks.org               http://www.gnumonks.org/
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
GCS/E/IT d- s-: a-- C+++ UL++++$ P+++ L++++$ E--- W- N++ o? K- w--- O- M+=
=20
V-- PS++ PE-- Y++ PGP++ t+ 5-- !X !R tv-- b+++ !DI !D G+ e* h--- r++ y+(*)

--tB3UQx9o7itSJcWB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE9Ul7IXaXGVTD0i/8RAl0ZAJ9s9rJCx2NuiYpt/xG+mYgZIgHAFACfZoLi
kyE0bvhAyI0FaZO8ENYQYwk=
=HTLa
-----END PGP SIGNATURE-----

--tB3UQx9o7itSJcWB--
