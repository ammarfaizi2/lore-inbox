Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261541AbULBBuO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261541AbULBBuO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 20:50:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261543AbULBBuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 20:50:13 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63377 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261541AbULBBuI
	(ORCPT <rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 20:50:08 -0500
Date: Wed, 1 Dec 2004 16:58:27 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Nikita Danilov <nikita@clusterfs.com>
Cc: Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au,
       Linux-Kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH]: 1/4 batch mark_page_accessed()
Message-ID: <20041201185827.GA5459@dmt.cyclades>
References: <16800.47044.75874.56255@gargle.gargle.HOWL> <20041126185833.GA7740@logos.cnet> <41A7CC3D.9030405@yahoo.com.au> <20041130162956.GA3047@dmt.cyclades> <20041130173323.0b3ac83d.akpm@osdl.org> <16813.47036.476553.612418@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16813.47036.476553.612418@gargle.gargle.HOWL>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


<snip>

>  > >  On the other hand, without batching you mix the locality up in LRU - the LRU becomes 
>  > >  more precise in terms of "LRU aging", but less ordered in terms of sequential 
>  > >  access pattern.
>  > > 
>  > >  The disk IO intensive reaim has very significant gain from the batching, its
>  > >  probably due to the enhanced LRU ordering (what Nikita says).
>  > > 
>  > >  The slowdown is probably due to the additional atomic_inc by page_cache_get(). 
>  > > 
>  > >  Is there no way to avoid such page_cache_get there (and in lru_cache_add also)?
>  > 
>  > Not really.  The page is only in the pagevec at that time - if someone does
>  > a put_page() on it the page will be freed for real, and will then be
>  > spilled onto the LRU.  Messy.
> 
> I don't think that atomic_inc will be particularly
> costly. generic_file_{write,read}() call find_get_page() just before
> calling mark_page_accessed(), so cache-line with page reference counter
> is most likely still exclusive owned by this CPU. 

Assuming that is true - what could cause the slowdown? 

There are only benefits from the makr_page_accessed batching, I can't
see any drawbacks. Do you?
