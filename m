Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263182AbUJ2COt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263182AbUJ2COt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 22:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263167AbUJ2COt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 22:14:49 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:10502 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263182AbUJ2AQu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 20:16:50 -0400
Date: Fri, 29 Oct 2004 02:16:18 +0200
From: Adrian Bunk <bunk@stusta.de>
To: dri-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] DRM: remove unused functions
Message-ID: <20041029001618.GF29142@stusta.de>
References: <20041028221535.GL3207@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041028221535.GL3207@stusta.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ this time without the problems due to a digital signature... ]

The patch below removes two unused functions from DRM.


diffstat output:
 drivers/char/drm/i810_dma.c |   18 ------------------
 drivers/char/drm/i915_dma.c |   18 ------------------
 2 files changed, 36 deletions(-)


Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.10-rc1-mm1-full/drivers/char/drm/i810_dma.c.old	2004-10-28 22:55:34.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/drivers/char/drm/i810_dma.c	2004-10-28 22:55:45.000000000 +0200
@@ -51,24 +51,6 @@
 #define up_write up
 #endif
 
-static inline void i810_print_status_page(drm_device_t *dev)
-{
-   	drm_device_dma_t *dma = dev->dma;
-      	drm_i810_private_t *dev_priv = dev->dev_private;
-	u32 *temp = dev_priv->hw_status_page;
-   	int i;
-
-   	DRM_DEBUG(  "hw_status: Interrupt Status : %x\n", temp[0]);
-   	DRM_DEBUG(  "hw_status: LpRing Head ptr : %x\n", temp[1]);
-   	DRM_DEBUG(  "hw_status: IRing Head ptr : %x\n", temp[2]);
-      	DRM_DEBUG(  "hw_status: Reserved : %x\n", temp[3]);
-	DRM_DEBUG(  "hw_status: Last Render: %x\n", temp[4]);
-   	DRM_DEBUG(  "hw_status: Driver Counter : %d\n", temp[5]);
-   	for(i = 6; i < dma->buf_count + 6; i++) {
-	   	DRM_DEBUG( "buffer status idx : %d used: %d\n", i - 6, temp[i]);
-	}
-}
-
 static drm_buf_t *i810_freelist_get(drm_device_t *dev)
 {
    	drm_device_dma_t *dma = dev->dma;
--- linux-2.6.10-rc1-mm1-full/drivers/char/drm/i915_dma.c.old	2004-10-28 22:56:35.000000000 +0200
+++ linux-2.6.10-rc1-mm1-full/drivers/char/drm/i915_dma.c	2004-10-28 22:56:47.000000000 +0200
@@ -13,24 +13,6 @@
 #include "i915_drm.h"
 #include "i915_drv.h"
 
-static inline void i915_print_status_page(drm_device_t * dev)
-{
-	drm_i915_private_t *dev_priv = dev->dev_private;
-	u32 *temp = dev_priv->hw_status_page;
-
-	if (!temp) {
-		DRM_DEBUG("no status page\n");
-		return;
-	}
-
-	DRM_DEBUG("hw_status: Interrupt Status : %x\n", temp[0]);
-	DRM_DEBUG("hw_status: LpRing Head ptr : %x\n", temp[1]);
-	DRM_DEBUG("hw_status: IRing Head ptr : %x\n", temp[2]);
-	DRM_DEBUG("hw_status: Reserved : %x\n", temp[3]);
-	DRM_DEBUG("hw_status: Driver Counter : %d\n", temp[5]);
-
-}
-
 /* Really want an OS-independent resettable timer.  Would like to have
  * this loop run for (eg) 3 sec, but have the timer reset every time
  * the head pointer changes, so that EBUSY only happens if the ring
