Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261869AbVAaAl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbVAaAl0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jan 2005 19:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261872AbVAaAl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jan 2005 19:41:26 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:1547 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261869AbVAaAgx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jan 2005 19:36:53 -0500
Date: Mon, 31 Jan 2005 01:36:50 +0100
From: Adrian Bunk <bunk@stusta.de>
To: dri-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] DRM: misc cleanup
Message-ID: <20050131003650.GB7103@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following cleanups:
- make needlessly global functions static
- remove the following unused global functions:
  - drm_fops.c: drm_read
  - i810_dma.c: i810_do_cleanup_pageflip
  - i830_dma.c: i830_do_cleanup_pageflip
  - i915_dma.c: i915_do_cleanup_pageflip
  - mga_dma.c: mga_do_dma_idle
  - mga_dma.c: mga_do_engine_reset
  - radeon_irq.c: radeon_emit_and_wait_irq
  - sis_ds.c: mmAddRange
  - sis_ds.c: mmReserveMem
  - sis_ds.c: mmFreeReserved
  - sis_ds.c: mmDestroy
  - via_ds.c: via_mmDumpMemInfo
  - via_ds.c: via_mmAddRange
  - via_ds.c: via_mmReserveMem
  - via_ds.c: via_mmFreeReserved
  - via_ds.c: via_mmDestroy
- remove the followig unused global variable:
  - via_mm.c: VIA_DEBUG


Signed-off-by: Adrian Bunk <bunk@stusta.de>


---

 drivers/char/drm/ati_pcigart.c  |    2 
 drivers/char/drm/drmP.h         |   21 ----
 drivers/char/drm/drm_auth.c     |    4 
 drivers/char/drm/drm_bufs.c     |   12 +-
 drivers/char/drm/drm_context.c  |    6 -
 drivers/char/drm/drm_drv.c      |    9 +-
 drivers/char/drm/drm_fops.c     |   10 --
 drivers/char/drm/drm_irq.c      |    2 
 drivers/char/drm/drm_lock.c     |   12 ++
 drivers/char/drm/drm_proc.c     |    2 
 drivers/char/drm/drm_vm.c       |   10 +-
 drivers/char/drm/i810_dma.c     |  141 ++++++++++++++------------------
 drivers/char/drm/i810_drv.h     |   45 ----------
 drivers/char/drm/i830_dma.c     |  126 ++++++++++++----------------
 drivers/char/drm/i830_drv.c     |    2 
 drivers/char/drm/i830_drv.h     |   37 --------
 drivers/char/drm/i830_irq.c     |    4 
 drivers/char/drm/i915_dma.c     |   60 +++++--------
 drivers/char/drm/i915_drv.c     |    2 
 drivers/char/drm/i915_drv.h     |   10 --
 drivers/char/drm/i915_irq.c     |    4 
 drivers/char/drm/mga_dma.c      |   61 -------------
 drivers/char/drm/mga_drv.h      |   13 --
 drivers/char/drm/mga_state.c    |   45 +++++-----
 drivers/char/drm/r128_cce.c     |    4 
 drivers/char/drm/r128_drv.h     |   16 ---
 drivers/char/drm/r128_state.c   |   66 +++++++-------
 drivers/char/drm/radeon_cp.c    |    5 -
 drivers/char/drm/radeon_drv.h   |   24 -----
 drivers/char/drm/radeon_irq.c   |    9 --
 drivers/char/drm/radeon_state.c |   94 ++++++++++-----------
 drivers/char/drm/sis_drv.h      |    7 -
 drivers/char/drm/sis_ds.c       |   84 -------------------
 drivers/char/drm/sis_ds.h       |   22 ----
 drivers/char/drm/sis_mm.c       |   41 ++++-----
 drivers/char/drm/via_dma.c      |    4 
 drivers/char/drm/via_drv.h      |    2 
 drivers/char/drm/via_ds.c       |  108 ------------------------
 drivers/char/drm/via_ds.h       |    8 -
 drivers/char/drm/via_map.c      |    2 
 drivers/char/drm/via_mm.c       |   13 +-
 drivers/char/drm/via_mm.h       |    5 -
 42 files changed, 335 insertions(+), 819 deletions(-)

--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/ati_pcigart.c.old	2005-01-31 00:12:08.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/ati_pcigart.c	2005-01-31 00:12:20.000000000 +0100
@@ -52,7 +52,7 @@
 # define ATI_MAX_PCIGART_PAGES		8192	/**< 32 MB aperture, 4K pages */
 # define ATI_PCIGART_PAGE_SIZE		4096	/**< PCI GART page size */
 
-unsigned long drm_ati_alloc_pcigart_table( void )
+static unsigned long drm_ati_alloc_pcigart_table( void )
 {
 	unsigned long address;
 	struct page *page;
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/drmP.h.old	2005-01-31 00:12:35.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/drmP.h	2005-01-31 00:22:34.000000000 +0100
@@ -767,8 +767,6 @@
 				/* Driver support (drm_drv.h) */
 extern int           drm_init(struct drm_driver *driver);
 extern void          drm_exit(struct drm_driver *driver);
-extern int           drm_version(struct inode *inode, struct file *filp,
-				  unsigned int cmd, unsigned long arg);
 extern int           drm_ioctl(struct inode *inode, struct file *filp,
 				unsigned int cmd, unsigned long arg);
 extern int           drm_takedown(drm_device_t * dev);
@@ -776,21 +774,13 @@
 				/* Device support (drm_fops.h) */
 extern int           drm_open(struct inode *inode, struct file *filp);
 extern int           drm_stub_open(struct inode *inode, struct file *filp);
-extern int	     drm_open_helper(struct inode *inode, struct file *filp,
-				      drm_device_t *dev);
 extern int	     drm_flush(struct file *filp);
 extern int	     drm_fasync(int fd, struct file *filp, int on);
 extern int           drm_release(struct inode *inode, struct file *filp);
 
 				/* Mapping support (drm_vm.h) */
-extern void	     drm_vm_open(struct vm_area_struct *vma);
-extern void	     drm_vm_close(struct vm_area_struct *vma);
-extern void	     drm_vm_shm_close(struct vm_area_struct *vma);
-extern int	     drm_mmap_dma(struct file *filp,
-				   struct vm_area_struct *vma);
 extern int	     drm_mmap(struct file *filp, struct vm_area_struct *vma);
 extern unsigned int  drm_poll(struct file *filp, struct poll_table_struct *wait);
-extern ssize_t       drm_read(struct file *filp, char __user *buf, size_t count, loff_t *off);
 
 				/* Memory management support (drm_memory.h) */
 #include "drm_memory.h"
@@ -845,9 +835,6 @@
 extern int	     drm_rmctx( struct inode *inode, struct file *filp,
 				 unsigned int cmd, unsigned long arg );
 
-extern int	     drm_context_switch(drm_device_t *dev, int old, int new);
-extern int	     drm_context_switch_complete(drm_device_t *dev, int new);
-
 extern int	     drm_ctxbitmap_init( drm_device_t *dev );
 extern void	     drm_ctxbitmap_cleanup( drm_device_t *dev );
 extern void          drm_ctxbitmap_free( drm_device_t *dev, int ctx_handle );
@@ -865,9 +852,6 @@
 
 
 				/* Authentication IOCTL support (drm_auth.h) */
-extern int	     drm_add_magic(drm_device_t *dev, drm_file_t *priv,
-				    drm_magic_t magic);
-extern int	     drm_remove_magic(drm_device_t *dev, drm_magic_t magic);
 extern int	     drm_getmagic(struct inode *inode, struct file *filp,
 				   unsigned int cmd, unsigned long arg);
 extern int	     drm_authmagic(struct inode *inode, struct file *filp,
@@ -884,13 +868,9 @@
 				 unsigned int cmd, unsigned long arg);
 extern int	     drm_lock_take(__volatile__ unsigned int *lock,
 				    unsigned int context);
-extern int	     drm_lock_transfer(drm_device_t *dev,
-					__volatile__ unsigned int *lock,
-					unsigned int context);
 extern int	     drm_lock_free(drm_device_t *dev,
 				    __volatile__ unsigned int *lock,
 				    unsigned int context);
-extern int           drm_notifier(void *priv);
 
 				/* Buffer management support (drm_bufs.h) */
 extern int	     drm_order( unsigned long size );
@@ -918,7 +898,6 @@
 				/* IRQ support (drm_irq.h) */
 extern int           drm_control( struct inode *inode, struct file *filp,
 				   unsigned int cmd, unsigned long arg );
-extern int           drm_irq_install( drm_device_t *dev );
 extern int           drm_irq_uninstall( drm_device_t *dev );
 extern irqreturn_t   drm_irq_handler( DRM_IRQ_ARGS );
 extern void          drm_driver_irq_preinstall( drm_device_t *dev );
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/drm_auth.c.old	2005-01-31 00:12:54.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/drm_auth.c	2005-01-31 00:13:16.000000000 +0100
@@ -87,7 +87,7 @@
  * associated the magic number hash key in drm_device::magiclist, while holding
  * the drm_device::struct_sem lock.
  */
-int drm_add_magic(drm_device_t *dev, drm_file_t *priv, drm_magic_t magic)
+static int drm_add_magic(drm_device_t *dev, drm_file_t *priv, drm_magic_t magic)
 {
 	int		  hash;
 	drm_magic_entry_t *entry;
@@ -124,7 +124,7 @@
  * Searches and unlinks the entry in drm_device::magiclist with the magic
  * number hash key, while holding the drm_device::struct_sem lock.
  */
-int drm_remove_magic(drm_device_t *dev, drm_magic_t magic)
+static int drm_remove_magic(drm_device_t *dev, drm_magic_t magic)
 {
 	drm_magic_entry_t *prev = NULL;
 	drm_magic_entry_t *pt;
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/drm_bufs.c.old	2005-01-31 00:13:31.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/drm_bufs.c	2005-01-31 00:14:18.000000000 +0100
@@ -345,8 +345,8 @@
  * reallocates the buffer list of the same size order to accommodate the new
  * buffers.
  */
-int drm_addbufs_agp( struct inode *inode, struct file *filp,
-		      unsigned int cmd, unsigned long arg )
+static int drm_addbufs_agp( struct inode *inode, struct file *filp,
+			     unsigned int cmd, unsigned long arg )
 {
 	drm_file_t *priv = filp->private_data;
 	drm_device_t *dev = priv->dev;
@@ -510,8 +510,8 @@
 }
 #endif /* __OS_HAS_AGP */
 
-int drm_addbufs_pci( struct inode *inode, struct file *filp,
-		      unsigned int cmd, unsigned long arg )
+static int drm_addbufs_pci( struct inode *inode, struct file *filp,
+			     unsigned int cmd, unsigned long arg )
 {
    	drm_file_t *priv = filp->private_data;
 	drm_device_t *dev = priv->dev;
@@ -740,8 +740,8 @@
 
 }
 
-int drm_addbufs_sg( struct inode *inode, struct file *filp,
-                     unsigned int cmd, unsigned long arg )
+static int drm_addbufs_sg( struct inode *inode, struct file *filp,
+			    unsigned int cmd, unsigned long arg )
 {
 	drm_file_t *priv = filp->private_data;
 	drm_device_t *dev = priv->dev;
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/drm_context.c.old	2005-01-31 00:14:48.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/drm_context.c	2005-01-31 00:15:08.000000000 +0100
@@ -84,7 +84,7 @@
  * drm_device::context_sareas to accommodate the new entry while holding the
  * drm_device::struct_sem lock.
  */
-int drm_ctxbitmap_next( drm_device_t *dev )
+static int drm_ctxbitmap_next( drm_device_t *dev )
 {
 	int bit;
 
@@ -297,7 +297,7 @@
  *
  * Attempt to set drm_device::context_flag.
  */
-int drm_context_switch( drm_device_t *dev, int old, int new )
+static int drm_context_switch( drm_device_t *dev, int old, int new )
 {
         if ( test_and_set_bit( 0, &dev->context_flag ) ) {
                 DRM_ERROR( "Reentering -- FIXME\n" );
@@ -326,7 +326,7 @@
  * hardware lock is held, clears the drm_device::context_flag and wakes up
  * drm_device::context_wait.
  */
-int drm_context_switch_complete( drm_device_t *dev, int new )
+static int drm_context_switch_complete( drm_device_t *dev, int new )
 {
         dev->last_context = new;  /* PRE/POST: This is the _only_ writer. */
         dev->last_switch  = jiffies;
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/drm_drv.c.old	2005-01-31 00:15:26.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/drm_drv.c	2005-01-31 00:16:58.000000000 +0100
@@ -55,8 +55,11 @@
 #include "drmP.h"
 #include "drm_core.h"
 
+static int drm_version( struct inode *inode, struct file *filp,
+			 unsigned int cmd, unsigned long arg );
+
 /** Ioctl table */
-drm_ioctl_desc_t		  drm_ioctls[] = {
+static drm_ioctl_desc_t		  drm_ioctls[] = {
 	[DRM_IOCTL_NR(DRM_IOCTL_VERSION)]       = { drm_version,     0, 0 },
 	[DRM_IOCTL_NR(DRM_IOCTL_GET_UNIQUE)]    = { drm_getunique,   0, 0 },
 	[DRM_IOCTL_NR(DRM_IOCTL_GET_MAGIC)]     = { drm_getmagic,    0, 0 },
@@ -461,8 +464,8 @@
  *
  * Fills in the version information in \p arg.
  */
-int drm_version( struct inode *inode, struct file *filp,
-		  unsigned int cmd, unsigned long arg )
+static int drm_version( struct inode *inode, struct file *filp,
+			 unsigned int cmd, unsigned long arg )
 {
 	drm_file_t *priv = filp->private_data;
 	drm_device_t *dev = priv->dev;
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/drm_fops.c.old	2005-01-31 00:17:23.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/drm_fops.c	2005-01-31 00:18:35.000000000 +0100
@@ -37,6 +37,8 @@
 #include "drmP.h"
 #include <linux/poll.h>
 
+static int drm_open_helper(struct inode *inode, struct file *filp, drm_device_t *dev);
+
 static int drm_setup( drm_device_t *dev )
 {
 	int i;
@@ -339,7 +341,7 @@
  * Creates and initializes a drm_file structure for the file private data in \p
  * filp and add it into the double linked list in \p dev.
  */
-int drm_open_helper(struct inode *inode, struct file *filp, drm_device_t *dev)
+static int drm_open_helper(struct inode *inode, struct file *filp, drm_device_t *dev)
 {
 	int	     minor = iminor(inode);
 	drm_file_t   *priv;
@@ -441,9 +443,3 @@
 }
 EXPORT_SYMBOL(drm_poll);
 
-
-/** No-op. */
-ssize_t drm_read(struct file *filp, char __user *buf, size_t count, loff_t *off)
-{
-	return 0;
-}
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/drm_irq.c.old	2005-01-31 00:18:56.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/drm_irq.c	2005-01-31 00:19:03.000000000 +0100
@@ -89,7 +89,7 @@
  * \c drm_driver_irq_preinstall() and \c drm_driver_irq_postinstall() functions
  * before and after the installation.
  */
-int drm_irq_install( drm_device_t *dev )
+static int drm_irq_install( drm_device_t *dev )
 {
 	int ret;
 	unsigned long sh_flags=0;
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/drm_lock.c.old	2005-01-31 00:19:29.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/drm_lock.c	2005-01-31 01:28:35.000000000 +0100
@@ -35,6 +35,11 @@
 
 #include "drmP.h"
 
+static int drm_lock_transfer(drm_device_t *dev,
+			     __volatile__ unsigned int *lock,
+			     unsigned int context);
+static int drm_notifier(void *priv);
+
 /** 
  * Lock ioctl.
  *
@@ -225,8 +230,9 @@
  * Resets the lock file pointer.
  * Marks the lock as held by the given context, via the \p cmpxchg instruction.
  */
-int drm_lock_transfer(drm_device_t *dev,
-		       __volatile__ unsigned int *lock, unsigned int context)
+static int drm_lock_transfer(drm_device_t *dev,
+			     __volatile__ unsigned int *lock,
+			     unsigned int context)
 {
 	unsigned int old, new, prev;
 
@@ -282,7 +288,7 @@
  * \return one if the signal should be delivered normally, or zero if the
  * signal should be blocked.
  */
-int drm_notifier(void *priv)
+static int drm_notifier(void *priv)
 {
 	drm_sigdata_t *s = (drm_sigdata_t *)priv;
 	unsigned int  old, new, prev;
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/drm_proc.c.old	2005-01-31 00:20:47.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/drm_proc.c	2005-01-31 00:20:56.000000000 +0100
@@ -57,7 +57,7 @@
 /**
  * Proc file list.
  */
-struct drm_proc_list {
+static struct drm_proc_list {
 	const char *name;	/**< file name */
 	int	   (*f)(char *, char **, off_t, int, int *, void *);	/**< proc callback*/
 } drm_proc_list[] = {
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/drm_vm.c.old	2005-01-31 00:21:17.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/drm_vm.c	2005-01-31 00:22:39.000000000 +0100
@@ -38,6 +38,8 @@
 #include <linux/efi.h>
 #endif
 
+static void drm_vm_close(struct vm_area_struct *vma);
+static void drm_vm_open(struct vm_area_struct *vma);
 
 /**
  * \c nopage method for AGP virtual memory.
@@ -163,7 +165,7 @@
  * Deletes map information if we are the last
  * person to close a mapping and it's not in the global maplist.
  */
-void drm_vm_shm_close(struct vm_area_struct *vma)
+static void drm_vm_shm_close(struct vm_area_struct *vma)
 {
 	drm_file_t	*priv	= vma->vm_file->private_data;
 	drm_device_t	*dev	= priv->dev;
@@ -399,7 +401,7 @@
  * Create a new drm_vma_entry structure as the \p vma private data entry and
  * add it to drm_device::vmalist.
  */
-void drm_vm_open(struct vm_area_struct *vma)
+static void drm_vm_open(struct vm_area_struct *vma)
 {
 	drm_file_t	*priv	= vma->vm_file->private_data;
 	drm_device_t	*dev	= priv->dev;
@@ -428,7 +430,7 @@
  * Search the \p vma private data entry in drm_device::vmalist, unlink it, and
  * free it.
  */
-void drm_vm_close(struct vm_area_struct *vma)
+static void drm_vm_close(struct vm_area_struct *vma)
 {
 	drm_file_t	*priv	= vma->vm_file->private_data;
 	drm_device_t	*dev	= priv->dev;
@@ -463,7 +465,7 @@
  * Sets the virtual memory area operations structure to vm_dma_ops, the file
  * pointer, and calls vm_open().
  */
-int drm_mmap_dma(struct file *filp, struct vm_area_struct *vma)
+static int drm_mmap_dma(struct file *filp, struct vm_area_struct *vma)
 {
 	drm_file_t	 *priv	 = filp->private_data;
 	drm_device_t	 *dev;
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/i810_drv.h.old	2005-01-31 00:22:56.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/i810_drv.h	2005-01-31 00:33:25.000000000 +0100
@@ -114,53 +114,8 @@
 } drm_i810_private_t;
 
 				/* i810_dma.c */
-extern int  i810_dma_schedule(drm_device_t *dev, int locked);
-extern int  i810_getbuf(struct inode *inode, struct file *filp,
-			unsigned int cmd, unsigned long arg);
-extern int  i810_dma_init(struct inode *inode, struct file *filp,
-			  unsigned int cmd, unsigned long arg);
-extern int  i810_dma_cleanup(drm_device_t *dev);
-extern int  i810_flush_ioctl(struct inode *inode, struct file *filp,
-			     unsigned int cmd, unsigned long arg);
 extern void i810_reclaim_buffers(drm_device_t *dev, struct file *filp);
-extern int  i810_getage(struct inode *inode, struct file *filp,
-			unsigned int cmd, unsigned long arg);
-extern int i810_mmap_buffers(struct file *filp, struct vm_area_struct *vma);
-
-/* Obsolete:
- */
-extern int i810_copybuf(struct inode *inode, struct file *filp,
-			unsigned int cmd, unsigned long arg);
-/* Obsolete:
- */
-extern int i810_docopy(struct inode *inode, struct file *filp,
-		       unsigned int cmd, unsigned long arg);
-
-extern int i810_rstatus(struct inode *inode, struct file *filp,
-			unsigned int cmd, unsigned long arg);
-extern int i810_ov0_info(struct inode *inode, struct file *filp,
-			unsigned int cmd, unsigned long arg);
-extern int i810_fstatus(struct inode *inode, struct file *filp,
-			unsigned int cmd, unsigned long arg);
-extern int i810_ov0_flip(struct inode *inode, struct file *filp,
-			unsigned int cmd, unsigned long arg);
-extern int i810_dma_mc(struct inode *inode, struct file *filp,
-			unsigned int cmd, unsigned long arg);
-
-
-extern void i810_dma_quiescent(drm_device_t *dev);
-
-extern int i810_dma_vertex(struct inode *inode, struct file *filp,
-		    unsigned int cmd, unsigned long arg);
 
-extern int i810_swap_bufs(struct inode *inode, struct file *filp,
-		   unsigned int cmd, unsigned long arg);
-
-extern int i810_clear_bufs(struct inode *inode, struct file *filp,
-		    unsigned int cmd, unsigned long arg);
-
-extern int i810_flip_bufs(struct inode *inode, struct file *filp,
-		   unsigned int cmd, unsigned long arg);
 
 extern int i810_driver_dma_quiescent(drm_device_t *dev);
 extern void i810_driver_release(drm_device_t *dev, struct file *filp);
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/i810_dma.c.old	2005-01-31 00:23:10.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/i810_dma.c	2005-01-31 00:33:33.000000000 +0100
@@ -50,26 +50,6 @@
 #define up_write up
 #endif
 
-drm_ioctl_desc_t i810_ioctls[] = {
-	[DRM_IOCTL_NR(DRM_I810_INIT)]    = { i810_dma_init,    1, 1 },
-	[DRM_IOCTL_NR(DRM_I810_VERTEX)]  = { i810_dma_vertex,  1, 0 },
-	[DRM_IOCTL_NR(DRM_I810_CLEAR)]   = { i810_clear_bufs,  1, 0 },
-	[DRM_IOCTL_NR(DRM_I810_FLUSH)]   = { i810_flush_ioctl, 1, 0 },
-	[DRM_IOCTL_NR(DRM_I810_GETAGE)]  = { i810_getage,      1, 0 },
-	[DRM_IOCTL_NR(DRM_I810_GETBUF)]  = { i810_getbuf,      1, 0 },
-	[DRM_IOCTL_NR(DRM_I810_SWAP)]    = { i810_swap_bufs,   1, 0 },
-	[DRM_IOCTL_NR(DRM_I810_COPY)]    = { i810_copybuf,     1, 0 },
-	[DRM_IOCTL_NR(DRM_I810_DOCOPY)]  = { i810_docopy,      1, 0 },
-	[DRM_IOCTL_NR(DRM_I810_OV0INFO)] = { i810_ov0_info,    1, 0 },
-	[DRM_IOCTL_NR(DRM_I810_FSTATUS)] = { i810_fstatus,     1, 0 },
-	[DRM_IOCTL_NR(DRM_I810_OV0FLIP)] = { i810_ov0_flip,    1, 0 },
-	[DRM_IOCTL_NR(DRM_I810_MC)]      = { i810_dma_mc,      1, 1 },
-	[DRM_IOCTL_NR(DRM_I810_RSTATUS)] = { i810_rstatus,     1, 0 },
-	[DRM_IOCTL_NR(DRM_I810_FLIP)]    = { i810_flip_bufs,   1, 0 }
-};
-
-int i810_max_ioctl = DRM_ARRAY_SIZE(i810_ioctls);
-
 static drm_buf_t *i810_freelist_get(drm_device_t *dev)
 {
    	drm_device_dma_t *dma = dev->dma;
@@ -110,16 +90,7 @@
    	return 0;
 }
 
-static struct file_operations i810_buffer_fops = {
-	.open	 = drm_open,
-	.flush	 = drm_flush,
-	.release = drm_release,
-	.ioctl	 = drm_ioctl,
-	.mmap	 = i810_mmap_buffers,
-	.fasync  = drm_fasync,
-};
-
-int i810_mmap_buffers(struct file *filp, struct vm_area_struct *vma)
+static int i810_mmap_buffers(struct file *filp, struct vm_area_struct *vma)
 {
 	drm_file_t	    *priv	  = filp->private_data;
 	drm_device_t	    *dev;
@@ -146,6 +117,15 @@
 	return 0;
 }
 
+static struct file_operations i810_buffer_fops = {
+	.open	 = drm_open,
+	.flush	 = drm_flush,
+	.release = drm_release,
+	.ioctl	 = drm_ioctl,
+	.mmap	 = i810_mmap_buffers,
+	.fasync  = drm_fasync,
+};
+
 static int i810_map_buffer(drm_buf_t *buf, struct file *filp)
 {
 	drm_file_t	  *priv	  = filp->private_data;
@@ -229,7 +209,7 @@
 	return retcode;
 }
 
-int i810_dma_cleanup(drm_device_t *dev)
+static int i810_dma_cleanup(drm_device_t *dev)
 {
 	drm_device_dma_t *dma = dev->dma;
 
@@ -455,7 +435,7 @@
  *    If it isn't then we have a v1.1 client. Fix up params.
  *    If it is, then we have a 1.2 client... get the rest of the data.
  */
-int i810_dma_init_compat(drm_i810_init_t *init, unsigned long arg)
+static int i810_dma_init_compat(drm_i810_init_t *init, unsigned long arg)
 {
 
 	/* Get v1.1 init data */
@@ -487,8 +467,8 @@
 	return 0;
 }
 
-int i810_dma_init(struct inode *inode, struct file *filp,
-		  unsigned int cmd, unsigned long arg)
+static int i810_dma_init(struct inode *inode, struct file *filp,
+			 unsigned int cmd, unsigned long arg)
 {
    	drm_file_t *priv = filp->private_data;
    	drm_device_t *dev = priv->dev;
@@ -942,7 +922,7 @@
 
 }
 
-void i810_dma_quiescent(drm_device_t *dev)
+static void i810_dma_quiescent(drm_device_t *dev)
 {
       	drm_i810_private_t *dev_priv = dev->dev_private;
    	RING_LOCALS;
@@ -1023,8 +1003,8 @@
 	}
 }
 
-int i810_flush_ioctl(struct inode *inode, struct file *filp,
-		     unsigned int cmd, unsigned long arg)
+static int i810_flush_ioctl(struct inode *inode, struct file *filp,
+			    unsigned int cmd, unsigned long arg)
 {
    	drm_file_t	  *priv	  = filp->private_data;
    	drm_device_t	  *dev	  = priv->dev;
@@ -1036,8 +1016,8 @@
 }
 
 
-int i810_dma_vertex(struct inode *inode, struct file *filp,
-	       unsigned int cmd, unsigned long arg)
+static int i810_dma_vertex(struct inode *inode, struct file *filp,
+			   unsigned int cmd, unsigned long arg)
 {
 	drm_file_t *priv = filp->private_data;
 	drm_device_t *dev = priv->dev;
@@ -1073,8 +1053,8 @@
 
 
 
-int i810_clear_bufs(struct inode *inode, struct file *filp,
-		   unsigned int cmd, unsigned long arg)
+static int i810_clear_bufs(struct inode *inode, struct file *filp,
+			   unsigned int cmd, unsigned long arg)
 {
 	drm_file_t *priv = filp->private_data;
 	drm_device_t *dev = priv->dev;
@@ -1096,8 +1076,8 @@
    	return 0;
 }
 
-int i810_swap_bufs(struct inode *inode, struct file *filp,
-		  unsigned int cmd, unsigned long arg)
+static int i810_swap_bufs(struct inode *inode, struct file *filp,
+			  unsigned int cmd, unsigned long arg)
 {
 	drm_file_t *priv = filp->private_data;
 	drm_device_t *dev = priv->dev;
@@ -1110,8 +1090,8 @@
    	return 0;
 }
 
-int i810_getage(struct inode *inode, struct file *filp, unsigned int cmd,
-		unsigned long arg)
+static int i810_getage(struct inode *inode, struct file *filp, unsigned int cmd,
+		       unsigned long arg)
 {
    	drm_file_t	  *priv	    = filp->private_data;
 	drm_device_t	  *dev	    = priv->dev;
@@ -1124,8 +1104,8 @@
 	return 0;
 }
 
-int i810_getbuf(struct inode *inode, struct file *filp, unsigned int cmd,
-		unsigned long arg)
+static int i810_getbuf(struct inode *inode, struct file *filp, unsigned int cmd,
+		       unsigned long arg)
 {
 	drm_file_t	  *priv	    = filp->private_data;
 	drm_device_t	  *dev	    = priv->dev;
@@ -1155,17 +1135,17 @@
 	return retcode;
 }
 
-int i810_copybuf(struct inode *inode,
-		 struct file *filp, 
-		 unsigned int cmd,
-		 unsigned long arg)
+static int i810_copybuf(struct inode *inode,
+			struct file *filp, 
+			unsigned int cmd,
+			unsigned long arg)
 {
 	/* Never copy - 2.4.x doesn't need it */
 	return 0;
 }
 
-int i810_docopy(struct inode *inode, struct file *filp, unsigned int cmd,
-		unsigned long arg)
+static int i810_docopy(struct inode *inode, struct file *filp, unsigned int cmd,
+		       unsigned long arg)
 {
 	/* Never copy - 2.4.x doesn't need it */
 	return 0;
@@ -1234,8 +1214,8 @@
 	ADVANCE_LP_RING();
 }
 
-int i810_dma_mc(struct inode *inode, struct file *filp,
-	unsigned int cmd, unsigned long arg)
+static int i810_dma_mc(struct inode *inode, struct file *filp,
+		       unsigned int cmd, unsigned long arg)
 {
 	drm_file_t *priv = filp->private_data;
 	drm_device_t *dev = priv->dev;
@@ -1265,8 +1245,8 @@
 	return 0;
 }
 
-int i810_rstatus(struct inode *inode, struct file *filp,
-		unsigned int cmd, unsigned long arg)
+static int i810_rstatus(struct inode *inode, struct file *filp,
+			unsigned int cmd, unsigned long arg)
 {
 	drm_file_t *priv = filp->private_data;
 	drm_device_t *dev = priv->dev;
@@ -1275,8 +1255,8 @@
 	return (int)(((u32 *)(dev_priv->hw_status_page))[4]);
 }
 
-int i810_ov0_info(struct inode *inode, struct file *filp,
-		unsigned int cmd, unsigned long arg)
+static int i810_ov0_info(struct inode *inode, struct file *filp,
+			 unsigned int cmd, unsigned long arg)
 {
 	drm_file_t *priv = filp->private_data;
 	drm_device_t *dev = priv->dev;
@@ -1290,8 +1270,8 @@
 	return 0;
 }
 
-int i810_fstatus(struct inode *inode, struct file *filp,
-		unsigned int cmd, unsigned long arg)
+static int i810_fstatus(struct inode *inode, struct file *filp,
+			unsigned int cmd, unsigned long arg)
 {
 	drm_file_t *priv = filp->private_data;
 	drm_device_t *dev = priv->dev;
@@ -1302,8 +1282,8 @@
 	return I810_READ(0x30008);
 }
 
-int i810_ov0_flip(struct inode *inode, struct file *filp,
-		unsigned int cmd, unsigned long arg)
+static int i810_ov0_flip(struct inode *inode, struct file *filp,
+			 unsigned int cmd, unsigned long arg)
 {
 	drm_file_t *priv = filp->private_data;
 	drm_device_t *dev = priv->dev;
@@ -1330,20 +1310,8 @@
 	dev_priv->sarea_priv->pf_current_page = dev_priv->current_page;
 }
 
-int i810_do_cleanup_pageflip( drm_device_t *dev )
-{
-	drm_i810_private_t *dev_priv = dev->dev_private;
-
-	DRM_DEBUG("%s\n", __FUNCTION__);
-	if (dev_priv->current_page != 0)
-		i810_dma_dispatch_flip( dev );
-
-	dev_priv->page_flipping = 0;
-	return 0;
-}
-
-int i810_flip_bufs(struct inode *inode, struct file *filp,
-		   unsigned int cmd, unsigned long arg)
+static int i810_flip_bufs(struct inode *inode, struct file *filp,
+			  unsigned int cmd, unsigned long arg)
 {
 	drm_file_t *priv = filp->private_data;
 	drm_device_t *dev = priv->dev;
@@ -1377,3 +1345,22 @@
 }
 
 
+drm_ioctl_desc_t i810_ioctls[] = {
+	[DRM_IOCTL_NR(DRM_I810_INIT)]    = { i810_dma_init,    1, 1 },
+	[DRM_IOCTL_NR(DRM_I810_VERTEX)]  = { i810_dma_vertex,  1, 0 },
+	[DRM_IOCTL_NR(DRM_I810_CLEAR)]   = { i810_clear_bufs,  1, 0 },
+	[DRM_IOCTL_NR(DRM_I810_FLUSH)]   = { i810_flush_ioctl, 1, 0 },
+	[DRM_IOCTL_NR(DRM_I810_GETAGE)]  = { i810_getage,      1, 0 },
+	[DRM_IOCTL_NR(DRM_I810_GETBUF)]  = { i810_getbuf,      1, 0 },
+	[DRM_IOCTL_NR(DRM_I810_SWAP)]    = { i810_swap_bufs,   1, 0 },
+	[DRM_IOCTL_NR(DRM_I810_COPY)]    = { i810_copybuf,     1, 0 },
+	[DRM_IOCTL_NR(DRM_I810_DOCOPY)]  = { i810_docopy,      1, 0 },
+	[DRM_IOCTL_NR(DRM_I810_OV0INFO)] = { i810_ov0_info,    1, 0 },
+	[DRM_IOCTL_NR(DRM_I810_FSTATUS)] = { i810_fstatus,     1, 0 },
+	[DRM_IOCTL_NR(DRM_I810_OV0FLIP)] = { i810_ov0_flip,    1, 0 },
+	[DRM_IOCTL_NR(DRM_I810_MC)]      = { i810_dma_mc,      1, 1 },
+	[DRM_IOCTL_NR(DRM_I810_RSTATUS)] = { i810_rstatus,     1, 0 },
+	[DRM_IOCTL_NR(DRM_I810_FLIP)]    = { i810_flip_bufs,   1, 0 }
+};
+
+int i810_max_ioctl = DRM_ARRAY_SIZE(i810_ioctls);
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/i830_drv.h.old	2005-01-31 00:34:26.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/i830_drv.h	2005-01-31 00:49:08.000000000 +0100
@@ -121,50 +121,13 @@
 } drm_i830_private_t;
 
 				/* i830_dma.c */
-extern int  i830_dma_schedule(drm_device_t *dev, int locked);
-extern int  i830_getbuf(struct inode *inode, struct file *filp,
-			unsigned int cmd, unsigned long arg);
-extern int  i830_dma_init(struct inode *inode, struct file *filp,
-			  unsigned int cmd, unsigned long arg);
-extern int  i830_dma_cleanup(drm_device_t *dev);
-extern int  i830_flush_ioctl(struct inode *inode, struct file *filp,
-			     unsigned int cmd, unsigned long arg);
 extern void i830_reclaim_buffers(drm_device_t *dev, struct file *filp);
-extern int  i830_getage(struct inode *inode, struct file *filp, unsigned int cmd,
-			unsigned long arg);
-extern int i830_mmap_buffers(struct file *filp, struct vm_area_struct *vma);
-extern int i830_copybuf(struct inode *inode, struct file *filp, 
-			unsigned int cmd, unsigned long arg);
-extern int i830_docopy(struct inode *inode, struct file *filp, 
-		       unsigned int cmd, unsigned long arg);
-
-extern void i830_dma_quiescent(drm_device_t *dev);
-
-extern int i830_dma_vertex(struct inode *inode, struct file *filp,
-			  unsigned int cmd, unsigned long arg);
-
-extern int i830_swap_bufs(struct inode *inode, struct file *filp,
-			 unsigned int cmd, unsigned long arg);
-
-extern int i830_clear_bufs(struct inode *inode, struct file *filp,
-			  unsigned int cmd, unsigned long arg);
-
-extern int i830_flip_bufs(struct inode *inode, struct file *filp,
-			 unsigned int cmd, unsigned long arg);
-
-extern int i830_getparam( struct inode *inode, struct file *filp,
-			  unsigned int cmd, unsigned long arg );
-
-extern int i830_setparam( struct inode *inode, struct file *filp,
-			  unsigned int cmd, unsigned long arg );
 
 /* i830_irq.c */
 extern int i830_irq_emit( struct inode *inode, struct file *filp, 
 			  unsigned int cmd, unsigned long arg );
 extern int i830_irq_wait( struct inode *inode, struct file *filp,
 			  unsigned int cmd, unsigned long arg );
-extern int i830_wait_irq(drm_device_t *dev, int irq_nr);
-extern int i830_emit_irq(drm_device_t *dev);
 
 extern irqreturn_t i830_driver_irq_handler( DRM_IRQ_ARGS );
 extern void i830_driver_irq_preinstall( drm_device_t *dev );
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/i830_dma.c.old	2005-01-31 00:34:55.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/i830_dma.c	2005-01-31 00:46:40.000000000 +0100
@@ -52,25 +52,6 @@
 #define up_write up
 #endif
 
-drm_ioctl_desc_t i830_ioctls[] = {
-	[DRM_IOCTL_NR(DRM_I830_INIT)]     = { i830_dma_init,    1, 1 },
-	[DRM_IOCTL_NR(DRM_I830_VERTEX)]   = { i830_dma_vertex,  1, 0 },
-	[DRM_IOCTL_NR(DRM_I830_CLEAR)]    = { i830_clear_bufs,  1, 0 },
-	[DRM_IOCTL_NR(DRM_I830_FLUSH)]    = { i830_flush_ioctl, 1, 0 },
-	[DRM_IOCTL_NR(DRM_I830_GETAGE)]   = { i830_getage,      1, 0 },
-	[DRM_IOCTL_NR(DRM_I830_GETBUF)]   = { i830_getbuf,      1, 0 },
-	[DRM_IOCTL_NR(DRM_I830_SWAP)]     = { i830_swap_bufs,   1, 0 },
-	[DRM_IOCTL_NR(DRM_I830_COPY)]     = { i830_copybuf,     1, 0 },
-	[DRM_IOCTL_NR(DRM_I830_DOCOPY)]   = { i830_docopy,      1, 0 },
-	[DRM_IOCTL_NR(DRM_I830_FLIP)]     = { i830_flip_bufs,   1, 0 },
-	[DRM_IOCTL_NR(DRM_I830_IRQ_EMIT)] = { i830_irq_emit,    1, 0 },
-	[DRM_IOCTL_NR(DRM_I830_IRQ_WAIT)] = { i830_irq_wait,    1, 0 },
-	[DRM_IOCTL_NR(DRM_I830_GETPARAM)] = { i830_getparam,    1, 0 },
-	[DRM_IOCTL_NR(DRM_I830_SETPARAM)] = { i830_setparam,    1, 0 } 
-};
-
-int i830_max_ioctl = DRM_ARRAY_SIZE(i830_ioctls);
-
 static inline void i830_print_status_page(drm_device_t *dev)
 {
    	drm_device_dma_t *dma = dev->dma;
@@ -128,16 +109,7 @@
    	return 0;
 }
 
-static struct file_operations i830_buffer_fops = {
-	.open	 = drm_open,
-	.flush	 = drm_flush,
-	.release = drm_release,
-	.ioctl	 = drm_ioctl,
-	.mmap	 = i830_mmap_buffers,
-	.fasync  = drm_fasync,
-};
-
-int i830_mmap_buffers(struct file *filp, struct vm_area_struct *vma)
+static int i830_mmap_buffers(struct file *filp, struct vm_area_struct *vma)
 {
 	drm_file_t	    *priv	  = filp->private_data;
 	drm_device_t	    *dev;
@@ -164,6 +136,15 @@
 	return 0;
 }
 
+static struct file_operations i830_buffer_fops = {
+	.open	 = drm_open,
+	.flush	 = drm_flush,
+	.release = drm_release,
+	.ioctl	 = drm_ioctl,
+	.mmap	 = i830_mmap_buffers,
+	.fasync  = drm_fasync,
+};
+
 static int i830_map_buffer(drm_buf_t *buf, struct file *filp)
 {
 	drm_file_t	  *priv	  = filp->private_data;
@@ -247,7 +228,7 @@
 	return retcode;
 }
 
-int i830_dma_cleanup(drm_device_t *dev)
+static int i830_dma_cleanup(drm_device_t *dev)
 {
 	drm_device_dma_t *dma = dev->dma;
 
@@ -479,8 +460,8 @@
    	return 0;
 }
 
-int i830_dma_init(struct inode *inode, struct file *filp,
-		  unsigned int cmd, unsigned long arg)
+static int i830_dma_init(struct inode *inode, struct file *filp,
+			 unsigned int cmd, unsigned long arg)
 {
    	drm_file_t *priv = filp->private_data;
    	drm_device_t *dev = priv->dev;
@@ -1252,7 +1233,7 @@
 }
 
 
-void i830_dma_quiescent(drm_device_t *dev)
+static void i830_dma_quiescent(drm_device_t *dev)
 {
       	drm_i830_private_t *dev_priv = dev->dev_private;
    	RING_LOCALS;
@@ -1329,8 +1310,8 @@
 	}
 }
 
-int i830_flush_ioctl(struct inode *inode, struct file *filp, 
-		     unsigned int cmd, unsigned long arg)
+static int i830_flush_ioctl(struct inode *inode, struct file *filp, 
+			    unsigned int cmd, unsigned long arg)
 {
    	drm_file_t	  *priv	  = filp->private_data;
    	drm_device_t	  *dev	  = priv->dev;
@@ -1341,8 +1322,8 @@
    	return 0;
 }
 
-int i830_dma_vertex(struct inode *inode, struct file *filp,
-	       unsigned int cmd, unsigned long arg)
+static int i830_dma_vertex(struct inode *inode, struct file *filp,
+			   unsigned int cmd, unsigned long arg)
 {
 	drm_file_t *priv = filp->private_data;
 	drm_device_t *dev = priv->dev;
@@ -1373,8 +1354,8 @@
 	return 0;
 }
 
-int i830_clear_bufs(struct inode *inode, struct file *filp,
-		   unsigned int cmd, unsigned long arg)
+static int i830_clear_bufs(struct inode *inode, struct file *filp,
+			   unsigned int cmd, unsigned long arg)
 {
 	drm_file_t *priv = filp->private_data;
 	drm_device_t *dev = priv->dev;
@@ -1397,8 +1378,8 @@
    	return 0;
 }
 
-int i830_swap_bufs(struct inode *inode, struct file *filp,
-		  unsigned int cmd, unsigned long arg)
+static int i830_swap_bufs(struct inode *inode, struct file *filp,
+			  unsigned int cmd, unsigned long arg)
 {
 	drm_file_t *priv = filp->private_data;
 	drm_device_t *dev = priv->dev;
@@ -1425,20 +1406,8 @@
 	dev_priv->sarea_priv->pf_current_page = dev_priv->current_page;
 }
 
-int i830_do_cleanup_pageflip( drm_device_t *dev )
-{
-	drm_i830_private_t *dev_priv = dev->dev_private;
-
-	DRM_DEBUG("%s\n", __FUNCTION__);
-	if (dev_priv->current_page != 0)
-		i830_dma_dispatch_flip( dev );
-
-	dev_priv->page_flipping = 0;
-	return 0;
-}
-
-int i830_flip_bufs(struct inode *inode, struct file *filp,
-		   unsigned int cmd, unsigned long arg)
+static int i830_flip_bufs(struct inode *inode, struct file *filp,
+			  unsigned int cmd, unsigned long arg)
 {
 	drm_file_t *priv = filp->private_data;
 	drm_device_t *dev = priv->dev;
@@ -1455,8 +1424,8 @@
    	return 0;
 }
 
-int i830_getage(struct inode *inode, struct file *filp, unsigned int cmd,
-		unsigned long arg)
+static int i830_getage(struct inode *inode, struct file *filp, unsigned int cmd,
+		       unsigned long arg)
 {
    	drm_file_t	  *priv	    = filp->private_data;
 	drm_device_t	  *dev	    = priv->dev;
@@ -1469,8 +1438,8 @@
 	return 0;
 }
 
-int i830_getbuf(struct inode *inode, struct file *filp, unsigned int cmd,
-		unsigned long arg)
+static int i830_getbuf(struct inode *inode, struct file *filp, unsigned int cmd,
+		       unsigned long arg)
 {
 	drm_file_t	  *priv	    = filp->private_data;
 	drm_device_t	  *dev	    = priv->dev;
@@ -1501,25 +1470,25 @@
 	return retcode;
 }
 
-int i830_copybuf(struct inode *inode,
-		 struct file *filp, 
-		 unsigned int cmd,
-		 unsigned long arg)
+static int i830_copybuf(struct inode *inode,
+			struct file *filp, 
+			unsigned int cmd,
+			unsigned long arg)
 {
 	/* Never copy - 2.4.x doesn't need it */
 	return 0;
 }
 
-int i830_docopy(struct inode *inode, struct file *filp, unsigned int cmd,
-		unsigned long arg)
+static int i830_docopy(struct inode *inode, struct file *filp, unsigned int cmd,
+		       unsigned long arg)
 {
 	return 0;
 }
 
 
 
-int i830_getparam( struct inode *inode, struct file *filp, unsigned int cmd,
-		      unsigned long arg )
+static int i830_getparam(struct inode *inode, struct file *filp,
+			 unsigned int cmd, unsigned long arg )
 {
 	drm_file_t	  *priv	    = filp->private_data;
 	drm_device_t	  *dev	    = priv->dev;
@@ -1552,8 +1521,8 @@
 }
 
 
-int i830_setparam( struct inode *inode, struct file *filp, unsigned int cmd,
-		   unsigned long arg )
+static int i830_setparam(struct inode *inode, struct file *filp,
+			 unsigned int cmd, unsigned long arg )
 {
 	drm_file_t	  *priv	    = filp->private_data;
 	drm_device_t	  *dev	    = priv->dev;
@@ -1596,3 +1565,22 @@
 	return 0;
 }
 
+
+drm_ioctl_desc_t i830_ioctls[] = {
+	[DRM_IOCTL_NR(DRM_I830_INIT)]     = { i830_dma_init,    1, 1 },
+	[DRM_IOCTL_NR(DRM_I830_VERTEX)]   = { i830_dma_vertex,  1, 0 },
+	[DRM_IOCTL_NR(DRM_I830_CLEAR)]    = { i830_clear_bufs,  1, 0 },
+	[DRM_IOCTL_NR(DRM_I830_FLUSH)]    = { i830_flush_ioctl, 1, 0 },
+	[DRM_IOCTL_NR(DRM_I830_GETAGE)]   = { i830_getage,      1, 0 },
+	[DRM_IOCTL_NR(DRM_I830_GETBUF)]   = { i830_getbuf,      1, 0 },
+	[DRM_IOCTL_NR(DRM_I830_SWAP)]     = { i830_swap_bufs,   1, 0 },
+	[DRM_IOCTL_NR(DRM_I830_COPY)]     = { i830_copybuf,     1, 0 },
+	[DRM_IOCTL_NR(DRM_I830_DOCOPY)]   = { i830_docopy,      1, 0 },
+	[DRM_IOCTL_NR(DRM_I830_FLIP)]     = { i830_flip_bufs,   1, 0 },
+	[DRM_IOCTL_NR(DRM_I830_IRQ_EMIT)] = { i830_irq_emit,    1, 0 },
+	[DRM_IOCTL_NR(DRM_I830_IRQ_WAIT)] = { i830_irq_wait,    1, 0 },
+	[DRM_IOCTL_NR(DRM_I830_GETPARAM)] = { i830_getparam,    1, 0 },
+	[DRM_IOCTL_NR(DRM_I830_SETPARAM)] = { i830_setparam,    1, 0 } 
+};
+
+int i830_max_ioctl = DRM_ARRAY_SIZE(i830_ioctls);
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/i830_drv.c.old	2005-01-31 00:47:34.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/i830_drv.c	2005-01-31 00:47:42.000000000 +0100
@@ -40,7 +40,7 @@
 
 #include "drm_pciids.h"
 
-int postinit( struct drm_device *dev, unsigned long flags )
+static int postinit( struct drm_device *dev, unsigned long flags )
 {
 	dev->counters += 4;
 	dev->types[6] = _DRM_STAT_IRQ;
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/i830_irq.c.old	2005-01-31 00:48:59.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/i830_irq.c	2005-01-31 00:49:17.000000000 +0100
@@ -55,7 +55,7 @@
 }
 
 
-int i830_emit_irq(drm_device_t *dev)
+static int i830_emit_irq(drm_device_t *dev)
 {
 	drm_i830_private_t *dev_priv = dev->dev_private;
 	RING_LOCALS;
@@ -73,7 +73,7 @@
 }
 
 
-int i830_wait_irq(drm_device_t *dev, int irq_nr)
+static int i830_wait_irq(drm_device_t *dev, int irq_nr)
 {
   	drm_i830_private_t *dev_priv = 
 	   (drm_i830_private_t *)dev->dev_private;
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/i915_drv.h.old	2005-01-31 00:50:32.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/i915_drv.h	2005-01-31 00:56:14.000000000 +0100
@@ -79,14 +79,6 @@
 } drm_i915_private_t;
 
 				/* i915_dma.c */
-extern int i915_dma_init(DRM_IOCTL_ARGS);
-extern int i915_dma_cleanup(drm_device_t * dev);
-extern int i915_flush_ioctl(DRM_IOCTL_ARGS);
-extern int i915_batchbuffer(DRM_IOCTL_ARGS);
-extern int i915_flip_bufs(DRM_IOCTL_ARGS);
-extern int i915_getparam(DRM_IOCTL_ARGS);
-extern int i915_setparam(DRM_IOCTL_ARGS);
-extern int i915_cmdbuffer(DRM_IOCTL_ARGS);
 extern void i915_kernel_lost_context(drm_device_t * dev);
 extern void i915_driver_pretakedown(drm_device_t *dev);
 extern void i915_driver_prerelease(drm_device_t *dev, DRMFILE filp);
@@ -94,8 +86,6 @@
 /* i915_irq.c */
 extern int i915_irq_emit(DRM_IOCTL_ARGS);
 extern int i915_irq_wait(DRM_IOCTL_ARGS);
-extern int i915_wait_irq(drm_device_t * dev, int irq_nr);
-extern int i915_emit_irq(drm_device_t * dev);
 
 extern irqreturn_t i915_driver_irq_handler(DRM_IRQ_ARGS);
 extern void i915_driver_irq_preinstall(drm_device_t *dev);
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/i915_dma.c.old	2005-01-31 00:50:50.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/i915_dma.c	2005-01-31 00:55:04.000000000 +0100
@@ -12,23 +12,6 @@
 #include "i915_drm.h"
 #include "i915_drv.h"
 
-drm_ioctl_desc_t i915_ioctls[] = {
-	[DRM_IOCTL_NR(DRM_I915_INIT)] = {i915_dma_init, 1, 1},
-	[DRM_IOCTL_NR(DRM_I915_FLUSH)] = {i915_flush_ioctl, 1, 0},
-	[DRM_IOCTL_NR(DRM_I915_FLIP)] = {i915_flip_bufs, 1, 0},
-	[DRM_IOCTL_NR(DRM_I915_BATCHBUFFER)] = {i915_batchbuffer, 1, 0},
-	[DRM_IOCTL_NR(DRM_I915_IRQ_EMIT)] = {i915_irq_emit, 1, 0},
-	[DRM_IOCTL_NR(DRM_I915_IRQ_WAIT)] = {i915_irq_wait, 1, 0},
-	[DRM_IOCTL_NR(DRM_I915_GETPARAM)] = {i915_getparam, 1, 0},
-	[DRM_IOCTL_NR(DRM_I915_SETPARAM)] = {i915_setparam, 1, 1},
-	[DRM_IOCTL_NR(DRM_I915_ALLOC)] = {i915_mem_alloc, 1, 0},
-	[DRM_IOCTL_NR(DRM_I915_FREE)] = {i915_mem_free, 1, 0},
-	[DRM_IOCTL_NR(DRM_I915_INIT_HEAP)] = {i915_mem_init_heap, 1, 1},
-	[DRM_IOCTL_NR(DRM_I915_CMDBUFFER)] = {i915_cmdbuffer, 1, 0}
-};
-
-int i915_max_ioctl = DRM_ARRAY_SIZE(i915_ioctls);
-
 /* Really want an OS-independent resettable timer.  Would like to have
  * this loop run for (eg) 3 sec, but have the timer reset every time
  * the head pointer changes, so that EBUSY only happens if the ring
@@ -75,7 +58,7 @@
 		dev_priv->sarea_priv->perf_boxes |= I915_BOX_RING_EMPTY;
 }
 
-int i915_dma_cleanup(drm_device_t * dev)
+static int i915_dma_cleanup(drm_device_t * dev)
 {
 	/* Make sure interrupts are disabled here because the uninstall ioctl
 	 * may not have been called from userspace and after dev_private
@@ -227,7 +210,7 @@
 	return 0;
 }
 
-int i915_dma_init(DRM_IOCTL_ARGS)
+static int i915_dma_init(DRM_IOCTL_ARGS)
 {
 	DRM_DEVICE;
 	drm_i915_private_t *dev_priv;
@@ -538,7 +521,7 @@
 	return i915_wait_ring(dev, dev_priv->ring.Size - 8, __FUNCTION__);
 }
 
-int i915_flush_ioctl(DRM_IOCTL_ARGS)
+static int i915_flush_ioctl(DRM_IOCTL_ARGS)
 {
 	DRM_DEVICE;
 
@@ -547,7 +530,7 @@
 	return i915_quiescent(dev);
 }
 
-int i915_batchbuffer(DRM_IOCTL_ARGS)
+static int i915_batchbuffer(DRM_IOCTL_ARGS)
 {
 	DRM_DEVICE;
 	drm_i915_private_t *dev_priv = (drm_i915_private_t *) dev->dev_private;
@@ -581,7 +564,7 @@
 	return ret;
 }
 
-int i915_cmdbuffer(DRM_IOCTL_ARGS)
+static int i915_cmdbuffer(DRM_IOCTL_ARGS)
 {
 	DRM_DEVICE;
 	drm_i915_private_t *dev_priv = (drm_i915_private_t *) dev->dev_private;
@@ -617,18 +600,7 @@
 	return 0;
 }
 
-int i915_do_cleanup_pageflip(drm_device_t * dev)
-{
-	drm_i915_private_t *dev_priv = dev->dev_private;
-
-	DRM_DEBUG("%s\n", __FUNCTION__);
-	if (dev_priv->current_page != 0)
-		i915_dispatch_flip(dev);
-
-	return 0;
-}
-
-int i915_flip_bufs(DRM_IOCTL_ARGS)
+static int i915_flip_bufs(DRM_IOCTL_ARGS)
 {
 	DRM_DEVICE;
 
@@ -639,7 +611,7 @@
 	return i915_dispatch_flip(dev);
 }
 
-int i915_getparam(DRM_IOCTL_ARGS)
+static int i915_getparam(DRM_IOCTL_ARGS)
 {
 	DRM_DEVICE;
 	drm_i915_private_t *dev_priv = dev->dev_private;
@@ -674,7 +646,7 @@
 	return 0;
 }
 
-int i915_setparam(DRM_IOCTL_ARGS)
+static int i915_setparam(DRM_IOCTL_ARGS)
 {
 	DRM_DEVICE;
 	drm_i915_private_t *dev_priv = dev->dev_private;
@@ -723,3 +695,19 @@
 	}
 }
 
+drm_ioctl_desc_t i915_ioctls[] = {
+	[DRM_IOCTL_NR(DRM_I915_INIT)] = {i915_dma_init, 1, 1},
+	[DRM_IOCTL_NR(DRM_I915_FLUSH)] = {i915_flush_ioctl, 1, 0},
+	[DRM_IOCTL_NR(DRM_I915_FLIP)] = {i915_flip_bufs, 1, 0},
+	[DRM_IOCTL_NR(DRM_I915_BATCHBUFFER)] = {i915_batchbuffer, 1, 0},
+	[DRM_IOCTL_NR(DRM_I915_IRQ_EMIT)] = {i915_irq_emit, 1, 0},
+	[DRM_IOCTL_NR(DRM_I915_IRQ_WAIT)] = {i915_irq_wait, 1, 0},
+	[DRM_IOCTL_NR(DRM_I915_GETPARAM)] = {i915_getparam, 1, 0},
+	[DRM_IOCTL_NR(DRM_I915_SETPARAM)] = {i915_setparam, 1, 1},
+	[DRM_IOCTL_NR(DRM_I915_ALLOC)] = {i915_mem_alloc, 1, 0},
+	[DRM_IOCTL_NR(DRM_I915_FREE)] = {i915_mem_free, 1, 0},
+	[DRM_IOCTL_NR(DRM_I915_INIT_HEAP)] = {i915_mem_init_heap, 1, 1},
+	[DRM_IOCTL_NR(DRM_I915_CMDBUFFER)] = {i915_cmdbuffer, 1, 0}
+};
+
+int i915_max_ioctl = DRM_ARRAY_SIZE(i915_ioctls);
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/i915_drv.c.old	2005-01-31 00:55:25.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/i915_drv.c	2005-01-31 00:55:32.000000000 +0100
@@ -15,7 +15,7 @@
 
 #include "drm_pciids.h"
 
-int postinit( struct drm_device *dev, unsigned long flags )
+static int postinit( struct drm_device *dev, unsigned long flags )
 {
 	dev->counters += 4;
 	dev->types[6] = _DRM_STAT_IRQ;
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/i915_irq.c.old	2005-01-31 00:55:58.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/i915_irq.c	2005-01-31 00:56:19.000000000 +0100
@@ -36,7 +36,7 @@
 	return IRQ_HANDLED;
 }
 
-int i915_emit_irq(drm_device_t * dev)
+static int i915_emit_irq(drm_device_t * dev)
 {
 	drm_i915_private_t *dev_priv = dev->dev_private;
 	u32 ret;
@@ -56,7 +56,7 @@
 	return ret;
 }
 
-int i915_wait_irq(drm_device_t * dev, int irq_nr)
+static int i915_wait_irq(drm_device_t * dev, int irq_nr)
 {
 	drm_i915_private_t *dev_priv = (drm_i915_private_t *) dev->dev_private;
 	int ret = 0;
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/mga_drv.h.old	2005-01-31 00:56:41.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/mga_drv.h	2005-01-31 01:01:38.000000000 +0100
@@ -121,10 +121,6 @@
 extern int mga_driver_dma_quiescent(drm_device_t *dev);
 
 extern int mga_do_wait_for_idle( drm_mga_private_t *dev_priv );
-extern int mga_do_dma_idle( drm_mga_private_t *dev_priv );
-extern int mga_do_dma_reset( drm_mga_private_t *dev_priv );
-extern int mga_do_engine_reset( drm_mga_private_t *dev_priv );
-extern int mga_do_cleanup_dma( drm_device_t *dev );
 
 extern void mga_do_dma_flush( drm_mga_private_t *dev_priv );
 extern void mga_do_dma_wrap_start( drm_mga_private_t *dev_priv );
@@ -132,15 +128,6 @@
 
 extern int mga_freelist_put( drm_device_t *dev, drm_buf_t *buf );
 
-				/* mga_state.c */
-extern int  mga_dma_clear( DRM_IOCTL_ARGS );
-extern int  mga_dma_swap( DRM_IOCTL_ARGS );
-extern int  mga_dma_vertex( DRM_IOCTL_ARGS );
-extern int  mga_dma_indices( DRM_IOCTL_ARGS );
-extern int  mga_dma_iload( DRM_IOCTL_ARGS );
-extern int  mga_dma_blit( DRM_IOCTL_ARGS );
-extern int  mga_getparam( DRM_IOCTL_ARGS );
-
 				/* mga_warp.c */
 extern int mga_warp_install_microcode( drm_mga_private_t *dev_priv );
 extern int mga_warp_init( drm_mga_private_t *dev_priv );
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/mga_dma.c.old	2005-01-31 00:56:57.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/mga_dma.c	2005-01-31 00:58:18.000000000 +0100
@@ -41,6 +41,7 @@
 #define MGA_DEFAULT_USEC_TIMEOUT	10000
 #define MGA_FREELIST_DEBUG		0
 
+static int mga_do_cleanup_dma( drm_device_t *dev );
 
 /* ================================================================
  * Engine control
@@ -68,25 +69,7 @@
 	return DRM_ERR(EBUSY);
 }
 
-int mga_do_dma_idle( drm_mga_private_t *dev_priv )
-{
-	u32 status = 0;
-	int i;
-	DRM_DEBUG( "\n" );
-
-	for ( i = 0 ; i < dev_priv->usec_timeout ; i++ ) {
-		status = MGA_READ( MGA_STATUS ) & MGA_DMA_IDLE_MASK;
-		if ( status == MGA_ENDPRDMASTS ) return 0;
-		DRM_UDELAY( 1 );
-	}
-
-#if MGA_DMA_DEBUG
-	DRM_ERROR( "failed! status=0x%08x\n", status );
-#endif
-	return DRM_ERR(EBUSY);
-}
-
-int mga_do_dma_reset( drm_mga_private_t *dev_priv )
+static int mga_do_dma_reset( drm_mga_private_t *dev_priv )
 {
 	drm_mga_sarea_t *sarea_priv = dev_priv->sarea_priv;
 	drm_mga_primary_buffer_t *primary = &dev_priv->prim;
@@ -110,44 +93,6 @@
 	return 0;
 }
 
-int mga_do_engine_reset( drm_mga_private_t *dev_priv )
-{
-	DRM_DEBUG( "\n" );
-
-	/* Okay, so we've completely screwed up and locked the engine.
-	 * How about we clean up after ourselves?
-	 */
-	MGA_WRITE( MGA_RST, MGA_SOFTRESET );
-	DRM_UDELAY( 15 );				/* Wait at least 10 usecs */
-	MGA_WRITE( MGA_RST, 0 );
-
-	/* Initialize the registers that get clobbered by the soft
-	 * reset.  Many of the core register values survive a reset,
-	 * but the drawing registers are basically all gone.
-	 *
-	 * 3D clients should probably die after calling this.  The X
-	 * server should reset the engine state to known values.
-	 */
-#if 0
-	MGA_WRITE( MGA_PRIMPTR,
-		   virt_to_bus((void *)dev_priv->prim.status_page) |
-		   MGA_PRIMPTREN0 |
-		   MGA_PRIMPTREN1 );
-#endif
-
-	MGA_WRITE( MGA_ICLEAR, MGA_SOFTRAPICLR );
-	MGA_WRITE( MGA_IEN,    MGA_SOFTRAPIEN );
-
-	/* The primary DMA stream should look like new right about now.
-	 */
-	mga_do_dma_reset( dev_priv );
-
-	/* This bad boy will never fail.
-	 */
-	return 0;
-}
-
-
 /* ================================================================
  * Primary DMA stream
  */
@@ -625,7 +570,7 @@
 	return 0;
 }
 
-int mga_do_cleanup_dma( drm_device_t *dev )
+static int mga_do_cleanup_dma( drm_device_t *dev )
 {
 	DRM_DEBUG( "\n" );
 
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/mga_state.c.old	2005-01-31 00:59:36.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/mga_state.c	2005-01-31 01:01:43.000000000 +0100
@@ -37,21 +37,6 @@
 #include "mga_drm.h"
 #include "mga_drv.h"
 
-drm_ioctl_desc_t mga_ioctls[] = {
-	[DRM_IOCTL_NR(DRM_MGA_INIT)]    = { mga_dma_init,    1, 1 },
-	[DRM_IOCTL_NR(DRM_MGA_FLUSH)]   = { mga_dma_flush,   1, 0 },
-	[DRM_IOCTL_NR(DRM_MGA_RESET)]   = { mga_dma_reset,   1, 0 },
-	[DRM_IOCTL_NR(DRM_MGA_SWAP)]    = { mga_dma_swap,    1, 0 },
-	[DRM_IOCTL_NR(DRM_MGA_CLEAR)]   = { mga_dma_clear,   1, 0 },
-	[DRM_IOCTL_NR(DRM_MGA_VERTEX)]  = { mga_dma_vertex,  1, 0 },
-	[DRM_IOCTL_NR(DRM_MGA_INDICES)] = { mga_dma_indices, 1, 0 },
-	[DRM_IOCTL_NR(DRM_MGA_ILOAD)]   = { mga_dma_iload,   1, 0 },
-	[DRM_IOCTL_NR(DRM_MGA_BLIT)]    = { mga_dma_blit,    1, 0 },
-	[DRM_IOCTL_NR(DRM_MGA_GETPARAM)]= { mga_getparam,    1, 0 },
-};
-
-int mga_max_ioctl = DRM_ARRAY_SIZE(mga_ioctls);
-
 /* ================================================================
  * DMA hardware state programming functions
  */
@@ -893,7 +878,7 @@
  *
  */
 
-int mga_dma_clear( DRM_IOCTL_ARGS )
+static int mga_dma_clear( DRM_IOCTL_ARGS )
 {
 	DRM_DEVICE;
 	drm_mga_private_t *dev_priv = dev->dev_private;
@@ -918,7 +903,7 @@
 	return 0;
 }
 
-int mga_dma_swap( DRM_IOCTL_ARGS )
+static int mga_dma_swap( DRM_IOCTL_ARGS )
 {
 	DRM_DEVICE;
 	drm_mga_private_t *dev_priv = dev->dev_private;
@@ -940,7 +925,7 @@
 	return 0;
 }
 
-int mga_dma_vertex( DRM_IOCTL_ARGS )
+static int mga_dma_vertex( DRM_IOCTL_ARGS )
 {
 	DRM_DEVICE;
 	drm_mga_private_t *dev_priv = dev->dev_private;
@@ -979,7 +964,7 @@
 	return 0;
 }
 
-int mga_dma_indices( DRM_IOCTL_ARGS )
+static int mga_dma_indices( DRM_IOCTL_ARGS )
 {
 	DRM_DEVICE;
 	drm_mga_private_t *dev_priv = dev->dev_private;
@@ -1018,7 +1003,7 @@
 	return 0;
 }
 
-int mga_dma_iload( DRM_IOCTL_ARGS )
+static int mga_dma_iload( DRM_IOCTL_ARGS )
 {
 	DRM_DEVICE;
 	drm_device_dma_t *dma = dev->dma;
@@ -1060,7 +1045,7 @@
 	return 0;
 }
 
-int mga_dma_blit( DRM_IOCTL_ARGS )
+static int mga_dma_blit( DRM_IOCTL_ARGS )
 {
 	DRM_DEVICE;
 	drm_mga_private_t *dev_priv = dev->dev_private;
@@ -1089,7 +1074,7 @@
 	return 0;
 }
 
-int mga_getparam( DRM_IOCTL_ARGS )
+static int mga_getparam( DRM_IOCTL_ARGS )
 {
 	DRM_DEVICE;
 	drm_mga_private_t *dev_priv = dev->dev_private;
@@ -1121,3 +1106,19 @@
 	
 	return 0;
 }
+
+
+drm_ioctl_desc_t mga_ioctls[] = {
+	[DRM_IOCTL_NR(DRM_MGA_INIT)]    = { mga_dma_init,    1, 1 },
+	[DRM_IOCTL_NR(DRM_MGA_FLUSH)]   = { mga_dma_flush,   1, 0 },
+	[DRM_IOCTL_NR(DRM_MGA_RESET)]   = { mga_dma_reset,   1, 0 },
+	[DRM_IOCTL_NR(DRM_MGA_SWAP)]    = { mga_dma_swap,    1, 0 },
+	[DRM_IOCTL_NR(DRM_MGA_CLEAR)]   = { mga_dma_clear,   1, 0 },
+	[DRM_IOCTL_NR(DRM_MGA_VERTEX)]  = { mga_dma_vertex,  1, 0 },
+	[DRM_IOCTL_NR(DRM_MGA_INDICES)] = { mga_dma_indices, 1, 0 },
+	[DRM_IOCTL_NR(DRM_MGA_ILOAD)]   = { mga_dma_iload,   1, 0 },
+	[DRM_IOCTL_NR(DRM_MGA_BLIT)]    = { mga_dma_blit,    1, 0 },
+	[DRM_IOCTL_NR(DRM_MGA_GETPARAM)]= { mga_getparam,    1, 0 },
+};
+
+int mga_max_ioctl = DRM_ARRAY_SIZE(mga_ioctls);
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/r128_drv.h.old	2005-01-31 01:02:03.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/r128_drv.h	2005-01-31 01:07:01.000000000 +0100
@@ -139,27 +139,13 @@
 extern int r128_engine_reset( DRM_IOCTL_ARGS );
 extern int r128_fullscreen( DRM_IOCTL_ARGS );
 extern int r128_cce_buffers( DRM_IOCTL_ARGS );
-extern int r128_getparam( DRM_IOCTL_ARGS );
 
 extern void r128_freelist_reset( drm_device_t *dev );
-extern drm_buf_t *r128_freelist_get( drm_device_t *dev );
 
 extern int r128_wait_ring( drm_r128_private_t *dev_priv, int n );
 
 extern int r128_do_cce_idle( drm_r128_private_t *dev_priv );
 extern int r128_do_cleanup_cce( drm_device_t *dev );
-extern int r128_do_cleanup_pageflip( drm_device_t *dev );
-
-				/* r128_state.c */
-extern int r128_cce_clear( DRM_IOCTL_ARGS );
-extern int r128_cce_swap( DRM_IOCTL_ARGS );
-extern int r128_cce_flip( DRM_IOCTL_ARGS );
-extern int r128_cce_vertex( DRM_IOCTL_ARGS );
-extern int r128_cce_indices( DRM_IOCTL_ARGS );
-extern int r128_cce_blit( DRM_IOCTL_ARGS );
-extern int r128_cce_depth( DRM_IOCTL_ARGS );
-extern int r128_cce_stipple( DRM_IOCTL_ARGS );
-extern int r128_cce_indirect( DRM_IOCTL_ARGS );
 
 extern int r128_driver_vblank_wait(drm_device_t *dev, unsigned int *sequence);
 
@@ -406,8 +392,6 @@
 	R128_WRITE(R128_CLOCK_CNTL_DATA, (val));			\
 } while (0)
 
-extern int R128_READ_PLL(drm_device_t *dev, int addr);
-
 
 #define CCE_PACKET0( reg, n )		(R128_CCE_PACKET0 |		\
 					 ((n) << 16) | ((reg) >> 2))
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/r128_cce.c.old	2005-01-31 01:02:20.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/r128_cce.c	2005-01-31 01:02:57.000000000 +0100
@@ -80,7 +80,7 @@
 	0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0
 };
 
-int R128_READ_PLL(drm_device_t *dev, int addr)
+static int R128_READ_PLL(drm_device_t *dev, int addr)
 {
 	drm_r128_private_t *dev_priv = dev->dev_private;
 
@@ -808,7 +808,7 @@
 }
 #endif
 
-drm_buf_t *r128_freelist_get( drm_device_t *dev )
+static drm_buf_t *r128_freelist_get( drm_device_t *dev )
 {
 	drm_device_dma_t *dma = dev->dma;
 	drm_r128_private_t *dev_priv = dev->dev_private;
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/r128_state.c.old	2005-01-31 01:03:28.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/r128_state.c	2005-01-31 01:07:05.000000000 +0100
@@ -32,28 +32,6 @@
 #include "r128_drm.h"
 #include "r128_drv.h"
 
-drm_ioctl_desc_t r128_ioctls[] = {
-	[DRM_IOCTL_NR(DRM_R128_INIT)]       = { r128_cce_init,     1, 1 },
-	[DRM_IOCTL_NR(DRM_R128_CCE_START)]  = { r128_cce_start,    1, 1 },
-	[DRM_IOCTL_NR(DRM_R128_CCE_STOP)]   = { r128_cce_stop,     1, 1 },
-	[DRM_IOCTL_NR(DRM_R128_CCE_RESET)]  = { r128_cce_reset,    1, 1 },
-	[DRM_IOCTL_NR(DRM_R128_CCE_IDLE)]   = { r128_cce_idle,     1, 0 },
-	[DRM_IOCTL_NR(DRM_R128_RESET)]      = { r128_engine_reset, 1, 0 },
-	[DRM_IOCTL_NR(DRM_R128_FULLSCREEN)] = { r128_fullscreen,   1, 0 },
-	[DRM_IOCTL_NR(DRM_R128_SWAP)]       = { r128_cce_swap,     1, 0 },
-	[DRM_IOCTL_NR(DRM_R128_FLIP)]       = { r128_cce_flip,     1, 0 },
-	[DRM_IOCTL_NR(DRM_R128_CLEAR)]      = { r128_cce_clear,    1, 0 },
-	[DRM_IOCTL_NR(DRM_R128_VERTEX)]     = { r128_cce_vertex,   1, 0 },
-	[DRM_IOCTL_NR(DRM_R128_INDICES)]    = { r128_cce_indices,  1, 0 },
-	[DRM_IOCTL_NR(DRM_R128_BLIT)]       = { r128_cce_blit,     1, 0 },
-	[DRM_IOCTL_NR(DRM_R128_DEPTH)]      = { r128_cce_depth,    1, 0 },
-	[DRM_IOCTL_NR(DRM_R128_STIPPLE)]    = { r128_cce_stipple,  1, 0 },
-	[DRM_IOCTL_NR(DRM_R128_INDIRECT)]   = { r128_cce_indirect, 1, 1 },
-	[DRM_IOCTL_NR(DRM_R128_GETPARAM)]   = { r128_getparam, 1, 0 },
-};
-
-int r128_max_ioctl = DRM_ARRAY_SIZE(r128_ioctls);
-
 /* ================================================================
  * CCE hardware state programming functions
  */
@@ -1281,7 +1259,7 @@
  * IOCTL functions
  */
 
-int r128_cce_clear( DRM_IOCTL_ARGS )
+static int r128_cce_clear( DRM_IOCTL_ARGS )
 {
 	DRM_DEVICE;
 	drm_r128_private_t *dev_priv = dev->dev_private;
@@ -1328,7 +1306,7 @@
 	return 0;
 }
 
-int r128_do_cleanup_pageflip( drm_device_t *dev )
+static int r128_do_cleanup_pageflip( drm_device_t *dev )
 {
 	drm_r128_private_t *dev_priv = dev->dev_private;
 	DRM_DEBUG( "\n" );
@@ -1349,7 +1327,7 @@
  * They can & should be intermixed to support multiple 3d windows.  
  */
 
-int r128_cce_flip( DRM_IOCTL_ARGS )
+static int r128_cce_flip( DRM_IOCTL_ARGS )
 {
 	DRM_DEVICE;
 	drm_r128_private_t *dev_priv = dev->dev_private;
@@ -1368,7 +1346,7 @@
 	return 0;
 }
 
-int r128_cce_swap( DRM_IOCTL_ARGS )
+static int r128_cce_swap( DRM_IOCTL_ARGS )
 {
 	DRM_DEVICE;
 	drm_r128_private_t *dev_priv = dev->dev_private;
@@ -1390,7 +1368,7 @@
 	return 0;
 }
 
-int r128_cce_vertex( DRM_IOCTL_ARGS )
+static int r128_cce_vertex( DRM_IOCTL_ARGS )
 {
 	DRM_DEVICE;
 	drm_r128_private_t *dev_priv = dev->dev_private;
@@ -1450,7 +1428,7 @@
 	return 0;
 }
 
-int r128_cce_indices( DRM_IOCTL_ARGS )
+static int r128_cce_indices( DRM_IOCTL_ARGS )
 {
 	DRM_DEVICE;
 	drm_r128_private_t *dev_priv = dev->dev_private;
@@ -1522,7 +1500,7 @@
 	return 0;
 }
 
-int r128_cce_blit( DRM_IOCTL_ARGS )
+static int r128_cce_blit( DRM_IOCTL_ARGS )
 {
 	DRM_DEVICE;
 	drm_device_dma_t *dma = dev->dma;
@@ -1552,7 +1530,7 @@
 	return ret;
 }
 
-int r128_cce_depth( DRM_IOCTL_ARGS )
+static int r128_cce_depth( DRM_IOCTL_ARGS )
 {
 	DRM_DEVICE;
 	drm_r128_private_t *dev_priv = dev->dev_private;
@@ -1582,7 +1560,7 @@
 	return ret;
 }
 
-int r128_cce_stipple( DRM_IOCTL_ARGS )
+static int r128_cce_stipple( DRM_IOCTL_ARGS )
 {
 	DRM_DEVICE;
 	drm_r128_private_t *dev_priv = dev->dev_private;
@@ -1606,7 +1584,7 @@
 	return 0;
 }
 
-int r128_cce_indirect( DRM_IOCTL_ARGS )
+static int r128_cce_indirect( DRM_IOCTL_ARGS )
 {
 	DRM_DEVICE;
 	drm_r128_private_t *dev_priv = dev->dev_private;
@@ -1682,7 +1660,7 @@
 	return 0;
 }
 
-int r128_getparam( DRM_IOCTL_ARGS )
+static int r128_getparam( DRM_IOCTL_ARGS )
 {
 	DRM_DEVICE;
 	drm_r128_private_t *dev_priv = dev->dev_private;
@@ -1730,3 +1708,25 @@
 	r128_do_cleanup_cce( dev );
 }
 
+
+drm_ioctl_desc_t r128_ioctls[] = {
+	[DRM_IOCTL_NR(DRM_R128_INIT)]       = { r128_cce_init,     1, 1 },
+	[DRM_IOCTL_NR(DRM_R128_CCE_START)]  = { r128_cce_start,    1, 1 },
+	[DRM_IOCTL_NR(DRM_R128_CCE_STOP)]   = { r128_cce_stop,     1, 1 },
+	[DRM_IOCTL_NR(DRM_R128_CCE_RESET)]  = { r128_cce_reset,    1, 1 },
+	[DRM_IOCTL_NR(DRM_R128_CCE_IDLE)]   = { r128_cce_idle,     1, 0 },
+	[DRM_IOCTL_NR(DRM_R128_RESET)]      = { r128_engine_reset, 1, 0 },
+	[DRM_IOCTL_NR(DRM_R128_FULLSCREEN)] = { r128_fullscreen,   1, 0 },
+	[DRM_IOCTL_NR(DRM_R128_SWAP)]       = { r128_cce_swap,     1, 0 },
+	[DRM_IOCTL_NR(DRM_R128_FLIP)]       = { r128_cce_flip,     1, 0 },
+	[DRM_IOCTL_NR(DRM_R128_CLEAR)]      = { r128_cce_clear,    1, 0 },
+	[DRM_IOCTL_NR(DRM_R128_VERTEX)]     = { r128_cce_vertex,   1, 0 },
+	[DRM_IOCTL_NR(DRM_R128_INDICES)]    = { r128_cce_indices,  1, 0 },
+	[DRM_IOCTL_NR(DRM_R128_BLIT)]       = { r128_cce_blit,     1, 0 },
+	[DRM_IOCTL_NR(DRM_R128_DEPTH)]      = { r128_cce_depth,    1, 0 },
+	[DRM_IOCTL_NR(DRM_R128_STIPPLE)]    = { r128_cce_stipple,  1, 0 },
+	[DRM_IOCTL_NR(DRM_R128_INDIRECT)]   = { r128_cce_indirect, 1, 1 },
+	[DRM_IOCTL_NR(DRM_R128_GETPARAM)]   = { r128_getparam, 1, 0 },
+};
+
+int r128_max_ioctl = DRM_ARRAY_SIZE(r128_ioctls);
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/radeon_drv.h.old	2005-01-31 01:07:19.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/radeon_drv.h	2005-01-31 01:14:11.000000000 +0100
@@ -284,42 +284,20 @@
 extern int radeon_wait_ring( drm_radeon_private_t *dev_priv, int n );
 
 extern int radeon_do_cp_idle( drm_radeon_private_t *dev_priv );
-extern int radeon_do_cleanup_cp( drm_device_t *dev );
-extern int radeon_do_cleanup_pageflip( drm_device_t *dev );
 
 extern int radeon_driver_preinit(struct drm_device *dev, unsigned long flags);
 extern int radeon_driver_postcleanup(struct drm_device *dev);
 
-				/* radeon_state.c */
-extern int radeon_cp_clear( DRM_IOCTL_ARGS );
-extern int radeon_cp_swap( DRM_IOCTL_ARGS );
-extern int radeon_cp_vertex( DRM_IOCTL_ARGS );
-extern int radeon_cp_indices( DRM_IOCTL_ARGS );
-extern int radeon_cp_texture( DRM_IOCTL_ARGS );
-extern int radeon_cp_stipple( DRM_IOCTL_ARGS );
-extern int radeon_cp_indirect( DRM_IOCTL_ARGS );
-extern int radeon_cp_vertex2( DRM_IOCTL_ARGS );
-extern int radeon_cp_cmdbuf( DRM_IOCTL_ARGS );
-extern int radeon_cp_getparam( DRM_IOCTL_ARGS );
-extern int radeon_cp_setparam( DRM_IOCTL_ARGS );
-extern int radeon_cp_flip( DRM_IOCTL_ARGS );
-
 extern int radeon_mem_alloc( DRM_IOCTL_ARGS );
 extern int radeon_mem_free( DRM_IOCTL_ARGS );
 extern int radeon_mem_init_heap( DRM_IOCTL_ARGS );
 extern void radeon_mem_takedown( struct mem_block **heap );
 extern void radeon_mem_release( DRMFILE filp, struct mem_block *heap );
-extern int radeon_surface_alloc(DRM_IOCTL_ARGS);
-extern int radeon_surface_free(DRM_IOCTL_ARGS);
 
 				/* radeon_irq.c */
 extern int radeon_irq_emit( DRM_IOCTL_ARGS );
 extern int radeon_irq_wait( DRM_IOCTL_ARGS );
 
-extern int radeon_emit_and_wait_irq(drm_device_t *dev);
-extern int radeon_wait_irq(drm_device_t *dev, int swi_nr);
-extern int radeon_emit_irq(drm_device_t *dev);
-
 extern void radeon_do_release(drm_device_t *dev);
 extern int radeon_driver_vblank_wait(drm_device_t *dev, unsigned int *sequence);
 extern irqreturn_t radeon_driver_irq_handler( DRM_IRQ_ARGS );
@@ -860,8 +838,6 @@
 	RADEON_WRITE( RADEON_CLOCK_CNTL_DATA, (val) );			\
 } while (0)
 
-extern int RADEON_READ_PLL( drm_device_t *dev, int addr );
-
 
 #define CP_PACKET0( reg, n )						\
 	(RADEON_CP_PACKET0 | ((n) << 16) | ((reg) >> 2))
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/radeon_cp.c.old	2005-01-31 01:07:35.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/radeon_cp.c	2005-01-31 01:08:21.000000000 +0100
@@ -35,6 +35,7 @@
 
 #define RADEON_FIFO_DEBUG	0
 
+static int radeon_do_cleanup_cp( drm_device_t *dev );
 
 /* CP microcode (from ATI) */
 static u32 R200_cp_microcode[][2] = {
@@ -815,7 +816,7 @@
 	{ 0000000000, 0000000000 },
 };
 
-int RADEON_READ_PLL(drm_device_t *dev, int addr)
+static int RADEON_READ_PLL(drm_device_t *dev, int addr)
 {
 	drm_radeon_private_t *dev_priv = dev->dev_private;
 
@@ -1538,7 +1539,7 @@
 	return 0;
 }
 
-int radeon_do_cleanup_cp( drm_device_t *dev )
+static int radeon_do_cleanup_cp( drm_device_t *dev )
 {
 	drm_radeon_private_t *dev_priv = dev->dev_private;
 	DRM_DEBUG( "\n" );
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/radeon_irq.c.old	2005-01-31 01:08:44.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/radeon_irq.c	2005-01-31 01:09:28.000000000 +0100
@@ -93,7 +93,7 @@
 		RADEON_WRITE( RADEON_GEN_INT_STATUS, tmp );
 }
 
-int radeon_emit_irq(drm_device_t *dev)
+static int radeon_emit_irq(drm_device_t *dev)
 {
 	drm_radeon_private_t *dev_priv = dev->dev_private;
 	unsigned int ret;
@@ -112,7 +112,7 @@
 }
 
 
-int radeon_wait_irq(drm_device_t *dev, int swi_nr)
+static int radeon_wait_irq(drm_device_t *dev, int swi_nr)
 {
   	drm_radeon_private_t *dev_priv = 
 	   (drm_radeon_private_t *)dev->dev_private;
@@ -134,11 +134,6 @@
 	return ret;
 }
 
-int radeon_emit_and_wait_irq(drm_device_t *dev)
-{
-	return radeon_wait_irq( dev, radeon_emit_irq(dev) );
-}
-
 
 int radeon_driver_vblank_wait(drm_device_t *dev, unsigned int *sequence)
 {
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/radeon_state.c.old	2005-01-31 01:09:51.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/radeon_state.c	2005-01-31 01:14:15.000000000 +0100
@@ -33,38 +33,6 @@
 #include "radeon_drm.h"
 #include "radeon_drv.h"
 
-drm_ioctl_desc_t radeon_ioctls[] = {
-	[DRM_IOCTL_NR(DRM_RADEON_CP_INIT)]    = { radeon_cp_init,      1, 1 },
-	[DRM_IOCTL_NR(DRM_RADEON_CP_START)]   = { radeon_cp_start,     1, 1 },
-	[DRM_IOCTL_NR(DRM_RADEON_CP_STOP)]    = { radeon_cp_stop,      1, 1 },
-	[DRM_IOCTL_NR(DRM_RADEON_CP_RESET)]   = { radeon_cp_reset,     1, 1 },
-	[DRM_IOCTL_NR(DRM_RADEON_CP_IDLE)]    = { radeon_cp_idle,      1, 0 },
-	[DRM_IOCTL_NR(DRM_RADEON_CP_RESUME)]  = { radeon_cp_resume,    1, 0 },
-	[DRM_IOCTL_NR(DRM_RADEON_RESET)]      = { radeon_engine_reset, 1, 0 },
-	[DRM_IOCTL_NR(DRM_RADEON_FULLSCREEN)] = { radeon_fullscreen,   1, 0 },
-	[DRM_IOCTL_NR(DRM_RADEON_SWAP)]       = { radeon_cp_swap,      1, 0 },
-	[DRM_IOCTL_NR(DRM_RADEON_CLEAR)]      = { radeon_cp_clear,     1, 0 },
-	[DRM_IOCTL_NR(DRM_RADEON_VERTEX)]     = { radeon_cp_vertex,    1, 0 },
-	[DRM_IOCTL_NR(DRM_RADEON_INDICES)]    = { radeon_cp_indices,   1, 0 },
-	[DRM_IOCTL_NR(DRM_RADEON_TEXTURE)]    = { radeon_cp_texture,   1, 0 },
-	[DRM_IOCTL_NR(DRM_RADEON_STIPPLE)]    = { radeon_cp_stipple,   1, 0 },
-	[DRM_IOCTL_NR(DRM_RADEON_INDIRECT)]   = { radeon_cp_indirect,  1, 1 },
-	[DRM_IOCTL_NR(DRM_RADEON_VERTEX2)]    = { radeon_cp_vertex2,   1, 0 },
-	[DRM_IOCTL_NR(DRM_RADEON_CMDBUF)]     = { radeon_cp_cmdbuf,    1, 0 },
-	[DRM_IOCTL_NR(DRM_RADEON_GETPARAM)]   = { radeon_cp_getparam,  1, 0 },
-	[DRM_IOCTL_NR(DRM_RADEON_FLIP)]       = { radeon_cp_flip,      1, 0 },
-	[DRM_IOCTL_NR(DRM_RADEON_ALLOC)]      = { radeon_mem_alloc,    1, 0 },
-	[DRM_IOCTL_NR(DRM_RADEON_FREE)]       = { radeon_mem_free,     1, 0 },
-	[DRM_IOCTL_NR(DRM_RADEON_INIT_HEAP)]  = { radeon_mem_init_heap,1, 1 },
-	[DRM_IOCTL_NR(DRM_RADEON_IRQ_EMIT)]   = { radeon_irq_emit,     1, 0 },
-	[DRM_IOCTL_NR(DRM_RADEON_IRQ_WAIT)]   = { radeon_irq_wait,     1, 0 },
-	[DRM_IOCTL_NR(DRM_RADEON_SETPARAM)]   = { radeon_cp_setparam,  1, 0 },
-	[DRM_IOCTL_NR(DRM_RADEON_SURF_ALLOC)] = { radeon_surface_alloc,1, 0 },
-	[DRM_IOCTL_NR(DRM_RADEON_SURF_FREE)]  = { radeon_surface_free, 1, 0 }
-};
-
-int radeon_max_ioctl = DRM_ARRAY_SIZE(radeon_ioctls);
-
 /* ================================================================
  * Helper functions for client state checking and fixup
  */
@@ -1891,7 +1859,7 @@
 /* ================================================================
  * IOCTL functions
  */
-int radeon_surface_alloc(DRM_IOCTL_ARGS)
+static int radeon_surface_alloc(DRM_IOCTL_ARGS)
 {
 	DRM_DEVICE;
 	drm_radeon_private_t *dev_priv = dev->dev_private;
@@ -1911,7 +1879,7 @@
 		return 0;
 }
 
-int radeon_surface_free(DRM_IOCTL_ARGS)
+static int radeon_surface_free(DRM_IOCTL_ARGS)
 {
 	DRM_DEVICE;
 	drm_radeon_private_t *dev_priv = dev->dev_private;
@@ -1931,7 +1899,7 @@
 		return 0;
 }
 
-int radeon_cp_clear( DRM_IOCTL_ARGS )
+static int radeon_cp_clear( DRM_IOCTL_ARGS )
 {
 	DRM_DEVICE;
 	drm_radeon_private_t *dev_priv = dev->dev_private;
@@ -1988,7 +1956,7 @@
 /* Called whenever a client dies, from drm_release.
  * NOTE:  Lock isn't necessarily held when this is called!
  */
-int radeon_do_cleanup_pageflip( drm_device_t *dev )
+static int radeon_do_cleanup_pageflip( drm_device_t *dev )
 {
 	drm_radeon_private_t *dev_priv = dev->dev_private;
 	DRM_DEBUG( "\n" );
@@ -2003,7 +1971,7 @@
 /* Swapping and flipping are different operations, need different ioctls.
  * They can & should be intermixed to support multiple 3d windows.  
  */
-int radeon_cp_flip( DRM_IOCTL_ARGS )
+static int radeon_cp_flip( DRM_IOCTL_ARGS )
 {
 	DRM_DEVICE;
 	drm_radeon_private_t *dev_priv = dev->dev_private;
@@ -2022,7 +1990,7 @@
 	return 0;
 }
 
-int radeon_cp_swap( DRM_IOCTL_ARGS )
+static int radeon_cp_swap( DRM_IOCTL_ARGS )
 {
 	DRM_DEVICE;
 	drm_radeon_private_t *dev_priv = dev->dev_private;
@@ -2043,7 +2011,7 @@
 	return 0;
 }
 
-int radeon_cp_vertex( DRM_IOCTL_ARGS )
+static int radeon_cp_vertex( DRM_IOCTL_ARGS )
 {
 	DRM_DEVICE;
 	drm_radeon_private_t *dev_priv = dev->dev_private;
@@ -2128,7 +2096,7 @@
 	return 0;
 }
 
-int radeon_cp_indices( DRM_IOCTL_ARGS )
+static int radeon_cp_indices( DRM_IOCTL_ARGS )
 {
 	DRM_DEVICE;
 	drm_radeon_private_t *dev_priv = dev->dev_private;
@@ -2230,7 +2198,7 @@
 	return 0;
 }
 
-int radeon_cp_texture( DRM_IOCTL_ARGS )
+static int radeon_cp_texture( DRM_IOCTL_ARGS )
 {
 	DRM_DEVICE;
 	drm_radeon_private_t *dev_priv = dev->dev_private;
@@ -2261,7 +2229,7 @@
 	return ret;
 }
 
-int radeon_cp_stipple( DRM_IOCTL_ARGS )
+static int radeon_cp_stipple( DRM_IOCTL_ARGS )
 {
 	DRM_DEVICE;
 	drm_radeon_private_t *dev_priv = dev->dev_private;
@@ -2284,7 +2252,7 @@
 	return 0;
 }
 
-int radeon_cp_indirect( DRM_IOCTL_ARGS )
+static int radeon_cp_indirect( DRM_IOCTL_ARGS )
 {
 	DRM_DEVICE;
 	drm_radeon_private_t *dev_priv = dev->dev_private;
@@ -2359,7 +2327,7 @@
 	return 0;
 }
 
-int radeon_cp_vertex2( DRM_IOCTL_ARGS )
+static int radeon_cp_vertex2( DRM_IOCTL_ARGS )
 {
 	DRM_DEVICE;
 	drm_radeon_private_t *dev_priv = dev->dev_private;
@@ -2693,7 +2661,7 @@
 	return 0;
 }
 
-int radeon_cp_cmdbuf( DRM_IOCTL_ARGS )
+static int radeon_cp_cmdbuf( DRM_IOCTL_ARGS )
 {
 	DRM_DEVICE;
 	drm_radeon_private_t *dev_priv = dev->dev_private;
@@ -2832,7 +2800,7 @@
 
 
 
-int radeon_cp_getparam( DRM_IOCTL_ARGS )
+static int radeon_cp_getparam( DRM_IOCTL_ARGS )
 {
 	DRM_DEVICE;
 	drm_radeon_private_t *dev_priv = dev->dev_private;
@@ -2906,7 +2874,7 @@
 	return 0;
 }
 
-int radeon_cp_setparam( DRM_IOCTL_ARGS ) {
+static int radeon_cp_setparam( DRM_IOCTL_ARGS ) {
 	DRM_DEVICE;
 	drm_radeon_private_t *dev_priv = dev->dev_private;
 	drm_file_t *filp_priv;
@@ -2999,3 +2967,35 @@
 	 
 	 drm_free(radeon_priv, sizeof(*radeon_priv), DRM_MEM_FILES);
 }
+
+drm_ioctl_desc_t radeon_ioctls[] = {
+	[DRM_IOCTL_NR(DRM_RADEON_CP_INIT)]    = { radeon_cp_init,      1, 1 },
+	[DRM_IOCTL_NR(DRM_RADEON_CP_START)]   = { radeon_cp_start,     1, 1 },
+	[DRM_IOCTL_NR(DRM_RADEON_CP_STOP)]    = { radeon_cp_stop,      1, 1 },
+	[DRM_IOCTL_NR(DRM_RADEON_CP_RESET)]   = { radeon_cp_reset,     1, 1 },
+	[DRM_IOCTL_NR(DRM_RADEON_CP_IDLE)]    = { radeon_cp_idle,      1, 0 },
+	[DRM_IOCTL_NR(DRM_RADEON_CP_RESUME)]  = { radeon_cp_resume,    1, 0 },
+	[DRM_IOCTL_NR(DRM_RADEON_RESET)]      = { radeon_engine_reset, 1, 0 },
+	[DRM_IOCTL_NR(DRM_RADEON_FULLSCREEN)] = { radeon_fullscreen,   1, 0 },
+	[DRM_IOCTL_NR(DRM_RADEON_SWAP)]       = { radeon_cp_swap,      1, 0 },
+	[DRM_IOCTL_NR(DRM_RADEON_CLEAR)]      = { radeon_cp_clear,     1, 0 },
+	[DRM_IOCTL_NR(DRM_RADEON_VERTEX)]     = { radeon_cp_vertex,    1, 0 },
+	[DRM_IOCTL_NR(DRM_RADEON_INDICES)]    = { radeon_cp_indices,   1, 0 },
+	[DRM_IOCTL_NR(DRM_RADEON_TEXTURE)]    = { radeon_cp_texture,   1, 0 },
+	[DRM_IOCTL_NR(DRM_RADEON_STIPPLE)]    = { radeon_cp_stipple,   1, 0 },
+	[DRM_IOCTL_NR(DRM_RADEON_INDIRECT)]   = { radeon_cp_indirect,  1, 1 },
+	[DRM_IOCTL_NR(DRM_RADEON_VERTEX2)]    = { radeon_cp_vertex2,   1, 0 },
+	[DRM_IOCTL_NR(DRM_RADEON_CMDBUF)]     = { radeon_cp_cmdbuf,    1, 0 },
+	[DRM_IOCTL_NR(DRM_RADEON_GETPARAM)]   = { radeon_cp_getparam,  1, 0 },
+	[DRM_IOCTL_NR(DRM_RADEON_FLIP)]       = { radeon_cp_flip,      1, 0 },
+	[DRM_IOCTL_NR(DRM_RADEON_ALLOC)]      = { radeon_mem_alloc,    1, 0 },
+	[DRM_IOCTL_NR(DRM_RADEON_FREE)]       = { radeon_mem_free,     1, 0 },
+	[DRM_IOCTL_NR(DRM_RADEON_INIT_HEAP)]  = { radeon_mem_init_heap,1, 1 },
+	[DRM_IOCTL_NR(DRM_RADEON_IRQ_EMIT)]   = { radeon_irq_emit,     1, 0 },
+	[DRM_IOCTL_NR(DRM_RADEON_IRQ_WAIT)]   = { radeon_irq_wait,     1, 0 },
+	[DRM_IOCTL_NR(DRM_RADEON_SETPARAM)]   = { radeon_cp_setparam,  1, 0 },
+	[DRM_IOCTL_NR(DRM_RADEON_SURF_ALLOC)] = { radeon_surface_alloc,1, 0 },
+	[DRM_IOCTL_NR(DRM_RADEON_SURF_FREE)]  = { radeon_surface_free, 1, 0 }
+};
+
+int radeon_max_ioctl = DRM_ARRAY_SIZE(radeon_ioctls);
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/sis_ds.h.old	2005-01-31 01:15:08.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/sis_ds.h	2005-01-31 01:18:36.000000000 +0100
@@ -115,10 +115,6 @@
  */
 memHeap_t *mmInit( int ofs, int size );
 
-memHeap_t *mmAddRange( memHeap_t *heap,
-		       int ofs,
-		       int size );
-
 /*
  * Allocate 'size' bytes with 2^align2 bytes alignment,
  * restrict the search to free memory after 'startSearch'
@@ -143,22 +139,4 @@
  */
 int mmFreeMem( PMemBlock b );
 
-/*
- * Reserve 'size' bytes block start at offset
- * This is used to prevent allocation of memory already used
- * by the X server for the front buffer, pixmaps, and cursor
- * input: size, offset
- * output: 0 if OK, -1 if error
- */
-int mmReserveMem( memHeap_t *heap, int offset,int size );
-int mmFreeReserved( memHeap_t *heap, int offset );
-
-/*
- * destroy MM
- */
-void mmDestroy( memHeap_t *mmInit );
-
-/* For debuging purpose. */
-void mmDumpMemInfo( memHeap_t *mmInit );
-
 #endif /* __SIS_DS_H__ */
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/sis_ds.c.old	2005-01-31 01:15:30.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/sis_ds.c	2005-01-31 01:18:53.000000000 +0100
@@ -194,32 +194,6 @@
 		return 0;
 }
 
-/* Kludgey workaround for existing i810 server.  Remove soon.
- */
-memHeap_t *mmAddRange( memHeap_t *heap,
-		       int ofs,
-		       int size )
-{
-	PMemBlock blocks;
-	blocks = (TMemBlock *)drm_calloc(2, sizeof(TMemBlock), DRM_MEM_DRIVER);
-	if (blocks != NULL) {
-		blocks[0].size = size;
-		blocks[0].free = 1;
-		blocks[0].ofs = ofs;
-		blocks[0].next = &blocks[1];
-
-		/* Discontinuity - stops JoinBlock from trying to join
-		 * non-adjacent ranges.
-		 */
-		blocks[1].size = 0;
-		blocks[1].free = 0;
-		blocks[1].ofs = ofs+size;
-		blocks[1].next = (PMemBlock)heap;
-		return (memHeap_t *)blocks;
-	} else
-		return heap;
-}
-
 static TMemBlock* SliceBlock(TMemBlock *p, 
 			     int startofs, int size, 
 			     int reserved, int alignment)
@@ -325,61 +299,3 @@
 	return 0;
 }
 
-int mmReserveMem(memHeap_t *heap, int offset,int size)
-{
-	int endofs;
-	TMemBlock *p;
-
-	if (heap == NULL || size <= 0)
-		return -1;
-
-	endofs = offset + size;
-	p = (TMemBlock *)heap;
-	while (p && p->ofs <= offset) {
-		if (ISFREE(p) && endofs <= (p->ofs+p->size)) {
-			SliceBlock(p,offset,size,1,1);
-			return 0;
-		}
-		p = p->next;
-	}
-	return -1;
-}
-
-int mmFreeReserved(memHeap_t *heap, int offset)
-{
-	TMemBlock *p,*prev;
-
-	if (heap == NULL)
-		return -1;
-
-	p = (TMemBlock *)heap;
-	prev = NULL;
-	while (p != NULL && p->ofs != offset) {
-		prev = p;
-		p = p->next;
-	}
-	if (p == NULL || !p->reserved)
-		return -1;
-
-	p->free = 1;
-	p->reserved = 0;
-	Join2Blocks(p);
-	if (prev != NULL)
-		Join2Blocks(prev);
-	return 0;
-}
-
-void mmDestroy(memHeap_t *heap)
-{
-	TMemBlock *p,*q;
-
-	if (heap == NULL)
-		return;
-
-	p = (TMemBlock *)heap;
-	while (p != NULL) {
-		q = p->next;
-		drm_free(p, sizeof(TMemBlock), DRM_MEM_DRIVER);
-		p = q;
-	}
-}
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/via_ds.h.old	2005-01-31 01:15:58.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/via_ds.h	2005-01-31 01:17:18.000000000 +0100
@@ -101,12 +101,4 @@
  */
 int via_mmFreeMem(PMemBlock b);
 
-/*
- * destroy MM
- */
-void via_mmDestroy(memHeap_t * mmInit);
-
-/* For debugging purpose. */
-void via_mmDumpMemInfo(memHeap_t * mmInit);
-
 #endif
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/via_ds.c.old	2005-01-31 01:16:09.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/via_ds.c	2005-01-31 01:24:14.000000000 +0100
@@ -32,7 +32,6 @@
 #include <asm/io.h>
 
 #include "via_ds.h"
-extern unsigned int VIA_DEBUG;
 
 set_t *via_setInit(void)
 {
@@ -126,31 +125,8 @@
 
 #define ISFREE(bptr) ((bptr)->free)
 
-#define PRINTF(fmt, arg...) do{}while(0)
 #define fprintf(fmt, arg...) do{}while(0)
 
-void via_mmDumpMemInfo(memHeap_t * heap)
-{
-	TMemBlock *p;
-
-	PRINTF("Memory heap %p:\n", heap);
-
-	if (heap == 0)
-		PRINTF("  heap == 0\n");
-	else {
-		p = (TMemBlock *) heap;
-
-		while (p) {
-			PRINTF("  Offset:%08x, Size:%08x, %c%c\n", p->ofs,
-			       p->size, p->free ? '.' : 'U',
-			       p->reserved ? 'R' : '.');
-			p = p->next;
-		}
-	}
-
-	PRINTF("End of memory blocks\n");
-}
-
 memHeap_t *via_mmInit(int ofs, int size)
 {
 	PMemBlock blocks;
@@ -169,29 +145,6 @@
 		return 0;
 }
 
-memHeap_t *via_mmAddRange(memHeap_t * heap, int ofs, int size)
-{
-	PMemBlock blocks;
-	blocks = (TMemBlock *) drm_calloc(2, sizeof(TMemBlock), DRM_MEM_DRIVER);
-
-	if (blocks) {
-		blocks[0].size = size;
-		blocks[0].free = 1;
-		blocks[0].ofs = ofs;
-		blocks[0].next = &blocks[1];
-
-		/* Discontinuity - stops JoinBlock from trying to join non-adjacent
-		 * ranges.
-		 */
-		blocks[1].size = 0;
-		blocks[1].free = 0;
-		blocks[1].ofs = ofs + size;
-		blocks[1].next = (PMemBlock) heap;
-		return (memHeap_t *) blocks;
-	} else
-		return heap;
-}
-
 static TMemBlock *SliceBlock(TMemBlock * p,
 			     int startofs, int size,
 			     int reserved, int alignment)
@@ -325,64 +278,3 @@
 	return 0;
 }
 
-int via_mmReserveMem(memHeap_t * heap, int offset, int size)
-{
-	int endofs;
-	TMemBlock *p;
-
-	if (!heap || size <= 0)
-		return -1;
-	endofs = offset + size;
-	p = (TMemBlock *) heap;
-
-	while (p && p->ofs <= offset) {
-		if (ISFREE(p) && endofs <= (p->ofs + p->size)) {
-			SliceBlock(p, offset, size, 1, 1);
-			return 0;
-		}
-		p = p->next;
-	}
-	return -1;
-}
-
-int via_mmFreeReserved(memHeap_t * heap, int offset)
-{
-	TMemBlock *p, *prev;
-
-	if (!heap)
-		return -1;
-
-	p = (TMemBlock *) heap;
-	prev = NULL;
-
-	while (p && p->ofs != offset) {
-		prev = p;
-		p = p->next;
-	}
-
-	if (!p || !p->reserved)
-		return -1;
-	p->free = 1;
-	p->reserved = 0;
-	Join2Blocks(p);
-
-	if (prev)
-		Join2Blocks(prev);
-
-	return 0;
-}
-
-void via_mmDestroy(memHeap_t * heap)
-{
-	TMemBlock *p, *q;
-
-	if (!heap)
-		return;
-	p = (TMemBlock *) heap;
-
-	while (p) {
-		q = p->next;
-		drm_free(p, sizeof(TMemBlock), DRM_MEM_DRIVER);
-		p = q;
-	}
-}
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/sis_drv.h.old	2005-01-31 01:19:38.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/sis_drv.h	2005-01-31 01:22:14.000000000 +0100
@@ -46,13 +46,6 @@
 	memHeap_t *FBHeap;
 } drm_sis_private_t;
 
-extern int sis_fb_alloc( DRM_IOCTL_ARGS );
-extern int sis_fb_free( DRM_IOCTL_ARGS );
-extern int sis_ioctl_agp_init( DRM_IOCTL_ARGS );
-extern int sis_ioctl_agp_alloc( DRM_IOCTL_ARGS );
-extern int sis_ioctl_agp_free( DRM_IOCTL_ARGS );
-extern int sis_fb_init( DRM_IOCTL_ARGS );
-
 extern int sis_init_context(drm_device_t *dev, int context);
 extern int sis_final_context(drm_device_t *dev, int context);
 
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/sis_mm.c.old	2005-01-31 01:20:00.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/sis_mm.c	2005-01-31 01:22:11.000000000 +0100
@@ -36,17 +36,6 @@
 #include <video/sisfb.h>
 #endif
 
-drm_ioctl_desc_t sis_ioctls[] = {
-	[DRM_IOCTL_NR(DRM_SIS_FB_ALLOC)]  = { sis_fb_alloc,        1, 0 },
-	[DRM_IOCTL_NR(DRM_SIS_FB_FREE)]   = { sis_fb_free,         1, 0 },
-	[DRM_IOCTL_NR(DRM_SIS_AGP_INIT)]  = { sis_ioctl_agp_init,  1, 1 },
-	[DRM_IOCTL_NR(DRM_SIS_AGP_ALLOC)] = { sis_ioctl_agp_alloc, 1, 0 },
-	[DRM_IOCTL_NR(DRM_SIS_AGP_FREE)]  = { sis_ioctl_agp_free,  1, 0 },
-	[DRM_IOCTL_NR(DRM_SIS_FB_INIT)]   = { sis_fb_init,         1, 1 }
-};
-
-int sis_max_ioctl = DRM_ARRAY_SIZE(sis_ioctls);
-
 #define MAX_CONTEXT 100
 #define VIDEO_TYPE 0 
 #define AGP_TYPE 1
@@ -91,12 +80,12 @@
 /* fb management via fb device */ 
 #if defined(__linux__) && defined(CONFIG_FB_SIS)
 
-int sis_fb_init( DRM_IOCTL_ARGS )
+static int sis_fb_init( DRM_IOCTL_ARGS )
 {
 	return 0;
 }
 
-int sis_fb_alloc( DRM_IOCTL_ARGS )
+static int sis_fb_alloc( DRM_IOCTL_ARGS )
 {
 	drm_sis_mem_t fb;
 	struct sis_memreq req;
@@ -129,7 +118,7 @@
 	return retval;
 }
 
-int sis_fb_free( DRM_IOCTL_ARGS )
+static int sis_fb_free( DRM_IOCTL_ARGS )
 {
 	drm_sis_mem_t fb;
 	int retval = 0;
@@ -160,7 +149,7 @@
  *    X driver/sisfb                                  HW-   Command-
  *  framebuffer memory           DRI heap           Cursor   queue
  */
-int sis_fb_init( DRM_IOCTL_ARGS )
+static int sis_fb_init( DRM_IOCTL_ARGS )
 {
 	DRM_DEVICE;
 	drm_sis_private_t *dev_priv = dev->dev_private;
@@ -186,7 +175,7 @@
 	return 0;
 }
 
-int sis_fb_alloc( DRM_IOCTL_ARGS )
+static int sis_fb_alloc( DRM_IOCTL_ARGS )
 {
 	DRM_DEVICE;
 	drm_sis_private_t *dev_priv = dev->dev_private;
@@ -223,7 +212,7 @@
 	return retval;
 }
 
-int sis_fb_free( DRM_IOCTL_ARGS )
+static int sis_fb_free( DRM_IOCTL_ARGS )
 {
 	DRM_DEVICE;
 	drm_sis_private_t *dev_priv = dev->dev_private;
@@ -250,7 +239,7 @@
 
 /* agp memory management */ 
 
-int sis_ioctl_agp_init( DRM_IOCTL_ARGS )
+static int sis_ioctl_agp_init( DRM_IOCTL_ARGS )
 {
 	DRM_DEVICE;
 	drm_sis_private_t *dev_priv = dev->dev_private;
@@ -276,7 +265,7 @@
 	return 0;
 }
 
-int sis_ioctl_agp_alloc( DRM_IOCTL_ARGS )
+static int sis_ioctl_agp_alloc( DRM_IOCTL_ARGS )
 {
 	DRM_DEVICE;
 	drm_sis_private_t *dev_priv = dev->dev_private;
@@ -313,7 +302,7 @@
 	return retval;
 }
 
-int sis_ioctl_agp_free( DRM_IOCTL_ARGS )
+static int sis_ioctl_agp_free( DRM_IOCTL_ARGS )
 {
 	DRM_DEVICE;
 	drm_sis_private_t *dev_priv = dev->dev_private;
@@ -414,3 +403,15 @@
 	
 	return 1;
 }
+
+
+drm_ioctl_desc_t sis_ioctls[] = {
+	[DRM_IOCTL_NR(DRM_SIS_FB_ALLOC)]  = { sis_fb_alloc,        1, 0 },
+	[DRM_IOCTL_NR(DRM_SIS_FB_FREE)]   = { sis_fb_free,         1, 0 },
+	[DRM_IOCTL_NR(DRM_SIS_AGP_INIT)]  = { sis_ioctl_agp_init,  1, 1 },
+	[DRM_IOCTL_NR(DRM_SIS_AGP_ALLOC)] = { sis_ioctl_agp_alloc, 1, 0 },
+	[DRM_IOCTL_NR(DRM_SIS_AGP_FREE)]  = { sis_ioctl_agp_free,  1, 0 },
+	[DRM_IOCTL_NR(DRM_SIS_FB_INIT)]   = { sis_fb_init,         1, 1 }
+};
+
+int sis_max_ioctl = DRM_ARRAY_SIZE(sis_ioctls);
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/via_drv.h.old	2005-01-31 01:22:30.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/via_drv.h	2005-01-31 01:23:24.000000000 +0100
@@ -70,7 +70,6 @@
 extern int via_init_context(drm_device_t * dev, int context);
 extern int via_final_context(drm_device_t * dev, int context);
 
-extern int via_do_init_map(drm_device_t * dev, drm_via_init_t * init);
 extern int via_do_cleanup_map(drm_device_t * dev);
 extern int via_map_init(struct inode *inode, struct file *filp,
 			unsigned int cmd, unsigned long arg);
@@ -84,7 +83,6 @@
 extern int via_dma_cleanup(drm_device_t * dev);
 extern void via_init_command_verifier(void);
 extern int via_verify_command_stream(const uint32_t * buf, unsigned int size, drm_device_t *dev);
-extern int via_wait_idle(drm_via_private_t * dev_priv);
 
 
 #endif
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/via_dma.c.old	2005-01-31 01:22:47.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/via_dma.c	2005-01-31 01:23:07.000000000 +0100
@@ -37,6 +37,8 @@
 static void via_cmdbuf_reset(drm_via_private_t * dev_priv);
 static void via_cmdbuf_rewind(drm_via_private_t * dev_priv);
 
+static int via_wait_idle(drm_via_private_t * dev_priv);
+
 /*
  * Free space in command buffer.
  */
@@ -483,7 +485,7 @@
 
 
 
-int via_wait_idle(drm_via_private_t * dev_priv)
+static int via_wait_idle(drm_via_private_t * dev_priv)
 {
 	int count = 10000000;
 	while (count-- && (VIA_READ(VIA_REG_STATUS) &
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/via_map.c.old	2005-01-31 01:23:33.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/via_map.c	2005-01-31 01:23:38.000000000 +0100
@@ -25,7 +25,7 @@
 #include "via_drm.h"
 #include "via_drv.h"
 
-int via_do_init_map(drm_device_t * dev, drm_via_init_t * init)
+static int via_do_init_map(drm_device_t * dev, drm_via_init_t * init)
 {
 	drm_via_private_t *dev_priv;
 	unsigned int i;
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/via_mm.h.old	2005-01-31 01:24:48.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/via_mm.h	2005-01-31 01:26:40.000000000 +0100
@@ -37,9 +37,4 @@
 	void *virtual;
 } drm_via_dma_t;
 
-int via_fb_alloc(drm_via_mem_t * mem);
-int via_fb_free(drm_via_mem_t * mem);
-int via_agp_alloc(drm_via_mem_t * mem);
-int via_agp_free(drm_via_mem_t * mem);
-
 #endif
--- linux-2.6.11-rc2-mm2-full/drivers/char/drm/via_mm.c.old	2005-01-31 01:24:25.000000000 +0100
+++ linux-2.6.11-rc2-mm2-full/drivers/char/drm/via_mm.c	2005-01-31 01:26:54.000000000 +0100
@@ -29,8 +29,6 @@
 
 #define MAX_CONTEXT 100
 
-unsigned int VIA_DEBUG = 1;
-
 typedef struct {
 	int used;
 	int context;
@@ -39,6 +37,11 @@
 
 static via_context_t global_ppriv[MAX_CONTEXT];
 
+static int via_agp_alloc(drm_via_mem_t * mem);
+static int via_agp_free(drm_via_mem_t * mem);
+static int via_fb_alloc(drm_via_mem_t * mem);
+static int via_fb_free(drm_via_mem_t * mem);
+
 static int add_alloc_set(int context, int type, unsigned int val)
 {
 	int i, retval = 0;
@@ -204,7 +207,7 @@
 	return -EFAULT;
 }
 
-int via_fb_alloc(drm_via_mem_t * mem)
+static int via_fb_alloc(drm_via_mem_t * mem)
 {
 	drm_via_mm_t fb;
 	PMemBlock block;
@@ -241,7 +244,7 @@
 	return retval;
 }
 
-int via_agp_alloc(drm_via_mem_t * mem)
+static int via_agp_alloc(drm_via_mem_t * mem)
 {
 	drm_via_mm_t agp;
 	PMemBlock block;
@@ -297,7 +300,7 @@
 	return -EFAULT;
 }
 
-int via_fb_free(drm_via_mem_t * mem)
+static int via_fb_free(drm_via_mem_t * mem)
 {
 	drm_via_mm_t fb;
 	int retval = 0;

