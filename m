Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261889AbTLHVu2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 16:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbTLHVu2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 16:50:28 -0500
Received: from holomorphy.com ([199.26.172.102]:57821 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261875AbTLHVuY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 16:50:24 -0500
Date: Mon, 8 Dec 2003 13:50:12 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: marcelo.tosatti@cyclades.com
Cc: linux-kernel@vger.kernel.org
Subject: fix 2.4 BLK_BOUNCE_ANY
Message-ID: <20031208215012.GC19856@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	marcelo.tosatti@cyclades.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The bitshift defining BLK_BOUNCE_ANY can overflow. This patch casts
to u64 before shifting there as well as in BLK_BOUNCE_HIGH to ensure
integer overflow does not occur.

Originally discovered by Zwane Mwaikambo during pgcl development,
submitted by me to mainline to 2.6, and already included in 2.6.


-- wli


===== include/linux/blkdev.h 1.25 vs edited =====
--- 1.25/include/linux/blkdev.h	Wed Jul 16 13:20:46 2003
+++ edited/include/linux/blkdev.h	Mon Dec  8 13:44:17 2003
@@ -176,8 +176,8 @@
 
 extern unsigned long blk_max_low_pfn, blk_max_pfn;
 
-#define BLK_BOUNCE_HIGH		(blk_max_low_pfn << PAGE_SHIFT)
-#define BLK_BOUNCE_ANY		(blk_max_pfn << PAGE_SHIFT)
+#define BLK_BOUNCE_HIGH		((u64)blk_max_low_pfn << PAGE_SHIFT)
+#define BLK_BOUNCE_ANY		((u64)blk_max_pfn << PAGE_SHIFT)
 
 extern void blk_queue_bounce_limit(request_queue_t *, u64);
 
