Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964947AbVHKAGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964947AbVHKAGx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Aug 2005 20:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964933AbVHKAGv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Aug 2005 20:06:51 -0400
Received: from mx1.redhat.com ([66.187.233.31]:28563 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S964913AbVHKAGu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Aug 2005 20:06:50 -0400
Date: Wed, 10 Aug 2005 20:06:34 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH/RFT 4/5] CLOCK-Pro page replacement
In-Reply-To: <20050810232209.GA3809@dmt.cnet>
Message-ID: <Pine.LNX.4.61.0508101958510.2695@chimarrao.boston.redhat.com>
References: <20050810200216.644997000@jumble.boston.redhat.com>
 <20050810200943.809832000@jumble.boston.redhat.com> <20050810232209.GA3809@dmt.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Aug 2005, Marcelo Tosatti wrote:

> First of all, this is very nice! The code is amazingly easy to read.

Thank you.

> You change the rate of active list scanning, which I suppose won't
> change the current reclaiming behaviour much (at least not on the
> "stress system to death" tests which most folks use to test page
> replacement policies). I'll do some STP benchmarking.
> 
> But the fundamental metric for page replacement decision continues
> to be recency alone.
>
> IMHO much deeper surgery is needed: actually use inter-reference
> distance as the metric for page replacement decision.

Actually, inter-reference distance is what triggers whether the
active list gets scanned in addition to the inactive list.

The inter-reference distance also determines on which list a
page gets allocated.

I agree the code probably needs tweaking in this respect, though.

> As we talked, I've got an ARC variant working, but from what I gather
> so far its not as simple as I've imagined. Direct replacement from the
> active list seems to screw up most "stress system to death" workloads,
> increasing major pagefaults.

I'm not surprised!

If a page is not frequently enough accessed to be on the active
list, chances are it could still be accessed more frequently than
many pages on the inactive list, and evicting the page is the
wrong thing to do.

I suspect that ARC and CAR/CART are more suited for databases
than for general purpose OSes.  The reason databases are
probably different is that databases tend to have large indexes,
which are accessed more frequently than most data.  This may
lead to a stricter "separation" between hot and cold pages.

> Still lack a set of well analyzed pertinent VM tests... 

Agreed - I really am not sure how to properly test replacement
algorithms.

-- 
All Rights Reversed
