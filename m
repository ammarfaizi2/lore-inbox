Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262134AbVDFHtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262134AbVDFHtz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 03:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262136AbVDFHtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 03:49:55 -0400
Received: from smtp204.mail.sc5.yahoo.com ([216.136.130.127]:18851 "HELO
	smtp204.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262134AbVDFHtw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 03:49:52 -0400
Message-ID: <4253949A.3040707@yahoo.com.au>
Date: Wed, 06 Apr 2005 17:49:46 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20050105 Debian/1.7.5-1
X-Accept-Language: en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: [patch 1/5] sched: remove degenerate domains
References: <425322E0.9070307@yahoo.com.au> <20050406054412.GA5853@elte.hu>
In-Reply-To: <20050406054412.GA5853@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> 
> 
>>This is Suresh's patch with some modifications.
> 
> 
>>Remove degenerate scheduler domains during the sched-domain init.
> 
> 
> actually, i'd suggest to not do this patch. The point of booting with a 
> CONFIG_NUMA kernel on a non-NUMA box is mostly for testing, and the 
> 'degenerate' toplevel domain exposed conceptual bugs in the 
> sched-domains code. In that sense removing such 'unnecessary' domains 
> inhibits debuggability to a certain degree. If we had this patch earlier 
> we'd not have experienced the wrong decisions taken by the scheduler, 
> only on the much rarer 'really NUMA' boxes.
> 

True. Although I'd imagine it may be something distros may want.
For example, a generic x86-64 kernel for both AMD and Intel systems
could easily have SMT and NUMA turned on.

I agree with the downside of exercising less code paths though.

What about putting as a (default to off for 2.6) config option in
the config embedded menu?

> is there any case where we'd want to simplify the domain tree? One more 
> domain level is just one (and very minor) aspect of CONFIG_NUMA - i'd 
> not want to run a CONFIG_NUMA kernel on a non-NUMA box, even if the 
> domain tree got optimized. Hm?
> 

I guess there is the SMT issue too, and even booting an SMP kernel
on a UP system. Also small ia64 NUMA systems will probably have one
redundant NUMA level.

If/when topologies get more complex (for example, the recent Altix
discussions we had with Paul), it will be generally easier to set
up all levels in a generic way, then weed them out using something
like this, rather than put the logic in the domain setup code.

Nick

-- 
SUSE Labs, Novell Inc.

