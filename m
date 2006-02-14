Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030523AbWBNJHn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030523AbWBNJHn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 04:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030524AbWBNJHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 04:07:42 -0500
Received: from fmr21.intel.com ([143.183.121.13]:63641 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S1030523AbWBNJHm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 04:07:42 -0500
Date: Tue, 14 Feb 2006 01:07:12 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: Peter Williams <pwil3058@bigpond.net.au>
Cc: Andrew Morton <akpm@osdl.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>, kernel@kolivas.org,
       npiggin@suse.de, mingo@elte.hu, rostedt@goodmis.org,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [rfc][patch] sched: remove smpnice
Message-ID: <20060214010712.B20191@unix-os.sc.intel.com>
References: <43ED3D6A.8010300@bigpond.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <43ED3D6A.8010300@bigpond.net.au>; from pwil3058@bigpond.net.au on Fri, Feb 10, 2006 at 05:27:06PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 10, 2006 at 05:27:06PM -0800, Peter Williams wrote:
>> "Siddha, Suresh B" <suresh.b.siddha@intel.com> wrote:
>>>My testing showed that 178.galgel in SPECfp2000 is down by 
>~10% when run with 
>>>nice -20 on a 4P(8-way with HT) system compared to a nice-0 run.
>
>Is it normal to run enough -20 tasks to cause this problem to manifest?

On a 4P(8-way with HT), if you run a -20 task(a simple infinite loop)
it hops from one processor to another processor... you can observe it
using top.

find_busiest_group() thinks there is an imbalance and ultimately the
idle cpu kicks active load balance on busy cpu, resulting in the hopping.

>>>
>>>b) On a lightly loaded system, this can result in HT 
>scheduler optimizations
>>>being disabled in presence of low priority tasks... in this 
>case, they(low
>>>priority ones) can end up running on the same package, even 
>in the presence 
>>>of other idle packages.. Though this is not as serious as 
>"a" above...
>>>
>
>I think that this issue comes under the heading of "Result of better 
>nice enforcement" which is the purpose of the patch :-).  I wouldn't 
>call this HT disablement or do I misunderstand the issue.
>
>The only way that I can see load balancing subverting the HT 
>scheduling 
>mechanisms is if (say) there are 2 CPUs with 2 HT channels 
>each and all 
>of the high priority tasks end up sharing the 2 channels of one CPU 
>while all of the low priority tasks share the 2 channels of the other 
>one.  This scenario is far more likely to happen without the smpnice 
>patches than with them.

I agree with you.. But lets take a DP system with HT, now if there are
only two low priority tasks running, ideally we should be running them
on two different packages. With this patch, we may end up running on the
same logical processor.. leave alone running on the same package..
As these are low priority tasks, it might be ok.. But...

thanks,
suresh
