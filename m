Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266806AbTADLeR>; Sat, 4 Jan 2003 06:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266839AbTADLeR>; Sat, 4 Jan 2003 06:34:17 -0500
Received: from holomorphy.com ([66.224.33.161]:61645 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266806AbTADLeR>;
	Sat, 4 Jan 2003 06:34:17 -0500
Date: Sat, 4 Jan 2003 03:42:39 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: blkdev.h paddr overflows
Message-ID: <20030104114239.GD10697@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>, axboe@suse.de,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch, originally from Zwane Mwaikambo for my current page
clustering tree, corrects overflows with pfn's shifted to paddrs.
The portion of the fix casting the pfn's to dma_addr_t, included
here, is applicable to mainline.


Please apply,
Bill


===== include/linux/blkdev.h 1.94 vs edited =====
--- 1.94/include/linux/blkdev.h	Tue Nov 19 17:13:41 2002
+++ edited/include/linux/blkdev.h	Mon Dec 30 11:09:01 2002
@@ -287,8 +287,8 @@
  * BLK_BOUNCE_ANY	: don't bounce anything
  * BLK_BOUNCE_ISA	: bounce pages above ISA DMA boundary
  */
-#define BLK_BOUNCE_HIGH		(blk_max_low_pfn << PAGE_SHIFT)
-#define BLK_BOUNCE_ANY		(blk_max_pfn << PAGE_SHIFT)
+#define BLK_BOUNCE_HIGH		((dma_addr_t)blk_max_low_pfn << PAGE_SHIFT)
+#define BLK_BOUNCE_ANY		((dma_addr_t)blk_max_pfn << PAGE_SHIFT)
 #define BLK_BOUNCE_ISA		(ISA_DMA_THRESHOLD)
 
 extern int init_emergency_isa_pool(void);
