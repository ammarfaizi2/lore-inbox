Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751188AbWHBPWI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbWHBPWI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 11:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751194AbWHBPWI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 11:22:08 -0400
Received: from mail.sf-mail.de ([62.27.20.61]:58071 "EHLO mail.sf-mail.de")
	by vger.kernel.org with ESMTP id S1751188AbWHBPWG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 11:22:06 -0400
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: Muli Ben-Yehuda <muli@il.ibm.com>
Subject: [PATCH] Move valid_dma_direction() from x86_64 to generic code
Date: Wed, 2 Aug 2006 17:20:40 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@suse.de>, discuss@x86-64.org
References: <200607280928.54306.eike-kernel@sf-tec.de> <20060728174449.GA11046@rhun.ibm.com>
In-Reply-To: <20060728174449.GA11046@rhun.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200608021720.40815.eike-kernel@sf-tec.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As suggested by Muli Ben-Yehuda this function is moved to generic code as
may be useful for all archs.

Signed-off-by: Rolf Eike Beer <eike-kernel@sf-tec.de>

---
commit 9f990495512e3f106ce56f885a675636b47ff421
tree ad2864a5204c57d9836ff2360d6bf80c0d2246e3
parent 3ac898b16fb75cd996ec98fa578ea06b6ffb2760
author Rolf Eike Beer <eike-kernel@sf-tec.de> Wed, 02 Aug 2006 17:07:56 +0200
committer Rolf Eike Beer <beer@siso-eb-i34d.silicon-software.de> Wed, 02 Aug 2006 17:07:56 +0200

 include/asm-x86_64/dma-mapping.h |    7 -------
 include/linux/dma-mapping.h      |    7 +++++++
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/asm-x86_64/dma-mapping.h b/include/asm-x86_64/dma-mapping.h
index b6da83d..10174b1 100644
--- a/include/asm-x86_64/dma-mapping.h
+++ b/include/asm-x86_64/dma-mapping.h
@@ -55,13 +55,6 @@ extern dma_addr_t bad_dma_address;
 extern struct dma_mapping_ops* dma_ops;
 extern int iommu_merge;
 
-static inline int valid_dma_direction(int dma_direction)
-{
-	return ((dma_direction == DMA_BIDIRECTIONAL) ||
-		(dma_direction == DMA_TO_DEVICE) ||
-		(dma_direction == DMA_FROM_DEVICE));
-}
-
 static inline int dma_mapping_error(dma_addr_t dma_addr)
 {
 	if (dma_ops->mapping_error)
diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
index 635690c..ff203c4 100644
--- a/include/linux/dma-mapping.h
+++ b/include/linux/dma-mapping.h
@@ -24,6 +24,13 @@ #define DMA_29BIT_MASK	0x000000001ffffff
 #define DMA_28BIT_MASK	0x000000000fffffffULL
 #define DMA_24BIT_MASK	0x0000000000ffffffULL
 
+static inline int valid_dma_direction(int dma_direction)
+{
+	return ((dma_direction == DMA_BIDIRECTIONAL) ||
+		(dma_direction == DMA_TO_DEVICE) ||
+		(dma_direction == DMA_FROM_DEVICE));
+}
+
 #include <asm/dma-mapping.h>
 
 /* Backwards compat, remove in 2.7.x */
