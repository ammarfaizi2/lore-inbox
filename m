Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261416AbUE0Fhm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbUE0Fhm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 01:37:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbUE0Fhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 01:37:42 -0400
Received: from smtp015.mail.yahoo.com ([216.136.173.59]:23953 "HELO
	smtp015.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261416AbUE0Fhk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 01:37:40 -0400
Message-ID: <40B57E9D.8020606@yahoo.com.au>
Date: Thu, 27 May 2004 15:37:33 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: Buddy Lumpkin <b.lumpkin@comcast.net>
CC: "'John Bradford'" <john@grabjohn.com>,
       "'William Lee Irwin III'" <wli@holomorphy.com>, orders@nodivisions.com,
       linux-kernel@vger.kernel.org
Subject: Re: why swap at all?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Buddy Lumpkin wrote:
>>>Couple that with the fact that there are many pte's pointing at the same
>>>physical page (shared page) in many cases where many processes 
>>>
>>>are running
>>>on the system. Because all of the references to that page must be removed
>>>before the page can be evicted, there are some absolute 
>>>limitations in the
>>>rate that pages can be evicted from memory as the number of processes
>>>running on the system and the total amount of memory increases.
>>>
> 
> 
>>This is still many orders of magnitude faster than filling the page
>>from disk, and you typically don't reclaim much of mapped memory anyway.
> 
> 
> This discussion went broke-minded again. Your still picturing that single
> IDE hard drive in your workstation and im talking about big iron, large
> databases, etc.. where the total amount of aggregate disk I/O is completely
> limited by the rate you can evict pages from the pagecache.
> 
> Picture 6 to 7 fibre channel cards with over 70% utilization during peak
> usage times connected to a large EMC storage array with 64GB of non-volatile
> cache.
> 

I can picture it but I don't know how the kernel is going to handle
it. All I am doing is speaking from what I have seen.

http://marc.theaimsgroup.com/?l=linux-kernel&m=107817776322044&w=2

This post for example, has profiles of a 32 CPU system with 16 FC
controllers and over 1000 disks, doing some database workload. Does
this qualify as big iron?

In the bottom profile, you see the disks being kept busy with 50%
idle time. The top 6 functions are all to do with generating IO
requests and pushing them through the block layer, none of them
involve memory reclaim.

There are profiles from a different setup in a related thread here:

http://groups.google.com.au/groups?q=g:thl3816668183d&dq=&hl=en&lr=&ie=UTF-8&selm=1yjKu-7qU-1%40gated-at.bofh.it&rnum=9

I think we see kmem_cache_alloc make a miserable showing for the
memory allocation team, but it wouldn't even be there if the
profile were sorted by ticks (the left hand column).


Now If you had some experiences of memory reclaim slowing down
block IO, I'd love to hear them because that is related to an area
that I am looking at currently. I'm not saying what you claim is
impossible, but it is something that shouldn't happen and we don't
relly see... You're continuing to insist there is a problem but
that simply isn't helpful without further details.
