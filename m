Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317756AbSGKFAf>; Thu, 11 Jul 2002 01:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317764AbSGKFAe>; Thu, 11 Jul 2002 01:00:34 -0400
Received: from holomorphy.com ([66.224.33.161]:3220 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S317756AbSGKFAe>;
	Thu, 11 Jul 2002 01:00:34 -0400
Date: Wed, 10 Jul 2002 22:02:21 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: lazy_buddy-2.5.25-1
Message-ID: <20020711050221.GC27093@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
References: <20020710085917.GP25360@holomorphy.com> <20020711044956.GB27093@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020711044956.GB27093@holomorphy.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2002 at 09:49:56PM -0700, William Lee Irwin III wrote:
> Ugh, forward port breakage. Ran into this in a different patch but
> realized it was broken here too. Sorry folks. You'll need this on
> top of the prior post.

Even worse, I spotted another (thankfully more minor) bug while still
peeking at this... okay, back to more urgent things.


Cheers,
Bill


# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.631   -> 1.632  
#	     mm/page_alloc.c	1.126   -> 1.127  
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/10	wli@tisifone.holomorphy.com	1.632
# page_alloc.c:
#   Correct nr_deferred_pages() calculation.
# --------------------------------------------
#
diff --minimal -Nru a/mm/page_alloc.c b/mm/page_alloc.c
--- a/mm/page_alloc.c	Wed Jul 10 21:59:45 2002
+++ b/mm/page_alloc.c	Wed Jul 10 21:59:45 2002
@@ -739,8 +739,8 @@
 	for (pgdat = pgdat_list; pgdat; pgdat = pgdat->node_next) {
 		node_zones = pgdat->node_zones;
 		for (i = 0; i < MAX_NR_ZONES; ++i) {
-			for (order = 0; order < MAX_ORDER; ++order)
-				pages += node_zones[i].free_area[order].locally_free;
+			for (order = MAX_ORDER; order >= 0; --order)
+				pages = 2*pages + node_zones[i].free_area[order].locally_free;
 		}
 	}
 	return pages;
