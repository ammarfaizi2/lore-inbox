Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261273AbVFFKhV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261273AbVFFKhV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 06:37:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261276AbVFFKhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 06:37:21 -0400
Received: from smtp202.mail.sc5.yahoo.com ([216.136.129.92]:53934 "HELO
	smtp202.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261273AbVFFKhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 06:37:10 -0400
Message-ID: <42A42745.9080103@yahoo.com.au>
Date: Mon, 06 Jun 2005 20:36:53 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: "M.Baris Demiray" <baris@labristeknoloji.com>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.12-rc5-mm2] [sched] add allowed CPUs check into find_idlest_group()
References: <42A3381F.90801@labristeknoloji.com> <42A3AA63.7060201@yahoo.com.au> <42A42FDE.2040600@labristeknoloji.com>
In-Reply-To: <42A42FDE.2040600@labristeknoloji.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

M.Baris Demiray wrote:
> 
> Hello Nick,
> 
> Nick Piggin wrote:
> 
>> M.Baris Demiray wrote:
>>
>> [...]
>> Close.
>>
>> Probably it would be better to take the intersection of
>> (group->cpumask, p->cpus_allowed), and skip the group if
>> the intersection is empty.
> 
> 
> But, isn't it required for us to be allowed to run on _every_
> CPU in that group. If we take intersection and continue if
> that's not empty, then there could be CPUs in group that are
> not allowed. Since any CPU then can be the idlest in that
> group we can be assigned to a CPU that is not allowed.
> Missing something?
> 

That should be OK. We basically aren't too interested in
exactly which CPU it should go to, but just that it should
go to that group.

If the group is determined to be the idlest, and there is
a CPU that can run the task, then that's all we need.

>  > [...]
> 
>>
>> I don't think it does anything ;)
> 
> 
> LOL. Hope next one'll do.
> 
> Meanwhile, what is the problem with that patch? Not traversing
> the CPUs correctly or continue;ing is wrong?
> 
>     for_each_cpu_mask(i, group->cpumask) {
>         if (!cpu_isset(i, p->cpus_allowed))
>             continue;
>     }
> 

In Linux, the for_* macros actually *are* for loops. So that is
that loop that your continue continues, and seeing as it is at
the end of that for loop, it does nothing.

Thanks,
Nick

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
