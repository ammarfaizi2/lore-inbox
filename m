Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965157AbVKPBrs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965157AbVKPBrs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 20:47:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965156AbVKPBrs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 20:47:48 -0500
Received: from holly.csn.ul.ie ([136.201.105.4]:61131 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S965157AbVKPBrr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 20:47:47 -0500
Date: Wed, 16 Nov 2005 01:47:43 +0000 (GMT)
From: Mel Gorman <mel@csn.ul.ie>
X-X-Sender: mel@skynet
To: Andi Kleen <ak@suse.de>
Cc: linux-mm@kvack.org, mingo@elte.hu, linux-kernel@vger.kernel.org,
       nickpiggin@yahoo.com.au, lhms-devel@lists.sourceforge.net
Subject: Re: [PATCH 5/5] Light Fragmentation Avoidance V20: 005_configurable
In-Reply-To: <200511160039.21243.ak@suse.de>
Message-ID: <Pine.LNX.4.58.0511160143320.8470@skynet>
References: <20051115164946.21980.2026.sendpatchset@skynet.csn.ul.ie>
 <20051115165012.21980.51131.sendpatchset@skynet.csn.ul.ie>
 <200511160039.21243.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Nov 2005, Andi Kleen wrote:

> On Tuesday 15 November 2005 17:50, Mel Gorman wrote:
> > The anti-defragmentation strategy has memory overhead. This patch allows
> > the strategy to be disabled for small memory systems or if it is known the
> > workload is suffering because of the strategy. It also acts to show where
> > the anti-defrag strategy interacts with the standard buddy allocator.
>
> If anything this should be a boot time option or perhaps sysctl, not a config.

I'll take a look at what's involved in doing this. Using a compile time
option, I was depending on the compiler to see that

for (i = 0; i < RCLM_TYPES; i++) {}

would only every iterate once and get rid of the loop. If I think there is
any chance of these patches getting merged, I'll work on making this a
sysctl or boot-time option rather than a compile option.

> In general CONFIGs that change runtime behaviour are evil - just makes
> changing the option more painful, causes problems for distribution
> users, doesn't make much sense, etc.etc.
>

Agreed, but I felt that some mechanism for disabling this for small
systems was desirable. As it is right now, I see this as a
very-small-memory-available option.

> Also #ifdef as a documentation device is a really really scary concept.
> Yuck.
>

Can't argue with you there. However, for the purposes of discussion here,
it shows exactly where anti-defrag affects the current allocator.

-- 
Mel Gorman
Part-time Phd Student                          Java Applications Developer
University of Limerick                         IBM Dublin Software Lab
