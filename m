Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267720AbUIPGxs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267720AbUIPGxs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 02:53:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267734AbUIPGxs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 02:53:48 -0400
Received: from cantor.suse.de ([195.135.220.2]:61584 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267720AbUIPGxn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 02:53:43 -0400
Date: Thu, 16 Sep 2004 08:53:42 +0200
From: Andi Kleen <ak@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Zwane Mwaikambo <zwane@fsmlabs.com>, linux-kernel@vger.kernel.org,
       wli@holomorphy.com
Subject: Re: [PATCH] remove LOCK_SECTION from x86_64 spin_lock asm
Message-ID: <20040916065342.GE12915@wotan.suse.de>
References: <Pine.LNX.4.53.0409151458470.10849@musoma.fsmlabs.com> <20040915144523.0fec2070.akpm@osdl.org> <20040916061359.GA12915@wotan.suse.de> <20040916062759.GA10527@elte.hu> <20040916064428.GD12915@wotan.suse.de> <20040916065101.GA11726@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040916065101.GA11726@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 16, 2004 at 08:51:01AM +0200, Ingo Molnar wrote:
> 
> * Andi Kleen <ak@suse.de> wrote:
> 
> > I think the idea was that the spinlock functions should be small
> > enough that they don't have any stack local variables. [...]
> 
> this might work for x64, but even there, are you sure it works even with
> CONFIG_PREEMPT enabled (there the spinlocks are more complex)? It sure

I would expect so. x86-64 should have enough callee clobbered registers
by default to handle it.  Unless someone makes them complex enough that it
needs more than 4 variables or so or adds another function call. But I hope 
this won't happen.

> wont work on x86 so i think we need a generic 'soft PC' solution.
> 
> the alternative would be to unwind the stack - quite some task on some 
> platforms ...

Sometimes call graph profiling would be very useful, but I wouldn't 
want the profiler to do it by default, especially not for this silly
simple case. dwarf2 unwinding is complex enough that just requiring 
frame pointers for the CG case would look attractive.

-Andi

