Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268249AbUGXDJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268249AbUGXDJa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 23:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268251AbUGXDJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 23:09:30 -0400
Received: from smtp107.mail.sc5.yahoo.com ([66.163.169.227]:56431 "HELO
	smtp107.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268249AbUGXDJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 23:09:28 -0400
Message-ID: <4101D2E0.2000108@yahoo.com.au>
Date: Sat, 24 Jul 2004 13:09:20 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
CC: Dimitri Sivanich <sivanich@sgi.com>, Andrew Morton <akpm@osdl.org>,
       Anton Blanchard <anton@samba.org>, Andi Kleen <ak@suse.de>,
       Ingo Molnar <mingo@elte.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] consolidate sched domains
References: <41008386.9060009@yahoo.com.au> <20040723153022.GA16563@sgi.com> <200407231450.47070.suresh.b.siddha@intel.com>
In-Reply-To: <200407231450.47070.suresh.b.siddha@intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siddha, Suresh B wrote:
> On Friday 23 July 2004 08:30, Dimitri Sivanich wrote:
> 
>>On Fri, Jul 23, 2004 at 01:18:30PM +1000, Nick Piggin wrote:
>>
>>>The attached patch is against 2.6.8-rc1-mm1. Tested on SMP, UP and SMP+HT
>>>here and it seems to be OK.
>>>
>>>I have included the cpu_sibling_map for ppc64, although Anton said he did
>>>have an implementation floating around which he would probably prefer,
>>>but I'll let him deal with that.
>>
>>Do other architectures need to define their own cpu_sibling_maps, or am I
>>missing something that would define that for IA64 and others?
> 
> 
> Nick means, all the architectures which use CONFIG_SCHED_SMT needs to define 
> cpu_sibling_map.
> 

That's right.

> Nick, aren't you missing the attached fix in your patch?
> 

Indeed I am. Good catch, thanks.

> thanks,
> suresh
> 
> 
> ------------------------------------------------------------------------
> 
> --- linux-2.6.8-rc1/kernel/sched.c~	2004-07-23 13:19:48.000000000 -0700
> +++ linux-2.6.8-rc1/kernel/sched.c	2004-07-23 13:34:49.000000000 -0700
> @@ -3845,6 +3845,8 @@
>  		sd->groups->cpu_power = power;
>  
>  #ifdef CONFIG_NUMA
> +		if (i != first_cpu(sd->groups->cpumask))
> +			continue;
>  		sd = &per_cpu(node_domains, i);
>  		sd->groups->cpu_power += power;
>  #endif

