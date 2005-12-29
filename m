Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750710AbVL2PkI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750710AbVL2PkI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 10:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750762AbVL2PkI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 10:40:08 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:25360 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750710AbVL2PkG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 10:40:06 -0500
Date: Thu, 29 Dec 2005 16:40:05 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, arjan@infradead.org,
       linux-kernel@vger.kernel.org, mpm@selenic.com
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-ID: <20051229154005.GI3811@stusta.de>
References: <20051228114637.GA3003@elte.hu> <Pine.LNX.4.64.0512281111080.14098@g5.osdl.org> <1135798495.2935.29.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0512281300220.14098@g5.osdl.org> <20051228212313.GA4388@elte.hu> <20051228214845.GA7859@elte.hu> <20051228201150.b6cfca14.akpm@osdl.org> <20051229073259.GA20177@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051229073259.GA20177@elte.hu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2005 at 08:32:59AM +0100, Ingo Molnar wrote:
> 
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > Ingo Molnar <mingo@elte.hu> wrote:
> > >
> > > I think gcc should arguably not be forced to inline things when doing 
> > > -Os, and it's also expected to mess up much less than when optimizing 
> > > for speed. So maybe forced inlining should be dependent on 
> > > !CONFIG_CC_OPTIMIZE_FOR_SIZE?
> > 
> > When it comes to inlining I just don't trust gcc as far as I can spit 
> > it.  We're putting the kernel at the mercy of future random brainfarts 
> > and bugs from the gcc guys.  It would be better and safer IMO to 
> > continue to force `inline' to have strict and sane semamtics, and to 
> > simply be vigilant about our use of it.
> 
> i think there's quite an attitude here - we are at the mercy of "gcc 
> brainfarts" anyway, and users are at the mercy of "kernel brainfarts" 
> just as much. Should users disable swapping and trash-talk it just 
> because the Linux kernel used to have a poor VM? (And the gcc folks are 
> certainly listening - it's not like they were unwilling to fix stuff, 
> they simply had their own decade-old technological legacies that made 
> certain seemingly random problems much harder to attack. E.g. -Os has 
> recently been improved quite significantly in to-be-gcc-4.2.)
>...
> also, there's a fundamental conflict of 'speed vs. performance' here, 
> for a certain boundary region. For the extremes, very small and very 
> large functions, the decision is clear, but if e.g. a CPU has tons of 
> cache, it might prefer more agressive inlining than if it doesnt. So 
> it's not like we can do it in a fully static manner.
>...

I'd formulate it the other way round as Andrew:

We should force gcc to inline code where we do know best
("static inline"s in header files) and leave the decision
to gcc in the cases where gcc should know best controlled
by some high-level knobs like -Os/-O2.

gcc simply needs to be forced to inline in some cases in which we really 
need inlining, but in all other cases gcc knows best and we can trust 
gcc to make the right decision.

> 	Ingo

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

