Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262584AbTCYMb4>; Tue, 25 Mar 2003 07:31:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262600AbTCYMb4>; Tue, 25 Mar 2003 07:31:56 -0500
Received: from holomorphy.com ([66.224.33.161]:30625 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262584AbTCYMbz>;
	Tue, 25 Mar 2003 07:31:55 -0500
Date: Tue, 25 Mar 2003 04:42:41 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: akpm@zip.com.au
Cc: linux-kernel@vger.kernel.org
Subject: use page_to_pfn() in __blk_queue_bounce()
Message-ID: <20030325124241.GQ1232@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	akpm@zip.com.au, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

__blk_queue_bounce() contains an open-coded page_to_pfn() for the
discontig, non-MAP_NR_DENSE() case (wherever MAP_NR_DENSE() went).
This converts it to use the standard page_to_pfn() abstraction.


-- wli

diff -urpN linux-2.5.66/mm/highmem.c merge-2.5.66-1/mm/highmem.c
--- linux-2.5.66/mm/highmem.c	2003-03-24 14:00:50.000000000 -0800
+++ merge-2.5.66-1/mm/highmem.c	2003-03-25 04:08:01.000000000 -0800
@@ -381,7 +381,7 @@ static void __blk_queue_bounce(request_q
 		/*
 		 * is destination page below bounce pfn?
 		 */
-		if ((page - page_zone(page)->zone_mem_map) + (page_zone(page)->zone_start_pfn) < q->bounce_pfn)
+		if (page_to_pfn(page) < q->bounce_pfn)
 			continue;
 
 		/*
