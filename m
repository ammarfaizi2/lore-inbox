Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965241AbVHJR7O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965241AbVHJR7O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 13:59:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965242AbVHJR7O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 13:59:14 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:34210 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S965241AbVHJR7N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 13:59:13 -0400
Date: Wed, 10 Aug 2005 18:59:12 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: How to reclaim inode pages on demand
In-Reply-To: <1123696225.15970.10.camel@localhost>
Message-ID: <Pine.LNX.4.58.0508101851520.11984@skynet>
References: <Pine.LNX.4.58.0508081650160.26013@skynet> 
 <20050808160844.04d1f7ac.akpm@osdl.org>  <Pine.LNX.4.58.0508101730441.11984@skynet>
  <20050810101714.147e1333.akpm@osdl.org>  <Pine.LNX.4.58.0508101819340.11984@skynet>
 <1123696225.15970.10.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Aug 2005, Dave Hansen wrote:

> On Wed, 2005-08-10 at 18:27 +0100, Mel Gorman wrote:
> > I later linearly scan the mem_map looking for pages that can be freed up
> > (usually LRU pages). I was expecting any page with PG_inode set to have a
> > page->mapping but not all of them do. It is the pages without a ->mapping
> > that are confusing the hell out of me.
>
> How about putting a check for PG_inode and a periodic dump_stack()
> wherever page->mapping is cleared?  That should at least let you catch
> the culprit who is clearing them. __remove_from_page_cache() is the only
> real place I see this being done.
>

Will do, it might shed some light on whats happening.

> Are you remembering to clean PG_inode when a page is freed?

Yes, I was using the allocator to count how many inode-related pages there
were in the system. The answer was lots, another reason why I'm thinking
that I picked the worst possible benchmark to test this stuff with.

> Perhaps
> it's allocated for the page cache, reclaimed, returned to the allocator,
> and reallocated as anonymous memory where you're seeing the null
> ->mapping.  Might want to check for PG_inode in free_pages_check().
>

I am 99.99% certain I make that check but I can't double check the code
until late in the weekend.

-- 
Mel Gorman
Part-time Phd Student                          Java Applications Developer
University of Limerick                         IBM Dublin Software Lab
