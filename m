Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750940AbWIHMZW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750940AbWIHMZW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 08:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750942AbWIHMZW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 08:25:22 -0400
Received: from 41.150.104.212.access.eclipse.net.uk ([212.104.150.41]:24212
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S1750940AbWIHMZV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 08:25:21 -0400
Date: Fri, 8 Sep 2006 13:24:47 +0100
From: Andy Whitcroft <apw@shadowen.org>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: Andy Whitcroft <apw@shadowen.org>
Subject: [PATCH 0/5] Linear reclaim V1
Message-ID: <exportbomb.1157718286@pinky>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linear Reclaim (V1)

When we are out of memory of a suitable size we enter reclaim.
The current reclaim algorithm targets pages in LRU order, which
is great for fairness but highly unsuitable if you desire pages at
higher orders.  To get pages of higher order we must shoot down a
very high proportion of memory; >95% in a lot of cases.

This patch set adds a linear reclaim algorithm to the allocator.
It targets groups of pages at the specified order rather than in
lru order.  Passing over each area at this size and assessing the
likelyhood of reclaiming all of the pages within.  If chances are
high, we apply reclaim to all of the busy pages in this area in
the hopes of consolidating a complete page at that order.  This is
designed to be used when we are out of higher order pages.

This patch set is particularly effective when utilised with
an anti-fragmentation scheme which groups pages of similar
reclaimability together.

As it stands we introduce a complete second reclaim algorithm.
Once this has stablised it would make sense to merge the two
algorithms.  Targetting variable size blocks using pages at the
end of the LRU as seeds.  When operating at order 0 the algorithms
would then be equivalent.

-apw

Base: 2.6.18-rc5-mm1

Patches:
 o linear-reclaim-add-order-to-reclaim-path
 o linear-reclaim-export-page_order-and-family
 o linear-reclaim-pull-out-unfreeable-page-return
 o linear-reclaim-add-pfn_valid_within-for-zone-holes
 o linear-reclaim-core

Current version: V1
