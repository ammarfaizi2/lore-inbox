Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262990AbVDBEOR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262990AbVDBEOR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 23:14:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262995AbVDBEOQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 23:14:16 -0500
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:58194 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262990AbVDBEMr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 23:12:47 -0500
Message-ID: <424E1BBB.50800@yahoo.com.au>
Date: Sat, 02 Apr 2005 14:12:43 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
CC: mingo@elte.hu, akpm@osdl.org, linux-kernel@vger.kernel.org,
       kenneth.w.chen@intel.com
Subject: Re: [patch] sched: improve pinned task handling again!
References: <20050401185812.A5598@unix-os.sc.intel.com> <424E0D58.1070700@yahoo.com.au> <20050401200509.C5598@unix-os.sc.intel.com>
In-Reply-To: <20050401200509.C5598@unix-os.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siddha, Suresh B wrote:
> On Sat, Apr 02, 2005 at 01:11:20PM +1000, Nick Piggin wrote:
> 
>>How important is this? Any application to real workloads? Even if
>>not, I agree it would be nice to improve this more. I don't know
>>if I really like this approach - I guess due to what it adds to
>>fastpaths.
> 
> 
> Ken initially observed with older kernels(2.4 kernel with Ingo's sched), it was 
> happening with few hundred processes. 2.6 is not that bad and it improved
> with recent fixes. It is not very important. We want to raise the flag
> and see if we can comeup with a decent solution.
> 

OK.

> We changed nr_running from "unsigned long" to "unsigned int". So on 64-bit
> architectures, our change to fastpath is not a big deal.
> 

Yeah I see. You are looking at data from remote runqueues a bit
more often too, although I think they're all places where the
remote cacheline would have already been touched recently.

> 
>>Now presumably if the all_pinned logic is working properly in the
>>first place, and it is correctly causing balancing to back-off, you
>>could tweak that a bit to avoid livelocks? Perhaps the all_pinned
>>case should back off faster than the usual doubling of the interval,
>>and be allowed to exceed max_interval?
> 
> 
> Coming up with that number(how much to exceed) will be a big task. It depends
> on number of cpus and how fast they traverse the runqueue,...
> 

Well we probably don't need to really fine tune it a great deal.
Just pick a lage number that should work OK on most CPU speeds
and CPU counts.

-- 
SUSE Labs, Novell Inc.

