Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750805AbWATKlB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750805AbWATKlB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 05:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbWATKlB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 05:41:01 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:36830 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1750805AbWATKlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 05:41:00 -0500
Message-ID: <43D0BE27.5000807@jp.fujitsu.com>
Date: Fri, 20 Jan 2006 19:40:39 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Mel Gorman <mel@csn.ul.ie>
CC: Joel Schopp <jschopp@austin.ibm.com>, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org, lhms-devel@lists.sourceforge.net
Subject: Re: [Lhms-devel] Re: [PATCH 0/5] Reducing fragmentation using zones
References: <20060119190846.16909.14133.sendpatchset@skynet.csn.ul.ie> <43CFE77B.3090708@austin.ibm.com> <43D02B3E.5030603@jp.fujitsu.com> <Pine.LNX.4.58.0601200102040.15823@skynet> <43D03C24.5080409@jp.fujitsu.com> <Pine.LNX.4.58.0601200934300.10920@skynet>
In-Reply-To: <Pine.LNX.4.58.0601200934300.10920@skynet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman wrote:>
> What sort of tests would you suggest? 
> The tests I have been running to date are
> 
> "kbuild + aim9" for regression testing
> 
> "updatedb + 7 -j1 kernel compiles + highorder allocation" for seeing how
> easy it was to reclaim contiguous blocks
> 
> What tests could be run that would be representative of real-world
> workloads?
> 

1. Using 1000+ processes(threads) at once
2. heavy network load.
3. running NFS
is maybe good.

>>>> And, for people who want to remove range of memory, list-based approach
>>>> will
>>>> need some other hook and its flexibility is of no use.
>>>> (If list-based approach goes, I or someone will do.)
>>>>
>>> Will do what?
>>>
>> add kernelcore= boot option and so on :)
>> As you say, "In an ideal world, we would have both".
>>
> 
> List-based was frowned at for adding complexity to the main path so we may
> not get list-based built on top of zone based even though it is certinatly
> possible. One reason to do zone-based was to do a comparison between them
> in terms of complexity. Hopefully, Nick Piggin (as the first big objector
> to the list-based approach) will make some sort of comment on what he
> thinks of zone-based in comparison to list-based.
> 
I think there is another point.

what I concern about is Linus's word ,this:
> My point is that regardless of what you _want_, defragmentation is 
> _useless_. It's useless simply because for big areas it is so expensive as 
> to be impractical.

You should make your own answer for this before posting.

 From the old threads (very long!), I think  one of the point was :
To use hugepages, sysadmin can specifies what he wants at boot time.
This guarantees 100% allocation of needed huge pages.
Why memhotplug cannot specifies "how much they can remove" before booting.
This will guaranntee 100% memory hotremove.

I think hugetlb and memory hotplug cannot be good reason for defragment.

Finding the reason for defragment is good.
Unfortunately, I don't know the cases of memory allocation failure
because of fragmentation with recent kernel.

-- Kame


