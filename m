Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263315AbTGXLvN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 07:51:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263319AbTGXLvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 07:51:13 -0400
Received: from pacific.moreton.com.au ([203.143.235.130]:9613 "EHLO
	moreton.com.au") by vger.kernel.org with ESMTP id S263315AbTGXLvL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 07:51:11 -0400
Date: Thu, 24 Jul 2003 22:04:41 +1000
From: David McCullough <davidm@snapgear.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Bernardo Innocenti <bernie@develer.com>,
       Christoph Hellwig <hch@infradead.org>,
       "David S. Miller" <davem@redhat.com>, uclinux-dev@uclinux.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg Ungerer <gerg@snapgear.com>
Subject: Re: [uClinux-dev] Kernel 2.6 size increase - get_current()?
Message-ID: <20030724120441.GC16168@beast>
References: <200307232046.46990.bernie@develer.com> <200307240035.38502.bernie@develer.com> <1058999786.6890.21.camel@dhcp22.swansea.linux.org.uk> <200307240100.00632.bernie@develer.com> <20030724050655.GA11947@beast> <1059046125.7993.11.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1059046125.7993.11.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jivin Alan Cox lays it down ...
> On Iau, 2003-07-24 at 06:06, David McCullough wrote:
> > Back when I first did the 2.4 uClinux port,  the m68k MMU code was
> > dedicating a register (a2) for current.  I thought that was a bad idea
> > given how often you run out of registers on the 68k,  and made it a
> 
> On some platforms a global register current was a win, I can't speak for
> m68k - current is used a lot.


I'm sure that using a register for current was the right thing to do at
the time.  One problem with a global register approach is that the more
inlining the code uses,  the more like the compiler is going to want
that extra register :-)


> > On the 2.5/2.6 front,  I think the change comes from the 8K (2 page) task
> > structure and everyone just masking the kernel stack pointer to get the
> > task pointer.  Gerg would know for sure,  he did the 2.5 work in this area.
> > We should be easily able to switch back to the current_task pointer with a
> > few small mods to entry.S.
> 
> A lot of platforms went this way because "current" is hard to do right
> on an SMP box. Its effectively per CPU dependant, and that means you
> either set up the MMU to do per CPU pages (via segments or tables) which
> is a pita, or you do the stack trick. For uniprocessor a global still
> works perfectly well.


Sounds like something that can at least be made conditional on SMP.
I'll look into it for m68knommu since it is more likely to care about "size"
than SMP.


> > A general comment on the use of inline throughout the kernel.  Although
> > they may show gains on x86 platforms,  they often perform worse on 
> > embedded processors with limited cache,  as well as adding size.  I
> 
> Code size for critical paths is getting more and more performance critical
> on x86 as well as on the embedded CPU systems. 3Ghz superscalar processors
> lose a lot of clocks to a memory stall.

So should the trend be away from inlining,  especially larger functions ?

I know on m68k some of the really simple inlines are actually smaller as
an inline than as a function call.  But they have to be very simple,  or
only used once.

Cheers,
Davidm

-- 
David McCullough, davidm@snapgear.com  Ph:+61 7 34352815 http://www.SnapGear.com
Custom Embedded Solutions + Security   Fx:+61 7 38913630 http://www.uCdot.org
