Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267381AbSLRWbv>; Wed, 18 Dec 2002 17:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267382AbSLRWbv>; Wed, 18 Dec 2002 17:31:51 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:56329 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267381AbSLRWbs>; Wed, 18 Dec 2002 17:31:48 -0500
Date: Wed, 18 Dec 2002 14:37:35 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jamie Lokier <lk@tantalophile.demon.co.uk>
cc: "H. Peter Anvin" <hpa@transmeta.com>,
       Terje Eggestad <terje.eggestad@scali.com>,
       Ulrich Drepper <drepper@redhat.com>,
       Matti Aarnio <matti.aarnio@zmailer.org>,
       Hugh Dickins <hugh@veritas.com>, Dave Jones <davej@codemonkey.org.uk>,
       Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <20021218222835.GA14801@bjl1.asuk.net>
Message-ID: <Pine.LNX.4.44.0212181432470.1516-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 18 Dec 2002, Jamie Lokier wrote:
> 
> That said, you always need the page at 0xfffe0000 mapped anyway, so
> that sysexit can jump to a fixed address (which is fastest).

Yes. This is important. There _needs_ to be some fixed address at least as 
far as the kernel is concerned (it might move around between reboots or 
something like that, but it needs to be something the kernel knows about 
intimately and doesn't need lots of dynamic lookup).

However, there's another issue, namely process startup cost. I personally 
want it to be as light as at all possible. I hate doing an "strace" on 
user processes and seeing tons and tons of crapola showing up. Just for 
fun, do a

	strace /bin/sh -c "echo hello"

to see what I'm talking about. And that's actually a _lot_ better these 
days than it used to be.

Anyway, I really hate to see "unnecessary crap" in the user mode startup 
just because kernel interfaces are bad. That's why I like the AT_SYSINFO 
ELF auxilliary table approach - it's something that is already _there_ for 
the process to just take advantage of. Having to do a magic mmap for 
somehting that everybody needs to do is just bad design.

			Linus

