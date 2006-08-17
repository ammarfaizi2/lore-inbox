Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964771AbWHQQ1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964771AbWHQQ1K (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Aug 2006 12:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965052AbWHQQ1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Aug 2006 12:27:09 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:11914 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964771AbWHQQ1I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Aug 2006 12:27:08 -0400
Date: Thu, 17 Aug 2006 09:26:33 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Manfred Spraul <manfred@colorfullife.com>
cc: Andi Kleen <ak@muc.de>, mpm@selenic.com,
       Marcelo Tosatti <marcelo@kvack.org>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>, Andi Kleen <ak@suse.de>,
       Dave Chinner <dgc@sgi.com>
Subject: Re: [MODSLAB 3/7] A Kmalloc subsystem
In-Reply-To: <44E3FC4F.2090506@colorfullife.com>
Message-ID: <Pine.LNX.4.64.0608170922030.24204@schroedinger.engr.sgi.com>
References: <20060816022238.13379.24081.sendpatchset@schroedinger.engr.sgi.com>
 <20060816022253.13379.76984.sendpatchset@schroedinger.engr.sgi.com>
 <20060816094358.e7006276.ak@muc.de> <Pine.LNX.4.64.0608161718160.19789@schroedinger.engr.sgi.com>
 <44E3FC4F.2090506@colorfullife.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Aug 2006, Manfred Spraul wrote:

> I'm not sure that the current approach with virt_to_page()/vmalloc_to_page()
> is the right thing(tm): Both functions are slow.

Right. Would be great to avoid it but if we have to use it then I think we 
should just store as much metainformation in the page as possible.

> If you have non-power-of-two caches, you could store the control data at
> (addr&(~PAGE_SIZE)) - the lookup would be much faster. I wrote a patch a few
> weeks ago, it's attached.

That would only work for slabs that use order 0 pages.

> Right now we have a few slab users that perform kmalloc(PAGE_SIZE). But that's
> a mostly for historic reasons: kmalloc was significantly (IIRC up to factor
> 10) faster than get_free_pages(). Now get_free_pages() also contains per-cpu
> structures, so we could convert __get_name or the pipe code back to
> get_free_pages().

Note that the caches of the page allocator only work for zero order pages. 

And the reason for the existence of those caches is questionable. 
We have repeatedly found in pratical tests that switching off these 
caches has no influence on performance whatsoever.
