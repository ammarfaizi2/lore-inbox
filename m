Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932547AbVKBHVD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932547AbVKBHVD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 02:21:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932613AbVKBHVB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 02:21:01 -0500
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:46993 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932547AbVKBHVA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 02:21:00 -0500
Date: Wed, 02 Nov 2005 16:19:18 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
Cc: "Martin J. Bligh" <mbligh@mbligh.org>,
       Joel Schopp <jschopp@austin.ibm.com>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net, Ingo Molnar <mingo@elte.hu>,
       Mel Gorman <mel@csn.ul.ie>
In-Reply-To: <43682940.3020200@yahoo.com.au>
References: <216280000.1130898244@[10.10.2.4]> <43682940.3020200@yahoo.com.au>
X-Mailer-Plugin: BkASPil for Becky!2 Ver.2.051
Message-Id: <20051102121733.9E74.Y-GOTO@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Becky! ver. 2.21.02 [ja]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.
Nick-san.

I posted patches to make ZONE_REMOVABLE to LHMS.
I don't say they are better than Mel-san's patch.
I hope this will be base of good discussion.


There were 2 types.
One was just add ZONE_REMOVABLE.
This patch came from early implementation of memory hotplug VA-Linux
team. 
http://sourceforge.net/mailarchive/forum.php?thread_id=5969508&forum_id=223

ZONE_HIGHMEM is used for this purpose at early implementation.
We thought ZONE_HIGHMEM is easier removing than other zone.
But some of archtecture don't use it. That is why ZONE_REMOVABLE
was born.
(And I remember that ZONE_DMA32 was defined after this patch.
 So, number of zone became 5, and one more bit was necessary in
 page->flags. (I don't know recent progress of ZONE_DMA32)).


Another one was a bit similar than Mel-san's one.
One of motivation of this patch was to create orthogonal relationship
between Removable and DMA/Normal/Highmem. I thought it is desirable.
Because, ppc64 can treat that all of memory is same (DMA) zone.
I thought that new zone spoiled its good feature.

http://sourceforge.net/mailarchive/forum.php?thread_id=5345977&forum_id=223
http://sourceforge.net/mailarchive/forum.php?thread_id=5345978&forum_id=223
http://sourceforge.net/mailarchive/forum.php?thread_id=5345979&forum_id=223
http://sourceforge.net/mailarchive/forum.php?thread_id=5345980&forum_id=223


Thanks.

P.S. to Mel-san.
 I'm sorry for late writing of this. This threads was mail bomb for me
 to read with my poor English skill. :-(


> Martin J. Bligh wrote:
> 
> >>But let's move this to another thread if it is going to continue. I
> >>would be happy to discuss scheduler problems.
> > 
> > 
> > My point was that most things we do add complexity to the codebase,
> > including the things you do yourself ... I'm not saying the we're worse
> > off for the changes you've made, by any means - I think they've been
> > mostly beneficial.
> 
> Heh - I like the "mostly" ;)
> 
> > I'm just pointing out that we ALL do it, so let us
> > not be too quick to judge when others propose adding something that does ;-)
> > 
> 
> What I'm getting worried about is the marked increase in the
> rate of features and complexity going in.
> 
> I am almost certainly never going to use memory hotplug or
> demand paging of hugepages. I am pretty likely going to have
> to wade through this code at some point in the future if it
> is merged.
> 
> It is also going to slow down my kernel by maybe 1% when
> doing kbuilds, but hey let's not worry about that until we've
> merged 10 more such slowdowns (ok that wasn't aimed at you or
> Mel, but my perception of the status quo).
> 
> > 
> >>You can't what? What doesn't work? If you have no hard limits set,
> >>then the frag patches can't guarantee anything either.
> >>
> >>You can't have it both ways. Either you have limits for things or
> >>you don't need any guarantees. Zones handle the former case nicely,
> >>and we currently do the latter case just fine (along with the frag
> >>patches).
> > 
> > 
> > I'll go look through Mel's current patchset again. I was under the
> > impression it didn't suffer from this problem, at least not as much
> > as zones did.
> > 
> 
> Over time, I don't think it can offer any stronger a guarantee
> than what we currently have. I'm not even sure that it would be
> any better at all for problematic workloads as time -> infinity.
> 
> > Nothing is guaranteed. You can shag the whole machine and/or VM in
> > any number of ways ... if we can significantly improve the probability 
> > of existing higher order allocs working, and new functionality has
> > an excellent probability of success, that's as good as you're going to 
> > get. Have a free "perfect is the enemy of good" Linus quote, on me ;-)
> > 
> 
> I think it falls down if these higher order allocations actually
> get *used* for anything. You'll simply be going through the process
> of replacing your contiguous, easy-to-reclaim memory with pinned
> kernel memory.
> 
> However, for the purpose of memory hot unplug, a new zone *will*
> guarantee memory can be reclaimed and unplugged.
> 
> -- 
> SUSE Labs, Novell Inc.
> 
> Send instant messages to your online friends http://au.messenger.yahoo.com 
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-mm' in
> the body to majordomo@kvack.org.  For more info on Linux MM,
> see: http://www.linux-mm.org/ .
> Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>

-- 
Yasunori Goto 

