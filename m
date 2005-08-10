Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965197AbVHJQdK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965197AbVHJQdK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 12:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965198AbVHJQdK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 12:33:10 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:21915 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S965197AbVHJQdJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 12:33:09 -0400
Date: Wed, 10 Aug 2005 17:32:48 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: How to reclaim inode pages on demand
In-Reply-To: <20050808160844.04d1f7ac.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0508101730441.11984@skynet>
References: <Pine.LNX.4.58.0508081650160.26013@skynet> <20050808160844.04d1f7ac.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Aug 2005, Andrew Morton wrote:

> Mel Gorman <mel@csn.ul.ie> wrote:
> >
> > Hi,
> >
> > I am working on a direct reclaim strategy to free up large blocks of
> > contiguous pages. The part I have is working fine, but I am finding a
> > hundreds of pages that are being used for inodes that I need to reclaim. I
> > tried purging the inode lists using a variation of prune_icache() but it
> > is not working out.
> >
> > Given a struct page, that one knows is an inode, can anyone suggest the
> > best way to find the inode using it and free it?
>
> Simple answer: invalidate_mapping_pages(page->mapping, start, end).
>

The majority of pages I am seeing no longer have page->mapping set. Does
this mean they are in the process of being cleared up?

> Problem: races.  If you pick a random page up off the LRU and start playing
> with its mapping, what stops that mapping from getting freed under your
> feet?
>

Nothing at all, which explains why I occasionally got oops when I was
trying to free pages with the mapping set. I am going to follow your
suggestions and see how I get on.

If it is still not working out, I will try reclaiming when the workload is
something other than a large number of kernel compiles to see if I am on
the right track at all.

Thanks a lot
