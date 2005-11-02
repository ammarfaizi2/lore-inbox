Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932587AbVKBLW0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932587AbVKBLW0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Nov 2005 06:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932591AbVKBLW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Nov 2005 06:22:26 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:928 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S932587AbVKBLWZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Nov 2005 06:22:25 -0500
Date: Wed, 2 Nov 2005 11:22:06 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Ingo Molnar <mingo@elte.hu>, Dave Hansen <haveblue@us.ibm.com>,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andrew Morton <akpm@osdl.org>,
       kravetz@us.ibm.com, linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lhms <lhms-devel@lists.sourceforge.net>
Subject: Re: [Lhms-devel] [PATCH 0/7] Fragmentation Avoidance V19
In-Reply-To: <43680923.1040007@jp.fujitsu.com>
Message-ID: <Pine.LNX.4.58.0511021121220.5235@skynet>
References: <4366A8D1.7020507@yahoo.com.au> <Pine.LNX.4.58.0510312333240.29390@skynet>
 <4366C559.5090504@yahoo.com.au> <Pine.LNX.4.58.0511010137020.29390@skynet>
 <4366D469.2010202@yahoo.com.au> <Pine.LNX.4.58.0511011014060.14884@skynet>
 <20051101135651.GA8502@elte.hu> <1130854224.14475.60.camel@localhost>
 <20051101142959.GA9272@elte.hu> <1130856555.14475.77.camel@localhost>
 <20051101150142.GA10636@elte.hu> <43679C69.6050107@jp.fujitsu.com>
 <Pine.LNX.4.58.0511011708000.14884@skynet> <43680923.1040007@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Nov 2005, KAMEZAWA Hiroyuki wrote:

> Mel Gorman wrote:
> > 3. When adding a node that must be removable, make the array look like
> > this
> >
> > int fallback_allocs[RCLM_TYPES-1][RCLM_TYPES+1] = {
> >         {RCLM_NORCLM,   RCLM_TYPES,    RCLM_TYPES,  RCLM_TYPES, RCLM_TYPES},
> >         {RCLM_EASY,     RCLM_FALLBACK, RCLM_NORCLM, RCLM_KERN, RCLM_TYPES},
> >         {RCLM_KERN,     RCLM_TYPES,    RCLM_TYPES,  RCLM_TYPES, RCLM_TYPES},
> > };
> >
> > The effect of this is only allocations that are easily reclaimable will
> > end up in this node. This would be a straight-forward addition to build
> > upon this set of patches. The difference would only be visible to
> > architectures that cared.
> >
> Thank you for illustration.
> maybe fallback_list per pgdat/zone is what I need with your patch.  right ?
>

With my patch, yes. With zones, you need to change how zonelists are built
for each node.

-- 
Mel Gorman
Part-time Phd Student                          Java Applications Developer
University of Limerick                         IBM Dublin Software Lab
