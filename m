Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932199AbWDCQ7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbWDCQ7G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 12:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932189AbWDCQ7G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 12:59:06 -0400
Received: from mga07.intel.com ([143.182.124.22]:29703 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S932268AbWDCQ7F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 12:59:05 -0400
TrustExchangeSourcedMail: True
X-ExchangeTrusted: True
X-IronPort-AV: i="4.03,159,1141632000"; 
   d="scan'208"; a="18458408:sNHT2741992792"
Date: Mon, 3 Apr 2006 09:57:47 -0700
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>, Mike Galbraith <efault@gmx.de>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Con Kolivas <kernel@kolivas.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: smpnice work around for active_load_balance()
Message-ID: <20060403095747.A29737@unix-os.sc.intel.com>
References: <4428D112.7050704@bigpond.net.au> <20060328112521.A27574@unix-os.sc.intel.com> <4429BC61.7020201@bigpond.net.au> <20060328185202.A1135@unix-os.sc.intel.com> <442A0235.1060305@bigpond.net.au> <20060329145242.A11376@unix-os.sc.intel.com> <442B1AE8.5030005@bigpond.net.au> <443074B4.4030807@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <443074B4.4030807@bigpond.net.au>; from pwil3058@bigpond.net.au on Mon, Apr 03, 2006 at 11:04:52AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2006 at 11:04:52AM +1000, Peter Williams wrote:
> Peter Williams wrote:
> > I gave an example in a previous e-mail.  Basically, at the end of 
> > scheduler_tick() if rebalance_tick() doesn't move any tasks (it would be 
> > foolish to contemplate moving tasks of the queue just after you've moved 
> > some there) and the run queue has exactly one running task and it's time 
> > for a HT/MC rebalance check on the package that this run queue belongs 
> > to then check that package to to see if it meets the rest of criteria 
> > for needing to lose some tasks.  If it does look for a package that is a 
> > suitable recipient for the moved task and if you find one then mark this 
> > run queue as needing active load balancing and arrange for its migration 
> > thread to be started.
> > 
> > Simple, direct and amenable to being only built on architectures that 
> > need the functionality.
> 
> Are you working on this idea or should I do it?

my issues raised in response to this idea are unanswered.

<issues>
First of all we will be doing unnecessary checks to see if there is
an imbalance.. Current code triggers the checks and movement only when
it is necessary.. And second, finding the correct destination cpu in the 
presence of SMT and MC is really complicated.. Look at different examples
in the OLS paper.. Domain topology provides all this info with no added
complexity...
</issues>

I don't see a merit and so I am not looking into this.

thanks,
suresh
