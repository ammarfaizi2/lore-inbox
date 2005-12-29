Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750940AbVL2UBO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbVL2UBO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 15:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbVL2UBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 15:01:14 -0500
Received: from inti.inf.utfsm.cl ([200.1.21.155]:49869 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1750936AbVL2UBM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 15:01:12 -0500
Message-Id: <200512291957.jBTJvvOk018363@laptop11.inf.utfsm.cl>
To: Adrian Bunk <bunk@stusta.de>
cc: Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjan@infradead.org>, Matt Mackall <mpm@selenic.com>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers 
In-Reply-To: Message from Adrian Bunk <bunk@stusta.de> 
   of "Thu, 29 Dec 2005 14:52:50 BST." <20051229135250.GE3811@stusta.de> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 18)
Date: Thu, 29 Dec 2005 16:57:57 -0300
From: Horst von Brand <vonbrand@inf.utfsm.cl>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0b5 (inti.inf.utfsm.cl [200.1.21.155]); Thu, 29 Dec 2005 16:57:57 -0300 (CLST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> wrote:
> On Thu, Dec 29, 2005 at 08:59:36AM +0100, Ingo Molnar wrote:
> > * Adrian Bunk <bunk@stusta.de> wrote:

> > > > unit-at-a-time still increases the kernel stack footprint somewhat
> > > > (by about 5% in the CC_OPTIMIZE_FOR_SIZE case), but not by the
> > > > insane degree gcc3 used to, which prompted the original
> > > > -fno-unit-at-a-time addition.
> > > >...

> > > Please hold off this patch.
> > > 
> > > I do already plan to look at this after the smoke has cleared after 
> > > the 4k stacks issue. I want to avoid two different knobs both with 
> > > negative effects on stack usage (currently CONFIG_4KSTACKS=y, and 
> > > after your patch gcc >= 4.0) giving a low testing coverage of the 
> > > worst cases.

This is /one/ knob with effect on stack usage...

> > this is obviously not 2.6.15 stuff, so we've got enough time to see the 
> > effects. [ And what does "I do plan to look at this" mean? When 
> > precisely, and can i thus go to other topics without the issue being 
> > dropped on the floor indefinitely? ]

> It won't be dropped on the floor indefinitely.
> 
> "I do plan to look at this" means that I'd currently estimate this being 
> 2.6.19 stuff.
> 
> Yes that's one year from now, but we need it properly analyzed and 
> tested before getting it into Linus' tree, and I do really want it 
> untangled from and therefore after 4k stacks.

That is "indefinitely" in my book. Or nearly so. And in the meantime will
get many hackers to patch it in by hand and forget to tell...

> > also note that the inlining patch actually _reduces_ average stack 
> > footprint by ~3-4%:
> >                                             orig        +inlining
> >         # of functions above 256 bytes:      683              660
> >                total stackspace, bytes:   148492           142884
> > 
> > it is the unit-at-a-time patch that increases stack footprint (by about 
> > 7-8%, which together with the inlining patch gives a net ~5%).
> 
> The problem with the stack is that average stack usage is relatively 
> uninteresting - what matters is the worst case stack usage. And I'd 
> expect the stack footprint improvements you see with less inlining in 
> different places than the deteriorations with unit-at-a-time.

That is a red herring. The numbers are for number of large stack users
(goes down) and cummulative stack usage (goes down too). Sure, if the
number of > 256 bytes stack users goes down while the largest stack uses go
up we are in trouble. And if the grand total goes down but stack usage by
some critical users go up we might be screwed. That could be answered by
looking at the details behind the above numbers. But there is only one way
to find out if it causes problems (and fix them)...

I'd (tend to) buy an argument about possible instabilities in that gcc
code, but then again, it has to be tested sometime...

Make it a configuration option, under EXPERIMENTAL, VERY DANGEROUS, HIGH
EXPLOSIVE if you must.
-- 
Dr. Horst H. von Brand                   User #22616 counter.li.org
Departamento de Informatica                     Fono: +56 32 654431
Universidad Tecnica Federico Santa Maria              +56 32 654239
Casilla 110-V, Valparaiso, Chile                Fax:  +56 32 797513

