Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932690AbVKBJNT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932690AbVKBJNT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 04:13:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932692AbVKBJNS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 04:13:18 -0500
Received: from e35.co.us.ibm.com ([32.97.110.153]:15564 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S932691AbVKBJMj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 04:12:39 -0500
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Ingo Molnar <mingo@elte.hu>,
       Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Dave Hansen <haveblue@us.ibm.com>, Mel Gorman <mel@csn.ul.ie>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>
Reply-To: Gerrit Huizenga <gh@us.ibm.com>
From: Gerrit Huizenga <gh@us.ibm.com>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19 
In-reply-to: Your message of Wed, 02 Nov 2005 19:50:15 +1100.
             <43687DC7.3060904@yahoo.com.au> 
Date: Wed, 02 Nov 2005 01:12:30 -0800
Message-Id: <E1EXEfW-0005ON-00@w-gerrit.beaverton.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 02 Nov 2005 19:50:15 +1100, Nick Piggin wrote:
> Gerrit Huizenga wrote:
> 
> > So, people are working towards two distinct solutions, both of which
> > require us to do a better job of defragmenting memory (or avoiding
> > fragementation in the first place).
> > 
> 
> This is just going around in circles. Even with your fragmentation
> avoidance and memory defragmentation, there are still going to be
> cases where memory does get fragmented and can't be defragmented.
> This is Ingo's point, I believe.
> 
> Isn't the solution for your hypervisor problem to dish out pages of
> the same size that are used by the virtual machines. Doesn't this
> provide you with a nice, 100% solution that doesn't add complexity
> where it isn't needed?

So do you see the problem with fragementation if the hypervisor is
handing out, say, 1 MB pages?  Or, more likely, something like 64 MB
pages?  What are the chances that an entire 64 MB page can be freed
on a large system that has been up a while?

And, if you create zones, you run into all of the zone rebalancing
problems of ZONE_DMA, ZONE_NORMAL, ZONE_HIGHMEM.  In that case, on
any long running system, ZONE_HOTPLUGGABLE has been overwhelmed with
random allocations, making almost none of it available.

However, with reasonable defragmentation or fragmentation avoidance,
we have some potential to make large chunks available for return to
the hypervisor.  And, that same capability continues to help those
who want to remove fixed ranges of physical memory.

gerrit
