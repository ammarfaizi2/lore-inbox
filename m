Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262190AbVF1Bmn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262190AbVF1Bmn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 21:42:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262195AbVF1Bmn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 21:42:43 -0400
Received: from smtp203.mail.sc5.yahoo.com ([216.136.129.93]:34645 "HELO
	smtp203.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262190AbVF1BmW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 21:42:22 -0400
Message-ID: <42C0AAF8.5090700@yahoo.com.au>
Date: Tue, 28 Jun 2005 11:42:16 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [patch 2] mm: speculative get_page
References: <42BF9CD1.2030102@yahoo.com.au> <42BF9D67.10509@yahoo.com.au> <42BF9D86.90204@yahoo.com.au> <20050627141220.GM3334@holomorphy.com> <42C093B4.3010707@yahoo.com.au> <20050628012254.GO3334@holomorphy.com>
In-Reply-To: <20050628012254.GO3334@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> William Lee Irwin III wrote:
> 
>>>SetPageFreeing is only done in shrink_list(), so other pages in the
>>>buddy bitmaps and/or pagecache pages freed by other methods may not
> 
> 
> On Tue, Jun 28, 2005 at 10:03:00AM +1000, Nick Piggin wrote:
> 
>>It is also done by remove_exclusive_swap_page, although that hunk
>>leaked into a later patch (#5), sorry.
>>Other methods (eg truncate) don't seem to have an atomicity guarantee
>>anyway - ie. it is valid to pick up a reference on a page that is
>>just about to get truncated. PageFreeing is only used when some code
>>is making an assumption about the number of users of the page.
> 
> 
> tmpfs
> 

Well it switches between page and swap cache, but it seems to just
use the normal pagecache / swapcache functions for that. It could be
that I've got a big hole somewhere, but so far I don't think you've
pointed oen out.

> 
> William Lee Irwin III wrote:
> 
>>>be found by this. There's also likely trouble with higher-order pages.
> 
> 
> On Tue, Jun 28, 2005 at 10:03:00AM +1000, Nick Piggin wrote:
> 
>>There isn't because higher order pages aren't used for pagecache.
> 
> 
> hugetlbfs
> 

Well what's the trouble with it?

> 
> William Lee Irwin III wrote:
> 
>>>page != *pagep won't be reliably tripped unless the pagecache
>>>modification has the appropriate memory barriers.
> 
> 
> On Tue, Jun 28, 2005 at 10:03:00AM +1000, Nick Piggin wrote:
> 
>>There are appropriate memory barriers: the radix tree is
>>modified uner the rwlock/spinlock, and this function has
>>a memory barrier before testing page != *pagep.
> 
> 
> Someone else deal with this (paulus? anton? other arch maintainers?).
> 

I know what a memory barrier is and does, so you said the
necessary memory barriers aren't in place, so can you deal
with it?

> 
> William Lee Irwin III wrote:
> 
>>>The lockless radix tree lookups are a harder problem than this, and
>>>the implementation didn't look promising. I have other problems to deal
>>>with so I'm not going to go very far into this.
> 
> 
> On Tue, Jun 28, 2005 at 10:03:00AM +1000, Nick Piggin wrote:
> 
>>What's wrong with the lockless radix tree lookups?
> 
> 
> The above is as much as I wanted to go into it. I need to direct my
> capacity for the grunt work of devising adversary arguments elsewhere.
> 

I don't think there is anything wrong with it. I would be very
keen to see real adversary arguments elsewhere though.

> 
> William Lee Irwin III wrote:
> 
>>>While I agree that locklessness is the right direction for the
>>>pagecache to go, this RFC seems to have too far to go to use it to
>>>conclude anything about the subject.
> 
> 
> On Tue, Jun 28, 2005 at 10:03:00AM +1000, Nick Piggin wrote:
> 
>>You don't seem to have looked enough to conclude anything about it.
> 
> 
> You requested comments. I made some.
> 

Well yeah thanks, you did point out a thinko I made, and that was very
helpful and I value any time you spend looking at it. But just saying
"this is wrong, that won't work, that's crap, ergo the concept is
useless" without finding anything specifically wrong is not very
constructive.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
