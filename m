Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbVL2Nwx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbVL2Nwx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 08:52:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750722AbVL2Nwx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 08:52:53 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:44559 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750714AbVL2Nww (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 08:52:52 -0500
Date: Thu, 29 Dec 2005 14:52:50 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Matt Mackall <mpm@selenic.com>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-ID: <20051229135250.GE3811@stusta.de>
References: <20051228114637.GA3003@elte.hu> <20051229043835.GC4872@stusta.de> <20051229075936.GC20177@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051229075936.GC20177@elte.hu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2005 at 08:59:36AM +0100, Ingo Molnar wrote:
> 
> * Adrian Bunk <bunk@stusta.de> wrote:
> 
> > > unit-at-a-time still increases the kernel stack footprint somewhat (by 
> > > about 5% in the CC_OPTIMIZE_FOR_SIZE case), but not by the insane degree 
> > > gcc3 used to, which prompted the original -fno-unit-at-a-time addition.
> > >...
> > 
> > Please hold off this patch.
> > 
> > I do already plan to look at this after the smoke has cleared after 
> > the 4k stacks issue. I want to avoid two different knobs both with 
> > negative effects on stack usage (currently CONFIG_4KSTACKS=y, and 
> > after your patch gcc >= 4.0) giving a low testing coverage of the 
> > worst cases.
> 
> this is obviously not 2.6.15 stuff, so we've got enough time to see the 
> effects. [ And what does "I do plan to look at this" mean? When 
> precisely, and can i thus go to other topics without the issue being 
> dropped on the floor indefinitely? ]

It won't be dropped on the floor indefinitely.

"I do plan to look at this" means that I'd currently estimate this being 
2.6.19 stuff.

Yes that's one year from now, but we need it properly analyzed and 
tested before getting it into Linus' tree, and I do really want it 
untangled from and therefore after 4k stacks.

> also note that the inlining patch actually _reduces_ average stack 
> footprint by ~3-4%:
>                                             orig        +inlining
>         # of functions above 256 bytes:      683              660
>                total stackspace, bytes:   148492           142884
> 
> it is the unit-at-a-time patch that increases stack footprint (by about 
> 7-8%, which together with the inlining patch gives a net ~5%).

The problem with the stack is that average stack usage is relatively 
uninteresting - what matters is the worst case stack usage. And I'd 
expect the stack footprint improvements you see with less inlining in 
different places than the deteriorations with unit-at-a-time.

> 	Ingo

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

