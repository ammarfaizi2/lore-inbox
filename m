Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964977AbVLaPIg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964977AbVLaPIg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 10:08:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964980AbVLaPIg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 10:08:36 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:31244 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964977AbVLaPIf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 10:08:35 -0500
Date: Sat, 31 Dec 2005 16:08:32 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>,
       Arjan van de Ven <arjan@infradead.org>,
       Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       mpm@selenic.com
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-ID: <20051231150831.GL3811@stusta.de>
References: <Pine.LNX.4.64.0512290923420.14098@g5.osdl.org> <20051229202852.GE12056@redhat.com> <Pine.LNX.4.64.0512291240490.3298@g5.osdl.org> <Pine.LNX.4.64.0512291322560.3298@g5.osdl.org> <20051229224839.GA12247@elte.hu> <1135897092.2935.81.camel@laptopd505.fenrus.org> <Pine.LNX.4.63.0512300035550.2747@gockel.physik3.uni-rostock.de> <20051230074916.GC25637@elte.hu> <20051231143800.GJ3811@stusta.de> <20051231144534.GA5826@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051231144534.GA5826@elte.hu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ this email discusses only your uninline patch ]

On Sat, Dec 31, 2005 at 03:45:35PM +0100, Ingo Molnar wrote:
> 
> * Adrian Bunk <bunk@stusta.de> wrote:
> 
> > On Fri, Dec 30, 2005 at 08:49:16AM +0100, Ingo Molnar wrote:
> > > 
> > > * Tim Schmielau <tim@physik3.uni-rostock.de> wrote:
> > > 
> > > > What about the previous suggestion to remove inline from *all* static 
> > > > inline functions in .c files?
> > > 
> > > i think this is a way too static approach. Why go from one extreme to 
> > > the other, when my 3 simple patches (which arguably create a more 
> > > flexible scenario) gives us savings of 7.7%?
> > 
> > This point only discusses the inline change, which were (without 
> > unit-at-a-time) in your measurements 2.9%.
> > 
> > Your patch might be simple, but it also might have side effects in 
> > cases where we _really_ want the code forced to be inlined. How simple 
> > is it to prove that your uninline patch doesn't cause a subtle 
> > breakage somewhere?
> 
> it's quite simple: run the latency tracer with stack-trace debugging 
> enabled, and it will measure the worst-case stack footprint that is 
> triggered on that system. Obviously any compiler version change or 
> option change can cause problems, there's nothing new about it - and 
> it's not realistic to wait one year for changes like that. If you have 
> to wait that long, you are testing it the wrong way.

What are you talking about?

You sent two different patches:
1. uninline
2. unit-at-a-time for i386

These are two separate patches that should be discussed separately.

Your answer regarding your second patch does't fit in any way my email 
regarding your first patch.

Your uninline patch shouldn't cause any regressions regarding stack 
footprint, and stack usage is not what I was talking about.

My email was about things like Andi's example of the x86-64 vsyscall 
code where we really need inlining, and due to your proposed inline 
semantics change there might be breakages if an __always_inline is 
forgotten at a place where it was required.

Your uninline patch might be simple, but the safe way would be Arjan's 
approach to start removing all the buggy inline's from .c files.

> 	Ingo

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

