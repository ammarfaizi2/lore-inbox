Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932650AbWAFH0m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932650AbWAFH0m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 02:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932652AbWAFH0m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 02:26:42 -0500
Received: from warden-p.diginsite.com ([208.29.163.248]:11742 "HELO
	warden.diginsite.com") by vger.kernel.org with SMTP id S932650AbWAFH0l
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 02:26:41 -0500
Date: Thu, 5 Jan 2006 23:26:11 -0800 (PST)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Eric Dumazet <dada1@cosmosbay.com>
cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Shrinks sizeof(files_struct) and better layout
In-Reply-To: <43BE0FC3.7030602@cosmosbay.com>
Message-ID: <Pine.LNX.4.62.0601052318570.1708@qynat.qvtvafvgr.pbz>
References: <20051108185349.6e86cec3.akpm@osdl.org> <437226B1.4040901@cosmosbay.com>
 <20051109220742.067c5f3a.akpm@osdl.org> <4373698F.9010608@cosmosbay.com>
 <43BB1178.7020409@cosmosbay.com> <p733bk4z2z0.fsf@verdi.suse.de>
 <43BBADD5.3070706@cosmosbay.com> <Pine.LNX.4.62.0601051900440.973@qynat.qvtvafvgr.pbz>
 <43BE0FC3.7030602@cosmosbay.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jan 2006, Eric Dumazet wrote:
> David Lang a écrit :
>> On Wed, 4 Jan 2006, Eric Dumazet wrote:
>>> Andi Kleen a écrit :
>>>> Eric Dumazet <dada1@cosmosbay.com> writes:
>>>>> 1) Reduces the size of (struct fdtable) to exactly 64 bytes on 32bits
>>>>> platforms, lowering kmalloc() allocated space by 50%.
>>>> 
>>>> It should be probably a kmem_cache_alloc() instead of a kmalloc
>>>> in the first place anyways. This would reduce fragmentation.
>>> 
>>> Well in theory yes, if you really expect thousand of tasks running...
>>> But for most machines, number of concurrent tasks is < 200, and using a 
>>> special cache for this is not a win.
>> 
>> is it enough of a win on machines with thousands of concurrent tasks that 
>> it would be a useful config option?
>
> Well..., not if NR_CPUS is big too. (We just saw a thread on lkml about 
> raising NR_CPUS to 1024 on ia64).
>
> On a 1024 CPUS machine, a kmem cache could use at least 1 MB for its internal 
> structures, plus 1024 pages (PAGE_SIZE) for holding the caches (one cache per 
> CPU), if you assume at least one task was created on behalf each cpu.
>
> if PAGE_SIZE is 64KB, you end up with 65 MB of ram for the cache. Even with 
> 100.000 tasks running on the machine, its not a win.
>
> slab caches are very complex machinery that consume O(NR_CPUS) ram.

Ok, so if you have large numbers of CPU's and large page sizes it's not 
useful. however, what about a 2-4 cpu machine with 4k page 
sizes, 8-32G of ram (a not unreasonable Opteron system config) that will 
be running 5,000-20,000 processes/threads?

I know people argue that programs that do such things are bad (and I 
definantly agree that they aren't optimized), but the reality is that some 
workloads are like that. if a machine is being built for such uses 
configuring the kernel to better tolorate such use may be useful

David Lang


-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare

