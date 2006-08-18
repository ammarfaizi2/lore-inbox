Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751325AbWHRJfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751325AbWHRJfz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Aug 2006 05:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbWHRJfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Aug 2006 05:35:55 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:1299 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751325AbWHRJfy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Aug 2006 05:35:54 -0400
Message-ID: <44E58A89.8040001@sw.ru>
Date: Fri, 18 Aug 2006 13:38:17 +0400
From: Kirill Korotaev <dev@sw.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: rohitseth@google.com
CC: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>, hugh@veritas.com,
       ckrm-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>
Subject: Re: [RFC][PATCH 5/7] UBC: kernel memory accounting (core)
References: <44E33893.6020700@sw.ru>  <44E33C8A.6030705@sw.ru>	 <1155752693.22595.76.camel@galaxy.corp.google.com> <44E46ED3.7000201@sw.ru> <1155834136.14617.29.camel@galaxy.corp.google.com>
In-Reply-To: <1155834136.14617.29.camel@galaxy.corp.google.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rohit Seth wrote:
> On Thu, 2006-08-17 at 17:27 +0400, Kirill Korotaev wrote:
> 
>>>If I'm reading this patch right then seems like you are making page
>>>allocations to fail w/o (for example) trying to purge some pages from
>>>the page cache belonging to this container.  Or is that reclaim going to
>>>come later?
>>
>>charged kernel objects can't be _reclaimed_. how do you propose
>>to reclaim tasks page tables or files or task struct or vma or etc.?
> 
> 
> 
> I agree that kernel objects cann't be reclaimed easily.  But what you
> are proposing is also not right.  Returning failure w/o doing any
> reclaim on pages (that are reclaimable) is not useful.  And this is why
> I asked, is this change going to be part of next set of patches (as
> current set of patches are only tracking kernel usage).
1. reclaiming user resources is not that good idea as it looks to you.
such solutions end up with lots of resources spent on reclaim.
for user memory reclaims mean consumption of expensive disk I/O bandwidth
which reduces overall system throughput and influences other users.

2. kernel memory is mostly not reclaimable. can you reclaim vma structs or ipc ids?
even with page tables it is not that easy.
And the fact is:
 - kernel memory consumtion is usually less then user memory,
   so it's not worth reclaiming it.
 - reclaiming can result in kind of user service deadlocks when you are
   unable to handle user requests gracefully anymore.
   See my email to Dave with an example.
 - our solution _is_ right and works (for >3 years in production already).
   If desired it _can_ be extended with reclamation.

Kirill

