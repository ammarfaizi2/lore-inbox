Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261464AbTJHRqd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 13:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbTJHRqc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 13:46:32 -0400
Received: from intra.cyclades.com ([64.186.161.6]:60127 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S261464AbTJHRqb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 13:46:31 -0400
Date: Wed, 8 Oct 2003 14:41:13 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Hugh Dickins <hugh@veritas.com>
Cc: Rik van Riel <riel@redhat.com>, <Matt_Domsch@Dell.com>,
       <marcelo.tosatti@cyclades.com>, <linux-kernel@vger.kernel.org>,
       <benh@kernel.crashing.org>
Subject: Re: [PATCH] page->flags corruption fix
In-Reply-To: <Pine.LNX.4.44.0310081752140.3312-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0310081440460.1875-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 8 Oct 2003, Hugh Dickins wrote:

> On Wed, 8 Oct 2003, Rik van Riel wrote:
> > 
> > 1) cpu A adds page P to the swap cache, loading page->flags
> >    and modifying it locally
> 
> Right, the add_to_swap_cache in try_to_swap_out.
> 
> > 2) a second thread scans a page table entry and sees that
> >    the page was accessed, so cpu B moves page P to the
> >    active list
> 
> Right, the mark_page_accessed in try_to_swap_out
> (I don't see any other mark_page_accessed as problematic).
> Or the del_page_from_active_list in refill_inactive.
> 
> > 3) cpu A undoes the PG_inactive -> PG_active bit change,
> >    corrupting the page->flags of P
> 
> (Mainline is easier than -rmap since no separate PG_inactive bit.)
> 
> Thanks a lot for explaining, I see it now.  Personally I'd prefer a
> lighter weight patch, either pagemap_lru_lock within add_to_swap_cache,
> or better moving the PG_flags clearing from __add_to_page_cache into
> __free_pages_ok, where I still believe it can be done non-atomically.
> 
> But you've proved your point, and I understand you preferring a more
> straightforward and future-proof way.  I'm not writing an alternative
> patch, don't let me stand in the way of progress...
> 
> A little of the above explanation in the change comment would be nice.

Maybe comments on top of the code? 

Rik? :)

