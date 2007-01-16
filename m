Return-Path: <linux-kernel-owner+w=401wt.eu-S1751468AbXAPJ5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbXAPJ5p (ORCPT <rfc822;w@1wt.eu>);
	Tue, 16 Jan 2007 04:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbXAPJ5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Jan 2007 04:57:45 -0500
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:34918 "EHLO
	ausmtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751468AbXAPJ5o (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Jan 2007 04:57:44 -0500
Message-ID: <45ACA173.8000207@in.ibm.com>
Date: Tue, 16 Jan 2007 15:27:07 +0530
From: Balbir Singh <balbir@in.ibm.com>
Reply-To: balbir@in.ibm.com
Organization: IBM
User-Agent: Thunderbird 1.5.0.8 (X11/20061117)
MIME-Version: 1.0
To: Roy Huang <royhuang9@gmail.com>
CC: linux-kernel@vger.kernel.org, aubreylee@gmail.com, nickpiggin@yahoo.com.au,
       torvalds@osdl.org
Subject: Re: [PATCH] Provide an interface to limit total page cache.
References: <afe668f90701150139q26e41720lf06d6ee445a917b0@mail.gmail.com> <661de9470701150301i7f315280p5ffa2b388e883f50@mail.gmail.com> <afe668f90701151834u13c75a88sa4592a4a9482d510@mail.gmail.com>
In-Reply-To: <afe668f90701151834u13c75a88sa4592a4a9482d510@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roy Huang wrote:
> Hi Balbir,
> 
> Thanks for your comment.
> 
> On 1/15/07, Balbir Singh <balbir@in.ibm.com> wrote:
> 
>> wakeup_kswapd and shrink_all_memory use swappiness to determine what to reclaim
>> (mapped pages or page cache).  This patch does not ensure that only
>> page cache is
>> reclaimed/limited. If the swappiness value is high, mapped pages will be hit.
>>
> You are right, it is possible to release mapped pages. It can be
> avoided by add a field in "struct scan_control" to determine whether
> mapped pages will be released.
> 

Yes that could be done. I have been trying to figure out if there is a good
reason why the LRU is common for both mapped and pagecache. Does it make
sense to split them up? I am still digging through lkml archives to see
if I can find something.

>> One could get similar functionality by implementing resource management.
>>
>> Resource  management splits tasks into groups and does management of
>> resources for the
>> groups rather than the whole system. Such a facility will come with a
>> resource controller for
>> memory (split into finer grain rss/page cache/mlock'ed memory, etc),
>> one for cpu, etc.
> I s there any more information in detail about resource controller?
> Even there is a resource controller for tasks, all memory is also
> possbile to be eaten up by page cache.


Yes, please see the discussions on lkml on resource management, ckrm,
beancounters and containers.

http://lwn.net/Articles/206697/ RFC for memory controller, might be a good
starting point

-- 

	Balbir Singh,
	Linux Technology Center,
	IBM Software Labs
