Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267218AbSLSXYw>; Thu, 19 Dec 2002 18:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267374AbSLSXYw>; Thu, 19 Dec 2002 18:24:52 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:12302 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267218AbSLSXYw>; Thu, 19 Dec 2002 18:24:52 -0500
Date: Thu, 19 Dec 2002 15:30:23 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "H. Peter Anvin" <hpa@transmeta.com>
cc: Jamie Lokier <lk@tantalophile.demon.co.uk>, <bart@etpmod.phys.tue.nl>,
       <davej@codemonkey.org.uk>, <terje.eggestad@scali.com>,
       <drepper@redhat.com>, <matti.aarnio@zmailer.org>, <hugh@veritas.com>,
       <mingo@elte.hu>, <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <Pine.LNX.4.44.0212191437220.5879-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.44.0212191519260.6279-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 19 Dec 2002, Linus Torvalds wrote:
> 
> So it's between 0-4 cycles on machines that take 200 - 1000 cycles for
> just the system call overhead.

Side note: I'd expect indirect calls - and especially the predictable 
ones, like this - to maintain competitive behaviour on CPU's. Even the P4, 
which usually has really bad worst-case behaviour for more complex 
instructions (just look at the 2000 cycles for a regular int80/iret and 
shudder) does a indirect call without huge problems.

That's because indirect calls are actually very common, and to some degree 
getting _more_ so with the proliferation of OO languages (and I'm 
discounting the "indirect call" that is just a return statement - they've 
obviously always been common, but a return stack means that CPU 
optimizations for "ret" instructions are different from "real" indirect 
calls).

So I don't worry about the indirection per se. I'd worry a lot more about
some of the tricks people mentioned (ie the "pushl $0xfffff000 ; ret"  
approach probably sucks quite badly on some CPU's, simply because it does
bad things to return stacks on modern CPU's - not necessarily visible in 
microbenchmarks, but..).

			Linus

