Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318088AbSHHXHG>; Thu, 8 Aug 2002 19:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318092AbSHHXHG>; Thu, 8 Aug 2002 19:07:06 -0400
Received: from ppp-217-133-219-100.dialup.tiscali.it ([217.133.219.100]:40659
	"EHLO home.ldb.ods.org") by vger.kernel.org with ESMTP
	id <S318088AbSHHXHE>; Thu, 8 Aug 2002 19:07:04 -0400
Subject: Re: [PATCH] [2.5] asm-generic/atomic.h and changes to arm, parisc,
	mips, m68k, sh, cris to use it
From: Luca Barbieri <ldb@ldb.ods.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Roman Zippel <zippel@linux-m68k.org>,
       Linux-Kernel ML <linux-kernel@vger.kernel.org>
In-Reply-To: <1028851871.28883.126.camel@irongate.swansea.linux.org.uk>
References: <Pine.LNX.4.44.0208090018470.8911-100000@serv> 
	<1028846417.1669.95.camel@ldb> 
	<1028851871.28883.126.camel@irongate.swansea.linux.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-f/1FgwUEZgD7gXDm6Z0B"
X-Mailer: Ximian Evolution 1.0.5 
Date: 09 Aug 2002 01:09:52 +0200
Message-Id: <1028848192.19043.109.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-f/1FgwUEZgD7gXDm6Z0B
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Fri, 2002-08-09 at 02:11, Alan Cox wrote:
> On Thu, 2002-08-08 at 23:40, Luca Barbieri wrote:
> > > The compiler can cache the value in a register
> > It shouldn't since it is volatile and the machine has instructions with
> > memory operands.
> 
> I'm curious what part of C99 guarantees that it must generate
> 
> 	add 1 to memory
> 
> not
> 
> 	load memory
> 	add 1
> 	store memory
> 
> It certainly guarantees not to cache it for use next statement, but does
> it actually persuade the compiler to use direct operations on memory ?
> 
> I'm not a C99 language lawyer but genuinely curious
No, I don't claim it is standard behavior (I also don't claim it isn't
and unfortunately the C99 standard is not free so I cannot check it).

I just claim that if the value isn't going to be reused, using the
instruction with memory operands should be faster, because otherwise
there would have been little reason to include it in the instruction set
(except code size optimization, but it seems very unlikely that a CPU
would include CISC instructions just for that).
So a working GCC with optimization enabled should generate it and
especially should always generate it if it generates it in one
compilation (because of volatility).

Of course there is a risk of failure, but it seems small enough to not
worry about it unless there are other good reasons for the compiler to
behave differently.

However OTOH if it fails it would fail subtly so maybe it's better to do
it safely with inline assembly.


--=-f/1FgwUEZgD7gXDm6Z0B
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9UvpAdjkty3ft5+cRAvVpAJ9I7bp58/ScTOg4SsG+w6o52SvIYQCfUHjn
C1bynqRUUt4mBAE4f3OecFw=
=Jnwz
-----END PGP SIGNATURE-----

--=-f/1FgwUEZgD7gXDm6Z0B--
