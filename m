Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268685AbUIXL37@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268685AbUIXL37 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 07:29:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268690AbUIXL37
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 07:29:59 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:18398 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id S268685AbUIXL3z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 07:29:55 -0400
Date: Fri, 24 Sep 2004 13:29:54 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Pawe?? Sikora <pluto@pld-linux.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: unresolved symbol __udivsi3_i4
Message-ID: <20040924112954.GI22710@lug-owl.de>
Mail-Followup-To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Pawe?? Sikora <pluto@pld-linux.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20040924021050.689.qmail@web53608.mail.yahoo.com> <200409240801.57848.pluto@pld-linux.org> <Pine.GSO.4.61.0409241031410.27692@waterleaf.sonytel.be> <20040924105207.GH22710@lug-owl.de> <Pine.GSO.4.61.0409241314530.27692@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="j/tBPq5EzcXNongx"
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.61.0409241314530.27692@waterleaf.sonytel.be>
X-Operating-System: Linux mail 2.6.8-rc4 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--j/tBPq5EzcXNongx
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-09-24 13:15:26 +0200, Geert Uytterhoeven <geert@linux-m68k.org>
wrote in message <Pine.GSO.4.61.0409241314530.27692@waterleaf.sonytel.be>:
> On Fri, 24 Sep 2004, Jan-Benedict Glaw wrote:
> > > > > unresolved symbol __udivsi3_i4
> > > > # objdump -T /lib/libgcc_s.so.1|grep div
> > > > 000024c0 g    DF .text  00000162  GLIBC_2.0   __divdi3
> > > > 00002b80 g    DF .text  000001ed  GCC_3.0     __udivmoddi4
> > > > 00002870 g    DF .text  00000120  GLIBC_2.0   __udivdi3
> > > >=20
> > > > you can link module with libgcc.a or fix it.
> > >=20
> > > Just add an implementation for __udivsi3_i4 to arch/sh/lib/. They alr=
eady have
> > > udivdi3.c over there.
> >=20
> > Either that (which I don't like!), or have a try compiling the kernel
>=20
> Why don't you like that? It's done that way on most architectures.

Well, the kernel is (or should be) a freestanding program, so it
shouldn't use *any* external code (and it doesn't, intentionally).
We're working hard not linking in libgcc.a (IIRC some archs actually do
that) (because eg. your compiler was compiled for i686-pc-linux-gnu, you
want to compile for a real i386 and end up with Pentium-alike code in
your i386 kernel).

So people started doing freestanding implementations of eg. __udivsi3 in
their kernel files. But why should they? GCC also could have emitted
inlined code to do that task, without ever calling an external function
for that.

However, this topic has been discussed several times with no real
resolution, so I guess we won't find a real cool solution this time,
too.

MfG, JBG (and greetings from Oldenburg!)

--=20
Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481             =
_ O _
"Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg  =
_ _ O
 fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Irak! =
  O O O
ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TCPA)=
);

--j/tBPq5EzcXNongx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFBVAUyHb1edYOZ4bsRAnlLAJ4mY7sRWmrFHaVX+JDr5CUoEz31kACffl+q
X30K6D6uKIB8qE8vuNMqzD4=
=MmqQ
-----END PGP SIGNATURE-----

--j/tBPq5EzcXNongx--
