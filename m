Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261884AbUBWIsP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 03:48:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbUBWIsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 03:48:15 -0500
Received: from mail-10.iinet.net.au ([203.59.3.42]:51932 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261884AbUBWIsH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 03:48:07 -0500
Message-ID: <4039BE41.1000804@cyberone.com.au>
Date: Mon, 23 Feb 2004 19:48:01 +1100
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040122 Debian/1.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Nick Piggin <piggin@cyberone.com.au>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] vm-fix-all_zones_ok (was Re: 2.6.3-mm3)
References: <20040222172200.1d6bdfae.akpm@osdl.org>	<40395ACE.4030203@cyberone.com.au> <20040222175507.558a5b3d.akpm@osdl.org> <40396ACD.7090109@cyberone.com.au> <40396DA7.70200@cyberone.com.au> <4039B4E6.3050801@cyberone.com.au>
In-Reply-To: <4039B4E6.3050801@cyberone.com.au>
Content-Type: multipart/mixed;
 boundary="------------080103030903090103050701"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080103030903090103050701
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



Nick Piggin wrote:

>
> Humph. OK you're right.


Aha but you've broken something! Tell me I'm still useful.


--------------080103030903090103050701
Content-Type: text/plain;
 name="vm-fix-all_zones_ok.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="vm-fix-all_zones_ok.patch"

 linux-2.6-npiggin/mm/vmscan.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff -puN mm/vmscan.c~vm-fix-all_zones_ok mm/vmscan.c
--- linux-2.6/mm/vmscan.c~vm-fix-all_zones_ok	2004-02-23 19:44:06.000000000 +1100
+++ linux-2.6-npiggin/mm/vmscan.c	2004-02-23 19:45:10.000000000 +1100
@@ -1008,10 +1008,12 @@ static int balance_pgdat(pg_data_t *pgda
 
 			if (nr_pages)		/* Software suspend */
 				to_reclaim = min(to_free, SWAP_CLUSTER_MAX*8);
-			else			/* Zone balancing */
+			else {			/* Zone balancing */
 				to_reclaim = zone->reclaim_batch;
+				if (zone->pages_high < zone->free_pages)
+					all_zones_ok = 0;
+			}
 
-			all_zones_ok = 0;
 			zone->temp_priority = priority;
 			reclaimed = shrink_zone(zone, GFP_KERNEL,
 					to_reclaim, &nr_scanned, ps, priority);

_

--------------080103030903090103050701--
