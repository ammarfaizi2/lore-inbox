Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263624AbUDMQFK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 12:05:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263625AbUDMQFK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 12:05:10 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:14650 "EHLO
	MTVMIME02.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263624AbUDMQFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 12:05:04 -0400
Date: Tue, 13 Apr 2004 17:04:59 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: haael <haael@interia.pl>
cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       Kernel developers <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: Doesn't compile without CONFIG_SWAP
In-Reply-To: <200404131730.14554.haael@interia.pl>
Message-ID: <Pine.LNX.4.44.0404131700260.5511-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Apr 2004, haael wrote:
> I was compiling Linux 2.6.5 with -mjb1 patch, trying to get as small
> kernel as possible. I got an error:
> <code>
>   CC      mm/vmscan.o
> mm/vmscan.c: In function `refill_inactive_zone':
> mm/vmscan.c:650: `swapper_space' undeclared (first use in this function)

Thanks, below should be the right fix (total_swapcache_pages is defined
to swapper_space.nrpages when CONFIG_SWAP=y, to 0 when CONFIG_SWAP=n).

--- 2.6.5-mjb1/mm/vmscan.c	2004-04-10 10:43:46.000000000 +0100
+++ linux/mm/vmscan.c	2004-04-13 16:58:35.009183744 +0100
@@ -647,7 +647,7 @@ refill_inactive_zone(struct zone *zone, 
 		 */
 		si_meminfo(&i);
 		app_centile = 100 - ((i.freeram + get_page_cache_size() -
-			swapper_space.nrpages) / (i.totalram / 100));
+			total_swapcache_pages) / (i.totalram / 100));
 
 		/*
 		 * swap_centile is the percentage of the last (sizeof physical

