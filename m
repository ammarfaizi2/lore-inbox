Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932379AbVLHVJN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932379AbVLHVJN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 16:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932378AbVLHVJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 16:09:08 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:52369 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932358AbVLHVJG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 16:09:06 -0500
Date: Thu, 8 Dec 2005 13:08:50 -0800 (PST)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Andi Kleen <ak@suse.de>
cc: akpm@osdl.org, Christoph Hellwig <hch@infradead.org>,
       linux-ia64@vger.kernel.org, steiner@sgi.com,
       linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: Re: [PATCH 3/3] Zone reclaim V3: Frequency of failed reclaim attempts
In-Reply-To: <20051208205241.GR11190@wotan.suse.de>
Message-ID: <Pine.LNX.4.62.0512081308360.30567@schroedinger.engr.sgi.com>
References: <20051208203707.30456.57439.sendpatchset@schroedinger.engr.sgi.com>
 <20051208203717.30456.17434.sendpatchset@schroedinger.engr.sgi.com>
 <20051208205241.GR11190@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch:

Index: linux-2.6.15-rc4/mm/vmscan.c
===================================================================
--- linux-2.6.15-rc4.orig/mm/vmscan.c	2005-12-08 12:31:56.000000000 -0800
+++ linux-2.6.15-rc4/mm/vmscan.c	2005-12-08 13:07:05.000000000 -0800
@@ -1386,7 +1386,7 @@ int zone_reclaim(struct zone *zone, gfp_
 	 * will be a waste of time. Continue off node allocations for the
 	 * duration of this tick.
 	 */
-	if (zone->last_unsuccessful_zone_reclaim == get_jiffies_64())
+	if (zone->last_unsuccessful_zone_reclaim == jiffies)
 		return 0;
 
 	sc.gfp_mask = gfp_mask;
@@ -1408,7 +1408,7 @@ int zone_reclaim(struct zone *zone, gfp_
 	p->reclaim_state = NULL;
 	current->flags &= ~PF_MEMALLOC;
 	if (sc.nr_reclaimed == 0)
-		zone->last_unsuccessful_zone_reclaim = get_jiffies_64();
+		zone->last_unsuccessful_zone_reclaim = jiffies;
 	cond_resched();
 	return sc.nr_reclaimed >= (1 << order);
 }
