Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269593AbUICKlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269593AbUICKlE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 06:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269590AbUICKlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 06:41:04 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:20416 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S269599AbUICKhY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 06:37:24 -0400
Date: Fri, 3 Sep 2004 11:37:19 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: torvalds@osdl.org, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [BK pull] DRM macro removal tree
Message-ID: <Pine.LNX.4.58.0409031134290.32026@skynet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Linus,

Please do a

	bk pull bk://drm.bkbits.net/drm-fntbl

This isn't the standard drm-2.6 tree, it is a separate tree for feeding
the macro removal function table stuff. The highlights of this tree are:

	Gamma driver is marked as broken.
	remove most of the DRIVER_ macros.
	remove HAVE_KERNEL_CTX_SWITCH, HAVE_DMA_FREELIST, HAVE_DMA_SCHEDULE
	HAVE_DMA_WAITLIST, DRM_IOREMAP* and DRM_FIND_MAP.

This is all the work I did on the drmfntbl-0-0-1 branch of the CVS tree,
I'll start bringing the drmfntbl-0-0-2 branch over now which removes
nearly all the rest of the macros...

This will include the latest DRM changes and will update the following files:

 drivers/char/drm/Kconfig         |    2
 drivers/char/drm/drmP.h          |  115 ++++++++-------
 drivers/char/drm/drm_bufs.h      |   48 ------
 drivers/char/drm/drm_context.h   |   14 +
 drivers/char/drm/drm_dma.h       |   13 -
 drivers/char/drm/drm_drv.h       |  296 +++++++++++++--------------------------
 drivers/char/drm/drm_fops.h      |    7
 drivers/char/drm/drm_memory.h    |    1
 drivers/char/drm/ffb.h           |    4
 drivers/char/drm/ffb_context.c   |   60 +++++++
 drivers/char/drm/ffb_drv.c       |   56 -------
 drivers/char/drm/ffb_drv.h       |    7
 drivers/char/drm/gamma.h         |   28 ---
 drivers/char/drm/gamma_context.h |    4
 drivers/char/drm/gamma_dma.c     |   63 ++++++--
 drivers/char/drm/gamma_drv.h     |    5
 drivers/char/drm/i810.h          |   25 ---
 drivers/char/drm/i810_dma.c      |   31 +++-
 drivers/char/drm/i810_drv.h      |    1
 drivers/char/drm/i830.h          |   27 ---
 drivers/char/drm/i830_dma.c      |   32 +++-
 drivers/char/drm/i830_drv.h      |    1
 drivers/char/drm/i915.h          |   21 --
 drivers/char/drm/i915_dma.c      |   29 +++
 drivers/char/drm/mga.h           |   19 --
 drivers/char/drm/mga_dma.c       |   46 ++++--
 drivers/char/drm/r128.h          |   31 ----
 drivers/char/drm/r128_cce.c      |   31 +---
 drivers/char/drm/r128_drv.h      |    1
 drivers/char/drm/r128_state.c    |   30 +++
 drivers/char/drm/radeon.h        |   45 -----
 drivers/char/drm/radeon_cp.c     |   38 ++---
 drivers/char/drm/radeon_drv.h    |    1
 drivers/char/drm/radeon_state.c  |   46 +++++-
 drivers/char/drm/sis.h           |   11 -
 drivers/char/drm/sis_drv.c       |    1
 drivers/char/drm/sis_drv.h       |    2
 drivers/char/drm/sis_mm.c        |   10 +
 drivers/char/drm/tdfx_drv.c      |    5
 39 files changed, 545 insertions(+), 662 deletions(-)

through these ChangeSets:

<airlied@starflyer.(none)> (04/09/03 1.1837.34.8)
   remove DRM_IOREMAP* and DRM_FIND_MAP macros replace them with inline fns

   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (04/09/03 1.1837.34.7)
   remove HAVE_DMA_WAITLIST as it was only used by gamma

   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (04/09/03 1.1837.34.6)
   remove __HAVE_DMA_SCHEDULE was only used by gamma.

   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (04/09/03 1.1837.34.5)
   Dump __HAVE_DMA_FREELIST is only used by gamma.

   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (04/09/03 1.1837.34.4)
   remove DRIVER_FOPS and related macros

   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (04/09/03 1.1837.34.3)
   Remove DRIVER_CTX_[CD]TOR, HAVE_KERNEL_CTX_SWITCH, DRIVER_BUF_PRIV_T, DRIVER_AGP_BUFFERS_MAP

   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (04/09/02 1.1837.34.2)
   Initial DRM function table removes some if the DRIVER_ macros.

   Signed-off-by: Dave Airlie <airlied@linux.ie>

<airlied@starflyer.(none)> (04/09/02 1.1837.34.1)
   Mark gamma as broken

   Signed-off-by: Dave Airlie <airlied@linux.ie>

diff -Nru a/drivers/char/drm/Kconfig b/drivers/char/drm/Kconfig
--- a/drivers/char/drm/Kconfig	Fri Sep  3 20:29:48 2004
+++ b/drivers/char/drm/Kconfig	Fri Sep  3 20:29:48 2004
@@ -24,7 +24,7 @@

 config DRM_GAMMA
 	tristate "3dlabs GMX 2000"
-	depends on DRM
+	depends on DRM && BROKEN
 	help
 	  This is the old gamma driver, please tell me if it might actually
 	  work.
diff -Nru a/drivers/char/drm/drmP.h b/drivers/char/drm/drmP.h
--- a/drivers/char/drm/drmP.h	Fri Sep  3 20:29:48 2004
+++ b/drivers/char/drm/drmP.h	Fri Sep  3 20:29:48 2004
@@ -95,12 +95,6 @@
 #ifndef __HAVE_IRQ
 #define __HAVE_IRQ		0
 #endif
-#ifndef __HAVE_DMA_WAITLIST
-#define __HAVE_DMA_WAITLIST	0
-#endif
-#ifndef __HAVE_DMA_FREELIST
-#define __HAVE_DMA_FREELIST	0
-#endif

 #define __REALLY_HAVE_AGP	(__HAVE_AGP && (defined(CONFIG_AGP) || \
 						defined(CONFIG_AGP_MODULE)))
@@ -266,54 +260,6 @@


 /***********************************************************************/
-/** \name Mapping helper macros */
-/*@{*/
-
-#define DRM_IOREMAP(map, dev)							\
-	(map)->handle = DRM(ioremap)( (map)->offset, (map)->size, (dev) )
-
-#define DRM_IOREMAP_NOCACHE(map, dev)						\
-	(map)->handle = DRM(ioremap_nocache)((map)->offset, (map)->size, (dev))
-
-#define DRM_IOREMAPFREE(map, dev)						\
-	do {									\
-		if ( (map)->handle && (map)->size )				\
-			DRM(ioremapfree)( (map)->handle, (map)->size, (dev) );	\
-	} while (0)
-
-/**
- * Find mapping.
- *
- * \param _map matching mapping if found, untouched otherwise.
- * \param _o offset.
- *
- * Expects the existence of a local variable named \p dev pointing to the
- * drm_device structure.
- */
-#define DRM_FIND_MAP(_map, _o)								\
-do {											\
-	struct list_head *_list;							\
-	list_for_each( _list, &dev->maplist->head ) {					\
-		drm_map_list_t *_entry = list_entry( _list, drm_map_list_t, head );	\
-		if ( _entry->map &&							\
-		     _entry->map->offset == (_o) ) {					\
-			(_map) = _entry->map;						\
-			break;								\
- 		}									\
-	}										\
-} while(0)
-
-/**
- * Drop mapping.
- *
- * \sa #DRM_FIND_MAP.
- */
-#define DRM_DROP_MAP(_map)
-
-/*@}*/
-
-
-/***********************************************************************/
 /** \name Internal types and structures */
 /*@{*/

@@ -610,6 +556,28 @@

 #endif

+/**
+ * DRM device functions structure
+ */
+struct drm_device;
+
+struct drm_driver_fn {
+	int (*preinit)(struct drm_device *);
+	int (*postinit)(struct drm_device *);
+	void (*prerelease)(struct drm_device *, struct file *filp);
+	void (*pretakedown)(struct drm_device *);
+	int (*postcleanup)(struct drm_device *);
+	int (*presetup)(struct drm_device *);
+	int (*postsetup)(struct drm_device *);
+	void (*open_helper)(struct drm_device *, drm_file_t *);
+	void (*release)(struct drm_device *, struct file *filp);
+	void (*dma_ready)(struct drm_device *);
+	int (*dma_quiescent)(struct drm_device *);
+	int (*context_ctor)(struct drm_device *dev, int context);
+ 	int (*context_dtor)(struct drm_device *dev, int context);
+ 	int (*kernel_context_switch)(struct drm_device *dev, int old, int new);
+ 	int (*kernel_context_switch_unlock)(struct drm_device *dev);
+};
 /**
  * DRM device structure.
  */
@@ -738,8 +706,13 @@
 	void		  *dev_private; /**< device private data */
 	drm_sigdata_t     sigdata; /**< For block_all_signals */
 	sigset_t          sigmask;
+
+	struct            drm_driver_fn fn_tbl;
+	drm_local_map_t   *agp_buffer_map;
+	int               dev_priv_size;
 } drm_device_t;

+extern void DRM(driver_register_fns)(struct drm_device *dev);

 /******************************************************************/
 /** \name Internal function definitions */
@@ -986,6 +959,40 @@
 					       unsigned long addr,
 					       dma_addr_t bus_addr);

+
+/* Inline replacements for DRM_IOREMAP macros */
+static __inline__ void drm_core_ioremap(struct drm_map *map, struct drm_device *dev)
+{
+	map->handle = DRM(ioremap)( map->offset, map->size, dev );
+}
+
+static __inline__ void drm_core_ioremap_nocache(struct drm_map *map, struct drm_device *dev)
+{
+	map->handle = DRM(ioremap_nocache)(map->offset, map->size, dev);
+}
+
+static __inline__ void drm_core_ioremapfree(struct drm_map *map, struct drm_device *dev)
+{
+	if ( map->handle && map->size )
+		DRM(ioremapfree)( map->handle, map->size, dev );
+}
+
+static __inline__ struct drm_map *drm_core_findmap(struct drm_device *dev, unsigned long offset)
+{
+	struct list_head *_list;
+	list_for_each( _list, &dev->maplist->head ) {
+		drm_map_list_t *_entry = list_entry( _list, drm_map_list_t, head );
+		if ( _entry->map &&
+		     _entry->map->offset == offset ) {
+			return _entry->map;
+		}
+	}
+	return NULL;
+}
+
+static __inline__ void drm_core_dropmap(struct drm_map *map)
+{
+}
 /*@}*/

 #endif /* __KERNEL__ */
diff -Nru a/drivers/char/drm/drm_bufs.h b/drivers/char/drm/drm_bufs.h
--- a/drivers/char/drm/drm_bufs.h	Fri Sep  3 20:29:48 2004
+++ b/drivers/char/drm/drm_bufs.h	Fri Sep  3 20:29:48 2004
@@ -44,18 +44,6 @@
 #define __HAVE_SG		0
 #endif

-#ifndef DRIVER_BUF_PRIV_T
-#define DRIVER_BUF_PRIV_T		u32
-#endif
-#ifndef DRIVER_AGP_BUFFERS_MAP
-#if __HAVE_AGP && __HAVE_DMA
-#error "You must define DRIVER_AGP_BUFFERS_MAP()"
-#else
-#define DRIVER_AGP_BUFFERS_MAP( dev )	NULL
-#endif
-#endif
-
-
 /**
  * Compute size order.  Returns the exponent of the smaller power of two which
  * is greater or equal to given number.
@@ -348,10 +336,6 @@
 			  sizeof(*entry->buflist),
 			  DRM_MEM_BUFS);

-#if __HAVE_DMA_FREELIST
-	   	DRM(freelist_destroy)(&entry->freelist);
-#endif
-
 		entry->buf_count = 0;
 	}
 }
@@ -473,8 +457,8 @@
 		init_waitqueue_head( &buf->dma_wait );
 		buf->filp    = NULL;

-		buf->dev_priv_size = sizeof(DRIVER_BUF_PRIV_T);
-		buf->dev_private = DRM(alloc)( sizeof(DRIVER_BUF_PRIV_T),
+		buf->dev_priv_size = dev->dev_priv_size;
+		buf->dev_private = DRM(alloc)( buf->dev_priv_size,
 					       DRM_MEM_BUFS );
 		if(!buf->dev_private) {
 			/* Set count correctly so we free the proper amount. */
@@ -520,12 +504,6 @@
 	DRM_DEBUG( "dma->buf_count : %d\n", dma->buf_count );
 	DRM_DEBUG( "entry->buf_count : %d\n", entry->buf_count );

-#if __HAVE_DMA_FREELIST
-	DRM(freelist_create)( &entry->freelist, entry->buf_count );
-	for ( i = 0 ; i < entry->buf_count ; i++ ) {
-		DRM(freelist_put)( dev, &entry->freelist, &entry->buflist[i] );
-	}
-#endif
 	up( &dev->struct_sem );

 	request.count = entry->buf_count;
@@ -698,8 +676,8 @@
 			init_waitqueue_head( &buf->dma_wait );
 			buf->filp    = NULL;

-			buf->dev_priv_size = sizeof(DRIVER_BUF_PRIV_T);
-			buf->dev_private = DRM(alloc)( sizeof(DRIVER_BUF_PRIV_T),
+			buf->dev_priv_size = dev->dev_priv_size;
+			buf->dev_private = DRM(alloc)( dev->dev_priv_size,
 						       DRM_MEM_BUFS );
 			if(!buf->dev_private) {
 				/* Set count correctly so we free the proper amount. */
@@ -759,12 +737,6 @@
 	dma->page_count += entry->seg_count << page_order;
 	dma->byte_count += PAGE_SIZE * (entry->seg_count << page_order);

-#if __HAVE_DMA_FREELIST
-	DRM(freelist_create)( &entry->freelist, entry->buf_count );
-	for ( i = 0 ; i < entry->buf_count ; i++ ) {
-		DRM(freelist_put)( dev, &entry->freelist, &entry->buflist[i] );
-	}
-#endif
 	up( &dev->struct_sem );

 	request.count = entry->buf_count;
@@ -882,8 +854,8 @@
 		init_waitqueue_head( &buf->dma_wait );
 		buf->filp    = NULL;

-		buf->dev_priv_size = sizeof(DRIVER_BUF_PRIV_T);
-		buf->dev_private = DRM(alloc)( sizeof(DRIVER_BUF_PRIV_T),
+		buf->dev_priv_size = dev->dev_priv_size;
+		buf->dev_private = DRM(alloc)( dev->dev_priv_size,
 					       DRM_MEM_BUFS );
 		if(!buf->dev_private) {
 			/* Set count correctly so we free the proper amount. */
@@ -930,12 +902,6 @@
 	DRM_DEBUG( "dma->buf_count : %d\n", dma->buf_count );
 	DRM_DEBUG( "entry->buf_count : %d\n", entry->buf_count );

-#if __HAVE_DMA_FREELIST
-	DRM(freelist_create)( &entry->freelist, entry->buf_count );
-	for ( i = 0 ; i < entry->buf_count ; i++ ) {
-		DRM(freelist_put)( dev, &entry->freelist, &entry->buflist[i] );
-	}
-#endif
 	up( &dev->struct_sem );

 	request.count = entry->buf_count;
@@ -1221,7 +1187,7 @@
 	if ( request.count >= dma->buf_count ) {
 		if ( (__HAVE_AGP && (dma->flags & _DRM_DMA_USE_AGP)) ||
 		     (__HAVE_SG && (dma->flags & _DRM_DMA_USE_SG)) ) {
-			drm_map_t *map = DRIVER_AGP_BUFFERS_MAP( dev );
+			drm_map_t *map = dev->agp_buffer_map;

 			if ( !map ) {
 				retcode = -EINVAL;
diff -Nru a/drivers/char/drm/drm_context.h b/drivers/char/drm/drm_context.h
--- a/drivers/char/drm/drm_context.h	Fri Sep  3 20:29:48 2004
+++ b/drivers/char/drm/drm_context.h	Fri Sep  3 20:29:48 2004
@@ -419,10 +419,13 @@
 				/* Should this return -EBUSY instead? */
 		return -ENOMEM;
 	}
-#ifdef DRIVER_CTX_CTOR
+
 	if ( ctx.handle != DRM_KERNEL_CONTEXT )
-		DRIVER_CTX_CTOR(ctx.handle); /* XXX: also pass dev ? */
-#endif
+	{
+		if (dev->fn_tbl.context_ctor)
+			dev->fn_tbl.context_ctor(dev, ctx.handle);
+	}
+
 	ctx_entry = DRM(alloc)( sizeof(*ctx_entry), DRM_MEM_CTXLIST );
 	if ( !ctx_entry ) {
 		DRM_DEBUG("out of memory\n");
@@ -554,9 +557,8 @@
 		priv->remove_auth_on_close = 1;
 	}
 	if ( ctx.handle != DRM_KERNEL_CONTEXT ) {
-#ifdef DRIVER_CTX_DTOR
-		DRIVER_CTX_DTOR(ctx.handle); /* XXX: also pass dev ? */
-#endif
+		if (dev->fn_tbl.context_dtor)
+			dev->fn_tbl.context_dtor(dev, ctx.handle);
 		DRM(ctxbitmap_free)( dev, ctx.handle );
 	}

diff -Nru a/drivers/char/drm/drm_dma.h b/drivers/char/drm/drm_dma.h
--- a/drivers/char/drm/drm_dma.h	Fri Sep  3 20:29:48 2004
+++ b/drivers/char/drm/drm_dma.h	Fri Sep  3 20:29:48 2004
@@ -116,9 +116,6 @@
 				  dma->bufs[i].buf_count *
 				  sizeof(*dma->bufs[0].buflist),
 				  DRM_MEM_BUFS);
-#if __HAVE_DMA_FREELIST
-		   	DRM(freelist_destroy)(&dma->bufs[i].freelist);
-#endif
 		}
 	}

@@ -158,16 +155,6 @@
 	if ( __HAVE_DMA_WAITQUEUE && waitqueue_active(&buf->dma_wait)) {
 		wake_up_interruptible(&buf->dma_wait);
 	}
-#if __HAVE_DMA_FREELIST
-	else {
-		drm_device_dma_t *dma = dev->dma;
-				/* If processes are waiting, the last one
-				   to wake will put the buffer on the free
-				   list.  If no processes are waiting, we
-				   put the buffer on the freelist here. */
-		DRM(freelist_put)(dev, &dma->bufs[buf->order].freelist, buf);
-	}
-#endif
 }

 #if !__HAVE_DMA_RECLAIM
diff -Nru a/drivers/char/drm/drm_drv.h b/drivers/char/drm/drm_drv.h
--- a/drivers/char/drm/drm_drv.h	Fri Sep  3 20:29:48 2004
+++ b/drivers/char/drm/drm_drv.h	Fri Sep  3 20:29:48 2004
@@ -67,82 +67,16 @@
 #ifndef __HAVE_MULTIPLE_DMA_QUEUES
 #define __HAVE_MULTIPLE_DMA_QUEUES	0
 #endif
-#ifndef __HAVE_DMA_SCHEDULE
-#define __HAVE_DMA_SCHEDULE		0
-#endif
-#ifndef __HAVE_DMA_FLUSH
-#define __HAVE_DMA_FLUSH		0
-#endif
-#ifndef __HAVE_DMA_READY
-#define __HAVE_DMA_READY		0
-#endif
-#ifndef __HAVE_DMA_QUIESCENT
-#define __HAVE_DMA_QUIESCENT		0
-#endif
-#ifndef __HAVE_RELEASE
-#define __HAVE_RELEASE			0
-#endif
 #ifndef __HAVE_COUNTERS
 #define __HAVE_COUNTERS			0
 #endif
 #ifndef __HAVE_SG
 #define __HAVE_SG			0
 #endif
-/* __HAVE_KERNEL_CTX_SWITCH isn't used by any of the drm modules in
- * the DRI cvs tree, but it is required by the kernel tree's sparc
- * driver.
- */
-#ifndef __HAVE_KERNEL_CTX_SWITCH
-#define __HAVE_KERNEL_CTX_SWITCH	0
-#endif
-#ifndef __HAVE_DRIVER_FOPS_READ
-#define __HAVE_DRIVER_FOPS_READ		0
-#endif
-#ifndef __HAVE_DRIVER_FOPS_POLL
-#define __HAVE_DRIVER_FOPS_POLL		0
-#endif

-#ifndef DRIVER_PREINIT
-#define DRIVER_PREINIT()
-#endif
-#ifndef DRIVER_POSTINIT
-#define DRIVER_POSTINIT()
-#endif
-#ifndef DRIVER_PRERELEASE
-#define DRIVER_PRERELEASE()
-#endif
-#ifndef DRIVER_PRETAKEDOWN
-#define DRIVER_PRETAKEDOWN()
-#endif
-#ifndef DRIVER_POSTCLEANUP
-#define DRIVER_POSTCLEANUP()
-#endif
-#ifndef DRIVER_PRESETUP
-#define DRIVER_PRESETUP()
-#endif
-#ifndef DRIVER_POSTSETUP
-#define DRIVER_POSTSETUP()
-#endif
 #ifndef DRIVER_IOCTLS
 #define DRIVER_IOCTLS
 #endif
-#ifndef DRIVER_OPEN_HELPER
-#define DRIVER_OPEN_HELPER( priv, dev )
-#endif
-#ifndef DRIVER_FOPS
-#define DRIVER_FOPS				\
-static struct file_operations	DRM(fops) = {	\
-	.owner   = THIS_MODULE,			\
-	.open	 = DRM(open),			\
-	.flush	 = DRM(flush),			\
-	.release = DRM(release),		\
-	.ioctl	 = DRM(ioctl),			\
-	.mmap	 = DRM(mmap),			\
-	.fasync  = DRM(fasync),			\
-	.poll	 = DRM(poll),			\
-	.read	 = DRM(read),			\
-}
-#endif

 #ifndef MODULE
 /** Use an additional macro to avoid preprocessor troubles */
@@ -166,10 +100,20 @@
 static drm_device_t	DRM(device)[MAX_DEVICES];
 static int		DRM(numdevs) = 0;

-DRIVER_FOPS;
+struct file_operations	DRM(fops) = {
+	.owner   = THIS_MODULE,
+	.open	 = DRM(open),
+	.flush	 = DRM(flush),
+	.release = DRM(release),
+	.ioctl	 = DRM(ioctl),
+	.mmap	 = DRM(mmap),
+	.fasync  = DRM(fasync),
+	.poll	 = DRM(poll),
+	.read	 = DRM(read),
+};

 /** Ioctl table */
-static drm_ioctl_desc_t		  DRM(ioctls)[] = {
+drm_ioctl_desc_t		  DRM(ioctls)[] = {
 	[DRM_IOCTL_NR(DRM_IOCTL_VERSION)]       = { DRM(version),     0, 0 },
 	[DRM_IOCTL_NR(DRM_IOCTL_GET_UNIQUE)]    = { DRM(getunique),   0, 0 },
 	[DRM_IOCTL_NR(DRM_IOCTL_GET_MAGIC)]     = { DRM(getmagic),    0, 0 },
@@ -208,12 +152,7 @@
 	[DRM_IOCTL_NR(DRM_IOCTL_LOCK)]	        = { DRM(lock),        1, 0 },
 	[DRM_IOCTL_NR(DRM_IOCTL_UNLOCK)]        = { DRM(unlock),      1, 0 },

-#if __HAVE_DMA_FLUSH
-	/* Gamma only, really */
-	[DRM_IOCTL_NR(DRM_IOCTL_FINISH)]        = { DRM(finish),      1, 0 },
-#else
 	[DRM_IOCTL_NR(DRM_IOCTL_FINISH)]        = { DRM(noop),      1, 0 },
-#endif

 #if __HAVE_DMA
 	[DRM_IOCTL_NR(DRM_IOCTL_ADD_BUFS)]      = { DRM(addbufs),     1, 1 },
@@ -265,7 +204,9 @@
 {
 	int i;

-	DRIVER_PRESETUP();
+	if (dev->fn_tbl.presetup)
+		dev->fn_tbl.presetup(dev);
+
 	atomic_set( &dev->ioctl_count, 0 );
 	atomic_set( &dev->vma_count, 0 );
 	dev->buf_use = 0;
@@ -311,9 +252,6 @@
 #ifdef __HAVE_COUNTER14
 	dev->types[14] = __HAVE_COUNTER14;
 #endif
-#ifdef __HAVE_COUNTER15
-	dev->types[14] = __HAVE_COUNTER14;
-#endif

 	for ( i = 0 ; i < DRM_ARRAY_SIZE(dev->counts) ; i++ )
 		atomic_set( &dev->counts[i], 0 );
@@ -371,7 +309,9 @@
 	 * drm_select_queue fails between the time the interrupt is
 	 * initialized and the time the queues are initialized.
 	 */
-	DRIVER_POSTSETUP();
+	if (dev->fn_tbl.postsetup)
+		dev->fn_tbl.postsetup(dev);
+
 	return 0;
 }

@@ -396,7 +336,9 @@

 	DRM_DEBUG( "\n" );

-	DRIVER_PRETAKEDOWN();
+	if (dev->fn_tbl.pretakedown)
+	  dev->fn_tbl.pretakedown(dev);
+
 #if __HAVE_IRQ
 	if ( dev->irq_enabled ) DRM(irq_uninstall)( dev );
 #endif
@@ -509,9 +451,6 @@
 #if __HAVE_DMA_QUEUE || __HAVE_MULTIPLE_DMA_QUEUES
 	if ( dev->queuelist ) {
 		for ( i = 0 ; i < dev->queue_count ; i++ ) {
-#if __HAVE_DMA_WAITLIST
-			DRM(waitlist_destroy)( &dev->queuelist[i]->waitlist );
-#endif
 			if ( dev->queuelist[i] ) {
 				DRM(free)( dev->queuelist[i],
 					  sizeof(*dev->queuelist[0]),
@@ -594,7 +533,12 @@
 	dev->pci_func = PCI_FUNC(pdev->devfn);
 	dev->irq = pdev->irq;

-	DRIVER_PREINIT();
+	/* dev_priv_size can be changed by a driver in driver_register_fns */
+ 	dev->dev_priv_size = sizeof(u32);
+	DRM(driver_register_fns)(dev);
+
+	if (dev->fn_tbl.preinit)
+	  dev->fn_tbl.preinit(dev);

 #if __REALLY_HAVE_AGP
 	dev->agp = DRM(agp_init)();
@@ -635,7 +579,8 @@
 		dev->minor,
 		pci_pretty_name(pdev));

-	DRIVER_POSTINIT();
+	if (dev->fn_tbl.postinit)
+	  dev->fn_tbl.postinit(dev);

 	return 0;
 }
@@ -718,8 +663,10 @@
 			dev->agp = NULL;
 		}
 #endif
+		if (dev->fn_tbl.postcleanup)
+		  dev->fn_tbl.postcleanup(dev);
+
 	}
-	DRIVER_POSTCLEANUP();
 	DRM(numdevs) = 0;
 }

@@ -834,7 +781,8 @@

 	DRM_DEBUG( "open_count = %d\n", dev->open_count );

-	DRIVER_PRERELEASE();
+	if (dev->fn_tbl.prerelease)
+		dev->fn_tbl.prerelease(dev, filp);

 	/* ========================================================
 	 * Begin inline drm_release
@@ -849,9 +797,10 @@
 		DRM_DEBUG( "File %p released, freeing lock for context %d\n",
 			filp,
 			_DRM_LOCKING_CONTEXT(dev->lock.hw_lock->lock) );
-#if __HAVE_RELEASE
-		DRIVER_RELEASE();
-#endif
+
+		if (dev->fn_tbl.release)
+			dev->fn_tbl.release(dev, filp);
+
 		DRM(lock_free)( dev, &dev->lock.hw_lock->lock,
 				_DRM_LOCKING_CONTEXT(dev->lock.hw_lock->lock) );

@@ -860,8 +809,7 @@
                                    processed via a callback to the X
                                    server. */
 	}
-#if __HAVE_RELEASE
-	else if ( priv->lock_count && dev->lock.hw_lock ) {
+	else if ( dev->fn_tbl.release && priv->lock_count && dev->lock.hw_lock ) {
 		/* The lock is required to reclaim buffers */
 		DECLARE_WAITQUEUE( entry, current );

@@ -890,12 +838,14 @@
 		current->state = TASK_RUNNING;
 		remove_wait_queue( &dev->lock.lock_queue, &entry );
 		if( !retcode ) {
-			DRIVER_RELEASE();
+			if (dev->fn_tbl.release)
+				dev->fn_tbl.release(dev, filp);
 			DRM(lock_free)( dev, &dev->lock.hw_lock->lock,
 					DRM_KERNEL_CONTEXT );
 		}
 	}
-#elif __HAVE_DMA
+
+#if __HAVE_DMA
 	DRM(reclaim_buffers)( filp );
 #endif

@@ -908,9 +858,8 @@
 		list_for_each_entry_safe( pos, n, &dev->ctxlist->head, head ) {
 			if ( pos->tag == priv &&
 			     pos->handle != DRM_KERNEL_CONTEXT ) {
-#ifdef DRIVER_CTX_DTOR
-				DRIVER_CTX_DTOR(pos->handle);
-#endif
+				if (dev->fn_tbl.context_dtor)
+					dev->fn_tbl.context_dtor(dev, pos->handle);
 #if __HAVE_CTX_BITMAP
 				DRM(ctxbitmap_free)( dev, pos->handle );
 #endif
@@ -1067,74 +1016,57 @@
 	q = dev->queuelist[lock.context];
 #endif

-#if __HAVE_DMA_FLUSH
-	ret = DRM(flush_block_and_flush)( dev, lock.context, lock.flags );
-#endif
-        if ( !ret ) {
-                add_wait_queue( &dev->lock.lock_queue, &entry );
-                for (;;) {
-                        current->state = TASK_INTERRUPTIBLE;
-                        if ( !dev->lock.hw_lock ) {
-                                /* Device has been unregistered */
-                                ret = -EINTR;
-                                break;
-                        }
-                        if ( DRM(lock_take)( &dev->lock.hw_lock->lock,
-					     lock.context ) ) {
-                                dev->lock.filp      = filp;
-                                dev->lock.lock_time = jiffies;
-                                atomic_inc( &dev->counts[_DRM_STAT_LOCKS] );
-                                break;  /* Got lock */
-                        }
-
-                                /* Contention */
-                        schedule();
-                        if ( signal_pending( current ) ) {
-                                ret = -ERESTARTSYS;
-                                break;
-                        }
-                }
-                current->state = TASK_RUNNING;
-                remove_wait_queue( &dev->lock.lock_queue, &entry );
-        }
-
-#if __HAVE_DMA_FLUSH
-	DRM(flush_unblock)( dev, lock.context, lock.flags ); /* cleanup phase */
-#endif
-
-        if ( !ret ) {
-		sigemptyset( &dev->sigmask );
-		sigaddset( &dev->sigmask, SIGSTOP );
-		sigaddset( &dev->sigmask, SIGTSTP );
-		sigaddset( &dev->sigmask, SIGTTIN );
-		sigaddset( &dev->sigmask, SIGTTOU );
-		dev->sigdata.context = lock.context;
-		dev->sigdata.lock    = dev->lock.hw_lock;
-		block_all_signals( DRM(notifier),
-				   &dev->sigdata, &dev->sigmask );
-
-#if __HAVE_DMA_READY
-                if ( lock.flags & _DRM_LOCK_READY ) {
-			DRIVER_DMA_READY();
+	add_wait_queue( &dev->lock.lock_queue, &entry );
+	for (;;) {
+		current->state = TASK_INTERRUPTIBLE;
+		if ( !dev->lock.hw_lock ) {
+			/* Device has been unregistered */
+			ret = -EINTR;
+			break;
 		}
-#endif
-#if __HAVE_DMA_QUIESCENT
-                if ( lock.flags & _DRM_LOCK_QUIESCENT ) {
-			DRIVER_DMA_QUIESCENT();
+		if ( DRM(lock_take)( &dev->lock.hw_lock->lock,
+				     lock.context ) ) {
+			dev->lock.filp      = filp;
+			dev->lock.lock_time = jiffies;
+			atomic_inc( &dev->counts[_DRM_STAT_LOCKS] );
+			break;  /* Got lock */
 		}
-#endif
-		/* __HAVE_KERNEL_CTX_SWITCH isn't used by any of the
-		 * drm modules in the DRI cvs tree, but it is required
-		 * by the Sparc driver.
-		 */
-#if __HAVE_KERNEL_CTX_SWITCH
-		if ( dev->last_context != lock.context ) {
-			DRM(context_switch)(dev, dev->last_context,
-					    lock.context);
+
+		/* Contention */
+		schedule();
+		if ( signal_pending( current ) ) {
+			ret = -ERESTARTSYS;
+			break;
 		}
-#endif
-        }
+	}
+	current->state = TASK_RUNNING;
+	remove_wait_queue( &dev->lock.lock_queue, &entry );

+	sigemptyset( &dev->sigmask );
+	sigaddset( &dev->sigmask, SIGSTOP );
+	sigaddset( &dev->sigmask, SIGTSTP );
+	sigaddset( &dev->sigmask, SIGTTIN );
+	sigaddset( &dev->sigmask, SIGTTOU );
+	dev->sigdata.context = lock.context;
+	dev->sigdata.lock    = dev->lock.hw_lock;
+	block_all_signals( DRM(notifier),
+			   &dev->sigdata, &dev->sigmask );
+
+	if (dev->fn_tbl.dma_ready && (lock.flags & _DRM_LOCK_READY))
+		dev->fn_tbl.dma_ready(dev);
+
+	if ( dev->fn_tbl.dma_quiescent && (lock.flags & _DRM_LOCK_QUIESCENT ))
+		return dev->fn_tbl.dma_quiescent(dev);
+
+	/* dev->fn_tbl.kernel_context_switch isn't used by any of the x86
+	 *  drivers but is used by the Sparc driver.
+	 */
+
+	if (dev->fn_tbl.kernel_context_switch &&
+	    dev->last_context != lock.context) {
+	  dev->fn_tbl.kernel_context_switch(dev, dev->last_context,
+					    lock.context);
+	}
         DRM_DEBUG( "%d %s\n", lock.context, ret ? "interrupted" : "has lock" );

         return ret;
@@ -1169,40 +1101,20 @@

 	atomic_inc( &dev->counts[_DRM_STAT_UNLOCKS] );

-	/* __HAVE_KERNEL_CTX_SWITCH isn't used by any of the drm
-	 * modules in the DRI cvs tree, but it is required by the
-	 * Sparc driver.
-	 */
-#if __HAVE_KERNEL_CTX_SWITCH
-	/* We no longer really hold it, but if we are the next
-	 * agent to request it then we should just be able to
-	 * take it immediately and not eat the ioctl.
+	/* kernel_context_switch isn't used by any of the x86 drm
+	 * modules but is required by the Sparc driver.
 	 */
-	dev->lock.filp = NULL;
-	{
-		__volatile__ unsigned int *plock = &dev->lock.hw_lock->lock;
-		unsigned int old, new, prev, ctx;
-
-		ctx = lock.context;
-		do {
-			old  = *plock;
-			new  = ctx;
-			prev = cmpxchg(plock, old, new);
-		} while (prev != old);
-	}
-	wake_up_interruptible(&dev->lock.lock_queue);
-#else
-	DRM(lock_transfer)( dev, &dev->lock.hw_lock->lock,
-			    DRM_KERNEL_CONTEXT );
-#if __HAVE_DMA_SCHEDULE
-	DRM(dma_schedule)( dev, 1 );
-#endif
-
-	if ( DRM(lock_free)( dev, &dev->lock.hw_lock->lock,
-			     DRM_KERNEL_CONTEXT ) ) {
-		DRM_ERROR( "\n" );
+	if (dev->fn_tbl.kernel_context_switch_unlock)
+		dev->fn_tbl.kernel_context_switch_unlock(dev);
+	else {
+		DRM(lock_transfer)( dev, &dev->lock.hw_lock->lock,
+				    DRM_KERNEL_CONTEXT );
+
+		if ( DRM(lock_free)( dev, &dev->lock.hw_lock->lock,
+				     DRM_KERNEL_CONTEXT ) ) {
+			DRM_ERROR( "\n" );
+		}
 	}
-#endif /* !__HAVE_KERNEL_CTX_SWITCH */

 	unblock_all_signals();
 	return 0;
diff -Nru a/drivers/char/drm/drm_fops.h b/drivers/char/drm/drm_fops.h
--- a/drivers/char/drm/drm_fops.h	Fri Sep  3 20:29:48 2004
+++ b/drivers/char/drm/drm_fops.h	Fri Sep  3 20:29:48 2004
@@ -72,7 +72,8 @@
 	priv->authenticated = capable(CAP_SYS_ADMIN);
 	priv->lock_count    = 0;

-	DRIVER_OPEN_HELPER( priv, dev );
+	if (dev->fn_tbl.open_helper)
+	  dev->fn_tbl.open_helper(dev, priv);

 	down(&dev->struct_sem);
 	if (!dev->file_last) {
@@ -130,19 +131,15 @@
 	return 0;
 }

-#if !__HAVE_DRIVER_FOPS_POLL
 /** No-op. */
 unsigned int DRM(poll)(struct file *filp, struct poll_table_struct *wait)
 {
 	return 0;
 }
-#endif


-#if !__HAVE_DRIVER_FOPS_READ
 /** No-op. */
 ssize_t DRM(read)(struct file *filp, char __user *buf, size_t count, loff_t *off)
 {
 	return 0;
 }
-#endif
diff -Nru a/drivers/char/drm/drm_memory.h b/drivers/char/drm/drm_memory.h
--- a/drivers/char/drm/drm_memory.h	Fri Sep  3 20:29:48 2004
+++ b/drivers/char/drm/drm_memory.h	Fri Sep  3 20:29:48 2004
@@ -187,6 +187,7 @@
 	iounmap(pt);
 }

+
 #if DEBUG_MEMORY
 #include "drm_memory_debug.h"
 #else
diff -Nru a/drivers/char/drm/ffb.h b/drivers/char/drm/ffb.h
--- a/drivers/char/drm/ffb.h	Fri Sep  3 20:29:48 2004
+++ b/drivers/char/drm/ffb.h	Fri Sep  3 20:29:48 2004
@@ -8,9 +8,5 @@
  */
 #define DRM(x) ffb_##x

-/* General customization:
- */
-#define __HAVE_KERNEL_CTX_SWITCH	1
-#define __HAVE_RELEASE			1
 #endif

diff -Nru a/drivers/char/drm/ffb_context.c b/drivers/char/drm/ffb_context.c
--- a/drivers/char/drm/ffb_context.c	Fri Sep  3 20:29:48 2004
+++ b/drivers/char/drm/ffb_context.c	Fri Sep  3 20:29:48 2004
@@ -537,3 +537,63 @@
 	}
 	return 0;
 }
+
+static void ffb_driver_release(drm_device_t *dev)
+{
+	ffb_dev_priv_t *fpriv = (ffb_dev_priv_t *) dev->dev_private;
+	int context = _DRM_LOCKING_CONTEXT(dev->lock.hw_lock->lock);
+	int idx;
+
+	idx = context - 1;
+	if (fpriv &&
+	    context != DRM_KERNEL_CONTEXT &&
+	    fpriv->hw_state[idx] != NULL) {
+		kfree(fpriv->hw_state[idx]);
+		fpriv->hw_state[idx] = NULL;
+	}
+}
+
+static int ffb_driver_presetup(drm_device_t *dev)
+{
+	int ret;
+	ret = ffb_presetup(dev);
+	if (_ret != 0) return ret;
+}
+
+static void ffb_driver_pretakedown(drm_device_t *dev)
+{
+	if (dev->dev_private) kfree(dev->dev_private);
+}
+
+static void ffb_driver_postcleanup(drm_device_t *dev)
+{
+	if (ffb_position != NULL) kfree(ffb_position);
+}
+
+static int ffb_driver_kernel_context_switch_unlock(struct drm_device *dev)
+{
+	dev->lock.filp = 0;
+	{
+		__volatile__ unsigned int *plock = &dev->lock.hw_lock->lock;
+		unsigned int old, new, prev, ctx;
+
+		ctx = lock.context;
+		do {
+			old  = *plock;
+			new  = ctx;
+			prev = cmpxchg(plock, old, new);
+		} while (prev != old);
+	}
+	wake_up_interruptible(&dev->lock.lock_queue);
+}
+
+static void ffb_driver_register_fns(drm_device_t *dev)
+{
+	DRM(fops).get_unmapped_area = ffb_get_unmapped_area;
+	dev->fn_tbl.release = ffb_driver_release;
+	dev->fn_tbl.presetup = ffb_driver_presetup;
+	dev->fn_tbl.pretakedown = ffb_driver_pretakedown;
+	dev->fn_tbl.postcleanup = ffb_driver_postcleanup;
+	dev->fn_tbl.kernel_context_switch = ffb_context_switch;
+	dev->fn_tbl.kernel_context_switch_unlock = ffb_driver_kernel_context_switch_unlock;
+}
diff -Nru a/drivers/char/drm/ffb_drv.c b/drivers/char/drm/ffb_drv.c
--- a/drivers/char/drm/ffb_drv.c	Fri Sep  3 20:29:48 2004
+++ b/drivers/char/drm/ffb_drv.c	Fri Sep  3 20:29:48 2004
@@ -26,53 +26,7 @@
 #define DRIVER_MINOR		0
 #define DRIVER_PATCHLEVEL	1

-#define DRIVER_FOPS						\
-static struct file_operations	DRM(fops) = {			\
-	.owner   		= THIS_MODULE,			\
-	.open	 		= DRM(open),			\
-	.flush	 		= DRM(flush),			\
-	.release 		= DRM(release),			\
-	.ioctl	 		= DRM(ioctl),			\
-	.mmap	 		= DRM(mmap),			\
-	.read	 		= DRM(read),			\
-	.fasync	 		= DRM(fasync),			\
-	.poll	 		= DRM(poll),			\
-	.get_unmapped_area	= ffb_get_unmapped_area,		\
-}
-
 #define DRIVER_COUNT_CARDS()	ffb_count_card_instances()
-/* Allocate private structure and fill it */
-#define DRIVER_PRESETUP()	do {		\
-	int _ret;				\
-	_ret = ffb_presetup(dev);		\
-	if (_ret != 0) return _ret;		\
-} while(0)
-
-/* Free private structure */
-#define DRIVER_PRETAKEDOWN()	do {				\
-	if (dev->dev_private) kfree(dev->dev_private);		\
-} while(0)
-
-#define DRIVER_POSTCLEANUP()	do {				\
-	if (ffb_position != NULL) kfree(ffb_position);		\
-} while(0)
-
-/* We have to free up the rogue hw context state holding error or
- * else we will leak it.
- */
-#define DRIVER_RELEASE()	do {					\
-	ffb_dev_priv_t *fpriv = (ffb_dev_priv_t *) dev->dev_private;	\
-	int context = _DRM_LOCKING_CONTEXT(dev->lock.hw_lock->lock);	\
-	int idx;							\
-									\
-	idx = context - 1;						\
-	if (fpriv &&							\
-	    context != DRM_KERNEL_CONTEXT &&				\
-	    fpriv->hw_state[idx] != NULL) {				\
-		kfree(fpriv->hw_state[idx]);				\
-		fpriv->hw_state[idx] = NULL;				\
-	}								\
-} while(0)

 /* For mmap customization */
 #define DRIVER_GET_MAP_OFS()	(map->offset & 0xffffffff)
@@ -275,11 +229,11 @@
 	return NULL;
 }

-static unsigned long ffb_get_unmapped_area(struct file *filp,
-					   unsigned long hint,
-					   unsigned long len,
-					   unsigned long pgoff,
-					   unsigned long flags)
+unsigned long ffb_get_unmapped_area(struct file *filp,
+				    unsigned long hint,
+				    unsigned long len,
+				    unsigned long pgoff,
+				    unsigned long flags)
 {
 	drm_map_t *map = ffb_find_map(filp, pgoff << PAGE_SHIFT);
 	unsigned long addr = -ENOMEM;
diff -Nru a/drivers/char/drm/ffb_drv.h b/drivers/char/drm/ffb_drv.h
--- a/drivers/char/drm/ffb_drv.h	Fri Sep  3 20:29:48 2004
+++ b/drivers/char/drm/ffb_drv.h	Fri Sep  3 20:29:48 2004
@@ -274,3 +274,10 @@
 	/* Context table. */
 	struct ffb_hw_context	*hw_state[FFB_MAX_CTXS];
 } ffb_dev_priv_t;
+
+extern struct file_operations DRM(fops);
+extern unsigned long ffb_get_unmapped_area(struct file *filp,
+					   unsigned long hint,
+					   unsigned long len,
+					   unsigned long pgoff,
+					   unsigned long flags);
diff -Nru a/drivers/char/drm/gamma.h b/drivers/char/drm/gamma.h
--- a/drivers/char/drm/gamma.h	Fri Sep  3 20:29:48 2004
+++ b/drivers/char/drm/gamma.h	Fri Sep  3 20:29:48 2004
@@ -77,38 +77,12 @@
 #define __HAVE_OLD_DMA			1
 #define __HAVE_PCI_DMA			1

-#define __HAVE_DRIVER_FOPS_READ		1
-#define __HAVE_DRIVER_FOPS_POLL		1
-
 #define __HAVE_MULTIPLE_DMA_QUEUES	1
 #define __HAVE_DMA_WAITQUEUE		1

-#define __HAVE_DMA_WAITLIST		1
-#define __HAVE_DMA_FREELIST		1
-
-#define __HAVE_DMA_FLUSH		1
-#define __HAVE_DMA_SCHEDULE		1
-
-#define __HAVE_DMA_READY		1
-#define DRIVER_DMA_READY() do {						\
-	gamma_dma_ready(dev);						\
-} while (0)
-
-#define __HAVE_DMA_QUIESCENT		1
-#define DRIVER_DMA_QUIESCENT() do {					\
-	drm_gamma_private_t *dev_priv =					\
-		(drm_gamma_private_t *)dev->dev_private;		\
-	if (dev_priv->num_rast == 2)					\
-		gamma_dma_quiescent_dual(dev);				\
-	else gamma_dma_quiescent_single(dev);				\
-	return 0;							\
-} while (0)
+/* removed from DRM HAVE_DMA_FREELIST & HAVE_DMA_SCHEDULE */

 #define __HAVE_IRQ			1
 #define __HAVE_IRQ_BH			1
-
-#define DRIVER_AGP_BUFFERS_MAP( dev )					\
-	((drm_gamma_private_t *)((dev)->dev_private))->buffers
-

 #endif /* __GAMMA_H__ */
diff -Nru a/drivers/char/drm/gamma_context.h b/drivers/char/drm/gamma_context.h
--- a/drivers/char/drm/gamma_context.h	Fri Sep  3 20:29:48 2004
+++ b/drivers/char/drm/gamma_context.h	Fri Sep  3 20:29:48 2004
@@ -42,7 +42,7 @@
    the circular buffer), is based on Alessandro Rubini's LINUX DEVICE
    DRIVERS (Cambridge: O'Reilly, 1998), pages 111-113. */

-ssize_t DRM(read)(struct file *filp, char __user *buf, size_t count, loff_t *off)
+ssize_t gamma_fops_read(struct file *filp, char __user *buf, size_t count, loff_t *off)
 {
 	drm_file_t    *priv   = filp->private_data;
 	drm_device_t  *dev    = priv->dev;
@@ -128,7 +128,7 @@
 	return 0;
 }

-unsigned int DRM(poll)(struct file *filp, struct poll_table_struct *wait)
+unsigned int gamma_fops_poll(struct file *filp, struct poll_table_struct *wait)
 {
 	drm_file_t   *priv = filp->private_data;
 	drm_device_t *dev  = priv->dev;
diff -Nru a/drivers/char/drm/gamma_dma.c b/drivers/char/drm/gamma_dma.c
--- a/drivers/char/drm/gamma_dma.c	Fri Sep  3 20:29:48 2004
+++ b/drivers/char/drm/gamma_dma.c	Fri Sep  3 20:29:48 2004
@@ -639,12 +639,12 @@
  			break;
  		}
  	}
-
-	DRM_FIND_MAP( dev_priv->mmio0, init->mmio0 );
-	DRM_FIND_MAP( dev_priv->mmio1, init->mmio1 );
-	DRM_FIND_MAP( dev_priv->mmio2, init->mmio2 );
-	DRM_FIND_MAP( dev_priv->mmio3, init->mmio3 );
-
+
+	dev_priv->mmio0 = drm_core_findmap(dev, init->mmio0);
+	dev_priv->mmio1 = drm_core_findmap(dev, init->mmio1);
+	dev_priv->mmio2 = drm_core_findmap(dev, init->mmio2);
+	dev_priv->mmio3 = drm_core_findmap(dev, init->mmio3);
+
 	dev_priv->sarea_priv = (drm_gamma_sarea_t *)
 		((u8 *)dev_priv->sarea->handle +
 		 init->sarea_priv_offset);
@@ -661,9 +661,8 @@

 		buf = dma->buflist[GLINT_DRI_BUF_COUNT];
 	} else {
-		DRM_FIND_MAP( dev_priv->buffers, init->buffers_offset );
-
-		DRM_IOREMAP( dev_priv->buffers, dev );
+		dev->agp_buffer_map = drm_core_findmap(dev, init->buffers_offset);
+		drm_core_ioremap( dev->agp_buffer_map, dev);

 		buf = dma->buflist[GLINT_DRI_BUF_COUNT];
 		pgt = buf->address;
@@ -699,10 +698,9 @@
 #endif

 	if ( dev->dev_private ) {
-		drm_gamma_private_t *dev_priv = dev->dev_private;

-		if ( dev_priv->buffers != NULL )
-			DRM_IOREMAPFREE( dev_priv->buffers, dev );
+		if ( dev->agp_buffer_map != NULL )
+			drm_core_ioremapfree( dev->agp_buffer_map, dev );

 		DRM(free)( dev->dev_private, sizeof(drm_gamma_private_t),
 			   DRM_MEM_DRIVER );
@@ -903,4 +901,45 @@
 	GAMMA_WRITE( GAMMA_GDELAYTIMER,		0x00000000 );
 	GAMMA_WRITE( GAMMA_COMMANDINTENABLE,	0x00000000 );
 	GAMMA_WRITE( GAMMA_GINTENABLE,		0x00000000 );
+}
+
+extern drm_ioctl_desc_t DRM(ioctls)[];
+
+static int gamma_driver_preinit(drm_device_t *dev)
+{
+	/* reset the finish ioctl */
+	DRM(ioctls)[DRM_IOCTL_NR(DRM_IOCTL_FINISH)].func = DRM(finish);
+	return 0;
+}
+
+static void gamma_driver_pretakedown(drm_device_t *dev)
+{
+	gamma_do_cleanup_dma(dev);
+}
+
+static void gamma_driver_dma_ready(drm_device_t *dev)
+{
+	gamma_dma_ready(dev);
+}
+
+static int gamma_driver_dma_quiescent(drm_device_t *dev)
+{
+	drm_gamma_private_t *dev_priv =	(
+		drm_gamma_private_t *)dev->dev_private;
+	if (dev_priv->num_rast == 2)
+		gamma_dma_quiescent_dual(dev);
+	else gamma_dma_quiescent_single(dev);
+	return 0;
+}
+
+void gamma_driver_register_fns(drm_device_t *dev)
+{
+	DRM(fops).read = gamma_fops_read;
+	DRM(fops).poll = gamma_fops_poll;
+	dev->fn_tbl.preinit = gamma_driver_preinit;
+	dev->fn_tbl.pretakedown = gamma_driver_pretakedown;
+	dev->fn_tbl.dma_ready = gamma_driver_dma_ready;
+	dev->fn_tbl.dma_quiescent = gamma_driver_dma_quiescent;
+	dev->fn_tbl.dma_flush_block_and_flush = gamma_flush_block_and_flush;
+	dev->fn_tbl.dma_flush_unblock = gamma_flush_unblock;
 }
diff -Nru a/drivers/char/drm/gamma_drv.h b/drivers/char/drm/gamma_drv.h
--- a/drivers/char/drm/gamma_drv.h	Fri Sep  3 20:29:48 2004
+++ b/drivers/char/drm/gamma_drv.h	Fri Sep  3 20:29:48 2004
@@ -35,7 +35,6 @@
 typedef struct drm_gamma_private {
 	drm_gamma_sarea_t *sarea_priv;
 	drm_map_t *sarea;
-	drm_map_t *buffers;
 	drm_map_t *mmio0;
 	drm_map_t *mmio1;
 	drm_map_t *mmio2;
@@ -91,6 +90,10 @@
 				       drm_buf_t *buf);
 extern drm_buf_t     *DRM(freelist_get)(drm_freelist_t *bl, int block);

+/* externs for gamma changes to the ops */
+extern struct file_operations DRM(fops);
+extern unsigned int gamma_fops_poll(struct file *filp, struct poll_table_struct *wait);
+extern ssize_t gamma_fops_read(struct file *filp, char __user *buf, size_t count, loff_t *off);


 #define GLINT_DRI_BUF_COUNT 256
diff -Nru a/drivers/char/drm/i810.h b/drivers/char/drm/i810.h
--- a/drivers/char/drm/i810.h	Fri Sep  3 20:29:48 2004
+++ b/drivers/char/drm/i810.h	Fri Sep  3 20:29:48 2004
@@ -84,41 +84,16 @@
 #define __HAVE_COUNTER8         _DRM_STAT_SECONDARY
 #define __HAVE_COUNTER9         _DRM_STAT_DMA

-/* Driver customization:
- */
-#define __HAVE_RELEASE		1
-#define DRIVER_RELEASE() do {						\
-	i810_reclaim_buffers( filp );					\
-} while (0)
-
-#define DRIVER_PRETAKEDOWN() do {					\
-	i810_dma_cleanup( dev );					\
-} while (0)
-
 /* DMA customization:
  */
 #define __HAVE_DMA		1
 #define __HAVE_DMA_QUEUE	1
-#define __HAVE_DMA_WAITLIST	0
 #define __HAVE_DMA_RECLAIM	1

-#define __HAVE_DMA_QUIESCENT	1
-#define DRIVER_DMA_QUIESCENT() do {					\
-	i810_dma_quiescent( dev );					\
-} while (0)
-
 /* Don't need an irq any more.  The template code will make sure that
  * a noop stub is generated for compatibility.
  */
 /* XXX: Add vblank support? */
 #define __HAVE_IRQ		0
-
-/* Buffer customization:
- */
-
-#define DRIVER_BUF_PRIV_T	drm_i810_buf_priv_t
-
-#define DRIVER_AGP_BUFFERS_MAP( dev )					\
-	((drm_i810_private_t *)((dev)->dev_private))->buffer_map

 #endif
diff -Nru a/drivers/char/drm/i810_dma.c b/drivers/char/drm/i810_dma.c
--- a/drivers/char/drm/i810_dma.c	Fri Sep  3 20:29:48 2004
+++ b/drivers/char/drm/i810_dma.c	Fri Sep  3 20:29:48 2004
@@ -364,15 +364,15 @@
 	   	DRM_ERROR("can not find sarea!\n");
 	   	return -EINVAL;
 	}
-	DRM_FIND_MAP( dev_priv->mmio_map, init->mmio_offset );
+	dev_priv->mmio_map = drm_core_findmap(dev, init->mmio_offset);
 	if (!dev_priv->mmio_map) {
 		dev->dev_private = (void *)dev_priv;
 	   	i810_dma_cleanup(dev);
 	   	DRM_ERROR("can not find mmio map!\n");
 	   	return -EINVAL;
 	}
-	DRM_FIND_MAP( dev_priv->buffer_map, init->buffers_offset );
-	if (!dev_priv->buffer_map) {
+	dev->agp_buffer_map = drm_core_findmap(dev, init->buffers_offset);
+	if (!dev->agp_buffer_map) {
 		dev->dev_private = (void *)dev_priv;
 	   	i810_dma_cleanup(dev);
 	   	DRM_ERROR("can not find dma buffer map!\n");
@@ -1388,3 +1388,28 @@
 	i810_dma_dispatch_flip( dev );
    	return 0;
 }
+
+static void i810_driver_pretakedown(drm_device_t *dev)
+{
+	i810_dma_cleanup( dev );
+}
+
+static void i810_driver_release(drm_device_t *dev, struct file *filp)
+{
+	i810_reclaim_buffers(filp);
+}
+
+static int i810_driver_dma_quiescent(drm_device_t *dev)
+{
+	i810_dma_quiescent( dev );
+	return 0;
+}
+
+void i810_driver_register_fns(drm_device_t *dev)
+{
+	dev->dev_priv_size = sizeof(drm_i810_buf_priv_t);
+	dev->fn_tbl.pretakedown = i810_driver_pretakedown;
+	dev->fn_tbl.release = i810_driver_release;
+	dev->fn_tbl.dma_quiescent = i810_driver_dma_quiescent;
+}
+
diff -Nru a/drivers/char/drm/i810_drv.h b/drivers/char/drm/i810_drv.h
--- a/drivers/char/drm/i810_drv.h	Fri Sep  3 20:29:48 2004
+++ b/drivers/char/drm/i810_drv.h	Fri Sep  3 20:29:48 2004
@@ -53,7 +53,6 @@

 typedef struct drm_i810_private {
 	drm_map_t *sarea_map;
-	drm_map_t *buffer_map;
 	drm_map_t *mmio_map;

 	drm_i810_sarea_t *sarea_priv;
diff -Nru a/drivers/char/drm/i830.h b/drivers/char/drm/i830.h
--- a/drivers/char/drm/i830.h	Fri Sep  3 20:29:48 2004
+++ b/drivers/char/drm/i830.h	Fri Sep  3 20:29:48 2004
@@ -83,30 +83,12 @@
 #define __HAVE_COUNTER8         _DRM_STAT_SECONDARY
 #define __HAVE_COUNTER9         _DRM_STAT_DMA

-/* Driver customization:
- */
-#define __HAVE_RELEASE		1
-#define DRIVER_RELEASE() do {						\
-	i830_reclaim_buffers( filp );					\
-} while (0)
-
-#define DRIVER_PRETAKEDOWN() do {					\
-	i830_dma_cleanup( dev );					\
-} while (0)
-
 /* DMA customization:
  */
 #define __HAVE_DMA		1
 #define __HAVE_DMA_QUEUE	1
-#define __HAVE_DMA_WAITLIST	0
 #define __HAVE_DMA_RECLAIM	1

-#define __HAVE_DMA_QUIESCENT	1
-#define DRIVER_DMA_QUIESCENT() do {					\
-	i830_dma_quiescent( dev );					\
-} while (0)
-
-
 /* Driver will work either way: IRQ's save cpu time when waiting for
  * the card, but are subject to subtle interactions between bios,
  * hardware and the driver.
@@ -120,14 +102,5 @@
 #else
 #define __HAVE_IRQ          0
 #endif
-
-
-/* Buffer customization:
- */
-
-#define DRIVER_BUF_PRIV_T	drm_i830_buf_priv_t
-
-#define DRIVER_AGP_BUFFERS_MAP( dev )					\
-	((drm_i830_private_t *)((dev)->dev_private))->buffer_map

 #endif
diff -Nru a/drivers/char/drm/i830_dma.c b/drivers/char/drm/i830_dma.c
--- a/drivers/char/drm/i830_dma.c	Fri Sep  3 20:29:48 2004
+++ b/drivers/char/drm/i830_dma.c	Fri Sep  3 20:29:48 2004
@@ -371,15 +371,15 @@
 		DRM_ERROR("can not find sarea!\n");
 		return -EINVAL;
 	}
-	DRM_FIND_MAP( dev_priv->mmio_map, init->mmio_offset );
+	dev_priv->mmio_map = drm_core_findmap(dev, init->mmio_offset);
 	if(!dev_priv->mmio_map) {
 		dev->dev_private = (void *)dev_priv;
 		i830_dma_cleanup(dev);
 		DRM_ERROR("can not find mmio map!\n");
 		return -EINVAL;
 	}
-	DRM_FIND_MAP( dev_priv->buffer_map, init->buffers_offset );
-	if(!dev_priv->buffer_map) {
+	dev->agp_buffer_map = drm_core_findmap(dev, init->buffers_offset);
+	if(!dev->agp_buffer_map) {
 		dev->dev_private = (void *)dev_priv;
 		i830_dma_cleanup(dev);
 		DRM_ERROR("can not find dma buffer map!\n");
@@ -1582,3 +1582,29 @@

 	return 0;
 }
+
+
+static void i830_driver_pretakedown(drm_device_t *dev)
+{
+	i830_dma_cleanup( dev );
+}
+
+static void i830_driver_release(drm_device_t *dev, struct file *filp)
+{
+	i830_reclaim_buffers(filp);
+}
+
+static int i830_driver_dma_quiescent(drm_device_t *dev)
+{
+	i830_dma_quiescent( dev );
+	return 0;
+}
+
+void i830_driver_register_fns(drm_device_t *dev)
+{
+	dev->dev_priv_size = sizeof(drm_i830_buf_priv_t);
+	dev->fn_tbl.pretakedown = i830_driver_pretakedown;
+	dev->fn_tbl.release = i830_driver_release;
+	dev->fn_tbl.dma_quiescent = i830_driver_dma_quiescent;
+}
+
diff -Nru a/drivers/char/drm/i830_drv.h b/drivers/char/drm/i830_drv.h
--- a/drivers/char/drm/i830_drv.h	Fri Sep  3 20:29:48 2004
+++ b/drivers/char/drm/i830_drv.h	Fri Sep  3 20:29:48 2004
@@ -53,7 +53,6 @@

 typedef struct drm_i830_private {
 	drm_map_t *sarea_map;
-	drm_map_t *buffer_map;
 	drm_map_t *mmio_map;

 	drm_i830_sarea_t *sarea_priv;
diff -Nru a/drivers/char/drm/i915.h b/drivers/char/drm/i915.h
--- a/drivers/char/drm/i915.h	Fri Sep  3 20:29:48 2004
+++ b/drivers/char/drm/i915.h	Fri Sep  3 20:29:48 2004
@@ -55,27 +55,6 @@
 #define __HAVE_COUNTER8         _DRM_STAT_SECONDARY
 #define __HAVE_COUNTER9         _DRM_STAT_DMA

-/* Driver customization:
- */
-#define DRIVER_PRETAKEDOWN() do {					\
-	if ( dev->dev_private ) {					\
-		drm_i915_private_t *dev_priv = dev->dev_private;	\
-	        i915_mem_takedown( &(dev_priv->agp_heap) );             \
- 	}								\
-	i915_dma_cleanup( dev );					\
-} while (0)
-
-/* When a client dies:
- *    - Free any alloced agp memory.
- */
-#define DRIVER_PRERELEASE() 						\
-do {									\
-	if ( dev->dev_private ) {					\
-		drm_i915_private_t *dev_priv = dev->dev_private;	\
-                i915_mem_release( dev, filp, dev_priv->agp_heap );	\
-	}								\
-} while (0)
-
 /* We use our own dma mechanisms, not the drm template code.  However,
  * the shared IRQ code is useful to us:
  */
diff -Nru a/drivers/char/drm/i915_dma.c b/drivers/char/drm/i915_dma.c
--- a/drivers/char/drm/i915_dma.c	Fri Sep  3 20:29:48 2004
+++ b/drivers/char/drm/i915_dma.c	Fri Sep  3 20:29:48 2004
@@ -91,7 +91,7 @@
 		    (drm_i915_private_t *) dev->dev_private;

 		if (dev_priv->ring.virtual_start) {
-			DRM_IOREMAPFREE(&dev_priv->ring.map, dev);
+			drm_core_ioremapfree( &dev_priv->ring.map, dev);
 		}

 		if (dev_priv->hw_status_page) {
@@ -125,7 +125,7 @@
 		return DRM_ERR(EINVAL);
 	}

-	DRM_FIND_MAP(dev_priv->mmio_map, init->mmio_offset);
+	dev_priv->mmio_map = drm_core_findmap(dev, init->mmio_offset);
 	if (!dev_priv->mmio_map) {
 		dev->dev_private = (void *)dev_priv;
 		i915_dma_cleanup(dev);
@@ -147,7 +147,7 @@
 	dev_priv->ring.map.flags = 0;
 	dev_priv->ring.map.mtrr = 0;

-	DRM_IOREMAP(&dev_priv->ring.map, dev);
+	drm_core_ioremap( &dev_priv->ring.map, dev );

 	if (dev_priv->ring.map.handle == NULL) {
 		dev->dev_private = (void *)dev_priv;
@@ -711,4 +711,27 @@
 	}

 	return 0;
+}
+
+static void i915_driver_pretakedown(drm_device_t *dev)
+{
+	if ( dev->dev_private ) {
+		drm_i915_private_t *dev_priv = dev->dev_private;
+	        i915_mem_takedown( &(dev_priv->agp_heap) );
+ 	}
+	i915_dma_cleanup( dev );
+}
+
+static void i915_driver_prerelease(drm_device_t *dev, DRMFILE filp)
+{
+	if ( dev->dev_private ) {
+		drm_i915_private_t *dev_priv = dev->dev_private;
+                i915_mem_release( dev, filp, dev_priv->agp_heap );
+	}
+}
+
+void i915_driver_register_fns(drm_device_t *dev)
+{
+	dev->fn_tbl.pretakedown = i915_driver_pretakedown;
+	dev->fn_tbl.prerelease = i915_driver_prerelease;
 }
diff -Nru a/drivers/char/drm/mga.h b/drivers/char/drm/mga.h
--- a/drivers/char/drm/mga.h	Fri Sep  3 20:29:48 2004
+++ b/drivers/char/drm/mga.h	Fri Sep  3 20:29:48 2004
@@ -69,30 +69,11 @@
 #define __HAVE_COUNTER7         _DRM_STAT_PRIMARY
 #define __HAVE_COUNTER8         _DRM_STAT_SECONDARY

-/* Driver customization:
- */
-#define DRIVER_PRETAKEDOWN() do {					\
-	mga_do_cleanup_dma( dev );					\
-} while (0)
-
 /* DMA customization:
  */
 #define __HAVE_DMA		1
 #define __HAVE_IRQ		1
 #define __HAVE_VBL_IRQ		1
 #define __HAVE_SHARED_IRQ       1
-
-#define __HAVE_DMA_QUIESCENT	1
-#define DRIVER_DMA_QUIESCENT() do {					\
-	drm_mga_private_t *dev_priv = dev->dev_private;			\
-	return mga_do_wait_for_idle( dev_priv );			\
-} while (0)
-
-/* Buffer customization:
- */
-#define DRIVER_BUF_PRIV_T	drm_mga_buf_priv_t
-
-#define DRIVER_AGP_BUFFERS_MAP( dev )					\
-	((drm_mga_private_t *)((dev)->dev_private))->buffers

 #endif
diff -Nru a/drivers/char/drm/mga_dma.c b/drivers/char/drm/mga_dma.c
--- a/drivers/char/drm/mga_dma.c	Fri Sep  3 20:29:48 2004
+++ b/drivers/char/drm/mga_dma.c	Fri Sep  3 20:29:48 2004
@@ -500,7 +500,7 @@
 		return DRM_ERR(EINVAL);
 	}

-	DRM_FIND_MAP( dev_priv->mmio, init->mmio_offset );
+	dev_priv->mmio = drm_core_findmap(dev, init->mmio_offset);
 	if(!dev_priv->mmio) {
 		DRM_ERROR( "failed to find mmio region!\n" );
 		/* Assign dev_private so we can do cleanup. */
@@ -508,7 +508,7 @@
 		mga_do_cleanup_dma( dev );
 		return DRM_ERR(EINVAL);
 	}
-	DRM_FIND_MAP( dev_priv->status, init->status_offset );
+	dev_priv->status = drm_core_findmap(dev, init->status_offset);
 	if(!dev_priv->status) {
 		DRM_ERROR( "failed to find status page!\n" );
 		/* Assign dev_private so we can do cleanup. */
@@ -516,8 +516,7 @@
 		mga_do_cleanup_dma( dev );
 		return DRM_ERR(EINVAL);
 	}
-
-	DRM_FIND_MAP( dev_priv->warp, init->warp_offset );
+	dev_priv->warp = drm_core_findmap(dev, init->warp_offset);
 	if(!dev_priv->warp) {
 		DRM_ERROR( "failed to find warp microcode region!\n" );
 		/* Assign dev_private so we can do cleanup. */
@@ -525,7 +524,7 @@
 		mga_do_cleanup_dma( dev );
 		return DRM_ERR(EINVAL);
 	}
-	DRM_FIND_MAP( dev_priv->primary, init->primary_offset );
+	dev_priv->primary = drm_core_findmap(dev, init->primary_offset);
 	if(!dev_priv->primary) {
 		DRM_ERROR( "failed to find primary dma region!\n" );
 		/* Assign dev_private so we can do cleanup. */
@@ -533,8 +532,8 @@
 		mga_do_cleanup_dma( dev );
 		return DRM_ERR(EINVAL);
 	}
-	DRM_FIND_MAP( dev_priv->buffers, init->buffers_offset );
-	if(!dev_priv->buffers) {
+	dev->agp_buffer_map = drm_core_findmap(dev, init->buffers_offset);
+	if(!dev->agp_buffer_map) {
 		DRM_ERROR( "failed to find dma buffer region!\n" );
 		/* Assign dev_private so we can do cleanup. */
 		dev->dev_private = (void *)dev_priv;
@@ -546,13 +545,13 @@
 		(drm_mga_sarea_t *)((u8 *)dev_priv->sarea->handle +
 				    init->sarea_priv_offset);

-	DRM_IOREMAP( dev_priv->warp, dev );
-	DRM_IOREMAP( dev_priv->primary, dev );
-	DRM_IOREMAP( dev_priv->buffers, dev );
+	drm_core_ioremap( dev_priv->warp, dev );
+	drm_core_ioremap( dev_priv->primary, dev );
+	drm_core_ioremap( dev->agp_buffer_map, dev );

 	if(!dev_priv->warp->handle ||
 	   !dev_priv->primary->handle ||
-	   !dev_priv->buffers->handle ) {
+	   !dev->agp_buffer_map->handle ) {
 		DRM_ERROR( "failed to ioremap agp regions!\n" );
 		/* Assign dev_private so we can do cleanup. */
 		dev->dev_private = (void *)dev_priv;
@@ -643,11 +642,11 @@
 		drm_mga_private_t *dev_priv = dev->dev_private;

 		if ( dev_priv->warp != NULL )
-			DRM_IOREMAPFREE( dev_priv->warp, dev );
+			drm_core_ioremapfree( dev_priv->warp, dev );
 		if ( dev_priv->primary != NULL )
-			DRM_IOREMAPFREE( dev_priv->primary, dev );
-		if ( dev_priv->buffers != NULL )
-			DRM_IOREMAPFREE( dev_priv->buffers, dev );
+			drm_core_ioremapfree( dev_priv->primary, dev );
+		if ( dev->agp_buffer_map != NULL )
+			drm_core_ioremapfree( dev->agp_buffer_map, dev );

 		if ( dev_priv->head != NULL ) {
 			mga_freelist_cleanup( dev );
@@ -799,4 +798,21 @@
 	DRM_COPY_TO_USER_IOCTL( argp, d, sizeof(d) );

 	return ret;
+}
+
+static void mga_driver_pretakedown(drm_device_t *dev)
+{
+	mga_do_cleanup_dma( dev );
+}
+
+static int mga_driver_dma_quiescent(drm_device_t *dev)
+{
+	drm_mga_private_t *dev_priv = dev->dev_private;
+	return mga_do_wait_for_idle( dev_priv );
+}
+
+void mga_driver_register_fns(drm_device_t *dev)
+{
+	dev->fn_tbl.pretakedown = mga_driver_pretakedown;
+	dev->fn_tbl.dma_quiescent = mga_driver_dma_quiescent;
 }
diff -Nru a/drivers/char/drm/r128.h b/drivers/char/drm/r128.h
--- a/drivers/char/drm/r128.h	Fri Sep  3 20:29:48 2004
+++ b/drivers/char/drm/r128.h	Fri Sep  3 20:29:48 2004
@@ -79,42 +79,11 @@
    [DRM_IOCTL_NR(DRM_IOCTL_R128_INDIRECT)]   = { r128_cce_indirect, 1, 1 }, \
    [DRM_IOCTL_NR(DRM_IOCTL_R128_GETPARAM)]   = { r128_getparam, 1, 0 },

-/* Driver customization:
- */
-#define DRIVER_PRERELEASE() do {					\
-	if ( dev->dev_private ) {					\
-		drm_r128_private_t *dev_priv = dev->dev_private;	\
-		if ( dev_priv->page_flipping ) {			\
-			r128_do_cleanup_pageflip( dev );		\
-		}							\
-	}								\
-} while (0)
-
-#define DRIVER_PRETAKEDOWN() do {					\
-	r128_do_cleanup_cce( dev );					\
-} while (0)
-
 /* DMA customization:
  */
 #define __HAVE_DMA		1
 #define __HAVE_IRQ		1
 #define __HAVE_VBL_IRQ		1
 #define __HAVE_SHARED_IRQ       1
-
-#if 0
-/* GH: Remove this for now... */
-#define __HAVE_DMA_QUIESCENT	1
-#define DRIVER_DMA_QUIESCENT() do {					\
-	drm_r128_private_t *dev_priv = dev->dev_private;		\
-	return r128_do_cce_idle( dev_priv );				\
-} while (0)
-#endif
-
-/* Buffer customization:
- */
-#define DRIVER_BUF_PRIV_T	drm_r128_buf_priv_t
-
-#define DRIVER_AGP_BUFFERS_MAP( dev )					\
-	((drm_r128_private_t *)((dev)->dev_private))->buffers

 #endif
diff -Nru a/drivers/char/drm/r128_cce.c b/drivers/char/drm/r128_cce.c
--- a/drivers/char/drm/r128_cce.c	Fri Sep  3 20:29:48 2004
+++ b/drivers/char/drm/r128_cce.c	Fri Sep  3 20:29:48 2004
@@ -467,29 +467,29 @@
 		return DRM_ERR(EINVAL);
 	}

-	DRM_FIND_MAP( dev_priv->mmio, init->mmio_offset );
+	dev_priv->mmio = drm_core_findmap(dev, init->mmio_offset);
 	if(!dev_priv->mmio) {
 		DRM_ERROR("could not find mmio region!\n");
 		dev->dev_private = (void *)dev_priv;
 		r128_do_cleanup_cce( dev );
 		return DRM_ERR(EINVAL);
 	}
-	DRM_FIND_MAP( dev_priv->cce_ring, init->ring_offset );
+	dev_priv->cce_ring = drm_core_findmap(dev, init->ring_offset);
 	if(!dev_priv->cce_ring) {
 		DRM_ERROR("could not find cce ring region!\n");
 		dev->dev_private = (void *)dev_priv;
 		r128_do_cleanup_cce( dev );
 		return DRM_ERR(EINVAL);
 	}
-	DRM_FIND_MAP( dev_priv->ring_rptr, init->ring_rptr_offset );
+	dev_priv->ring_rptr = drm_core_findmap(dev, init->ring_rptr_offset);
 	if(!dev_priv->ring_rptr) {
 		DRM_ERROR("could not find ring read pointer!\n");
 		dev->dev_private = (void *)dev_priv;
 		r128_do_cleanup_cce( dev );
 		return DRM_ERR(EINVAL);
 	}
-	DRM_FIND_MAP( dev_priv->buffers, init->buffers_offset );
-	if(!dev_priv->buffers) {
+	dev->agp_buffer_map = drm_core_findmap(dev, init->buffers_offset);
+	if(!dev->agp_buffer_map) {
 		DRM_ERROR("could not find dma buffer region!\n");
 		dev->dev_private = (void *)dev_priv;
 		r128_do_cleanup_cce( dev );
@@ -497,8 +497,7 @@
 	}

 	if ( !dev_priv->is_pci ) {
-		DRM_FIND_MAP( dev_priv->agp_textures,
-			      init->agp_textures_offset );
+		dev_priv->agp_textures = drm_core_findmap(dev, init->agp_textures_offset);
 		if(!dev_priv->agp_textures) {
 			DRM_ERROR("could not find agp texture region!\n");
 			dev->dev_private = (void *)dev_priv;
@@ -513,12 +512,12 @@

 #if __REALLY_HAVE_AGP
 	if ( !dev_priv->is_pci ) {
-		DRM_IOREMAP( dev_priv->cce_ring, dev );
-		DRM_IOREMAP( dev_priv->ring_rptr, dev );
-		DRM_IOREMAP( dev_priv->buffers, dev );
+		drm_core_ioremap( dev_priv->cce_ring, dev );
+		drm_core_ioremap( dev_priv->ring_rptr, dev );
+		drm_core_ioremap( dev->agp_buffer_map, dev );
 		if(!dev_priv->cce_ring->handle ||
 		   !dev_priv->ring_rptr->handle ||
-		   !dev_priv->buffers->handle) {
+		   !dev->agp_buffer_map->handle) {
 			DRM_ERROR("Could not ioremap agp regions!\n");
 			dev->dev_private = (void *)dev_priv;
 			r128_do_cleanup_cce( dev );
@@ -531,7 +530,7 @@
 			(void *)dev_priv->cce_ring->offset;
 		dev_priv->ring_rptr->handle =
 			(void *)dev_priv->ring_rptr->offset;
-		dev_priv->buffers->handle = (void *)dev_priv->buffers->offset;
+		dev->agp_buffer_map->handle = (void *)dev->agp_buffer_map->offset;
 	}

 #if __REALLY_HAVE_AGP
@@ -601,11 +600,11 @@
 #if __REALLY_HAVE_AGP
 		if ( !dev_priv->is_pci ) {
 			if ( dev_priv->cce_ring != NULL )
-				DRM_IOREMAPFREE( dev_priv->cce_ring, dev );
+				drm_core_ioremapfree( dev_priv->cce_ring, dev );
 			if ( dev_priv->ring_rptr != NULL )
-				DRM_IOREMAPFREE( dev_priv->ring_rptr, dev );
-			if ( dev_priv->buffers != NULL )
-				DRM_IOREMAPFREE( dev_priv->buffers, dev );
+				drm_core_ioremapfree( dev_priv->ring_rptr, dev );
+			if ( dev->agp_buffer_map != NULL )
+				drm_core_ioremapfree( dev->agp_buffer_map, dev );
 		} else
 #endif
 		{
diff -Nru a/drivers/char/drm/r128_drv.h b/drivers/char/drm/r128_drv.h
--- a/drivers/char/drm/r128_drv.h	Fri Sep  3 20:29:48 2004
+++ b/drivers/char/drm/r128_drv.h	Fri Sep  3 20:29:48 2004
@@ -100,7 +100,6 @@
 	drm_local_map_t *mmio;
 	drm_local_map_t *cce_ring;
 	drm_local_map_t *ring_rptr;
-	drm_local_map_t *buffers;
 	drm_local_map_t *agp_textures;
 } drm_r128_private_t;

diff -Nru a/drivers/char/drm/r128_state.c b/drivers/char/drm/r128_state.c
--- a/drivers/char/drm/r128_state.c	Fri Sep  3 20:29:48 2004
+++ b/drivers/char/drm/r128_state.c	Fri Sep  3 20:29:48 2004
@@ -667,7 +667,7 @@
 		 */
 		if ( dwords & 1 ) {
 			u32 *data = (u32 *)
-				((char *)dev_priv->buffers->handle
+				((char *)dev->agp_buffer_map->handle
 				 + buf->offset + start);
 			data[dwords++] = cpu_to_le32( R128_CCE_PACKET2 );
 		}
@@ -713,7 +713,7 @@
 	drm_r128_buf_priv_t *buf_priv = buf->dev_private;
 	drm_r128_sarea_t *sarea_priv = dev_priv->sarea_priv;
 	int format = sarea_priv->vc_format;
-	int offset = dev_priv->buffers->offset - dev_priv->cce_buffers_offset;
+	int offset = dev->agp_buffer_map->offset - dev_priv->cce_buffers_offset;
 	int prim = buf_priv->prim;
 	u32 *data;
 	int dwords;
@@ -733,7 +733,7 @@

 		dwords = (end - start + 3) / sizeof(u32);

-		data = (u32 *)((char *)dev_priv->buffers->handle
+		data = (u32 *)((char *)dev->agp_buffer_map->handle
 			       + buf->offset + start);

 		data[0] = cpu_to_le32( CCE_PACKET3( R128_3D_RNDR_GEN_INDX_PRIM,
@@ -857,7 +857,7 @@

 	dwords = (blit->width * blit->height) >> dword_shift;

-	data = (u32 *)((char *)dev_priv->buffers->handle + buf->offset);
+	data = (u32 *)((char *)dev->agp_buffer_map->handle + buf->offset);

 	data[0] = cpu_to_le32( CCE_PACKET3( R128_CNTL_HOSTDATA_BLT, dwords + 6 ) );
 	data[1] = cpu_to_le32( (R128_GMC_DST_PITCH_OFFSET_CNTL |
@@ -1693,4 +1693,26 @@
 	}

 	return 0;
+}
+
+static void r128_driver_prerelease(drm_device_t *dev, DRMFILE filp)
+{
+	if ( dev->dev_private ) {
+		drm_r128_private_t *dev_priv = dev->dev_private;
+		if ( dev_priv->page_flipping ) {
+			r128_do_cleanup_pageflip( dev );
+		}
+	}
+}
+
+static void r128_driver_pretakedown(drm_device_t *dev)
+{
+	r128_do_cleanup_cce( dev );
+}
+
+void r128_driver_register_fns(drm_device_t *dev)
+{
+	dev->dev_priv_size = sizeof(drm_r128_buf_priv_t);
+	dev->fn_tbl.prerelease = r128_driver_prerelease;
+	dev->fn_tbl.pretakedown = r128_driver_pretakedown;
 }
diff -Nru a/drivers/char/drm/radeon.h b/drivers/char/drm/radeon.h
--- a/drivers/char/drm/radeon.h	Fri Sep  3 20:29:48 2004
+++ b/drivers/char/drm/radeon.h	Fri Sep  3 20:29:48 2004
@@ -118,56 +118,11 @@
 #define DRIVER_FILE_FIELDS						\
 	int64_t radeon_fb_delta;					\

-#define DRIVER_OPEN_HELPER( filp_priv, dev )				\
-do {									\
-	drm_radeon_private_t *dev_priv = dev->dev_private;		\
-	if ( dev_priv )							\
-		filp_priv->radeon_fb_delta = dev_priv->fb_location;	\
-	else								\
-		filp_priv->radeon_fb_delta = 0;				\
-} while( 0 )
-
-/* When a client dies:
- *    - Check for and clean up flipped page state
- *    - Free any alloced GART memory.
- *
- * DRM infrastructure takes care of reclaiming dma buffers.
- */
-#define DRIVER_PRERELEASE() 						\
-do {									\
-	if ( dev->dev_private ) {					\
-		drm_radeon_private_t *dev_priv = dev->dev_private;	\
-		if ( dev_priv->page_flipping ) {			\
-			radeon_do_cleanup_pageflip( dev );		\
-		}							\
-		radeon_mem_release( filp, dev_priv->gart_heap );	\
-		radeon_mem_release( filp, dev_priv->fb_heap );		\
-	}								\
-} while (0)
-
-/* When the last client dies, shut down the CP and free dev->dev_priv.
- */
-/* #define __HAVE_RELEASE 1 */
-#define DRIVER_PRETAKEDOWN()			\
-do {						\
-    radeon_do_release( dev );			\
-} while (0)
-
-
-
 /* DMA customization:
  */
 #define __HAVE_DMA		1
 #define __HAVE_IRQ		1
 #define __HAVE_VBL_IRQ		1
 #define __HAVE_SHARED_IRQ       1
-
-
-/* Buffer customization:
- */
-#define DRIVER_BUF_PRIV_T	drm_radeon_buf_priv_t
-
-#define DRIVER_AGP_BUFFERS_MAP( dev )				\
-	((drm_radeon_private_t *)((dev)->dev_private))->buffers

 #endif
diff -Nru a/drivers/char/drm/radeon_cp.c b/drivers/char/drm/radeon_cp.c
--- a/drivers/char/drm/radeon_cp.c	Fri Sep  3 20:29:48 2004
+++ b/drivers/char/drm/radeon_cp.c	Fri Sep  3 20:29:48 2004
@@ -1118,29 +1118,29 @@
 		return DRM_ERR(EINVAL);
 	}

-	DRM_FIND_MAP( dev_priv->mmio, init->mmio_offset );
+	dev_priv->mmio = drm_core_findmap(dev, init->mmio_offset);
 	if(!dev_priv->mmio) {
 		DRM_ERROR("could not find mmio region!\n");
 		dev->dev_private = (void *)dev_priv;
 		radeon_do_cleanup_cp(dev);
 		return DRM_ERR(EINVAL);
 	}
-	DRM_FIND_MAP( dev_priv->cp_ring, init->ring_offset );
+	dev_priv->cp_ring = drm_core_findmap(dev, init->ring_offset);
 	if(!dev_priv->cp_ring) {
 		DRM_ERROR("could not find cp ring region!\n");
 		dev->dev_private = (void *)dev_priv;
 		radeon_do_cleanup_cp(dev);
 		return DRM_ERR(EINVAL);
 	}
-	DRM_FIND_MAP( dev_priv->ring_rptr, init->ring_rptr_offset );
+	dev_priv->ring_rptr = drm_core_findmap(dev, init->ring_rptr_offset);
 	if(!dev_priv->ring_rptr) {
 		DRM_ERROR("could not find ring read pointer!\n");
 		dev->dev_private = (void *)dev_priv;
 		radeon_do_cleanup_cp(dev);
 		return DRM_ERR(EINVAL);
 	}
-	DRM_FIND_MAP( dev_priv->buffers, init->buffers_offset );
-	if(!dev_priv->buffers) {
+	dev->agp_buffer_map = drm_core_findmap(dev, init->buffers_offset);
+	if(!dev->agp_buffer_map) {
 		DRM_ERROR("could not find dma buffer region!\n");
 		dev->dev_private = (void *)dev_priv;
 		radeon_do_cleanup_cp(dev);
@@ -1148,7 +1148,7 @@
 	}

 	if ( init->gart_textures_offset ) {
-		DRM_FIND_MAP( dev_priv->gart_textures, init->gart_textures_offset );
+		dev_priv->gart_textures = drm_core_findmap(dev, init->gart_textures_offset);
 		if ( !dev_priv->gart_textures ) {
 			DRM_ERROR("could not find GART texture region!\n");
 			dev->dev_private = (void *)dev_priv;
@@ -1163,12 +1163,12 @@

 #if __REALLY_HAVE_AGP
 	if ( !dev_priv->is_pci ) {
-		DRM_IOREMAP( dev_priv->cp_ring, dev );
-		DRM_IOREMAP( dev_priv->ring_rptr, dev );
-		DRM_IOREMAP( dev_priv->buffers, dev );
+		drm_core_ioremap( dev_priv->cp_ring, dev );
+		drm_core_ioremap( dev_priv->ring_rptr, dev );
+		drm_core_ioremap( dev->agp_buffer_map, dev );
 		if(!dev_priv->cp_ring->handle ||
 		   !dev_priv->ring_rptr->handle ||
-		   !dev_priv->buffers->handle) {
+		   !dev->agp_buffer_map->handle) {
 			DRM_ERROR("could not find ioremap agp regions!\n");
 			dev->dev_private = (void *)dev_priv;
 			radeon_do_cleanup_cp(dev);
@@ -1181,14 +1181,14 @@
 			(void *)dev_priv->cp_ring->offset;
 		dev_priv->ring_rptr->handle =
 			(void *)dev_priv->ring_rptr->offset;
-		dev_priv->buffers->handle = (void *)dev_priv->buffers->offset;
+		dev->agp_buffer_map->handle = (void *)dev->agp_buffer_map->offset;

 		DRM_DEBUG( "dev_priv->cp_ring->handle %p\n",
 			   dev_priv->cp_ring->handle );
 		DRM_DEBUG( "dev_priv->ring_rptr->handle %p\n",
 			   dev_priv->ring_rptr->handle );
-		DRM_DEBUG( "dev_priv->buffers->handle %p\n",
-			   dev_priv->buffers->handle );
+		DRM_DEBUG( "dev->agp_buffer_map->handle %p\n",
+			   dev->agp_buffer_map->handle );
 	}

 	dev_priv->fb_location = ( RADEON_READ( RADEON_MC_FB_LOCATION )
@@ -1213,12 +1213,12 @@

 #if __REALLY_HAVE_AGP
 	if ( !dev_priv->is_pci )
-		dev_priv->gart_buffers_offset = (dev_priv->buffers->offset
+		dev_priv->gart_buffers_offset = (dev->agp_buffer_map->offset
 						- dev->agp->base
 						+ dev_priv->gart_vm_start);
 	else
 #endif
-		dev_priv->gart_buffers_offset = (dev_priv->buffers->offset
+		dev_priv->gart_buffers_offset = (dev->agp_buffer_map->offset
 						- dev->sg->handle
 						+ dev_priv->gart_vm_start);

@@ -1289,11 +1289,11 @@
 #if __REALLY_HAVE_AGP
 		if ( !dev_priv->is_pci ) {
 			if ( dev_priv->cp_ring != NULL )
-				DRM_IOREMAPFREE( dev_priv->cp_ring, dev );
+				drm_core_ioremapfree( dev_priv->cp_ring, dev );
 			if ( dev_priv->ring_rptr != NULL )
-				DRM_IOREMAPFREE( dev_priv->ring_rptr, dev );
-			if ( dev_priv->buffers != NULL )
-				DRM_IOREMAPFREE( dev_priv->buffers, dev );
+				drm_core_ioremapfree( dev_priv->ring_rptr, dev );
+			if ( dev->agp_buffer_map != NULL )
+				drm_core_ioremapfree( dev->agp_buffer_map, dev );
 		} else
 #endif
 		{
diff -Nru a/drivers/char/drm/radeon_drv.h b/drivers/char/drm/radeon_drv.h
--- a/drivers/char/drm/radeon_drv.h	Fri Sep  3 20:29:48 2004
+++ b/drivers/char/drm/radeon_drv.h	Fri Sep  3 20:29:48 2004
@@ -138,7 +138,6 @@
 	drm_local_map_t *mmio;
 	drm_local_map_t *cp_ring;
 	drm_local_map_t *ring_rptr;
-	drm_local_map_t *buffers;
 	drm_local_map_t *gart_textures;

 	struct mem_block *gart_heap;
diff -Nru a/drivers/char/drm/radeon_state.c b/drivers/char/drm/radeon_state.c
--- a/drivers/char/drm/radeon_state.c	Fri Sep  3 20:29:48 2004
+++ b/drivers/char/drm/radeon_state.c	Fri Sep  3 20:29:48 2004
@@ -1247,7 +1247,7 @@
 		 */
 		if ( dwords & 1 ) {
 			u32 *data = (u32 *)
-				((char *)dev_priv->buffers->handle
+				((char *)dev->agp_buffer_map->handle
 				 + buf->offset + start);
 			data[dwords++] = RADEON_CP_PACKET2;
 		}
@@ -1301,7 +1301,7 @@

 	dwords = (prim->finish - prim->start + 3) / sizeof(u32);

-	data = (u32 *)((char *)dev_priv->buffers->handle +
+	data = (u32 *)((char *)dev->agp_buffer_map->handle +
 		       elt_buf->offset + prim->start);

 	data[0] = CP_PACKET3( RADEON_3D_RNDR_GEN_INDX_PRIM, dwords-2 );
@@ -1445,7 +1445,7 @@

 		/* Dispatch the indirect buffer.
 		 */
-		buffer = (u32*)((char*)dev_priv->buffers->handle + buf->offset);
+		buffer = (u32*)((char*)dev->agp_buffer_map->handle + buf->offset);
 		dwords = size / 4;
 		buffer[0] = CP_PACKET3( RADEON_CNTL_HOSTDATA_BLT, dwords + 6 );
 		buffer[1] = (RADEON_GMC_DST_PITCH_OFFSET_CNTL |
@@ -2546,4 +2546,44 @@
 	}

 	return 0;
+}
+
+/* When a client dies:
+ *    - Check for and clean up flipped page state
+ *    - Free any alloced GART memory.
+ *
+ * DRM infrastructure takes care of reclaiming dma buffers.
+ */
+static void radeon_driver_prerelease(drm_device_t *dev, DRMFILE filp)
+{
+	if ( dev->dev_private ) {
+		drm_radeon_private_t *dev_priv = dev->dev_private;
+		if ( dev_priv->page_flipping ) {
+			radeon_do_cleanup_pageflip( dev );
+		}
+		radeon_mem_release( filp, dev_priv->gart_heap );
+		radeon_mem_release( filp, dev_priv->fb_heap );
+	}
+}
+
+static void radeon_driver_pretakedown(drm_device_t *dev)
+{
+	radeon_do_release(dev);
+}
+
+static void radeon_driver_open_helper(drm_device_t *dev, drm_file_t *filp_priv)
+{
+	drm_radeon_private_t *dev_priv = dev->dev_private;
+	if ( dev_priv )
+		filp_priv->radeon_fb_delta = dev_priv->fb_location;
+	else
+		filp_priv->radeon_fb_delta = 0;
+}
+
+void radeon_driver_register_fns(struct drm_device *dev)
+{
+	dev->dev_priv_size = sizeof(drm_radeon_buf_priv_t);
+	dev->fn_tbl.prerelease = radeon_driver_prerelease;
+	dev->fn_tbl.pretakedown = radeon_driver_pretakedown;
+	dev->fn_tbl.open_helper = radeon_driver_open_helper;
 }
diff -Nru a/drivers/char/drm/sis.h b/drivers/char/drm/sis.h
--- a/drivers/char/drm/sis.h	Fri Sep  3 20:29:48 2004
+++ b/drivers/char/drm/sis.h	Fri Sep  3 20:29:48 2004
@@ -64,15 +64,4 @@

 #define __HAVE_COUNTERS		5

-/* Buffer customization:
- */
-#define DRIVER_AGP_BUFFERS_MAP( dev )					\
-	((drm_sis_private_t *)((dev)->dev_private))->buffers
-
-extern int sis_init_context(int context);
-extern int sis_final_context(int context);
-
-#define DRIVER_CTX_CTOR sis_init_context
-#define DRIVER_CTX_DTOR sis_final_context
-
 #endif
diff -Nru a/drivers/char/drm/sis_drv.c b/drivers/char/drm/sis_drv.c
--- a/drivers/char/drm/sis_drv.c	Fri Sep  3 20:29:48 2004
+++ b/drivers/char/drm/sis_drv.c	Fri Sep  3 20:29:48 2004
@@ -46,3 +46,4 @@
 #include "drm_proc.h"
 #include "drm_vm.h"
 #include "drm_stub.h"
+
diff -Nru a/drivers/char/drm/sis_drv.h b/drivers/char/drm/sis_drv.h
--- a/drivers/char/drm/sis_drv.h	Fri Sep  3 20:29:48 2004
+++ b/drivers/char/drm/sis_drv.h	Fri Sep  3 20:29:48 2004
@@ -31,8 +31,6 @@
 #include "sis_ds.h"

 typedef struct drm_sis_private {
-	drm_map_t *buffers;
-
 	memHeap_t *AGPHeap;
 	memHeap_t *FBHeap;
 } drm_sis_private_t;
diff -Nru a/drivers/char/drm/sis_mm.c b/drivers/char/drm/sis_mm.c
--- a/drivers/char/drm/sis_mm.c	Fri Sep  3 20:29:48 2004
+++ b/drivers/char/drm/sis_mm.c	Fri Sep  3 20:29:48 2004
@@ -326,7 +326,7 @@
 	return 0;
 }

-int sis_init_context(int context)
+int sis_init_context(struct drm_device *dev, int context)
 {
 	int i;

@@ -358,7 +358,7 @@
 	return 1;
 }

-int sis_final_context(int context)
+int sis_final_context(struct drm_device *dev, int context)
 {
 	int i;

@@ -403,4 +403,10 @@
         }

 	return 1;
+}
+
+void DRM(driver_register_fns)(drm_device_t *dev)
+{
+	dev->fn_tbl.context_ctor = sis_init_context;
+	dev->fn_tbl.context_dtor = sis_final_context;
 }
diff -Nru a/drivers/char/drm/tdfx_drv.c b/drivers/char/drm/tdfx_drv.c
--- a/drivers/char/drm/tdfx_drv.c	Fri Sep  3 20:29:48 2004
+++ b/drivers/char/drm/tdfx_drv.c	Fri Sep  3 20:29:48 2004
@@ -49,3 +49,8 @@
 #include "drm_proc.h"
 #include "drm_vm.h"
 #include "drm_stub.h"
+
+void DRM(driver_register_fns)(drm_device_t *dev)
+{
+}
+
