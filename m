Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268197AbTBNBlz>; Thu, 13 Feb 2003 20:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268199AbTBNBlz>; Thu, 13 Feb 2003 20:41:55 -0500
Received: from [66.78.32.3] ([66.78.32.3]:46542 "EHLO blacksea.bsdns.net")
	by vger.kernel.org with ESMTP id <S268197AbTBNBly> convert rfc822-to-8bit;
	Thu, 13 Feb 2003 20:41:54 -0500
Content-Type: text/plain; charset=US-ASCII
From: Eric Northup <lkml@digitaleric.net>
Reply-To: mailing-lists@digitaleric.net
To: Peter Tattam <peter@jazz-1.trumpet.com.au>, Andi Kleen <ak@suse.de>
Subject: Re: [discuss] Re: [Bug 350] New: i386 context switch very slow compared to 2.4 due to wrmsr (performance)
Date: Thu, 13 Feb 2003 20:51:35 -0500
User-Agent: KMail/1.4.2
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
       discuss@x86-64.org
References: <Pine.BSF.3.96.1030214103845.369E-100000@jazz-1.trumpet.com.au>
In-Reply-To: <Pine.BSF.3.96.1030214103845.369E-100000@jazz-1.trumpet.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200302132051.35268.lkml@digitaleric.net>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - blacksea.bsdns.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [0 0]
X-AntiAbuse: Sender Address Domain - digitaleric.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 13 February 2003 07:14 pm, Peter Tattam wrote:
> On Thu, 13 Feb 2003, Andi Kleen wrote:
> > [Hmm, this is becomming a FAQ]
> >
> > > Switching in and out of long mode is evil enough that I don't think it
> > > is worth it.  And encouraging people to write good JIT compiling
> >
> > Forget it. It is completely undefined in the architecture what happens
> > then. You'll lose interrupts and everything. Nothing for an operating
> > system intended to be stable.
> >
> > I have no plans at all to even think about it for Linux/x86-64.
[snip]
>
> The only other unknown quantity is the time it takes for the CPU to
> enable/disable long mode, but with modern CPU speeds, the interrupt latency
> may only be mildy affect by such a process, unless the CPU is broken in
> some way. I see no discussion in the AMD manuals regarding the cost of the
> mode switch, only what AMD engineers have hinted at.

I think the real issue is that AMD neither recommends nor supports this 
strategy.  ( http://www.x86-64.org/lists/discuss/msg02964.html ... there were 
better posts but I couldn't find them)  People with real hardware can't talk 
about it right now, but it seems to me this is just begging to get hit by 
errata -- how much effore do you think team Hammer spent testing a subtle 
mode transition which is marked "Don't do that!" ?

> > > emulators sounds much better, especially in the long run.  But it can
> > > be written.
> >
> > For DOS even a slow emulator should be good enough. After all most
> > DOS Programs are written for slow machines. Bochs running on a K8
> > will be hopefully fast enough. If not an JIT can be written, perhaps
> > you can extend valgrind for it.
> >
> > Or if you really rely on a DOS program executing fast you can
> > always boot a 32bit kernel which of course still supports vm86
> > in legacy mode.
>
> While an emulator sounds like a good idea, it is baggage that needs to be
> included.  JIT is probably overkill if the hardware can already do it.

I am actually working on a dynamic translator for x86, and am starting with 
16-bit real-mode.  It's a bit OT for linux-kernel, and it's not done yet so 
I'll spare you the details, but the point is that the kernel doesn't need to 
do anything special to help an emulator/dynamic translator, and that it 
*shouldn't* let you run real-mode code on the hardware.

> I contend that if the thunking code is reasonably well defined and thought
> out, jumping in & out of long mode might not be as big a hassle as
> originally thought.

Even the best code is subject to the limitations of the hardware it is run on.

-Eric
