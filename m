Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315485AbSEZAjE>; Sat, 25 May 2002 20:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315487AbSEZAjD>; Sat, 25 May 2002 20:39:03 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:46347 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S315485AbSEZAjC> convert rfc822-to-8bit; Sat, 25 May 2002 20:39:02 -0400
Date: Sat, 25 May 2002 17:39:00 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Robert Schwebel <robert@schwebel.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
In-Reply-To: <Pine.LNX.4.44.0205251651460.4120-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0205251729490.4355-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-MIME-Autoconverted: from 8bit to quoted-printable by deepthought.transmeta.com id g4Q0cWj27563
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 25 May 2002, Linus Torvalds wrote:
>
> Can we make the whole kernel truly hard-RT? Sure, possible in theory. In
> practice? No way, José. It's just not mainline enough.

Side note: we could, of course, mark some spinlocks (and thus some
code-paths) as being RT-safe, and then make sure that those spinlocks -
when they disable interrupts - actually disable the _hw_ interrupts even
with the RT patches.

That would make those sequences usable even from within a RT subset, but
would obviously mean that those spinlocks have to be checked for latency
issues - because any user (also non-RT ones) would obviously be truly
uninterruptible within these spinlocks.

Every single RT person out there is already painfully aware of (and used
to) having to limit the set of functions he can use while RT, so this is
something you guys tend to be pretty familiar with..

So the "hard-RT" thing doesn't need to be a complete on/off thing.

This kind of "limited kernel functionality" tends to help only RT kernel
modules, though. Full system calls (except the trivial ones like
"getpid()", of course) simply tend to have to require too much "real"
infrastructure that they can't use the RT subset.

Also, some people will he happy to know that soft-RT ends up getting
continually improved, and many people might be able to find that just the
regular preemptible kernel gives good enough latency at least if you can
limit the workload on the machine (which, on embedded devices tends to be
somethin gyou take for granted anyway).

That may not make the hard RT people happier, but at least it might shrink
the number of the die-hard hard RT'rs.

"If you can't beat them, try to make them extinct" ;)

			Linus

