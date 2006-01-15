Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750793AbWAOS7a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750793AbWAOS7a (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 13:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbWAOS7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 13:59:30 -0500
Received: from mx1.redhat.com ([66.187.233.31]:55262 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750793AbWAOS7a (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 13:59:30 -0500
Subject: Re: 2.6.15-rt4 failure with LATENCY_TRACE on x86_64
From: Clark Williams <williams@redhat.com>
To: Mikael Andersson <mikael@karett.se>
Cc: Steven Rostedt <rostedt@goodmis.org>, lkml <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <43C88833.9050107@karett.se>
References: <1137103652.11354.40.camel@localhost.localdomain>
	 <1137122280.7338.6.camel@localhost.localdomain>
	 <1137164761.3332.2.camel@localhost.localdomain>
	 <1137167679.7241.25.camel@localhost.localdomain>
	 <1137193088.3170.34.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0601131807350.10046@gandalf.stny.rr.com>
	 <43C88833.9050107@karett.se>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-t2iNG+9vXxq7sUELoqao"
Date: Sun, 15 Jan 2006 12:59:10 -0600
Message-Id: <1137351550.3627.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-t2iNG+9vXxq7sUELoqao
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Sat, 2006-01-14 at 06:12 +0100, Mikael Andersson wrote:
> Steven Rostedt wrote:
> > On Fri, 13 Jan 2006, Clark Williams wrote:
> >>Have you tried booting your system with a up kernel?
> >>
> > Not a x86_64 up.  But serveral up i386 boxes.
> >=20
>=20
> I had a very similar problem on a x86_64 up. I got a segfault in init=20
> with LATENCY_TRACE enabled on 2.6.15-rt2.
> I get it at ffffffff8010fe30, which should be mcount according to my=20
> System.map [1]. It seems a bit weird because i have tried to alter=20
> mcount somewhat. Initially by removing the initial comparison, but later
> i tried a few other things also. Nothing had any effect at all.

Glad to see that I'm not completely insane :).

>=20
> AFAIK glibc also has a mcount symbol, and it's almost as if ld.so would=20
> have linked the glibc mcount symbol to the kernel symbol mcount. That
> would naturally lead to a pagefault :)
>   And it would be consistent with the fact that statically linked shells
> works.
>=20
> It's probably something completely different, bevause that would be=20
> really weird. OTOH, it was really weird that i could change the asm for=20
> mcount in entry.S without any effect whatsoever.
>=20

Yeah, I don't really see how ld.so would know about the kernel mcount.
AFAIK it only knows about symbols exported from ELF libraries that it
has loaded in user space.=20

I'm still trying to figure out if LATENCY_TRACE could effect
do_execve(), since that's the routine that starts the init program. I'm
wondering if do_execve() is doing something that aggrevates ld.so, so
that it loads the program and/or libraries incorrectly.

Guess that's what I'll be doing Monday morning...

Clark

--=20
Clark Williams <williams@redhat.com>

--=-t2iNG+9vXxq7sUELoqao
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBDypt+Hyuj/+TTEp0RAmd5AJ9CR5wpHoGGLKpbvAFUG2+G8QkRuwCg4HWJ
qEM4kThjgKoRHWxuwfX14Ss=
=Mlrf
-----END PGP SIGNATURE-----

--=-t2iNG+9vXxq7sUELoqao--

