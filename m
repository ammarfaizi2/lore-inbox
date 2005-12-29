Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751054AbVL2WY6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbVL2WY6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 17:24:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751069AbVL2WY6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 17:24:58 -0500
Received: from waste.org ([64.81.244.121]:15084 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S1751054AbVL2WY5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 17:24:57 -0500
Date: Thu, 29 Dec 2005 16:20:59 -0600
From: Matt Mackall <mpm@selenic.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       arjan@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-ID: <20051229222059.GC3356@waste.org>
References: <20051228114637.GA3003@elte.hu> <Pine.LNX.4.64.0512281111080.14098@g5.osdl.org> <1135798495.2935.29.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org> <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu> <20051228201150.b6cfca14.akpm@osdl.org> <20051229073259.GA20177@elte.hu> <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org> <20051229201953.GA29546@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051229201953.GA29546@elte.hu>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2005 at 09:19:53PM +0100, Ingo Molnar wrote:
> 
> * Linus Torvalds <torvalds@osdl.org> wrote:
> 
> > > i think there's quite an attitude here - we are at the mercy of "gcc 
> > > brainfarts" anyway, and users are at the mercy of "kernel brainfarts" 
> > > just as much.
> > 
> > There's a huge difference here. The gcc people very much have a "Oh, 
> > we changed old documented behaviour - live with it" attitude, together 
> > with "That was a gcc extension, not part of the C language, so when we 
> > change how gcc behaves, it's _your_ problem" approach.
> > 
> > At least they used to.
> 
> yeah, i think that was definitely the case historically.
> 
> > Maybe the right thing to do is to just heed that warning, and remove 
> > such functions from header files and make them no-inline? That way we 
> > get the size fixes _regardless_ of any compiler options.
> 
> i think the eye-opener (for me at least) was that there's really a
> massive 5%+ size difference here, from 2 simple patches. And meanwhile
> Matt is doing truly hard size-reduction work and is mailing patches to
> lkml that remove 200-300 bytes of .text, which is 0.01% of code, apiece.

For the record, my cut-off for non-trivial stuff is currently about
1K. Which is more like 0.1% for minimal kernels. Unfortunately, the
impact of these patches on a stripped-down kernel is less substantial
than on a featureful one, so 

> Debloating is like scalability, a piece-by-piece process where we'll
> only see the full effects after doing 100 independent steps, but still
> we must not ignore the big effects either, nor must we get ourselves
> into losing maintainance battles.
> 
> The current inline model seems to be a lost battle, the 'size noise'
> caused by spurious inlines (which count in the thousands) is _far_
> outpowering most of the size reduction efforts. And i think it can be
> argued that at least in the -Os case gcc has a very clear directive wrt.
> what to do - and much less room to mess up. Independently of how much we
> trust it.

I think both these patches deserve a spin in -mm. But I can see
arguments for staging it. Hopefully we can get Andrew to take the
unit-at-a-time piece for post-2.6.15 and try out the inlining after
we've got some confidence with the first.

-- 
Mathematics is the supreme nostalgia of our time.
