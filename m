Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266833AbUJIN0G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266833AbUJIN0G (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 09:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266835AbUJIN0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 09:26:06 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:38871 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S266833AbUJINYp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 09:24:45 -0400
Date: Sat, 9 Oct 2004 14:24:40 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [bk tree] drm small cleanup patches
Message-ID: <Pine.LNX.4.58.0410091416280.21256@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
	This just pulls up a couple of very minor cleanups to the DRM,
	a) move common includes to a drm_core.h file - purely cosmetic
	b) remove some remnants of gamma driver from drm dma.

Please do a

	bk pull bk://drm.bkbits.net/drm-2.6

This will include the latest DRM changes and will update the following files:

 drivers/char/drm/drmP.h       |    7 -------
 drivers/char/drm/drm_core.h   |   40 ++++++++++++++++++++++++++++++++++++++++
 drivers/char/drm/drm_irq.h    |    4 ----
 drivers/char/drm/ffb_drv.c    |   19 +------------------
 drivers/char/drm/i810_drv.c   |   19 +------------------
 drivers/char/drm/i830_drv.c   |   19 +------------------
 drivers/char/drm/i915_drv.c   |   18 +-----------------
 drivers/char/drm/mga_drv.c    |   18 +-----------------
 drivers/char/drm/r128_drv.c   |   18 +-----------------
 drivers/char/drm/radeon_drv.c |   18 +-----------------
 drivers/char/drm/sis_drv.c    |   19 +------------------
 drivers/char/drm/tdfx_drv.c   |   19 +------------------
 12 files changed, 49 insertions(+), 169 deletions(-)

through these ChangeSets:

<airlied@starflyer.(none)> (04/10/09 1.2139)
   drm: cleanup header includes into one drm_core.h include

   This patch just cleans up the fact that all drm drivers include a
   bunch of header files, it places them into one place (drm_core.h)
   and uses that.

   From: Jon Smirl <jonsmirl@gmail.com>
   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (04/10/09 1.2138)
   drm: remove unused dma support remnants.

   These are unused since the gamma driver was dropped, they
   cause problems with the via driver (coming soon).

   Signed-off-by: Dave Airlie <airlied@linux.ie>

diff -Nru a/drivers/char/drm/drmP.h b/drivers/char/drm/drmP.h
--- a/drivers/char/drm/drmP.h	2004-10-09 21:20:22 +10:00
+++ b/drivers/char/drm/drmP.h	2004-10-09 21:20:22 +10:00
@@ -458,13 +458,6 @@
 		_DRM_DMA_USE_SG  = 0x02
 	} flags;

-	/** \name DMA support */
-	/*@{*/
-	drm_buf_t	  *this_buffer;	/**< Buffer being sent */
-	drm_buf_t	  *next_buffer; /**< Selected buffer to send */
-	drm_queue_t	  *next_queue;	/**< Queue from which buffer selected*/
-	wait_queue_head_t waiting;	/**< Processes waiting on free bufs */
-	/*@}*/
 } drm_device_dma_t;

 /**
diff -Nru a/drivers/char/drm/drm_core.h b/drivers/char/drm/drm_core.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/char/drm/drm_core.h	2004-10-09 21:20:22 +10:00
@@ -0,0 +1,40 @@
+/*
+ * Copyright 2004 Jon Smirl <jonsmirl@gmail.com>
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a
+ * copy of this software and associated documentation files (the "Software"),
+ * to deal in the Software without restriction, including without limitation
+ * the rights to use, copy, modify, merge, publish, distribute, sub license,
+ * and/or sell copies of the Software, and to permit persons to whom the
+ * Software is furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice (including the
+ * next paragraph) shall be included in all copies or substantial portions
+ * of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL
+ * VIA, S3 GRAPHICS, AND/OR ITS SUPPLIERS BE LIABLE FOR ANY CLAIM, DAMAGES OR
+ * OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
+ * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
+ * DEALINGS IN THE SOFTWARE.
+ */
+
+#include "drm_auth.h"
+#include "drm_agpsupport.h"
+#include "drm_bufs.h"
+#include "drm_context.h"
+#include "drm_dma.h"
+#include "drm_irq.h"
+#include "drm_drawable.h"
+#include "drm_drv.h"
+#include "drm_fops.h"
+#include "drm_init.h"
+#include "drm_ioctl.h"
+#include "drm_lock.h"
+#include "drm_memory.h"
+#include "drm_proc.h"
+#include "drm_vm.h"
+#include "drm_stub.h"
+#include "drm_scatter.h"
diff -Nru a/drivers/char/drm/drm_irq.h b/drivers/char/drm/drm_irq.h
--- a/drivers/char/drm/drm_irq.h	2004-10-09 21:20:22 +10:00
+++ b/drivers/char/drm/drm_irq.h	2004-10-09 21:20:22 +10:00
@@ -117,10 +117,6 @@

 	DRM_DEBUG( "%s: irq=%d\n", __FUNCTION__, dev->irq );

-	dev->dma->next_buffer = NULL;
-	dev->dma->next_queue = NULL;
-	dev->dma->this_buffer = NULL;
-
 	if (drm_core_check_feature(dev, DRIVER_IRQ_VBL)) {
 		init_waitqueue_head(&dev->vbl_queue);

diff -Nru a/drivers/char/drm/ffb_drv.c b/drivers/char/drm/ffb_drv.c
--- a/drivers/char/drm/ffb_drv.c	2004-10-09 21:20:22 +10:00
+++ b/drivers/char/drm/ffb_drv.c	2004-10-09 21:20:22 +10:00
@@ -210,12 +210,7 @@
 	return addr;
 }

-#include "drm_auth.h"
-#include "drm_bufs.h"
-#include "drm_context.h"
-#include "drm_dma.h"
-#include "drm_drawable.h"
-#include "drm_drv.h"
+#include "drm_core.h"

 /* This functions must be here since it references DRM(numdevs)
  * which drm_drv.h declares.
@@ -253,18 +248,6 @@
 			   i);
 	return ret;
 }
-
-#include "drm_fops.h"
-#include "drm_init.h"
-#include "drm_ioctl.h"
-#include "drm_irq.h"
-#include "drm_lock.h"
-#include "drm_memory.h"
-#include "drm_proc.h"
-#include "drm_vm.h"
-#include "drm_stub.h"
-#include "drm_scatter.h"
-

 static void ffb_driver_release(drm_device_t *dev, struct file *filp)
 {
diff -Nru a/drivers/char/drm/i810_drv.c b/drivers/char/drm/i810_drv.c
--- a/drivers/char/drm/i810_drv.c	2004-10-09 21:20:22 +10:00
+++ b/drivers/char/drm/i810_drv.c	2004-10-09 21:20:22 +10:00
@@ -37,21 +37,4 @@
 #include "i810_drm.h"
 #include "i810_drv.h"

-#include "drm_agpsupport.h"
-#include "drm_auth.h"
-#include "drm_bufs.h"
-#include "drm_context.h"
-#include "drm_dma.h"
-#include "drm_drawable.h"
-#include "drm_drv.h"
-
-#include "drm_fops.h"
-#include "drm_init.h"
-#include "drm_ioctl.h"
-#include "drm_irq.h"
-#include "drm_lock.h"
-#include "drm_memory.h"
-#include "drm_proc.h"
-#include "drm_vm.h"
-#include "drm_stub.h"
-#include "drm_scatter.h"
+#include "drm_core.h"
diff -Nru a/drivers/char/drm/i830_drv.c b/drivers/char/drm/i830_drv.c
--- a/drivers/char/drm/i830_drv.c	2004-10-09 21:20:22 +10:00
+++ b/drivers/char/drm/i830_drv.c	2004-10-09 21:20:22 +10:00
@@ -39,21 +39,4 @@
 #include "i830_drm.h"
 #include "i830_drv.h"

-#include "drm_agpsupport.h"
-#include "drm_auth.h"
-#include "drm_bufs.h"
-#include "drm_context.h"
-#include "drm_dma.h"
-#include "drm_drawable.h"
-#include "drm_drv.h"
-
-#include "drm_fops.h"
-#include "drm_init.h"
-#include "drm_ioctl.h"
-#include "drm_irq.h"
-#include "drm_lock.h"
-#include "drm_memory.h"
-#include "drm_proc.h"
-#include "drm_vm.h"
-#include "drm_stub.h"
-#include "drm_scatter.h"
+#include "drm_core.h"
diff -Nru a/drivers/char/drm/i915_drv.c b/drivers/char/drm/i915_drv.c
--- a/drivers/char/drm/i915_drv.c	2004-10-09 21:20:22 +10:00
+++ b/drivers/char/drm/i915_drv.c	2004-10-09 21:20:22 +10:00
@@ -14,20 +14,4 @@
 #include "i915_drm.h"
 #include "i915_drv.h"

-#include "drm_agpsupport.h"
-#include "drm_auth.h"		/* is this needed? */
-#include "drm_bufs.h"
-#include "drm_context.h"	/* is this needed? */
-#include "drm_drawable.h"	/* is this needed? */
-#include "drm_dma.h"
-#include "drm_drv.h"
-#include "drm_fops.h"
-#include "drm_init.h"
-#include "drm_irq.h"
-#include "drm_ioctl.h"
-#include "drm_lock.h"
-#include "drm_memory.h"		/*  */
-#include "drm_proc.h"
-#include "drm_vm.h"
-#include "drm_stub.h"
-#include "drm_scatter.h"
+#include "drm_core.h"
diff -Nru a/drivers/char/drm/mga_drv.c b/drivers/char/drm/mga_drv.c
--- a/drivers/char/drm/mga_drv.c	2004-10-09 21:20:22 +10:00
+++ b/drivers/char/drm/mga_drv.c	2004-10-09 21:20:22 +10:00
@@ -35,20 +35,4 @@
 #include "drm.h"
 #include "mga_drm.h"
 #include "mga_drv.h"
-#include "drm_agpsupport.h"
-#include "drm_auth.h"
-#include "drm_bufs.h"
-#include "drm_context.h"
-#include "drm_dma.h"
-#include "drm_drawable.h"
-#include "drm_drv.h"
-#include "drm_fops.h"
-#include "drm_init.h"
-#include "drm_ioctl.h"
-#include "drm_irq.h"
-#include "drm_lock.h"
-#include "drm_memory.h"
-#include "drm_proc.h"
-#include "drm_vm.h"
-#include "drm_stub.h"
-#include "drm_scatter.h"
+#include "drm_core.h"
diff -Nru a/drivers/char/drm/r128_drv.c b/drivers/char/drm/r128_drv.c
--- a/drivers/char/drm/r128_drv.c	2004-10-09 21:20:22 +10:00
+++ b/drivers/char/drm/r128_drv.c	2004-10-09 21:20:22 +10:00
@@ -37,20 +37,4 @@
 #include "r128_drv.h"
 #include "ati_pcigart.h"

-#include "drm_agpsupport.h"
-#include "drm_auth.h"
-#include "drm_bufs.h"
-#include "drm_context.h"
-#include "drm_dma.h"
-#include "drm_drawable.h"
-#include "drm_drv.h"
-#include "drm_fops.h"
-#include "drm_init.h"
-#include "drm_ioctl.h"
-#include "drm_irq.h"
-#include "drm_lock.h"
-#include "drm_memory.h"
-#include "drm_proc.h"
-#include "drm_vm.h"
-#include "drm_stub.h"
-#include "drm_scatter.h"
+#include "drm_core.h"
diff -Nru a/drivers/char/drm/radeon_drv.c b/drivers/char/drm/radeon_drv.c
--- a/drivers/char/drm/radeon_drv.c	2004-10-09 21:20:22 +10:00
+++ b/drivers/char/drm/radeon_drv.c	2004-10-09 21:20:22 +10:00
@@ -38,20 +38,4 @@
 #include "radeon_drv.h"
 #include "ati_pcigart.h"

-#include "drm_agpsupport.h"
-#include "drm_auth.h"
-#include "drm_bufs.h"
-#include "drm_context.h"
-#include "drm_dma.h"
-#include "drm_drawable.h"
-#include "drm_drv.h"
-#include "drm_fops.h"
-#include "drm_init.h"
-#include "drm_ioctl.h"
-#include "drm_irq.h"
-#include "drm_lock.h"
-#include "drm_memory.h"
-#include "drm_proc.h"
-#include "drm_vm.h"
-#include "drm_stub.h"
-#include "drm_scatter.h"
+#include "drm_core.h"
diff -Nru a/drivers/char/drm/sis_drv.c b/drivers/char/drm/sis_drv.c
--- a/drivers/char/drm/sis_drv.c	2004-10-09 21:20:22 +10:00
+++ b/drivers/char/drm/sis_drv.c	2004-10-09 21:20:22 +10:00
@@ -31,21 +31,4 @@
 #include "sis_drm.h"
 #include "sis_drv.h"

-#include "drm_auth.h"
-#include "drm_agpsupport.h"
-#include "drm_bufs.h"
-#include "drm_context.h"
-#include "drm_dma.h"
-#include "drm_drawable.h"
-#include "drm_drv.h"
-#include "drm_fops.h"
-#include "drm_init.h"
-#include "drm_irq.h"
-#include "drm_ioctl.h"
-#include "drm_lock.h"
-#include "drm_memory.h"
-#include "drm_proc.h"
-#include "drm_vm.h"
-#include "drm_stub.h"
-#include "drm_scatter.h"
-
+#include "drm_core.h"
diff -Nru a/drivers/char/drm/tdfx_drv.c b/drivers/char/drm/tdfx_drv.c
--- a/drivers/char/drm/tdfx_drv.c	2004-10-09 21:20:22 +10:00
+++ b/drivers/char/drm/tdfx_drv.c	2004-10-09 21:20:22 +10:00
@@ -34,24 +34,7 @@
 #include "tdfx.h"
 #include "drmP.h"

-#include "drm_agpsupport.h"
-#include "drm_auth.h"
-#include "drm_bufs.h"
-#include "drm_context.h"
-#include "drm_dma.h"
-#include "drm_drawable.h"
-#include "drm_drv.h"
-
-#include "drm_fops.h"
-#include "drm_init.h"
-#include "drm_ioctl.h"
-#include "drm_irq.h"
-#include "drm_lock.h"
-#include "drm_memory.h"
-#include "drm_proc.h"
-#include "drm_vm.h"
-#include "drm_stub.h"
-#include "drm_scatter.h"
+#include "drm_core.h"

 void DRM(driver_register_fns)(drm_device_t *dev)
 {
