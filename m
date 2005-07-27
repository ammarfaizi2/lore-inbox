Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261972AbVG0RTf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261972AbVG0RTf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 13:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbVG0RTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 13:19:35 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:38151 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261972AbVG0RTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 13:19:35 -0400
Date: Wed, 27 Jul 2005 19:19:23 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Andrew Morton <akpm@osdl.org>
Cc: airlied@linux.ie, dri-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/drm/drm_pci.c: fix warnings
Message-ID: <20050727171923.GG3160@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following warnings:

<--  snip  -->

...
  CC      drivers/char/drm/drm_pci.o
drivers/char/drm/drm_pci.c:53:5: warning: "DRM_DEBUG_MEMORY" is not defined
drivers/char/drm/drm_pci.c:84:5: warning: "DRM_DEBUG_MEMORY" is not defined
drivers/char/drm/drm_pci.c:119:5: warning: "DRM_DEBUG_MEMORY" is not defined
drivers/char/drm/drm_pci.c:126:5: warning: "DRM_DEBUG_MEMORY" is not defined
drivers/char/drm/drm_pci.c:134:5: warning: "DRM_DEBUG_MEMORY" is not defined
...

<--  snip  -->


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 22 Jul 2005

 drivers/char/drm/drm_pci.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

--- linux-2.6.13-rc3-mm1-full/drivers/char/drm/drm_pci.c.old	2005-07-22 18:16:02.000000000 +0200
+++ linux-2.6.13-rc3-mm1-full/drivers/char/drm/drm_pci.c	2005-07-22 18:16:24.000000000 +0200
@@ -50,7 +50,7 @@
 				dma_addr_t maxaddr)
 {
 	drm_dma_handle_t *dmah;
-#if DRM_DEBUG_MEMORY
+#ifdef DRM_DEBUG_MEMORY
 	int area = DRM_MEM_DMA;
 
 	spin_lock(&drm_mem_lock);
@@ -81,7 +81,7 @@
 	dmah->size = size;
 	dmah->vaddr = pci_alloc_consistent(dev->pdev, size, &dmah->busaddr);
 
-#if DRM_DEBUG_MEMORY
+#ifdef DRM_DEBUG_MEMORY
 	if (dmah->vaddr == NULL) {
 		spin_lock(&drm_mem_lock);
 		++drm_mem_stats[area].fail_count;
@@ -116,14 +116,14 @@
 void
 __drm_pci_free(drm_device_t * dev, drm_dma_handle_t *dmah)
 {
-#if DRM_DEBUG_MEMORY
+#ifdef DRM_DEBUG_MEMORY
 	int area = DRM_MEM_DMA;
 	int alloc_count;
 	int free_count;
 #endif
 
 	if (!dmah->vaddr) {
-#if DRM_DEBUG_MEMORY
+#ifdef DRM_DEBUG_MEMORY
 		DRM_MEM_ERROR(area, "Attempt to free address 0\n");
 #endif
 	} else {
@@ -131,7 +131,7 @@
 				    dmah->busaddr);
 	}
 
-#if DRM_DEBUG_MEMORY
+#ifdef DRM_DEBUG_MEMORY
 	spin_lock(&drm_mem_lock);
 	free_count = ++drm_mem_stats[area].free_count;
 	alloc_count = drm_mem_stats[area].succeed_count;

