Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751233AbWGLKct@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbWGLKct (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 06:32:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbWGLKct
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 06:32:49 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:6924 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1751233AbWGLKcs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 06:32:48 -0400
Date: Wed, 12 Jul 2006 11:32:41 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Marc Singer <elf@buici.com>, Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: DMA memory, split_page, BUG_ON(PageCompound()), sound
Message-ID: <20060712103241.GA7908@flint.arm.linux.org.uk>
Mail-Followup-To: Nick Piggin <nickpiggin@yahoo.com.au>,
	Marc Singer <elf@buici.com>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
References: <20060709000703.GA9806@cerise.buici.com> <44B0774E.5010103@yahoo.com.au> <20060710025103.GC28166@cerise.buici.com> <44B1FAE4.9070903@yahoo.com.au> <20060710162600.GB18728@flint.arm.linux.org.uk> <44B28F93.9020304@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44B28F93.9020304@yahoo.com.au>
User-Agent: Mutt/1.4.1i
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

In which case should ALSA be passing __GFP_COMP to the dma allocator ?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
