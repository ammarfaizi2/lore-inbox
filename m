Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262872AbVDLUOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262872AbVDLUOp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 16:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262146AbVDLUNF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 16:13:05 -0400
Received: from fire.osdl.org ([65.172.181.4]:29896 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262145AbVDLKbf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:31:35 -0400
Message-Id: <200504121030.j3CAUh75005131@shell0.pdx.osdl.net>
Subject: [patch 005/198] arm: add comment about dma_supported()
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, rmk+lkml@arm.linux.org.uk,
       rmk@arm.linux.org.uk
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:30:36 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Russell King <rmk+lkml@arm.linux.org.uk>

The ARM dma_supported() is rather basic, and I don't think it takes into
account everything that it should do (eg, whether the mask agrees with what
we'd return for GFP_DMA allocations).  Note this.

Signed-off-by: Russell King <rmk@arm.linux.org.uk>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/include/asm-arm/dma-mapping.h |    3 +++
 1 files changed, 3 insertions(+)

diff -puN include/asm-arm/dma-mapping.h~arm-add-comment-about-dma_supported include/asm-arm/dma-mapping.h
--- 25/include/asm-arm/dma-mapping.h~arm-add-comment-about-dma_supported	2005-04-12 03:21:04.755413968 -0700
+++ 25-akpm/include/asm-arm/dma-mapping.h	2005-04-12 03:21:04.758413512 -0700
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
_
