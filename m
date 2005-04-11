Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261965AbVDKWSU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261965AbVDKWSU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 18:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261968AbVDKWRF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 18:17:05 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:33298 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261965AbVDKWPg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 18:15:36 -0400
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] Add comment about dma_supported()
X-Patch-Ref: 01-fixes/05-dma_supported-comments
Message-Id: <E1DL7Bq-0003CF-QF@raistlin.arm.linux.org.uk>
Date: Mon, 11 Apr 2005 23:15:30 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The ARM dma_supported() is rather basic, and I don't think
it takes into account everything that it should do (eg,
whether the mask agrees with what we'd return for GFP_DMA
allocations).  Note this.

Signed-off-by: Russell King <rmk@arm.linux.org.uk>

diff -up -x BitKeeper -x ChangeSet -x SCCS -x _xlk -x '*.orig' -x '*.rej' -r orig/include/asm-arm/dma-mapping.h linux/include/asm-arm/dma-mapping.h
--- orig/include/asm-arm/dma-mapping.h	Wed Jan 12 10:13:19 2005
+++ linux/include/asm-arm/dma-mapping.h	Fri Jun 18 17:56:02 2004
@@ -21,6 +21,9 @@ extern void consistent_sync(void *kaddr,
  * properly.  For example, if your device can only drive the low 24-bits
  * during bus mastering, then you would pass 0x00ffffff as the mask
  * to this function.
+ *
+ * FIXME: This should really be a platform specific issue - we should
+ * return false if GFP_DMA allocations may not satisfy the supplied 'mask'.
  */
 static inline int dma_supported(struct device *dev, u64 mask)
 {

