Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318876AbSHLXkN>; Mon, 12 Aug 2002 19:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318878AbSHLXkN>; Mon, 12 Aug 2002 19:40:13 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:3346 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318876AbSHLXkM>; Mon, 12 Aug 2002 19:40:12 -0400
Date: Mon, 12 Aug 2002 16:45:05 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Robert Love <rml@tech9.net>, Skip Ford <skip.ford@verizon.net>,
       "Adam J. Richter" <adam@yggdrasil.com>, <ryan.flanigan@intel.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.31: modules don't work at all
In-Reply-To: <3D5845FF.C6668B15@zip.com.au>
Message-ID: <Pine.LNX.4.33.0208121642330.1278-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 12 Aug 2002, Andrew Morton wrote:
> Linus Torvalds wrote:
> > 
> > On Mon, 12 Aug 2002, Andrew Morton wrote:
> > >
> > > Gets tricky with nested lock_kernels.
> > 
> > No, lock-kernel already only increments once, at the first lock_kernel. We
> > have a totally separate counter for the BKL depth, see <asm/smplock.h>
> > 
> 
> There are eighteen smplock.h's, all different.  At least one (SuperH)
> hasn't been converted to preempt.

Note that this should all be trivial, and in fact I think everybody shares 
the same smplock.h these days. The x86 smplock.h is 100% C - even though 
it's not actually totally visible because we still have some old asm 
routines visible that are just #ifdef'ed out.

In fact, I'll clean that up a bit to make it clearer.

> However, soldiering on leads us to some difficulties.  You're proposing,
> effectively, that preempt_count gets shifted left one bit and that bit
> zero becomes "has done lock_kernel()".

Actually, on slight introspection I suspect the better answer is to make
the BKL bit somewhere higher up, since BKL is much less interesting than
most spinlocks, and getting increasingly more so. But yes.

			Linus

