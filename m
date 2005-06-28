Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262364AbVF1BXI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262364AbVF1BXI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Jun 2005 21:23:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262367AbVF1BXI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Jun 2005 21:23:08 -0400
Received: from holomorphy.com ([66.93.40.71]:18318 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262364AbVF1BW6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Jun 2005 21:22:58 -0400
Date: Mon, 27 Jun 2005 18:22:54 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [patch 2] mm: speculative get_page
Message-ID: <20050628012254.GO3334@holomorphy.com>
References: <42BF9CD1.2030102@yahoo.com.au> <42BF9D67.10509@yahoo.com.au> <42BF9D86.90204@yahoo.com.au> <20050627141220.GM3334@holomorphy.com> <42C093B4.3010707@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C093B4.3010707@yahoo.com.au>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> SetPageFreeing is only done in shrink_list(), so other pages in the
>> buddy bitmaps and/or pagecache pages freed by other methods may not

On Tue, Jun 28, 2005 at 10:03:00AM +1000, Nick Piggin wrote:
> It is also done by remove_exclusive_swap_page, although that hunk
> leaked into a later patch (#5), sorry.
> Other methods (eg truncate) don't seem to have an atomicity guarantee
> anyway - ie. it is valid to pick up a reference on a page that is
> just about to get truncated. PageFreeing is only used when some code
> is making an assumption about the number of users of the page.

tmpfs


William Lee Irwin III wrote:
>> be found by this. There's also likely trouble with higher-order pages.

On Tue, Jun 28, 2005 at 10:03:00AM +1000, Nick Piggin wrote:
> There isn't because higher order pages aren't used for pagecache.

hugetlbfs


William Lee Irwin III wrote:
>> page != *pagep won't be reliably tripped unless the pagecache
>> modification has the appropriate memory barriers.

On Tue, Jun 28, 2005 at 10:03:00AM +1000, Nick Piggin wrote:
> There are appropriate memory barriers: the radix tree is
> modified uner the rwlock/spinlock, and this function has
> a memory barrier before testing page != *pagep.

Someone else deal with this (paulus? anton? other arch maintainers?).


William Lee Irwin III wrote:
>> The lockless radix tree lookups are a harder problem than this, and
>> the implementation didn't look promising. I have other problems to deal
>> with so I'm not going to go very far into this.

On Tue, Jun 28, 2005 at 10:03:00AM +1000, Nick Piggin wrote:
> What's wrong with the lockless radix tree lookups?

The above is as much as I wanted to go into it. I need to direct my
capacity for the grunt work of devising adversary arguments elsewhere.


William Lee Irwin III wrote:
>> While I agree that locklessness is the right direction for the
>> pagecache to go, this RFC seems to have too far to go to use it to
>> conclude anything about the subject.

On Tue, Jun 28, 2005 at 10:03:00AM +1000, Nick Piggin wrote:
> You don't seem to have looked enough to conclude anything about it.

You requested comments. I made some.

Anyhow, my review has not been comprehensive. I stopped after the first
few things I found that needed fixing. If others could deal with the
rest of this, I'd be much obliged.


-- wli
