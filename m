Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267227AbSLSWoI>; Thu, 19 Dec 2002 17:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267374AbSLSWoI>; Thu, 19 Dec 2002 17:44:08 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:8971 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267227AbSLSWoE>; Thu, 19 Dec 2002 17:44:04 -0500
Date: Thu, 19 Dec 2002 14:49:50 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: "H. Peter Anvin" <hpa@transmeta.com>
cc: Jamie Lokier <lk@tantalophile.demon.co.uk>, <bart@etpmod.phys.tue.nl>,
       <davej@codemonkey.org.uk>, <terje.eggestad@scali.com>,
       <drepper@redhat.com>, <matti.aarnio@zmailer.org>, <hugh@veritas.com>,
       <mingo@elte.hu>, <linux-kernel@vger.kernel.org>
Subject: Re: Intel P6 vs P7 system call performance
In-Reply-To: <3E02479E.8050801@transmeta.com>
Message-ID: <Pine.LNX.4.44.0212191437220.5879-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 19 Dec 2002, H. Peter Anvin wrote:
> 
> Unfortunately it means taking an indirect call cost for every invocation...

Ehh.. I just tested the "cost" of this on a PIII (comparing a indirect
call with a direct one), and it's exactly one extra cycle.

ONE CYCLE. 

On a P4 the difference was 4 cycles. On my test P95 system I didn't see
any difference at all. And I don't have an athlon handy in my office.

That's the difference between

	static void *address = &do_nothing;
	asm("call *%0" :"m" (address))

and

	asm("call do_nothing");

So it's between 0-4 cycles on machines that take 200 - 1000 cycles for
just the system call overhead.

And for that "overhead", you get a binary that trivially works on all
kernels, _and_ doesn't need extra mmap's etc (which are _easily_ thousands
of cycles).

		Linus

