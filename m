Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750726AbWDTB4P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbWDTB4P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 21:56:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbWDTB4P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 21:56:15 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:4615 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750726AbWDTB4O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 21:56:14 -0400
Date: Thu, 20 Apr 2006 03:56:13 +0200
From: Adrian Bunk <bunk@stusta.de>
To: airlied@linux.ie
Cc: dri-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [RFC: 2.6 patch] drivers/char/drm/: possible cleanups
Message-ID: <20060420015613.GK25047@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make the following needlessly global function static:
  - drm_bufs.c: drm_addbufs_fb()
- remove the following unused EXPORT_SYMBOL's:
  - drm_agpsupport.c: drm_agp_bind_memory
  - drm_bufs.c: drm_rmmap_locked
  - drm_bufs.c: drm_rmmap
  - drm_stub.c: drm_get_dev

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/char/drm/drmP.h           |    1 -
 drivers/char/drm/drm_agpsupport.c |    2 --
 drivers/char/drm/drm_bufs.c       |    5 +----
 drivers/char/drm/drm_stub.c       |    2 --
 4 files changed, 1 insertion(+), 9 deletions(-)

--- linux-2.6.17-rc1-mm3-full/drivers/char/drm/drm_agpsupport.c.old	2006-04-20 03:16:40.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/drivers/char/drm/drm_agpsupport.c	2006-04-20 03:16:48.000000000 +0200
@@ -503,8 +503,6 @@
 	return agp_bind_memory(handle, start);
 }
 
-EXPORT_SYMBOL(drm_agp_bind_memory);
-
 /** Calls agp_unbind_memory() */
 int drm_agp_unbind_memory(DRM_AGP_MEM * handle)
 {
--- linux-2.6.17-rc1-mm3-full/drivers/char/drm/drmP.h.old	2006-04-20 03:18:35.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/drivers/char/drm/drmP.h	2006-04-20 03:18:38.000000000 +0200
@@ -889,7 +889,6 @@
 				/* Buffer management support (drm_bufs.h) */
 extern int drm_addbufs_agp(drm_device_t * dev, drm_buf_desc_t * request);
 extern int drm_addbufs_pci(drm_device_t * dev, drm_buf_desc_t * request);
-extern int drm_addbufs_fb(drm_device_t *dev, drm_buf_desc_t *request);
 extern int drm_addmap(drm_device_t * dev, unsigned int offset,
 		      unsigned int size, drm_map_type_t type,
 		      drm_map_flags_t flags, drm_local_map_t ** map_ptr);
--- linux-2.6.17-rc1-mm3-full/drivers/char/drm/drm_bufs.c.old	2006-04-20 03:17:18.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/drivers/char/drm/drm_bufs.c	2006-04-20 03:18:19.000000000 +0200
@@ -386,7 +386,6 @@
 
 	return 0;
 }
-EXPORT_SYMBOL(drm_rmmap_locked);
 
 int drm_rmmap(drm_device_t *dev, drm_local_map_t *map)
 {
@@ -398,7 +397,6 @@
 
 	return ret;
 }
-EXPORT_SYMBOL(drm_rmmap);
 
 /* The rmmap ioctl appears to be unnecessary.  All mappings are torn down on
  * the last close of the device, and this is necessary for cleanup when things
@@ -1053,7 +1051,7 @@
 	return 0;
 }
 
-int drm_addbufs_fb(drm_device_t * dev, drm_buf_desc_t * request)
+static int drm_addbufs_fb(drm_device_t * dev, drm_buf_desc_t * request)
 {
 	drm_device_dma_t *dma = dev->dma;
 	drm_buf_entry_t *entry;
@@ -1212,7 +1210,6 @@
 	atomic_dec(&dev->buf_alloc);
 	return 0;
 }
-EXPORT_SYMBOL(drm_addbufs_fb);
 
 
 /**
--- linux-2.6.17-rc1-mm3-full/drivers/char/drm/drm_stub.c.old	2006-04-20 03:19:16.000000000 +0200
+++ linux-2.6.17-rc1-mm3-full/drivers/char/drm/drm_stub.c	2006-04-20 03:19:25.000000000 +0200
@@ -229,8 +229,6 @@
 	return ret;
 }
 
-EXPORT_SYMBOL(drm_get_dev);
-
 /**
  * Put a device minor number.
  *

