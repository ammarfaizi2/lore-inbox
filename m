Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267880AbUJHBtA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267880AbUJHBtA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 21:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269824AbUJHBqx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 21:46:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:8419 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267880AbUJHBln (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 21:41:43 -0400
Date: Thu, 7 Oct 2004 18:41:34 -0700
From: Chris Wright <chrisw@osdl.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, chrisw@osdl.org,
       linux-kernel@vger.kernel.org, piggin@cyberone.com.au
Subject: Re: kswapd in tight loop 2.6.9-rc3-bk-recent
Message-ID: <20041007184134.S2357@build.pdx.osdl.net>
References: <20041007142019.D2441@build.pdx.osdl.net> <20041007164044.23bac609.akpm@osdl.org> <4165E0A7.7080305@yahoo.com.au> <20041007174242.3dd6facd.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20041007174242.3dd6facd.akpm@osdl.org>; from akpm@osdl.org on Thu, Oct 07, 2004 at 05:42:42PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Morton (akpm@osdl.org) wrote:
> 
> OK, after backing out the `goto spaghetti;' patch and cleaning up a few
> thing I'll test the below.  It'll make kswapd much less aggressive.

testing with this compile fix:

diff -u 25-akpm/mm/vmscan.c edited/mm/vmscan.c
--- 25-akpm/mm/vmscan.c	2004-10-07 17:38:20.348905464 -0700
+++ edited/mm/vmscan.c	2004-10-07 18:38:14 -07:00
@@ -999,7 +999,7 @@
 		struct zone *zone = pgdat->node_zones + i;
 
 		zone->temp_priority = DEF_PRIORITY;
-		zone->pages_to_reclaim = zone->pages_high - zone->pages_free;
+		zone->pages_to_reclaim = zone->pages_high - zone->free_pages;
 	}
 
 	for (priority = DEF_PRIORITY; priority >= 0; priority--) {
