Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161025AbWASBBL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161025AbWASBBL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 20:01:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161026AbWASBBL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 20:01:11 -0500
Received: from mailout.stusta.mhn.de ([141.84.69.5]:47113 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161025AbWASBBK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 20:01:10 -0500
Date: Thu, 19 Jan 2006 02:01:08 +0100
From: Adrian Bunk <bunk@stusta.de>
To: airlied@linux.ie
Cc: dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/char/drm/: make some functions static
Message-ID: <20060119010108.GS19398@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes some needlessly global functions static.


Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/char/drm/i810_dma.c    |    2 +-
 drivers/char/drm/i810_drv.h    |    2 --
 drivers/char/drm/i830_dma.c    |    2 +-
 drivers/char/drm/i830_drv.h    |    3 ---
 drivers/char/drm/savage_bci.c  |    4 +++-
 drivers/char/drm/savage_drv.h  |    1 -
 drivers/char/drm/via_dma.c     |   10 +++++-----
 drivers/char/drm/via_dmablit.c |    2 +-
 drivers/char/drm/via_drv.h     |    7 -------
 drivers/char/drm/via_irq.c     |    2 +-
 10 files changed, 12 insertions(+), 23 deletions(-)

--- linux-2.6.16-rc1-mm1-full/drivers/char/drm/i810_drv.h.old	2006-01-19 00:15:28.000000000 +0100
+++ linux-2.6.16-rc1-mm1-full/drivers/char/drm/i810_drv.h	2006-01-19 00:15:36.000000000 +0100
@@ -113,8 +113,6 @@
 } drm_i810_private_t;
 
 				/* i810_dma.c */
-extern void i810_reclaim_buffers(drm_device_t * dev, struct file *filp);
-
 extern int i810_driver_dma_quiescent(drm_device_t * dev);
 extern void i810_driver_reclaim_buffers_locked(drm_device_t * dev,
 					       struct file *filp);
--- linux-2.6.16-rc1-mm1-full/drivers/char/drm/i810_dma.c.old	2006-01-19 00:15:44.000000000 +0100
+++ linux-2.6.16-rc1-mm1-full/drivers/char/drm/i810_dma.c	2006-01-19 00:15:49.000000000 +0100
@@ -958,7 +958,7 @@
 }
 
 /* Must be called with the lock held */
-void i810_reclaim_buffers(drm_device_t * dev, struct file *filp)
+static void i810_reclaim_buffers(drm_device_t * dev, struct file *filp)
 {
 	drm_device_dma_t *dma = dev->dma;
 	int i;
--- linux-2.6.16-rc1-mm1-full/drivers/char/drm/i830_drv.h.old	2006-01-19 00:17:38.000000000 +0100
+++ linux-2.6.16-rc1-mm1-full/drivers/char/drm/i830_drv.h	2006-01-19 00:17:47.000000000 +0100
@@ -123,9 +123,6 @@
 extern drm_ioctl_desc_t i830_ioctls[];
 extern int i830_max_ioctl;
 
-/* i830_dma.c */
-extern void i830_reclaim_buffers(drm_device_t * dev, struct file *filp);
-
 /* i830_irq.c */
 extern int i830_irq_emit(struct inode *inode, struct file *filp,
 			 unsigned int cmd, unsigned long arg);
--- linux-2.6.16-rc1-mm1-full/drivers/char/drm/i830_dma.c.old	2006-01-19 00:18:33.000000000 +0100
+++ linux-2.6.16-rc1-mm1-full/drivers/char/drm/i830_dma.c	2006-01-19 00:18:41.000000000 +0100
@@ -1239,7 +1239,7 @@
 }
 
 /* Must be called with the lock held */
-void i830_reclaim_buffers(drm_device_t * dev, struct file *filp)
+static void i830_reclaim_buffers(drm_device_t * dev, struct file *filp)
 {
 	drm_device_dma_t *dma = dev->dma;
 	int i;
--- linux-2.6.16-rc1-mm1-full/drivers/char/drm/savage_drv.h.old	2006-01-19 00:19:48.000000000 +0100
+++ linux-2.6.16-rc1-mm1-full/drivers/char/drm/savage_drv.h	2006-01-19 00:19:55.000000000 +0100
@@ -212,7 +212,6 @@
 extern int savage_driver_firstopen(drm_device_t *dev);
 extern void savage_driver_lastclose(drm_device_t *dev);
 extern int savage_driver_unload(drm_device_t *dev);
-extern int savage_do_cleanup_bci(drm_device_t * dev);
 extern void savage_reclaim_buffers(drm_device_t * dev, DRMFILE filp);
 
 /* state functions */
--- linux-2.6.16-rc1-mm1-full/drivers/char/drm/savage_bci.c.old	2006-01-19 00:20:02.000000000 +0100
+++ linux-2.6.16-rc1-mm1-full/drivers/char/drm/savage_bci.c	2006-01-19 00:20:24.000000000 +0100
@@ -32,6 +32,8 @@
 #define SAVAGE_EVENT_USEC_TIMEOUT	5000000	/* 5s */
 #define SAVAGE_FREELIST_DEBUG		0
 
+static int savage_do_cleanup_bci(drm_device_t * dev);
+
 static int
 savage_bci_wait_fifo_shadow(drm_savage_private_t * dev_priv, unsigned int n)
 {
@@ -895,7 +897,7 @@
 	return 0;
 }
 
-int savage_do_cleanup_bci(drm_device_t * dev)
+static int savage_do_cleanup_bci(drm_device_t * dev)
 {
 	drm_savage_private_t *dev_priv = dev->dev_private;
 
--- linux-2.6.16-rc1-mm1-full/drivers/char/drm/via_drv.h.old	2006-01-19 00:21:25.000000000 +0100
+++ linux-2.6.16-rc1-mm1-full/drivers/char/drm/via_drv.h	2006-01-19 01:07:36.000000000 +0100
@@ -110,11 +110,6 @@
 extern int via_agp_init(DRM_IOCTL_ARGS);
 extern int via_map_init(DRM_IOCTL_ARGS);
 extern int via_decoder_futex(DRM_IOCTL_ARGS);
-extern int via_dma_init(DRM_IOCTL_ARGS);
-extern int via_cmdbuffer(DRM_IOCTL_ARGS);
-extern int via_flush_ioctl(DRM_IOCTL_ARGS);
-extern int via_pci_cmdbuffer(DRM_IOCTL_ARGS);
-extern int via_cmdbuf_size(DRM_IOCTL_ARGS);
 extern int via_wait_irq(DRM_IOCTL_ARGS);
 extern int via_dma_blit_sync( DRM_IOCTL_ARGS );
 extern int via_dma_blit( DRM_IOCTL_ARGS );
@@ -139,8 +134,6 @@
 extern void via_init_futex(drm_via_private_t * dev_priv);
 extern void via_cleanup_futex(drm_via_private_t * dev_priv);
 extern void via_release_futex(drm_via_private_t * dev_priv, int context);
-extern int via_driver_irq_wait(drm_device_t * dev, unsigned int irq,
-			       int force_sequence, unsigned int *sequence);
 
 extern void via_dmablit_handler(drm_device_t *dev, int engine, int from_irq);
 extern void via_init_dmablit(drm_device_t *dev);
--- linux-2.6.16-rc1-mm1-full/drivers/char/drm/via_dma.c.old	2006-01-19 00:21:41.000000000 +0100
+++ linux-2.6.16-rc1-mm1-full/drivers/char/drm/via_dma.c	2006-01-19 01:07:47.000000000 +0100
@@ -222,7 +222,7 @@
 	return 0;
 }
 
-int via_dma_init(DRM_IOCTL_ARGS)
+static int via_dma_init(DRM_IOCTL_ARGS)
 {
 	DRM_DEVICE;
 	drm_via_private_t *dev_priv = (drm_via_private_t *) dev->dev_private;
@@ -321,7 +321,7 @@
 	return 0;
 }
 
-int via_flush_ioctl(DRM_IOCTL_ARGS)
+static int via_flush_ioctl(DRM_IOCTL_ARGS)
 {
 	DRM_DEVICE;
 
@@ -330,7 +330,7 @@
 	return via_driver_dma_quiescent(dev);
 }
 
-int via_cmdbuffer(DRM_IOCTL_ARGS)
+static int via_cmdbuffer(DRM_IOCTL_ARGS)
 {
 	DRM_DEVICE;
 	drm_via_cmdbuffer_t cmdbuf;
@@ -375,7 +375,7 @@
 	return ret;
 }
 
-int via_pci_cmdbuffer(DRM_IOCTL_ARGS)
+static int via_pci_cmdbuffer(DRM_IOCTL_ARGS)
 {
 	DRM_DEVICE;
 	drm_via_cmdbuffer_t cmdbuf;
@@ -665,7 +665,7 @@
  * User interface to the space and lag functions.
  */
 
-int via_cmdbuf_size(DRM_IOCTL_ARGS)
+static int via_cmdbuf_size(DRM_IOCTL_ARGS)
 {
 	DRM_DEVICE;
 	drm_via_cmdbuf_size_t d_siz;
--- linux-2.6.16-rc1-mm1-full/drivers/char/drm/via_dmablit.c.old	2006-01-19 00:35:21.000000000 +0100
+++ linux-2.6.16-rc1-mm1-full/drivers/char/drm/via_dmablit.c	2006-01-19 00:35:38.000000000 +0100
@@ -167,7 +167,7 @@
  */
 
 
-void
+static void
 via_free_sg_info(struct pci_dev *pdev, drm_via_sg_info_t *vsg) 
 {
 	struct page *page;
--- linux-2.6.16-rc1-mm1-full/drivers/char/drm/via_irq.c.old	2006-01-19 00:36:22.000000000 +0100
+++ linux-2.6.16-rc1-mm1-full/drivers/char/drm/via_irq.c	2006-01-19 00:36:27.000000000 +0100
@@ -190,7 +190,7 @@
 	return ret;
 }
 
-int
+static int
 via_driver_irq_wait(drm_device_t * dev, unsigned int irq, int force_sequence,
 		    unsigned int *sequence)
 {

