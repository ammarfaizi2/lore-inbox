Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932426AbVLITr5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932426AbVLITr5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Dec 2005 14:47:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932427AbVLITr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Dec 2005 14:47:56 -0500
Received: from fmr24.intel.com ([143.183.121.16]:17624 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S932426AbVLITr4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Dec 2005 14:47:56 -0500
Date: Fri, 9 Dec 2005 11:47:41 -0800
From: Rohit Seth <rohit.seth@intel.com>
To: akpm@osdl.org
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH]: gets a new online cpu to use percpu_pagelist_fraction
Message-ID: <20051209114740.A557@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If percpu_pagelist_fraction tunable is set then this patch allows a newly
brought online cpu to use new settings for high and batch values in its 
per cpu pagelists.

Signed-off-by: Rohit Seth <rohit.seth@intel.com>


--- c/mm/page_alloc.c	2005-12-09 03:43:22.000000000 -0800
+++ linux-2.6.15-rc5-mm1/mm/page_alloc.c	2005-12-09 03:45:28.000000000 -0800
@@ -1977,6 +1977,10 @@
 			goto bad;
 
 		setup_pageset(zone->pageset[cpu], zone_batchsize(zone));
+
+		if (percpu_pagelist_fraction) 
+			setup_pagelist_highmark(zone_pcp(zone, cpu), 
+			 	(zone->present_pages / percpu_pagelist_fraction));
 	}
 
 	return 0;
