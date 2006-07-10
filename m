Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965279AbWGJW1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965279AbWGJW1P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 18:27:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965280AbWGJW1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 18:27:15 -0400
Received: from 206-124-142-26.buici.com ([206.124.142.26]:9645 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S965279AbWGJW1O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 18:27:14 -0400
Date: Mon, 10 Jul 2006 15:27:13 -0700
From: Marc Singer <elf@buici.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: DMA memory, split_page, BUG_ON(PageCompound()), sound
Message-ID: <20060710222713.GA6849@buici.com>
References: <20060709000703.GA9806@cerise.buici.com> <44B0774E.5010103@yahoo.com.au> <20060710025103.GC28166@cerise.buici.com> <44B1FAE4.9070903@yahoo.com.au> <20060710162600.GB18728@flint.arm.linux.org.uk> <44B28F93.9020304@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44B28F93.9020304@yahoo.com.au>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11, 2006 at 03:34:11AM +1000, Nick Piggin wrote:
> Russell King wrote:
> >On Mon, Jul 10, 2006 at 04:59:48PM +1000, Nick Piggin wrote:
> >
> >>I guess you could do it a number of ways. Maybe having GFP_USERMAP
> >>set __GFP_USERMAP|__GFP_COMP, and the arm dma memory allocator can
> >>strip the __GFP_COMP.
> >>
> >>If you get an explicit __GFP_COMP passed down, the allocator doesn't
> >>know whether that was because they want a user mappable area, or
> >>really want a compound page (in which case, stripping __GFP_COMP is
> >>the wrong thing to do).
> >
> >
> >So I'll mask off __GFP_COMP for the time being in the ARM dma allocator
> >with a note to this effect?
> 
> I believe that should do the trick, yes (AFAIK, nobody yet is
> explicitly relying on a compound page from the dma allocator).
> 
> Marc can hopefully confim the fix.

I'll verify that that works, yes.

> 
> -- 
> SUSE Labs, Novell Inc.
> Send instant messages to your online friends http://au.messenger.yahoo.com 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
