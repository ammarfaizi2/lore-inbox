Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261331AbTICBDU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Sep 2003 21:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbTICBDT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Sep 2003 21:03:19 -0400
Received: from dp.samba.org ([66.70.73.150]:36283 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S261331AbTICBDS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Sep 2003 21:03:18 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Hugh Dickins <hugh@veritas.com>
Cc: Jamie Lokier <jamie@shareable.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] Futex non-page-pinning fix 
In-reply-to: Your message of "Tue, 02 Sep 2003 04:23:24 +0100."
             <Pine.LNX.4.44.0309020355160.1923-100000@localhost.localdomain> 
Date: Wed, 03 Sep 2003 09:58:06 +1000
Message-Id: <20030903010318.18D972C100@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <Pine.LNX.4.44.0309020355160.1923-100000@localhost.localdomain> you 
write:
> On Mon, 1 Sep 2003, Hugh Dickins wrote:
> > 
> > 5. If you're not doing anything in __remove_from_page_cache (rightly
> > trying to avoid hotpath), you do need to futex_rehash in mm/swap_state.c
> > __delete_from_swap_cache (last time I did say without the __s, but that
> > would miss an instance you need to catch).  That will handle the swapoff
> > case amongst others.
> 
> Of course, the reason I originally said without the __s, was because
> move_from_swap_cache uses __delete_from_swap_cache, and we don't want
> interference there.  So best convert that to use __remove_from_page_cache
> instead, with INC_CACHE_INFO(del_total) outside the locking, after the
> set_page_dirty: would improve symmetry between move_from_ and move_to_.

But you previously said:

Message-ID: <Pine.LNX.4.44.0309012053110.1817-100000@localhost.localdomain>
> 2. Please leave mm/swap_state.c's move_to_swap_cache and move_from_swap_
> cache out of it.  I already explained how those are for tmpfs files, and
> it's only the file mapping and index you need to worry about, you won't
> see a such page while it's assigned to swapper_space.  If you're anxious
> to show that you've visited everywhere that modifies page->mapping, then
> add a comment or BUG, but not code which could mislead people into
> thinking futexes really need to be rehashed there.

Confused,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
