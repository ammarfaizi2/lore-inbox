Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267411AbTAQGzu>; Fri, 17 Jan 2003 01:55:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267412AbTAQGzu>; Fri, 17 Jan 2003 01:55:50 -0500
Received: from holomorphy.com ([66.224.33.161]:59284 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267411AbTAQGzt>;
	Fri, 17 Jan 2003 01:55:49 -0500
Date: Thu, 16 Jan 2003 23:04:37 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: akpm@zip.com.au
Cc: axboe@suse.de, linux-kernel@vger.kernel.org
Subject: blkdev.h fixes
Message-ID: <20030117070437.GR919@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	akpm@zip.com.au, axboe@suse.de, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm, the last round used dma_addr_t, but it turns out the things
they're compared against are unconditionally u64.


===== include/linux/blkdev.h 1.94 vs edited =====
--- 1.94/include/linux/blkdev.h	Tue Nov 19 17:13:41 2002
+++ edited/include/linux/blkdev.h	Thu Jan 16 23:02:46 2003
@@ -287,8 +287,8 @@
  * BLK_BOUNCE_ANY	: don't bounce anything
  * BLK_BOUNCE_ISA	: bounce pages above ISA DMA boundary
  */
-#define BLK_BOUNCE_HIGH		(blk_max_low_pfn << PAGE_SHIFT)
-#define BLK_BOUNCE_ANY		(blk_max_pfn << PAGE_SHIFT)
+#define BLK_BOUNCE_HIGH		((u64)blk_max_low_pfn << PAGE_SHIFT)
+#define BLK_BOUNCE_ANY		((u64)blk_max_pfn << PAGE_SHIFT)
 #define BLK_BOUNCE_ISA		(ISA_DMA_THRESHOLD)
 
 extern int init_emergency_isa_pool(void);
