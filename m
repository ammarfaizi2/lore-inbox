Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266777AbSLWQKT>; Mon, 23 Dec 2002 11:10:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266792AbSLWQKS>; Mon, 23 Dec 2002 11:10:18 -0500
Received: from holomorphy.com ([66.224.33.161]:49617 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S266777AbSLWQKS>;
	Mon, 23 Dec 2002 11:10:18 -0500
Date: Mon, 23 Dec 2002 08:17:36 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Cc: axboe@suse.de
Subject: blkdev.h integer overflows
Message-ID: <20021223161736.GY25000@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org, axboe@suse.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

blk_max_pfn is an unsigned long; left shifting by PAGE_SHIFT means
it may overflow.


Bill


diff -urpN mm2-2.5.52-1/include/linux/blkdev.h blk-2.5.52-1/include/linux/blkdev.h
--- mm2-2.5.52-1/include/linux/blkdev.h	2002-12-18 22:01:01.000000000 -0800
+++ blk-2.5.52-1/include/linux/blkdev.h	2002-12-23 08:06:25.000000000 -0800
@@ -297,8 +297,8 @@ extern unsigned long blk_max_low_pfn, bl
  * BLK_BOUNCE_ANY	: don't bounce anything
  * BLK_BOUNCE_ISA	: bounce pages above ISA DMA boundary
  */
-#define BLK_BOUNCE_HIGH		(blk_max_low_pfn << PAGE_SHIFT)
-#define BLK_BOUNCE_ANY		(blk_max_pfn << PAGE_SHIFT)
+#define BLK_BOUNCE_HIGH		((u64)blk_max_low_pfn << PAGE_SHIFT)
+#define BLK_BOUNCE_ANY		((u64)blk_max_pfn << PAGE_SHIFT)
 #define BLK_BOUNCE_ISA		(ISA_DMA_THRESHOLD)
 
 extern int init_emergency_isa_pool(void);
