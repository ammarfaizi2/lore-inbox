Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318007AbSHLNjR>; Mon, 12 Aug 2002 09:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318009AbSHLNjR>; Mon, 12 Aug 2002 09:39:17 -0400
Received: from ppp-217-133-217-5.dialup.tiscali.it ([217.133.217.5]:18580 "EHLO
	home.ldb.ods.org") by vger.kernel.org with ESMTP id <S318007AbSHLNjR>;
	Mon, 12 Aug 2002 09:39:17 -0400
Subject: Re: [patch] tls-2.5.31-C3
From: Luca Barbieri <ldb@ldb.ods.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux-Kernel ML <linux-kernel@vger.kernel.org>,
       Alexandre Julliard <julliard@winehq.com>
In-Reply-To: <Pine.LNX.4.44.0208121708050.19150-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0208121708050.19150-100000@localhost.localdomain>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-HhJYdyLdCSo1waA0JRc0"
X-Mailer: Ximian Evolution 1.0.5 
Date: 12 Aug 2002 15:43:01 +0200
Message-Id: <1029159781.4713.52.camel@ldb>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-HhJYdyLdCSo1waA0JRc0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2002-08-12 at 17:12, Ingo Molnar wrote:
> 
> On 12 Aug 2002, Luca Barbieri wrote:
> 
> > Numbers:
> > unconditional copy of 2 tls descs: 5 cycles
> > this patch with 1 tls desc: 26 cycles
> > this patch with 8 tls descs: 52 cycles
> 
> [ 0 tls descs: 2 cycles. ]
Yes but common multithreaded applications will have at least 1 for
pthreads.

> but yes, this is rougly what i'd say this approach costs.
> 
> > lldt: 51 cycles
> > lgdt: 50 cycles
> > context switch: 2000 cycles (measured with pipe read/write and vmstat so
> > it's not very accurate)
> 
> > So this patch causes a 1% context switch performance drop for
> > multithreaded applications.
> 
> how did you calculate this?
((26 - 5) / 2000) * 100 ~= 1
Benchmarks done in kernel mode (2.4.18) with interrupts disabled on a
Pentium3 running the rdtsc timed benchmark in a loop 1 million times
with 8 unbenchmarked iterations to warm up caches and with the time to
execute an empty benchmark subtracted.

> glibc multithreaded applications can avoid the
> lldt via using the TLS, and thus it's a net win.
Surely, this patch is better than the old LDT method but much worse than
the 2-TLS one.

So I would use the 2-TLS approach plus my patch plus the syscall and
segment.h improvements of the tls-2.5.31-C3 patch plus support for
setting the 0x40 segment around APM calls.

BTW, are there any programs that would benefit from having more than 2
user-settable GDT entries but that don't need more than about 8?
(assuming we have a fixed flat code and data segment and 0x40 segment)


--=-HhJYdyLdCSo1waA0JRc0
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQA9V7tldjkty3ft5+cRAqmqAJ9DyHv3Akxkeu0qdFzOiJekQFpCGQCdGpCP
xMKgpfSqJne8+5OOVNXBxOI=
=xbvI
-----END PGP SIGNATURE-----

--=-HhJYdyLdCSo1waA0JRc0--
