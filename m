Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964798AbWDCBEz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964798AbWDCBEz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Apr 2006 21:04:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964799AbWDCBEz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Apr 2006 21:04:55 -0400
Received: from omta05ps.mx.bigpond.com ([144.140.83.195]:26597 "EHLO
	omta05ps.mx.bigpond.com") by vger.kernel.org with ESMTP
	id S964798AbWDCBEy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Apr 2006 21:04:54 -0400
Message-ID: <443074B4.4030807@bigpond.net.au>
Date: Mon, 03 Apr 2006 11:04:52 +1000
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
References: <4428D112.7050704@bigpond.net.au> <20060328112521.A27574@unix-os.sc.intel.com> <4429BC61.7020201@bigpond.net.au> <20060328185202.A1135@unix-os.sc.intel.com> <442A0235.1060305@bigpond.net.au> <20060329145242.A11376@unix-os.sc.intel.com> <442B1AE8.5030005@bigpond.net.au>
In-Reply-To: <442B1AE8.5030005@bigpond.net.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH PLAIN at omta05ps.mx.bigpond.com from [147.10.133.38] using ID pwil3058@bigpond.net.au at Mon, 3 Apr 2006 01:04:52 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> Siddha, Suresh B wrote:
>> HT/MC imbalance is detected in a normal way.. A lightly loaded group
>> finds an imbalance and tries to pull some load from a busy group (which
>> is inline with normal load balance)... pull fails because the only task
>> on that cpu is busy running and needs to go off the cpu (which is 
>> triggered
>> by active load balance)... Scheduler load balance is generally done by 
>> a pull mechansim and here (HT/MC) it is still a pull 
>> mechanism(triggering a final push only because of the single running 
>> task)
>> If you have any better generic and simple method, please let us know.
> 
> I gave an example in a previous e-mail.  Basically, at the end of 
> scheduler_tick() if rebalance_tick() doesn't move any tasks (it would be 
> foolish to contemplate moving tasks of the queue just after you've moved 
> some there) and the run queue has exactly one running task and it's time 
> for a HT/MC rebalance check on the package that this run queue belongs 
> to then check that package to to see if it meets the rest of criteria 
> for needing to lose some tasks.  If it does look for a package that is a 
> suitable recipient for the moved task and if you find one then mark this 
> run queue as needing active load balancing and arrange for its migration 
> thread to be started.
> 
> Simple, direct and amenable to being only built on architectures that 
> need the functionality.

Are you working on this idea or should I do it?

Peter
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
