Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265003AbSKUW3m>; Thu, 21 Nov 2002 17:29:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264992AbSKUW3l>; Thu, 21 Nov 2002 17:29:41 -0500
Received: from air-2.osdl.org ([65.172.181.6]:13952 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S265003AbSKUWZ1>;
	Thu, 21 Nov 2002 17:25:27 -0500
Date: Thu, 21 Nov 2002 14:32:34 -0800
From: Bob Miller <rem@osdl.org>
To: trivial@rustcorp.com.au
Cc: linux-kernel@vger.kernel.org
Subject: [TRIVIAL PATCH 2.5.48] Use max_t() instead of max() in mm/vmscan.c
Message-ID: <20021121223234.GF1431@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This change removes a "duplicate 'const'" compiler warning.

diff -Nru a/mm/vmscan.c b/mm/vmscan.c
--- a/mm/vmscan.c	Thu Nov 21 13:51:25 2002
+++ b/mm/vmscan.c	Thu Nov 21 13:51:25 2002
@@ -743,7 +743,7 @@
 			continue;	/* zone has enough memory */
 
 		to_reclaim = min(to_reclaim, SWAP_CLUSTER_MAX);
-		to_reclaim = max(to_reclaim, nr_pages);
+		to_reclaim = max_t(const int, to_reclaim, nr_pages);
 
 		/*
 		 * If we cannot reclaim `nr_pages' pages by scanning twice
-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17
