Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261611AbUKVXNV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261611AbUKVXNV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 18:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261862AbUKVXKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 18:10:21 -0500
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:42377 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261611AbUKVXJj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 18:09:39 -0500
Message-ID: <41A271AE.7090802@yahoo.com.au>
Date: Tue, 23 Nov 2004 10:09:34 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041007 Debian/1.7.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: Andrew Morton <akpm@osdl.org>, hugh@veritas.com, torvalds@osdl.org,
       benh@kernel.crashing.org, linux-mm@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: deferred rss update instead of sloppy rss
References: <Pine.LNX.4.44.0411221457240.2970-100000@localhost.localdomain> <Pine.LNX.4.58.0411221343410.22895@schroedinger.engr.sgi.com> <20041122141148.1e6ef125.akpm@osdl.org> <Pine.LNX.4.58.0411221408540.22895@schroedinger.engr.sgi.com> <20041122144507.484a7627.akpm@osdl.org> <Pine.LNX.4.58.0411221444410.22895@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.58.0411221444410.22895@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:
> On Mon, 22 Nov 2004, Andrew Morton wrote:
> 
> 
>>>The page fault code only increments rss. For larger transactions that
>>>increase / decrease rss significantly the page_table_lock is taken and
>>>mm->rss is updated directly. So no
>>>gross inaccuracies can result.
>>
>>Sure.  Take a million successive pagefaults and mm->rss is grossly
>>inaccurate.  Hence my suggestion that it be spilled into mm->rss
>>periodically.
> 
> 
> It is spilled into mm->rss periodically. That is the whole point of the
> patch.
> 
> The timer tick occurs every 1 ms. The maximum pagefault frequency that I
> have  seen is 500000 faults /second. The max deviation is therefore
> less than 500 (could be greater if page table lock / mmap_sem always held
> when the tick occurs).


You could imagine a situation where something pagefaults and sleeps in
lock-step with the timer though. Theoretical problem only?

I think that by the time you get the spilling code in, the mm-list method
will be looking positively elegant!

