Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261393AbVCHPEc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261393AbVCHPEc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 10:04:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261400AbVCHPEc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 10:04:32 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:16610 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S261393AbVCHPEZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 10:04:25 -0500
Date: Tue, 8 Mar 2005 15:04:24 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: [PATCH] 2/2 Prezeroing large blocks of pages during allocation
 Version 4
In-Reply-To: <422D8F2A.4010002@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.58.0503081458440.3227@skynet>
References: <20050307194021.E6A86E594@skynet.csn.ul.ie> <422D42BF.4060506@jp.fujitsu.com>
 <Pine.LNX.4.58.0503081012270.30439@skynet> <422D8F2A.4010002@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Mar 2005, KAMEZAWA Hiroyuki wrote:

> Mel Gorman wrote:
>
> > > >
> > > Now, 5bits per  MAX_ORDER pages.
> > > I think it is simpler to use "char[]" for representing type of  memory
> > > alloc
> > > type than bitmap.
> > >
> > >
> >
> > Possibly, but it would also use up that bit more space. That map could be
> > condensed to 3 bits but would make it that bit (no pun) more complex and
> > difficult to merge. On the other hand, it would be faster to use a char[]
> > as it would be an array-index lookup to get a pageblock type rather than a
> > number of bit operations.
> >
> > So, it depends on what people know to be better in general because I have
> > not measured it to know for a fact. Is it better to use char[] and use
> > array indexes rather than bit operations or is it better to leave it as a
> > bitmap and condense it later when things have settled down?
> >
> Hmm, Okay, I'll wait for condensed version.
> BTW, in space consumption/cache view,  does using bitmap have  real benefit
> ?
>

For space, there is a small benefit. On my system with 1.5GiB of RAM, it
is about 130 bytes saved for prezeroing and about 220 with just the
placement policy.  For speed, I do not know how bitmaps normally perform
with the CPU cache, but for the placement policy, it makes no difference.
I implemented a version using char[] array and there was no performance
difference that I could measure. The bitmaps just are not consulted often
enough to make a big performance difference.

-- 
Mel Gorman
Part-time Phd Student				Java Applications Developer
University of Limerick				    IBM Dublin Software Lab
