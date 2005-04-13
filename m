Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261213AbVDMXHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261213AbVDMXHM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 19:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261214AbVDMXHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 19:07:11 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:63843 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261213AbVDMXHD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 19:07:03 -0400
Message-ID: <425DA60A.4090208@yahoo.com.au>
Date: Thu, 14 Apr 2005 09:06:50 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
CC: Ingo Molnar <mingo@elte.hu>, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [patch] sched: fix active load balance
References: <20050413120713.A25137@unix-os.sc.intel.com> <20050413200828.GB27088@elte.hu> <20050413132833.B25137@unix-os.sc.intel.com>
In-Reply-To: <20050413132833.B25137@unix-os.sc.intel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Siddha, Suresh B wrote:
> On Wed, Apr 13, 2005 at 10:08:28PM +0200, Ingo Molnar wrote:
> 
>>* Siddha, Suresh B <suresh.b.siddha@intel.com> wrote:
>>
>>
>>>-	for_each_domain(target_cpu, sd) {
>>>+	for_each_domain(target_cpu, sd)
>>> 		if ((sd->flags & SD_LOAD_BALANCE) &&
>>>-			cpu_isset(busiest_cpu, sd->span)) {
>>>-				sd = tmp;
>>>+			cpu_isset(busiest_cpu, sd->span))
>>> 				break;
>>>-		}
>>>-	}
>>

Yep that was broken :(
Thanks for picking that up Suresh.

>>hm, the right fix i think is to do:
>>
>> 	for_each_domain(target_cpu, tmp) {
>>  		if ((tmp->flags & SD_LOAD_BALANCE) &&
>> 			cpu_isset(busiest_cpu, tmp->span)) {
>> 				sd = tmp;
>>  				break;
>> 		}
>> 	}
> 
> 
> Your suggestion also looks similar to my patch. You are also breaking on the 
> first one.
> 
> 
>>because when balancing we want to match the widest-scope domain, not the 
>>first one.
> 
> 
> We want the first domain spanning both the cpu's. That is the domain where
> normal load balance failed and we restore to active load balance.
> 

Yes, that's right.

-- 
SUSE Labs, Novell Inc.

