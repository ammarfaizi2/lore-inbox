Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267551AbUIUKuc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267551AbUIUKuc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Sep 2004 06:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267561AbUIUKuc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Sep 2004 06:50:32 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:22708 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S267551AbUIUKuI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Sep 2004 06:50:08 -0400
Date: Tue, 21 Sep 2004 11:50:07 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [BK tree] [drm] remove counter macros..
Message-ID: <Pine.LNX.4.58.0409211148290.22187@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

This just another macro removal, the counter macros are gone...

Please do a

	bk pull bk://drm.bkbits.net/drm-2.6

This will include the latest DRM changes and will update the following files:

 drivers/char/drm/drm_drv.h  |   50 ++++++++------------------------------------
 drivers/char/drm/i810.h     |    6 -----
 drivers/char/drm/i810_dma.c |    6 +++++
 drivers/char/drm/i830.h     |    6 -----
 drivers/char/drm/i830_dma.c |    5 ++++
 drivers/char/drm/i915.h     |    6 -----
 drivers/char/drm/i915_dma.c |    6 +++++
 drivers/char/drm/mga.h      |    5 ----
 drivers/char/drm/mga_dma.c  |    5 ++++
 drivers/char/drm/sis.h      |    2 -
 10 files changed, 32 insertions(+), 65 deletions(-)

through these ChangeSets:

<airlied@starflyer.(none)> (04/09/20 1.1941)
   drm: drop __HAVE_COUNTER macros

   This removes all the __HAVE_COUNTER macro and replaces them with
   the driver setting the values in its register_fns.

   Signed-off-by: Dave Airlie <airlied@linux.ie>

diff -Nru a/drivers/char/drm/drm_drv.h b/drivers/char/drm/drm_drv.h
--- a/drivers/char/drm/drm_drv.h	Tue Sep 21 20:45:46 2004
+++ b/drivers/char/drm/drm_drv.h	Tue Sep 21 20:45:46 2004
@@ -52,10 +52,6 @@
  * OTHER DEALINGS IN THE SOFTWARE.
  */

-#ifndef __HAVE_COUNTERS
-#define __HAVE_COUNTERS			0
-#endif
-
 #ifndef DRIVER_IOCTLS
 #define DRIVER_IOCTLS
 #endif
@@ -195,41 +191,6 @@
 			return i;
 	}

-	dev->counters  = 6 + __HAVE_COUNTERS;
-	dev->types[0]  = _DRM_STAT_LOCK;
-	dev->types[1]  = _DRM_STAT_OPENS;
-	dev->types[2]  = _DRM_STAT_CLOSES;
-	dev->types[3]  = _DRM_STAT_IOCTLS;
-	dev->types[4]  = _DRM_STAT_LOCKS;
-	dev->types[5]  = _DRM_STAT_UNLOCKS;
-#ifdef __HAVE_COUNTER6
-	dev->types[6]  = __HAVE_COUNTER6;
-#endif
-#ifdef __HAVE_COUNTER7
-	dev->types[7]  = __HAVE_COUNTER7;
-#endif
-#ifdef __HAVE_COUNTER8
-	dev->types[8]  = __HAVE_COUNTER8;
-#endif
-#ifdef __HAVE_COUNTER9
-	dev->types[9]  = __HAVE_COUNTER9;
-#endif
-#ifdef __HAVE_COUNTER10
-	dev->types[10] = __HAVE_COUNTER10;
-#endif
-#ifdef __HAVE_COUNTER11
-	dev->types[11] = __HAVE_COUNTER11;
-#endif
-#ifdef __HAVE_COUNTER12
-	dev->types[12] = __HAVE_COUNTER12;
-#endif
-#ifdef __HAVE_COUNTER13
-	dev->types[13] = __HAVE_COUNTER13;
-#endif
-#ifdef __HAVE_COUNTER14
-	dev->types[14] = __HAVE_COUNTER14;
-#endif
-
 	for ( i = 0 ; i < DRM_ARRAY_SIZE(dev->counts) ; i++ )
 		atomic_set( &dev->counts[i], 0 );

@@ -510,7 +471,16 @@

 	/* dev_priv_size can be changed by a driver in driver_register_fns */
 	dev->dev_priv_size = sizeof(u32);
-
+
+	/* the DRM has 6 basic counters - drivers add theirs in register_fns */
+	dev->counters = 6;
+	dev->types[0]  = _DRM_STAT_LOCK;
+	dev->types[1]  = _DRM_STAT_OPENS;
+	dev->types[2]  = _DRM_STAT_CLOSES;
+	dev->types[3]  = _DRM_STAT_IOCTLS;
+	dev->types[4]  = _DRM_STAT_LOCKS;
+	dev->types[5]  = _DRM_STAT_UNLOCKS;
+
 	DRM(init_fn_table)(dev);

 	DRM(driver_register_fns)(dev);
diff -Nru a/drivers/char/drm/i810.h b/drivers/char/drm/i810.h
--- a/drivers/char/drm/i810.h	Tue Sep 21 20:45:46 2004
+++ b/drivers/char/drm/i810.h	Tue Sep 21 20:45:46 2004
@@ -74,10 +74,4 @@
 	[DRM_IOCTL_NR(DRM_IOCTL_I810_RSTATUS)] = { i810_rstatus,    1, 0 }, \
 	[DRM_IOCTL_NR(DRM_IOCTL_I810_FLIP)] =    { i810_flip_bufs,  1, 0 }

-#define __HAVE_COUNTERS         4
-#define __HAVE_COUNTER6         _DRM_STAT_IRQ
-#define __HAVE_COUNTER7         _DRM_STAT_PRIMARY
-#define __HAVE_COUNTER8         _DRM_STAT_SECONDARY
-#define __HAVE_COUNTER9         _DRM_STAT_DMA
-
 #endif
diff -Nru a/drivers/char/drm/i810_dma.c b/drivers/char/drm/i810_dma.c
--- a/drivers/char/drm/i810_dma.c	Tue Sep 21 20:45:46 2004
+++ b/drivers/char/drm/i810_dma.c	Tue Sep 21 20:45:46 2004
@@ -1412,5 +1412,11 @@
 	dev->fn_tbl.release = i810_driver_release;
 	dev->fn_tbl.dma_quiescent = i810_driver_dma_quiescent;
 	dev->fn_tbl.reclaim_buffers = i810_reclaim_buffers;
+
+	dev->counters += 4;
+	dev->types[6] = _DRM_STAT_IRQ;
+	dev->types[7] = _DRM_STAT_PRIMARY;
+	dev->types[8] = _DRM_STAT_SECONDARY;
+	dev->types[9] = _DRM_STAT_DMA;
 }

diff -Nru a/drivers/char/drm/i830.h b/drivers/char/drm/i830.h
--- a/drivers/char/drm/i830.h	Tue Sep 21 20:45:46 2004
+++ b/drivers/char/drm/i830.h	Tue Sep 21 20:45:46 2004
@@ -73,12 +73,6 @@
 	[DRM_IOCTL_NR(DRM_IOCTL_I830_GETPARAM)] = { i830_getparam,  1, 0 }, \
 	[DRM_IOCTL_NR(DRM_IOCTL_I830_SETPARAM)] = { i830_setparam,  1, 0 }

-#define __HAVE_COUNTERS         4
-#define __HAVE_COUNTER6         _DRM_STAT_IRQ
-#define __HAVE_COUNTER7         _DRM_STAT_PRIMARY
-#define __HAVE_COUNTER8         _DRM_STAT_SECONDARY
-#define __HAVE_COUNTER9         _DRM_STAT_DMA
-
 /* Driver will work either way: IRQ's save cpu time when waiting for
  * the card, but are subject to subtle interactions between bios,
  * hardware and the driver.
diff -Nru a/drivers/char/drm/i830_dma.c b/drivers/char/drm/i830_dma.c
--- a/drivers/char/drm/i830_dma.c	Tue Sep 21 20:45:46 2004
+++ b/drivers/char/drm/i830_dma.c	Tue Sep 21 20:45:46 2004
@@ -1615,5 +1615,10 @@
 	dev->fn_tbl.irq_uninstall = i830_driver_irq_uninstall;
 	dev->fn_tbl.irq_handler = i830_driver_irq_handler;
 #endif
+	dev->counters += 4;
+	dev->types[6] = _DRM_STAT_IRQ;
+	dev->types[7] = _DRM_STAT_PRIMARY;
+	dev->types[8] = _DRM_STAT_SECONDARY;
+	dev->types[9] = _DRM_STAT_DMA;
 }

diff -Nru a/drivers/char/drm/i915.h b/drivers/char/drm/i915.h
--- a/drivers/char/drm/i915.h	Tue Sep 21 20:45:46 2004
+++ b/drivers/char/drm/i915.h	Tue Sep 21 20:45:46 2004
@@ -45,12 +45,6 @@
         [DRM_IOCTL_NR(DRM_IOCTL_I915_INIT_HEAP)] = { i915_mem_init_heap, 1, 1 }, \
 	[DRM_IOCTL_NR(DRM_IOCTL_I915_CMDBUFFER)] = { i915_cmdbuffer, 1, 0 }

-#define __HAVE_COUNTERS         4
-#define __HAVE_COUNTER6         _DRM_STAT_IRQ
-#define __HAVE_COUNTER7         _DRM_STAT_PRIMARY
-#define __HAVE_COUNTER8         _DRM_STAT_SECONDARY
-#define __HAVE_COUNTER9         _DRM_STAT_DMA
-
 /* We use our own dma mechanisms, not the drm template code.  However,
  * the shared IRQ code is useful to us:
  */
diff -Nru a/drivers/char/drm/i915_dma.c b/drivers/char/drm/i915_dma.c
--- a/drivers/char/drm/i915_dma.c	Tue Sep 21 20:45:46 2004
+++ b/drivers/char/drm/i915_dma.c	Tue Sep 21 20:45:46 2004
@@ -746,4 +746,10 @@
 	dev->fn_tbl.irq_postinstall = i915_driver_irq_postinstall;
 	dev->fn_tbl.irq_uninstall = i915_driver_irq_uninstall;
 	dev->fn_tbl.irq_handler = i915_driver_irq_handler;
+
+	dev->counters += 4;
+	dev->types[6] = _DRM_STAT_IRQ;
+	dev->types[7] = _DRM_STAT_PRIMARY;
+	dev->types[8] = _DRM_STAT_SECONDARY;
+	dev->types[9] = _DRM_STAT_DMA;
 }
diff -Nru a/drivers/char/drm/mga.h b/drivers/char/drm/mga.h
--- a/drivers/char/drm/mga.h	Tue Sep 21 20:45:46 2004
+++ b/drivers/char/drm/mga.h	Tue Sep 21 20:45:46 2004
@@ -60,9 +60,4 @@
 	[DRM_IOCTL_NR(DRM_IOCTL_MGA_BLIT)]    = { mga_dma_blit,    1, 0 }, \
 	[DRM_IOCTL_NR(DRM_IOCTL_MGA_GETPARAM)]= { mga_getparam,    1, 0 },

-#define __HAVE_COUNTERS         3
-#define __HAVE_COUNTER6         _DRM_STAT_IRQ
-#define __HAVE_COUNTER7         _DRM_STAT_PRIMARY
-#define __HAVE_COUNTER8         _DRM_STAT_SECONDARY
-
 #endif
diff -Nru a/drivers/char/drm/mga_dma.c b/drivers/char/drm/mga_dma.c
--- a/drivers/char/drm/mga_dma.c	Tue Sep 21 20:45:46 2004
+++ b/drivers/char/drm/mga_dma.c	Tue Sep 21 20:45:46 2004
@@ -819,4 +819,9 @@
 	dev->fn_tbl.irq_postinstall = mga_driver_irq_postinstall;
 	dev->fn_tbl.irq_uninstall = mga_driver_irq_uninstall;
 	dev->fn_tbl.irq_handler = mga_driver_irq_handler;
+
+	dev->counters += 3;
+	dev->types[6] = _DRM_STAT_IRQ;
+	dev->types[7] = _DRM_STAT_PRIMARY;
+	dev->types[8] = _DRM_STAT_SECONDARY;
 }
diff -Nru a/drivers/char/drm/sis.h b/drivers/char/drm/sis.h
--- a/drivers/char/drm/sis.h	Tue Sep 21 20:45:46 2004
+++ b/drivers/char/drm/sis.h	Tue Sep 21 20:45:46 2004
@@ -58,6 +58,4 @@
 	[DRM_IOCTL_NR(DRM_IOCTL_SIS_AGP_FREE)]	= { sis_ioctl_agp_free,	1, 0 }, \
 	[DRM_IOCTL_NR(DRM_IOCTL_SIS_FB_INIT)]	= { sis_fb_init,	1, 1 }

-#define __HAVE_COUNTERS		5
-
 #endif
