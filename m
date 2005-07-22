Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261402AbVGVVbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261402AbVGVVbv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Jul 2005 17:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262184AbVGVVbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Jul 2005 17:31:51 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:32266 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261402AbVGVVbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Jul 2005 17:31:51 -0400
Date: Fri, 22 Jul 2005 23:31:46 +0200
From: Adrian Bunk <bunk@stusta.de>
To: airlied@linux.ie
Cc: dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/drm/drm_pci.c: fix -Wundef warnings
Message-ID: <20050722213146.GR3160@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following warnings with -Wundef:

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

