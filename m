Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262577AbTGXLWW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jul 2003 07:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262589AbTGXLWW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jul 2003 07:22:22 -0400
Received: from crosslink-village-512-1.bc.nu ([81.2.110.254]:31478 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S262577AbTGXLWV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jul 2003 07:22:21 -0400
Subject: Re: [uClinux-dev] Kernel 2.6 size increase - get_current()?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David McCullough <davidm@snapgear.com>
Cc: Bernardo Innocenti <bernie@develer.com>,
       Christoph Hellwig <hch@infradead.org>,
       "David S. Miller" <davem@redhat.com>, uclinux-dev@uclinux.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg Ungerer <gerg@snapgear.com>
In-Reply-To: <20030724050655.GA11947@beast>
References: <200307232046.46990.bernie@develer.com>
	 <200307240035.38502.bernie@develer.com>
	 <1058999786.6890.21.camel@dhcp22.swansea.linux.org.uk>
	 <200307240100.00632.bernie@develer.com>  <20030724050655.GA11947@beast>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1059046125.7993.11.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 24 Jul 2003 12:28:46 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-07-24 at 06:06, David McCullough wrote:
> Back when I first did the 2.4 uClinux port,  the m68k MMU code was
> dedicating a register (a2) for current.  I thought that was a bad idea
> given how often you run out of registers on the 68k,  and made it a

On some platforms a global register current was a win, I can't speak for
m68k - current is used a lot.

> On the 2.5/2.6 front,  I think the change comes from the 8K (2 page) task
> structure and everyone just masking the kernel stack pointer to get the
> task pointer.  Gerg would know for sure,  he did the 2.5 work in this area.
> We should be easily able to switch back to the current_task pointer with a
> few small mods to entry.S.

A lot of platforms went this way because "current" is hard to do right
on an SMP box. Its effectively per CPU dependant, and that means you
either set up the MMU to do per CPU pages (via segments or tables) which
is a pita, or you do the stack trick. For uniprocessor a global still
works perfectly well.

> A general comment on the use of inline throughout the kernel.  Although
> they may show gains on x86 platforms,  they often perform worse on 
> embedded processors with limited cache,  as well as adding size.  I

Code size for critical paths is getting more and more performance critical
on x86 as well as on the embedded CPU systems. 3Ghz superscalar processors
lose a lot of clocks to a memory stall.

