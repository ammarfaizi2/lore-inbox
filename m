Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbVIXVAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbVIXVAx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 17:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750760AbVIXVAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 17:00:52 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:4779 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750759AbVIXVAw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 17:00:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=Od/HrbE6LcJIlFldRPevdNitYB3zmFE1bXAt1VMRoknZS5du9qcR7K7tJj+yKXTnShWV90GzjKyy8w8VJ9UC0jAAjze6B5QILUZPsXxnuF/jc+P3OlY4cLunTQBoqe5xe9G+j1bh6kQnkR606mrdvqmsv9BkuC5ivYwo2ZGbtrw=
Date: Sun, 25 Sep 2005 01:11:40 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: David Airlie <airlied@linux.ie>
Cc: Michael Veeck <michael.veeck@gmx.net>, dri-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: [PATCH] Remove DRM_ARRAY_SIZE
Message-ID: <20050924211139.GA18795@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael Veeck <michael.veeck@gmx.net>

drivers/char/drm/drmP.h defines a macro DRM_ARRAY_SIZE(x) for
determining the size of an array. kernel.h already provides one.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 drivers/char/drm/drmP.h         |    1 -
 drivers/char/drm/drm_drv.c      |    4 ++--
 drivers/char/drm/drm_fops.c     |    2 +-
 drivers/char/drm/drm_ioc32.c    |    2 +-
 drivers/char/drm/ffb_drv.c      |    2 +-
 drivers/char/drm/i810_dma.c     |    2 +-
 drivers/char/drm/i830_dma.c     |    2 +-
 drivers/char/drm/i915_dma.c     |    2 +-
 drivers/char/drm/i915_ioc32.c   |    2 +-
 drivers/char/drm/mga_ioc32.c    |    2 +-
 drivers/char/drm/mga_state.c    |    2 +-
 drivers/char/drm/r128_ioc32.c   |    2 +-
 drivers/char/drm/r128_state.c   |    2 +-
 drivers/char/drm/radeon_ioc32.c |    2 +-
 drivers/char/drm/radeon_state.c |    2 +-
 drivers/char/drm/savage_bci.c   |    2 +-
 drivers/char/drm/sis_mm.c       |    2 +-
 drivers/char/drm/via_drv.c      |    2 +-
 18 files changed, 18 insertions(+), 19 deletions(-)

--- a/drivers/char/drm/drmP.h
+++ b/drivers/char/drm/drmP.h
@@ -228,7 +228,6 @@
 /** \name Internal types and structures */
 /*@{*/
 
-#define DRM_ARRAY_SIZE(x) (sizeof(x)/sizeof(x[0]))
 #define DRM_MIN(a,b) ((a)<(b)?(a):(b))
 #define DRM_MAX(a,b) ((a)>(b)?(a):(b))
 
--- a/drivers/char/drm/drm_drv.c
+++ b/drivers/char/drm/drm_drv.c
@@ -15,7 +15,7 @@
  * #define DRIVER_DESC		"Matrox G200/G400"
  * #define DRIVER_DATE		"20001127"
  *
- * #define DRIVER_IOCTL_COUNT	DRM_ARRAY_SIZE( mga_ioctls )
+ * #define DRIVER_IOCTL_COUNT	ARRAY_SIZE( mga_ioctls )
  *
  * #define drm_x		mga_##x
  * \endcode
@@ -118,7 +118,7 @@ static drm_ioctl_desc_t		  drm_ioctls[] 
 	[DRM_IOCTL_NR(DRM_IOCTL_WAIT_VBLANK)]   = { drm_wait_vblank, 0, 0 },
 };
 
-#define DRIVER_IOCTL_COUNT	DRM_ARRAY_SIZE( drm_ioctls )
+#define DRIVER_IOCTL_COUNT	ARRAY_SIZE( drm_ioctls )
 
 /**
  * Take down the DRM device.
--- a/drivers/char/drm/drm_fops.c
+++ b/drivers/char/drm/drm_fops.c
@@ -63,7 +63,7 @@ static int drm_setup( drm_device_t *dev 
 			return i;
 	}
 
-	for ( i = 0 ; i < DRM_ARRAY_SIZE(dev->counts) ; i++ )
+	for ( i = 0 ; i < ARRAY_SIZE(dev->counts) ; i++ )
 		atomic_set( &dev->counts[i], 0 );
 
 	for ( i = 0 ; i < DRM_HASH_SIZE ; i++ ) {
--- a/drivers/char/drm/mga_state.c
+++ b/drivers/char/drm/mga_state.c
@@ -1186,4 +1186,4 @@ drm_ioctl_desc_t mga_ioctls[] = {
 
 };
 
-int mga_max_ioctl = DRM_ARRAY_SIZE(mga_ioctls);
+int mga_max_ioctl = ARRAY_SIZE(mga_ioctls);
--- a/drivers/char/drm/r128_state.c
+++ b/drivers/char/drm/r128_state.c
@@ -1733,4 +1733,4 @@ drm_ioctl_desc_t r128_ioctls[] = {
 	[DRM_IOCTL_NR(DRM_R128_GETPARAM)]   = { r128_getparam, 1, 0 },
 };
 
-int r128_max_ioctl = DRM_ARRAY_SIZE(r128_ioctls);
+int r128_max_ioctl = ARRAY_SIZE(r128_ioctls);
--- a/drivers/char/drm/radeon_state.c
+++ b/drivers/char/drm/radeon_state.c
@@ -3104,4 +3104,4 @@ drm_ioctl_desc_t radeon_ioctls[] = {
 	[DRM_IOCTL_NR(DRM_RADEON_SURF_FREE)]  = { radeon_surface_free, 1, 0 }
 };
 
-int radeon_max_ioctl = DRM_ARRAY_SIZE(radeon_ioctls);
+int radeon_max_ioctl = ARRAY_SIZE(radeon_ioctls);
--- a/drivers/char/drm/sis_mm.c
+++ b/drivers/char/drm/sis_mm.c
@@ -413,5 +413,5 @@ drm_ioctl_desc_t sis_ioctls[] = {
 	[DRM_IOCTL_NR(DRM_SIS_FB_INIT)]   = { sis_fb_init,         1, 1 }
 };
 
-int sis_max_ioctl = DRM_ARRAY_SIZE(sis_ioctls);
+int sis_max_ioctl = ARRAY_SIZE(sis_ioctls);
 
--- a/drivers/char/drm/via_drv.c
+++ b/drivers/char/drm/via_drv.c
@@ -91,7 +91,7 @@ static struct drm_driver driver = {
 	.postinit = postinit,
 	.version = version,
 	.ioctls = ioctls,
-	.num_ioctls = DRM_ARRAY_SIZE(ioctls),
+	.num_ioctls = ARRAY_SIZE(ioctls),
 	.fops = {
 		.owner = THIS_MODULE,
 		.open = drm_open,
--- a/drivers/char/drm/i810_dma.c
+++ b/drivers/char/drm/i810_dma.c
@@ -1378,7 +1378,7 @@ drm_ioctl_desc_t i810_ioctls[] = {
 	[DRM_IOCTL_NR(DRM_I810_FLIP)]    = { i810_flip_bufs,   1, 0 }
 };
 
-int i810_max_ioctl = DRM_ARRAY_SIZE(i810_ioctls);
+int i810_max_ioctl = ARRAY_SIZE(i810_ioctls);
 
 /**
  * Determine if the device really is AGP or not.
--- a/drivers/char/drm/i830_dma.c
+++ b/drivers/char/drm/i830_dma.c
@@ -1581,7 +1581,7 @@ drm_ioctl_desc_t i830_ioctls[] = {
 	[DRM_IOCTL_NR(DRM_I830_SETPARAM)] = { i830_setparam,    1, 0 } 
 };
 
-int i830_max_ioctl = DRM_ARRAY_SIZE(i830_ioctls);
+int i830_max_ioctl = ARRAY_SIZE(i830_ioctls);
 
 /**
  * Determine if the device really is AGP or not.
--- a/drivers/char/drm/drm_ioc32.c
+++ b/drivers/char/drm/drm_ioc32.c
@@ -1052,7 +1052,7 @@ long drm_compat_ioctl(struct file *filp,
 	drm_ioctl_compat_t *fn;
 	int ret;
 
-	if (nr >= DRM_ARRAY_SIZE(drm_compat_ioctls))
+	if (nr >= ARRAY_SIZE(drm_compat_ioctls))
 		return -ENOTTY;
 
 	fn = drm_compat_ioctls[nr];
--- a/drivers/char/drm/ffb_drv.c
+++ b/drivers/char/drm/ffb_drv.c
@@ -333,7 +333,7 @@ static struct drm_driver driver = {
 	.postinit = postinit,
 	.version = version,
 	.ioctls = ioctls,
-	.num_ioctls = DRM_ARRAY_SIZE(ioctls),
+	.num_ioctls = ARRAY_SIZE(ioctls),
 	.fops = {
 		.owner = THIS_MODULE,
 		.open = drm_open,
--- a/drivers/char/drm/i915_dma.c
+++ b/drivers/char/drm/i915_dma.c
@@ -731,7 +731,7 @@ drm_ioctl_desc_t i915_ioctls[] = {
 	[DRM_IOCTL_NR(DRM_I915_CMDBUFFER)] = {i915_cmdbuffer, 1, 0}
 };
 
-int i915_max_ioctl = DRM_ARRAY_SIZE(i915_ioctls);
+int i915_max_ioctl = ARRAY_SIZE(i915_ioctls);
 
 /**
  * Determine if the device really is AGP or not.
--- a/drivers/char/drm/i915_ioc32.c
+++ b/drivers/char/drm/i915_ioc32.c
@@ -207,7 +207,7 @@ long i915_compat_ioctl(struct file *filp
 	if (nr < DRM_COMMAND_BASE)
 		return drm_compat_ioctl(filp, cmd, arg);
 	
-	if (nr < DRM_COMMAND_BASE + DRM_ARRAY_SIZE(i915_compat_ioctls))
+	if (nr < DRM_COMMAND_BASE + ARRAY_SIZE(i915_compat_ioctls))
 		fn = i915_compat_ioctls[nr - DRM_COMMAND_BASE];
 
 	lock_kernel();		/* XXX for now */
--- a/drivers/char/drm/mga_ioc32.c
+++ b/drivers/char/drm/mga_ioc32.c
@@ -220,7 +220,7 @@ long mga_compat_ioctl(struct file *filp,
 	if (nr < DRM_COMMAND_BASE)
 		return drm_compat_ioctl(filp, cmd, arg);
 	
-	if (nr < DRM_COMMAND_BASE + DRM_ARRAY_SIZE(mga_compat_ioctls))
+	if (nr < DRM_COMMAND_BASE + ARRAY_SIZE(mga_compat_ioctls))
 		fn = mga_compat_ioctls[nr - DRM_COMMAND_BASE];
 
 	lock_kernel();		/* XXX for now */
--- a/drivers/char/drm/r128_ioc32.c
+++ b/drivers/char/drm/r128_ioc32.c
@@ -205,7 +205,7 @@ long r128_compat_ioctl(struct file *filp
 	if (nr < DRM_COMMAND_BASE)
 		return drm_compat_ioctl(filp, cmd, arg);
 
-	if (nr < DRM_COMMAND_BASE + DRM_ARRAY_SIZE(r128_compat_ioctls))
+	if (nr < DRM_COMMAND_BASE + ARRAY_SIZE(r128_compat_ioctls))
 		fn = r128_compat_ioctls[nr - DRM_COMMAND_BASE];
 
 	lock_kernel();		/* XXX for now */
--- a/drivers/char/drm/radeon_ioc32.c
+++ b/drivers/char/drm/radeon_ioc32.c
@@ -381,7 +381,7 @@ long radeon_compat_ioctl(struct file *fi
 	if (nr < DRM_COMMAND_BASE)
 		return drm_compat_ioctl(filp, cmd, arg);
 
-	if (nr < DRM_COMMAND_BASE + DRM_ARRAY_SIZE(radeon_compat_ioctls))
+	if (nr < DRM_COMMAND_BASE + ARRAY_SIZE(radeon_compat_ioctls))
 		fn = radeon_compat_ioctls[nr - DRM_COMMAND_BASE];
 
 	lock_kernel();		/* XXX for now */
--- a/drivers/char/drm/savage_bci.c
+++ b/drivers/char/drm/savage_bci.c
@@ -1093,4 +1093,4 @@ drm_ioctl_desc_t savage_ioctls[] = {
 	[DRM_IOCTL_NR(DRM_SAVAGE_BCI_EVENT_WAIT)] = {savage_bci_event_wait, 1, 0},
 };
 
-int savage_max_ioctl = DRM_ARRAY_SIZE(savage_ioctls);
+int savage_max_ioctl = ARRAY_SIZE(savage_ioctls);

