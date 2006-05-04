Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751442AbWEDIcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbWEDIcc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 04:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751444AbWEDIcc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 04:32:32 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:25775 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1751442AbWEDIcb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 04:32:31 -0400
Date: Thu, 4 May 2006 10:37:08 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Bob Picco <bob.picco@hp.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       "Martin J. Bligh" <mbligh@mbligh.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Linux Memory Management <linux-mm@kvack.org>,
       Andy Whitcroft <apw@shadowen.org>
Subject: Re: assert/crash in __rmqueue() when enabling CONFIG_NUMA
Message-ID: <20060504083708.GA30853@elte.hu>
References: <20060419112130.GA22648@elte.hu> <p73aca07whs.fsf@bragg.suse.de> <20060502070618.GA10749@elte.hu> <200605020905.29400.ak@suse.de> <44576688.6050607@mbligh.org> <44576BF5.8070903@yahoo.com.au> <20060504013239.GG19859@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060504013239.GG19859@localhost>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Bob Picco <bob.picco@hp.com> wrote:

> The patch below isn't compile tested or correct for those cases where 
> alloc_remap is called or where arch code has allocated node_mem_map 
> for CONFIG_FLAT_NODE_MEM_MAP. It's just conveying what I believe the 
> issue is.

thx. One pair of parentheses were missing i think - see the delta fix 
below. I'll try it.

	Ingo

Index: linux/mm/page_alloc.c
===================================================================
--- linux.orig/mm/page_alloc.c
+++ linux/mm/page_alloc.c
@@ -2296,7 +2296,7 @@ static void __init alloc_node_mem_map(st
 		 */
 		start = pgdat->node_start_pfn & ~((1 << (MAX_ORDER - 1)) - 1);
 		end = start + pgdat->node_spanned_pages;
-		end = (end + ((1 << (MAX_ORDER - 1)) - 1) &
+		end = (end + ((1 << (MAX_ORDER - 1)) - 1)) &
 			~((1 << (MAX_ORDER - 1)) - 1);
 		size =  (end - start) * sizeof(struct page);
 		map = alloc_remap(pgdat->node_id, size);
