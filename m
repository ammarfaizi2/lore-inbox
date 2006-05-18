Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750839AbWERHmg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750839AbWERHmg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 03:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbWERHmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 03:42:36 -0400
Received: from mail03.syd.optusnet.com.au ([211.29.132.184]:12983 "EHLO
	mail03.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1750839AbWERHmf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 03:42:35 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: [PATCH][respin] mm: swap prefetch fix lowmem reserve calc
Date: Thu, 18 May 2006 17:42:20 +1000
User-Agent: KMail/1.9.1
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       ck list <ck@vds.kolivas.org>, Andrew Morton <akpm@osdl.org>
References: <200605181558.57777.kernel@kolivas.org> <446C1FC7.1020405@yahoo.com.au>
In-Reply-To: <446C1FC7.1020405@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605181742.20787.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 18 May 2006 17:18, Nick Piggin wrote:
> Anonymous memory is GFP_HIGHUSER, yeah? Anything wrong with
>
> -		ns->lowfree[idx] = z->pages_high * 3 + z->lowmem_reserve[idx];
> +		ns->lowfree[idx] = z->pages_high * 3 + z->lowmem_reserve[ZONE_HIGHMEM];

I guess not, thanks!
---

Correct the effect lowmem_reserve has on calculation of free limits
in swap_prefetch.

Signed-off-by: Con Kolivas <kernel@kolivas.org>

---
 mm/swap_prefetch.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6.17-rc4-mm1/mm/swap_prefetch.c
===================================================================
--- linux-2.6.17-rc4-mm1.orig/mm/swap_prefetch.c	2006-05-18 15:48:22.000000000 +1000
+++ linux-2.6.17-rc4-mm1/mm/swap_prefetch.c	2006-05-18 17:24:44.000000000 +1000
@@ -276,7 +276,8 @@ static void examine_free_limits(void)
 
 		ns = &sp_stat.node[z->zone_pgdat->node_id];
 		idx = zone_idx(z);
-		ns->lowfree[idx] = z->pages_high * 3 + z->lowmem_reserve[idx];
+		ns->lowfree[idx] = z->pages_high * 3 +
+			z->lowmem_reserve[ZONE_HIGHMEM];
 		ns->highfree[idx] = ns->lowfree[idx] + z->pages_high;
 
 		if (z->free_pages > ns->highfree[idx]) {

-- 
-ck
