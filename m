Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264455AbSIVS3s>; Sun, 22 Sep 2002 14:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264456AbSIVS3s>; Sun, 22 Sep 2002 14:29:48 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:34320 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S264455AbSIVS3r>; Sun, 22 Sep 2002 14:29:47 -0400
Date: Sun, 22 Sep 2002 11:35:55 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Roman Zippel <zippel@linux-m68k.org>
cc: Ingo Molnar <mingo@elte.hu>, Karim Yaghmour <karim@opersys.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LTT-Dev <ltt-dev@shafik.org>
Subject: Re: [PATCH] LTT for 2.5.38 1/9: Core infrastructure
In-Reply-To: <Pine.LNX.4.44.0209221830400.8911-100000@serv>
Message-ID: <Pine.LNX.4.44.0209221130060.1455-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 22 Sep 2002, Roman Zippel wrote:
> 
> To summarize: You find tracing useful, but software tracing is only of
> limited value in areas you're working at.
>
> What about other developers, which only want to develop a simple driver,
> without having to understand the whole kernel? Traces still work where
> printk() or kgdb don't work. I think it's reasonable to ask an user to
> enable tracing and reproduce the problem, which you can't reproduce
> yourself.

That makes adding source bloat ok? I've debugged some drivers with 
dprintk() style tracing, and it often makes the code harder to follow, 
even if it eds up being compiled away. 

>From what I've seen from the LTT thing, it's too heavy-weight to be good
for many things (taking SMP-global locks for trace events is _not_ a good
idea if the trace is for doing things like doing performance tracing,
where a tracer that adds synchronization fundamentally _changes_ what is
going on in ways that have nothing to do with timing).

I suspect we'll want to have some form of event tracing eventually, but
I'm personally pretty convinced that it needs to be a per-CPU thing, and 
the core mechanism would need to be very lightweight. It's easier to build 
up complexity on top of a lightweight interface than it is to make a 
lightweight interface out of a heavy one.

			Linus

