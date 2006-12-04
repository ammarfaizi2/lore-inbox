Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966979AbWLDUhf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966979AbWLDUhf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 15:37:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966980AbWLDUhf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 15:37:35 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:22384 "EHLO
	amsfep13-int.chello.nl" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S966979AbWLDUhe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 15:37:34 -0500
Subject: Re: [PATCH] Add __GFP_MOVABLE for callers to flag allocations that
	may be migrated
From: Peter Zijlstra <peter@programming.kicks-ass.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Mel Gorman <mel@skynet.ie>, clameter@sgi.com,
       Linux Memory Management List <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <20061204113051.4e90b249.akpm@osdl.org>
References: <20061130170746.GA11363@skynet.ie>
	 <20061130173129.4ebccaa2.akpm@osdl.org>
	 <Pine.LNX.4.64.0612010948320.32594@skynet.skynet.ie>
	 <20061201110103.08d0cf3d.akpm@osdl.org> <20061204140747.GA21662@skynet.ie>
	 <20061204113051.4e90b249.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 04 Dec 2006 21:37:20 +0100
Message-Id: <1165264640.23363.18.camel@lappy>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-12-04 at 11:30 -0800, Andrew Morton wrote:

> I'd also like to pin down the situation with lumpy-reclaim versus
> anti-fragmentation.  No offence, but I would of course prefer to avoid
> merging the anti-frag patches simply based on their stupendous size.  It
> seems to me that lumpy-reclaim is suitable for the e1000 problem, but
> perhaps not for the hugetlbpage problem.  Whereas anti-fragmentation adds
> vastly more code, but can address both problems?  Or something.

>From my understanding they complement each other nicely. Without some
form of anti fragmentation there is no guarantee lumpy reclaim will ever
free really high order pages. Although it might succeed nicely for the
network sized allocations we now have problems with.

- Andy, do you have any number on non largepage order allocations? 

But anti fragmentation as per Mel's patches is not good enough to
provide largepage allocations since we would need to shoot down most of
the LRU to obtain such a large contiguous area. Lumpy reclaim however
can quickly achieve these sizes.

