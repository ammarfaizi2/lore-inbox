Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964989AbWD0I7W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964989AbWD0I7W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 04:59:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964995AbWD0I7W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 04:59:22 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:64785 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S964989AbWD0I7V (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 04:59:21 -0400
Date: Thu, 27 Apr 2006 11:00:00 +0200
From: Jens Axboe <axboe@suse.de>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, npiggin@suse.de, linux-mm@kvack.org
Subject: Re: Lockless page cache test results
Message-ID: <20060427090000.GA23137@suse.de>
References: <20060426135310.GB5083@suse.de> <20060426095511.0cc7a3f9.akpm@osdl.org> <20060426174235.GC5002@suse.de> <20060426111054.2b4f1736.akpm@osdl.org> <Pine.LNX.4.64.0604261144290.3701@g5.osdl.org> <20060426191557.GA9211@suse.de> <20060426131200.516cbabc.akpm@osdl.org> <20060427074533.GJ9211@suse.de> <4450796A.2030908@yahoo.com.au> <44507AA9.2010005@yahoo.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44507AA9.2010005@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 27 2006, Nick Piggin wrote:
> Nick Piggin wrote:
> >Jens Axboe wrote:
> >
> >>Things look pretty bad for the lockless kernel though, Nick any idea
> >>what is going on there? The splice change is pretty simple, see the top
> >>three patches here:
> >
> >
> >Could just be the use of spin lock instead of read lock.
> >
> >I don't think it would be hard to convert find_get_pages_contig
> >to be lockless.
> >
> >Patched vanilla numbers look nicer, but I'm curious as to why
> >__do_page_cache was so bad before, if the file was in cache.
> >Presumably it should not more than double tree_lock acquisition...
> >it isn't getting called multiple times for each page, is it?
> 
> Hmm, what's more, find_get_pages_contig shouldn't result in any
> fewer tree_lock acquires than the open coded thing there now
> (for the densely populated pagecache case).

How do you figure? The open coded one does a find_get_page() on each
page in that range, so for x number of pages we'll grab and release
->tree_lock x times.

For the fully populated page case, find_get_pages_contig() should return
the full range of x pages with just one grab/release of ->tree_lock.

-- 
Jens Axboe

