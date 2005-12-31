Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964985AbVLaPWI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964985AbVLaPWI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 31 Dec 2005 10:22:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964987AbVLaPWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 31 Dec 2005 10:22:08 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:36876 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S964985AbVLaPWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 31 Dec 2005 10:22:05 -0500
Date: Sat, 31 Dec 2005 16:22:04 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: lkml <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Arjan van de Ven <arjan@infradead.org>,
       Matt Mackall <mpm@selenic.com>, Dave Jones <davej@redhat.com>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
Message-ID: <20051231152204.GM3811@stusta.de>
References: <20051228114637.GA3003@elte.hu> <20051229043835.GC4872@stusta.de> <20051229075936.GC20177@elte.hu> <20051229135250.GE3811@stusta.de> <20051229202550.GB29546@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051229202550.GB29546@elte.hu>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ this email discusses only your unit-at-a-time patch ]

On Thu, Dec 29, 2005 at 09:25:50PM +0100, Ingo Molnar wrote:
> 
> * Adrian Bunk <bunk@stusta.de> wrote:
> 
> > It won't be dropped on the floor indefinitely.
> > 
> > "I do plan to look at this" means that I'd currently estimate this 
> > being 2.6.19 stuff.
> 
> you must be kidding ...

No.

Both 4k stacks and unit-at-a-time are changes with negative impact on 
the stack usage, and I want to have problems sorted out separately.

We wouldn't have much discussion here if 4k stacks were only judged by 
technical facts, but although the last known problem was fixed in -mm 
nearly two months ago, it seems the ndiswrapper groupies have managed to 
spread enough FUD to even persuade Andrew that 4k stacks were evil.  :-(

> > Yes that's one year from now, but we need it properly analyzed and 
> > tested before getting it into Linus' tree, and I do really want it 
> > untangled from and therefore after 4k stacks.
> 
> you are really using the wrong technology for this.
> 
> look at the latency tracing patch i posted today: it includes a feature 
> that prints the worst-case stack footprint _as it happens_, and thus 
> allows the mapping of such effects in a very efficient and very 
> practical way. As it works on a live system, and profiles live function 
> traces, it goes through function pointers and irq entry nesting effects 
> too. We could perhaps put that into Fedora for a while and get the 
> worst-case footprints mapped.
> 
> in fact i've been running this feature in the -rt kernel for quite some 
> time, and it enabled the fixing of a couple of bad stack abusers, and it 
> also told us what our current worst-case stack footprint is [when 4K 
> stacks are enabled]: it's execve of an ELF binary.

That's nice.

Could you try to get at least the part that checks whether more than 
STACK_WARN stack is left (if CONFIG_DEBUG_STACKOVERFLOW is set) into
-mm (and perhaps later into Linus' tree)?

> 	Ingo

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

