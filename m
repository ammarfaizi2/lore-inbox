Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261668AbVDBDL1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261668AbVDBDL1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 22:11:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262981AbVDBDL1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 22:11:27 -0500
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:63655 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261668AbVDBDLY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 22:11:24 -0500
Message-ID: <424E0D58.1070700@yahoo.com.au>
Date: Sat, 02 Apr 2005 13:11:20 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
CC: mingo@elte.hu, akpm@osdl.org, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com
Subject: Re: [patch] sched: improve pinned task handling again!
References: <20050401185812.A5598@unix-os.sc.intel.com>
In-Reply-To: <20050401185812.A5598@unix-os.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siddha, Suresh B wrote:

> 
> This time Ken Chen brought up this issue -- No it has nothing to do with 
> industry db benchmark ;-) 
> 
> Even with the above mentioned Nick's patch in -mm, I see system livelock's 
> if for example I have 7000 processes pinned onto one cpu (this is on the 
> fastest 8-way system I have access to). I am sure there will be other 
> systems where this problem can be encountered even with lesser pin count.
> 

Thanks for testing these patches in -mm, by the way.

> We tried to fix this issue but as you know there is no good mechanism
> in fixing this issue with out letting the regular paths know about this.
> 
> Our proposed solution is appended and we tried to minimize the affect on 
> fast path.  It builds up on Nick's patch and once this situation is detected,
> it will not do any more move_tasks as long as busiest cpu is always the 
> same cpu and the queued processes on busiest_cpu, their
> cpu affinity remain same(found out by runqueue's "generation_num")
> 

7000 running processes pinned into one CPU. I guess that isn't a
great deal :(

How important is this? Any application to real workloads? Even if
not, I agree it would be nice to improve this more. I don't know
if I really like this approach - I guess due to what it adds to
fastpaths.

Now presumably if the all_pinned logic is working properly in the
first place, and it is correctly causing balancing to back-off, you
could tweak that a bit to avoid livelocks? Perhaps the all_pinned
case should back off faster than the usual doubling of the interval,
and be allowed to exceed max_interval?

Any thoughts Ingo?

-- 
SUSE Labs, Novell Inc.

