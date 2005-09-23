Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750714AbVIWG43@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750714AbVIWG43 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Sep 2005 02:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750717AbVIWG43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Sep 2005 02:56:29 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:14551 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750714AbVIWG42
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Sep 2005 02:56:28 -0400
Date: Fri, 23 Sep 2005 12:25:56 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Nishanth Aravamudan <nacc@us.ibm.com>, Tony Lindgren <tony@atomide.com>,
       Con Kolivas <kernel@kolivas.org>,
       Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, ck list <ck@vds.kolivas.org>
Subject: Re: [PATCH 1/3] dynticks - implement no idle hz for x86
Message-ID: <20050923065556.GA19063@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20050905072704.GB5734@atomide.com> <20050905170202.GJ25856@us.ibm.com> <20050907073743.GB5804@atomide.com> <20050907150517.GC4590@us.ibm.com> <20050908100035.GD25847@atomide.com> <20050908212213.GB2997@us.ibm.com> <20050908220854.GE2997@us.ibm.com> <20050920110654.GA373@in.ibm.com> <20050920145856.GE6589@us.ibm.com> <1127396290.4903.43.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1127396290.4903.43.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2005 at 03:38:10PM +0200, Martin Schwidefsky wrote:
> As I first saw the dyntick_timer structure I thought: "why does it have
> to be that complicated?". Must be because of the requirements for
> high-res-timers, since it's overkill for no-idle-hz.

I think most of the complication is because of the different needs of
various architectures. But if you think the structure can be cut down
further, that would be good to consider.

> I would really like to see how all the fields from the dyntick_timer
> structure are supposed to be used. Especially the who-calls-what graph,
> if I got it right then the low-level arch code calls common code
> functions which in turn call functions from the dyntick_timer structure.
> The question is what should be the connecting points between the arch
> code and the common timer code? With the current code its

> * do_timer()
> * update_process_times()
> * next_timer_event()
> and the non-trivial interactions with rcu via
> * test/set/clear bit on nohz_cpu_mask
> * rcu_pending() and friends.

I think with dyn-tick, next_timer_event is replaced by 
dyn_tick_reprogram_timer().  We should also add add_timer_on() to the
list.



-- 


Thanks and Regards,
Srivatsa Vaddagiri,
Linux Technology Center,
IBM Software Labs,
Bangalore, INDIA - 560017
