Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262457AbUBXUz7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Feb 2004 15:55:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262452AbUBXUz7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Feb 2004 15:55:59 -0500
Received: from nat-pool-bos.redhat.com ([66.187.230.200]:2433 "EHLO
	chimarrao.boston.redhat.com") by vger.kernel.org with ESMTP
	id S262457AbUBXUz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Feb 2004 15:55:57 -0500
Date: Tue, 24 Feb 2004 15:55:47 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>
cc: Chris Wedgwood <cw@f00f.org>, <piggin@cyberone.com.au>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vm-fix-all_zones_ok (was Re: 2.6.3-mm3)
In-Reply-To: <20040224012222.453e7db7.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0402241553550.21522-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 24 Feb 2004, Andrew Morton wrote:
> Chris Wedgwood <cw@f00f.org> wrote:
> > On Tue, Feb 24, 2004 at 03:11:40PM +1100, Nick Piggin wrote:
> > 
> > > Out of interest, what is the worst you can make it do with
> > > contrived cases?
> > 
> > 700MB slab used.
> 
> Sigh.  There is absolutely nothing wrong with having a large slab cache. 
> And there is nothing necessarily right about having a small one.

Could it be that the lower zone protection stuff simply means
that Chris's system only ever allocates page cache and anonymous
memory from his 600 MB highmem, leaving the 900 MB lowmem for
the slab cache to roam freely ?

I guess highmem allocations really should put some pressure on
lowmem, even when there is enough lowmem free, because otherwise
you end up effectively not using half of the memory on 1.5-2 GB
systems for paging ...

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

