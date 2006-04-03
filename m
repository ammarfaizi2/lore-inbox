Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964937AbWDCXL5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964937AbWDCXL5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 19:11:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964938AbWDCXL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 19:11:57 -0400
Received: from omta01sl.mx.bigpond.com ([144.140.92.153]:18650 "EHLO
	omta01sl.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S964937AbWDCXLz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 19:11:55 -0400
Message-ID: <4431ABB9.6050708@bigpond.net.au>
Date: Tue, 04 Apr 2006 09:11:53 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
CC: Andrew Morton <akpm@osdl.org>, Mike Galbraith <efault@gmx.de>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Ingo Molnar <mingo@elte.hu>,
       Con Kolivas <kernel@kolivas.org>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: smpnice work around for active_load_balance()
References: <4428D112.7050704@bigpond.net.au> <20060328112521.A27574@unix-os.sc.intel.com> <4429BC61.7020201@bigpond.net.au> <20060328185202.A1135@unix-os.sc.intel.com> <442A0235.1060305@bigpond.net.au> <20060329145242.A11376@unix-os.sc.intel.com> <442B1AE8.5030005@bigpond.net.au> <443074B4.4030807@bigpond.net.au> <20060403095747.A29737@unix-os.sc.intel.com>
In-Reply-To: <20060403095747.A29737@unix-os.sc.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta01sl.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Mon, 3 Apr 2006 23:11:53 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siddha, Suresh B wrote:
> On Mon, Apr 03, 2006 at 11:04:52AM +1000, Peter Williams wrote:
>> Peter Williams wrote:
>>> I gave an example in a previous e-mail.  Basically, at the end of 
>>> scheduler_tick() if rebalance_tick() doesn't move any tasks (it would be 
>>> foolish to contemplate moving tasks of the queue just after you've moved 
>>> some there) and the run queue has exactly one running task and it's time 
>>> for a HT/MC rebalance check on the package that this run queue belongs 
>>> to then check that package to to see if it meets the rest of criteria 
>>> for needing to lose some tasks.  If it does look for a package that is a 
>>> suitable recipient for the moved task and if you find one then mark this 
>>> run queue as needing active load balancing and arrange for its migration 
>>> thread to be started.
>>>
>>> Simple, direct and amenable to being only built on architectures that 
>>> need the functionality.
>> Are you working on this idea or should I do it?
> 
> my issues raised in response to this idea are unanswered.
> 
> <issues>
> First of all we will be doing unnecessary checks to see if there is
> an imbalance..

There will be saved overhead when the current code is removed that can 
be used.  Also, if you examine the idea you'll find that it would be 
very cheap and the possibilities for early abandonment of the checks 
would make them very efficient.

> Current code triggers the checks and movement only when
> it is necessary..

That is untrue.  The best you can say is when they MIGHT be necessary.

> And second, finding the correct destination cpu in the 
> presence of SMT and MC is really complicated.. Look at different examples
> in the OLS paper.. Domain topology provides all this info with no added
> complexity...

This to me would seem to be an argument in favour of change rather than 
an argument for retaining the current highly random process.

Finding the appropriate destination package/queue can be left to 
active_load_balance() and this would reduce the impact of the inherent 
raciness of load balancing.

> </issues>
> 
> I don't see a merit and so I am not looking into this.

OK.  I'll do it.

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
