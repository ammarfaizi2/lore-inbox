Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261233AbULWN3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261233AbULWN3J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 08:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261235AbULWN3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 08:29:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:40922 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261233AbULWN3B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 08:29:01 -0500
Date: Thu, 23 Dec 2004 08:28:39 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: "Zou, Nanhai" <nanhai.zou@intel.com>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       lista4@comhem.se, linux-kernel@vger.kernel.org, mr@ramendik.ru,
       kernel@kolivas.org
Subject: RE: 2.6.10-rc3: kswapd eats CPU on start of memory-eating task
In-Reply-To: <Pine.LNX.4.61.0412230825473.21365@chimarrao.boston.redhat.com>
Message-ID: <Pine.LNX.4.61.0412230827350.21365@chimarrao.boston.redhat.com>
References: <894E37DECA393E4D9374E0ACBBE7427013CA3A@pdsmsx402.ccr.corp.intel.com>
 <Pine.LNX.4.61.0412230825473.21365@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Dec 2004, Rik van Riel wrote:

>>> You need the oneline patch that Andrew Morton posted two
>>> days ago:
>>> 
>>> Message-Id: <20041219230754.64c0e52e.akpm@osdl.org>
>> 
>> You mean that totally disable swap_token?

Oops, wrong thread ;(     You need this one:

Message-Id: <20041220125443.091a911b.akpm@osdl.org>

We haven't been incrementing local variable total_scanned since the
scan_control stuff went in.  That broke kswapd throttling.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

  25-akpm/mm/vmscan.c |    1 +
  1 files changed, 1 insertion(+)

--- linux-2.6.9/mm/vmscan.c.oom	2004-12-21 11:26:20.343790527 -0500
+++ linux-2.6.9/mm/vmscan.c	2004-12-21 11:27:43.514384221 -0500
@@ -1079,6 +1079,7 @@
  			shrink_slab(sc.nr_scanned, GFP_KERNEL, lru_pages);
  			sc.nr_reclaimed += reclaim_state->reclaimed_slab;
  			total_reclaimed += sc.nr_reclaimed;
+			total_scanned += sc.nr_scanned;
  			if (zone->all_unreclaimable)
  				continue;
  			if (zone->pages_scanned >= (zone->nr_active +

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
