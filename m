Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261793AbVEVMFZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbVEVMFZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 08:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261790AbVEVMFZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 08:05:25 -0400
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:25565 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S261794AbVEVMCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 08:02:40 -0400
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Greg K-H <greg@kroah.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Jens Axboe <axboe@suse.de>
Subject: Re: [PATCH] Fix root hole in raw device
References: <11163046682662@kroah.com> <11163046681444@kroah.com>
	<20050517045748.GO1150@parcelfarce.linux.theplanet.co.uk>
	<1116335082.1963.58.camel@sisko.sctweedie.blueyonder.co.uk>
	<20050517165353.GB29811@parcelfarce.linux.theplanet.co.uk>
	<m3ekbz79wh.fsf@telia.com>
From: Peter Osterlund <petero2@telia.com>
Date: 22 May 2005 13:57:14 +0200
In-Reply-To: <m3ekbz79wh.fsf@telia.com>
Message-ID: <m3acmn79t1.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund <petero2@telia.com> writes:

> Al Viro <viro@parcelfarce.linux.theplanet.co.uk> writes:
> 
> > On Tue, May 17, 2005 at 02:04:42PM +0100, Stephen C. Tweedie wrote:
> > > 
> > > On Tue, 2005-05-17 at 05:57, Al Viro wrote:
> > > 
> > > > That is not quite correct.  You are passing very odd filp to ->ioctl()...
> > > > Old variant gave NULL, which is also not too nice, though.
> > > 
> > > Which would you prefer?  I guess that if there _are_ going to be
> > > problems, we'd be better off finding them early by passing in the NULL
> > > value.
> > 
> > For now I'd rather pass NULL.  Longer term (== post 2.6.12, since There Is No
> > 2.7(tm)) - just remove the struct file * argument of bdev ioctl and have
> > int flags used instead, with "opened for write" and "opened non-blocking"
> > passed in it.  And switch the inode argument to bdev...
> 
> Switching the inode argument to bdev would first require doing the
> same switch in cdrom_ioctl(), which the patch below does.

And this patch does the same for the blkdev_ioctl() function.

-
Switch the inode argument in blkdev_ioctl() from inode to bdev.
Suggested by Al Viro.

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 linux-petero/arch/um/drivers/ubd_kern.c      |    8 ++++----
 linux-petero/drivers/acorn/block/fd1772.c    |    6 ++----
 linux-petero/drivers/acorn/block/mfmhd.c     |    6 +++---
 linux-petero/drivers/block/DAC960.c          |    6 +++---
 linux-petero/drivers/block/acsi.c            |    8 ++++----
 linux-petero/drivers/block/amiflop.c         |    8 ++++----
 linux-petero/drivers/block/aoe/aoeblk.c      |    6 +++---
 linux-petero/drivers/block/ataflop.c         |    8 ++++----
 linux-petero/drivers/block/cciss.c           |    9 ++++-----
 linux-petero/drivers/block/cpqarray.c        |   12 ++++++------
 linux-petero/drivers/block/floppy.c          |   10 +++++-----
 linux-petero/drivers/block/ioctl.c           |    9 ++++-----
 linux-petero/drivers/block/loop.c            |   10 +++++-----
 linux-petero/drivers/block/nbd.c             |   20 ++++++++++----------
 linux-petero/drivers/block/paride/pcd.c      |    6 +++---
 linux-petero/drivers/block/paride/pd.c       |    6 +++---
 linux-petero/drivers/block/paride/pf.c       |    6 +++---
 linux-petero/drivers/block/pktcdvd.c         |   10 +++++-----
 linux-petero/drivers/block/ps2esdi.c         |    8 ++++----
 linux-petero/drivers/block/rd.c              |    3 +--
 linux-petero/drivers/block/swim3.c           |    6 +++---
 linux-petero/drivers/block/swim_iop.c        |    6 +++---
 linux-petero/drivers/block/sx8.c             |    8 ++++----
 linux-petero/drivers/block/ub.c              |    4 ++--
 linux-petero/drivers/block/umem.c            |    6 +++---
 linux-petero/drivers/block/viodasd.c         |    6 +++---
 linux-petero/drivers/block/xd.c              |    6 +++---
 linux-petero/drivers/block/xd.h              |    2 +-
 linux-petero/drivers/cdrom/aztcd.c           |    6 ++----
 linux-petero/drivers/cdrom/cdu31a.c          |    4 ++--
 linux-petero/drivers/cdrom/cm206.c           |    4 ++--
 linux-petero/drivers/cdrom/gscd.c            |    4 ++--
 linux-petero/drivers/cdrom/mcdx.c            |    6 +++---
 linux-petero/drivers/cdrom/optcd.c           |    5 +----
 linux-petero/drivers/cdrom/sbpcd.c           |    6 +++---
 linux-petero/drivers/cdrom/sjcd.c            |    2 +-
 linux-petero/drivers/cdrom/sonycd535.c       |    2 +-
 linux-petero/drivers/cdrom/viocd.c           |    6 +++---
 linux-petero/drivers/char/raw.c              |    2 +-
 linux-petero/drivers/ide/ide-cd.c            |    5 ++---
 linux-petero/drivers/ide/ide-disk.c          |    3 +--
 linux-petero/drivers/ide/ide-floppy.c        |    3 +--
 linux-petero/drivers/ide/ide-tape.c          |    3 +--
 linux-petero/drivers/ide/legacy/hd.c         |    6 +++---
 linux-petero/drivers/md/md.c                 |    6 +++---
 linux-petero/drivers/message/i2o/i2o_block.c |    6 +++---
 linux-petero/drivers/mmc/mmc_block.c         |    4 +---
 linux-petero/drivers/mtd/mtd_blkdevs.c       |    6 +++---
 linux-petero/drivers/s390/block/dasd_int.h   |    2 +-
 linux-petero/drivers/s390/block/dasd_ioctl.c |    4 ++--
 linux-petero/drivers/s390/block/xpram.c      |    2 +-
 linux-petero/drivers/s390/char/tape_block.c  |   10 +++++-----
 linux-petero/drivers/scsi/ide-scsi.c         |    3 +--
 linux-petero/drivers/scsi/sd.c               |    3 +--
 linux-petero/drivers/scsi/sr.c               |    6 +++---
 linux-petero/fs/block_dev.c                  |    4 ++--
 linux-petero/include/linux/fs.h              |    4 ++--
 57 files changed, 159 insertions(+), 177 deletions(-)

diff -puN arch/um/drivers/ubd_kern.c~blkdev_ioctl_use_bdev arch/um/drivers/ubd_kern.c
--- linux/arch/um/drivers/ubd_kern.c~blkdev_ioctl_use_bdev	2005-05-22 12:47:38.000000000 +0200
+++ linux-petero/arch/um/drivers/ubd_kern.c	2005-05-22 12:47:38.000000000 +0200
@@ -115,7 +115,7 @@ static void (*do_ubd)(void);
 
 static int ubd_open(struct inode * inode, struct file * filp);
 static int ubd_release(struct inode * inode, struct file * file);
-static int ubd_ioctl(struct inode * inode, struct file * file,
+static int ubd_ioctl(struct block_device * bdev, struct file * file,
 		     unsigned int cmd, unsigned long arg);
 
 #define MAX_DEV (8)
@@ -1042,11 +1042,11 @@ static void do_ubd_request(request_queue
 	}
 }
 
-static int ubd_ioctl(struct inode * inode, struct file * file,
+static int ubd_ioctl(struct block_device * bdev, struct file * file,
 		     unsigned int cmd, unsigned long arg)
 {
 	struct hd_geometry __user *loc = (struct hd_geometry __user *) arg;
-	struct ubd *dev = inode->i_bdev->bd_disk->private_data;
+	struct ubd *dev = bdev->bd_disk->private_data;
 	struct hd_driveid ubd_id = {
 		.cyls		= 0,
 		.heads		= 128,
@@ -1061,7 +1061,7 @@ static int ubd_ioctl(struct inode * inod
 		g.heads = 128;
 		g.sectors = 32;
 		g.cylinders = dev->size / (128 * 32 * 512);
-		g.start = get_start_sect(inode->i_bdev);
+		g.start = get_start_sect(bdev);
 		return(copy_to_user(loc, &g, sizeof(g)) ? -EFAULT : 0);
 
 	case HDIO_GET_IDENTITY:
diff -puN drivers/acorn/block/fd1772.c~blkdev_ioctl_use_bdev drivers/acorn/block/fd1772.c
--- linux/drivers/acorn/block/fd1772.c~blkdev_ioctl_use_bdev	2005-05-22 12:47:38.000000000 +0200
+++ linux-petero/drivers/acorn/block/fd1772.c	2005-05-22 12:47:38.000000000 +0200
@@ -365,7 +365,7 @@ static void finish_fdc_done(int dummy);
 static void floppy_off(unsigned int nr);
 static void setup_req_params(int drive);
 static void redo_fd_request(void);
-static int fd_ioctl(struct inode *inode, struct file *filp, unsigned int
+static int fd_ioctl(struct block_device *bdev, struct file *filp, unsigned int
 		    cmd, unsigned long param);
 static void fd_probe(int drive);
 static int fd_test_drive_present(int drive);
@@ -1309,11 +1309,9 @@ static int invalidate_drive(struct block
 	return 0;
 }
 
-static int fd_ioctl(struct inode *inode, struct file *filp,
+static int fd_ioctl(struct block_device *bdev, struct file *filp,
 		    unsigned int cmd, unsigned long param)
 {
-	struct block_device *bdev = inode->i_bdev;
-
 	switch (cmd) {
 	case FDFMTEND:
 	case FDFLUSH:
diff -puN drivers/acorn/block/mfmhd.c~blkdev_ioctl_use_bdev drivers/acorn/block/mfmhd.c
--- linux/drivers/acorn/block/mfmhd.c~blkdev_ioctl_use_bdev	2005-05-22 12:47:38.000000000 +0200
+++ linux-petero/drivers/acorn/block/mfmhd.c	2005-05-22 12:47:38.000000000 +0200
@@ -1153,9 +1153,9 @@ static int mfm_initdrives(void)
  * The 'front' end of the mfm driver follows...
  */
 
-static int mfm_ioctl(struct inode *inode, struct file *file, u_int cmd, u_long arg)
+static int mfm_ioctl(struct block_device *bdev, struct file *file, u_int cmd, u_long arg)
 {
-	struct mfm_info *p = inode->i_bdev->bd_disk->private_data;
+	struct mfm_info *p = bdev->bd_disk->private_data;
 	struct hd_geometry *geo = (struct hd_geometry *) arg;
 	if (cmd != HDIO_GETGEO)
 		return -EINVAL;
@@ -1167,7 +1167,7 @@ static int mfm_ioctl(struct inode *inode
 		return -EFAULT;
 	if (put_user (p->cylinders, &geo->cylinders))
 		return -EFAULT;
-	if (put_user (get_start_sect(inode->i_bdev), &geo->start))
+	if (put_user (get_start_sect(bdev), &geo->start))
 		return -EFAULT;
 	return 0;
 }
diff -puN drivers/block/DAC960.c~blkdev_ioctl_use_bdev drivers/block/DAC960.c
--- linux/drivers/block/DAC960.c~blkdev_ioctl_use_bdev	2005-05-22 12:47:38.000000000 +0200
+++ linux-petero/drivers/block/DAC960.c	2005-05-22 12:47:38.000000000 +0200
@@ -92,10 +92,10 @@ static int DAC960_open(struct inode *ino
 	return 0;
 }
 
-static int DAC960_ioctl(struct inode *inode, struct file *file,
+static int DAC960_ioctl(struct block_device *bdev, struct file *file,
 			unsigned int cmd, unsigned long arg)
 {
-	struct gendisk *disk = inode->i_bdev->bd_disk;
+	struct gendisk *disk = bdev->bd_disk;
 	DAC960_Controller_T *p = disk->queue->queuedata;
 	int drive_nr = (long)disk->private_data;
 	struct hd_geometry g;
@@ -130,7 +130,7 @@ static int DAC960_ioctl(struct inode *in
 		g.cylinders = i->ConfigurableDeviceSize / (g.heads * g.sectors);
 	}
 	
-	g.start = get_start_sect(inode->i_bdev);
+	g.start = get_start_sect(bdev);
 
 	return copy_to_user(loc, &g, sizeof g) ? -EFAULT : 0; 
 }
diff -puN drivers/block/acsi.c~blkdev_ioctl_use_bdev drivers/block/acsi.c
--- linux/drivers/block/acsi.c~blkdev_ioctl_use_bdev	2005-05-22 12:47:38.000000000 +0200
+++ linux-petero/drivers/block/acsi.c	2005-05-22 12:47:38.000000000 +0200
@@ -359,7 +359,7 @@ static void copy_from_acsibuffer( void )
 static void do_end_requests( void );
 static void do_acsi_request( request_queue_t * );
 static void redo_acsi_request( void );
-static int acsi_ioctl( struct inode *inode, struct file *file, unsigned int
+static int acsi_ioctl( struct block_device *bdev, struct file *file, unsigned int
                        cmd, unsigned long arg );
 static int acsi_open( struct inode * inode, struct file * filp );
 static int acsi_release( struct inode * inode, struct file * file );
@@ -1081,10 +1081,10 @@ static void redo_acsi_request( void )
  ***********************************************************************/
 
 
-static int acsi_ioctl( struct inode *inode, struct file *file,
+static int acsi_ioctl( struct block_device *bdev, struct file *file,
 					   unsigned int cmd, unsigned long arg )
 {
-	struct gendisk *disk = inode->i_bdev->bd_disk;
+	struct gendisk *disk = bdev->bd_disk;
 	struct acsi_info_struct *aip = disk->private_data;
 	switch (cmd) {
 	  case HDIO_GETGEO:
@@ -1096,7 +1096,7 @@ static int acsi_ioctl( struct inode *ino
 	    put_user( 64, &geo->heads );
 	    put_user( 32, &geo->sectors );
 	    put_user( aip->size >> 11, &geo->cylinders );
-		put_user(get_start_sect(inode->i_bdev), &geo->start);
+		put_user(get_start_sect(bdev), &geo->start);
 		return 0;
 	  }
 	  case SCSI_IOCTL_GET_IDLUN:
diff -puN drivers/block/amiflop.c~blkdev_ioctl_use_bdev drivers/block/amiflop.c
--- linux/drivers/block/amiflop.c~blkdev_ioctl_use_bdev	2005-05-22 12:47:38.000000000 +0200
+++ linux-petero/drivers/block/amiflop.c	2005-05-22 12:47:38.000000000 +0200
@@ -1424,10 +1424,10 @@ static void do_fd_request(request_queue_
 	redo_fd_request();
 }
 
-static int fd_ioctl(struct inode *inode, struct file *filp,
+static int fd_ioctl(struct block_device *bdev, struct file *filp,
 		    unsigned int cmd, unsigned long param)
 {
-	int drive = iminor(inode) & 3;
+	int drive = iminor(bdev->bd_inode) & 3;
 	static struct floppy_struct getprm;
 
 	switch(cmd){
@@ -1449,7 +1449,7 @@ static int fd_ioctl(struct inode *inode,
 			rel_fdc();
 			return -EBUSY;
 		}
-		fsync_bdev(inode->i_bdev);
+		fsync_bdev(bdev);
 		if (fd_motor_on(drive) == 0) {
 			rel_fdc();
 			return -ENODEV;
@@ -1478,7 +1478,7 @@ static int fd_ioctl(struct inode *inode,
 		break;
 	case FDFMTEND:
 		floppy_off(drive);
-		invalidate_bdev(inode->i_bdev, 0);
+		invalidate_bdev(bdev, 0);
 		break;
 	case FDGETPRM:
 		memset((void *)&getprm, 0, sizeof (getprm));
diff -puN drivers/block/aoe/aoeblk.c~blkdev_ioctl_use_bdev drivers/block/aoe/aoeblk.c
--- linux/drivers/block/aoe/aoeblk.c~blkdev_ioctl_use_bdev	2005-05-22 12:47:38.000000000 +0200
+++ linux-petero/drivers/block/aoe/aoeblk.c	2005-05-22 12:47:38.000000000 +0200
@@ -174,21 +174,21 @@ aoeblk_make_request(request_queue_t *q, 
  * block device directly.
  */
 static int
-aoeblk_ioctl(struct inode *inode, struct file *filp, uint cmd, ulong arg)
+aoeblk_ioctl(struct block_device *bdev, struct file *filp, uint cmd, ulong arg)
 {
 	struct aoedev *d;
 
 	if (!arg)
 		return -EINVAL;
 
-	d = inode->i_bdev->bd_disk->private_data;
+	d = bdev->bd_disk->private_data;
 	if ((d->flags & DEVFL_UP) == 0) {
 		printk(KERN_ERR "aoe: aoeblk_ioctl: disk not up\n");
 		return -ENODEV;
 	}
 
 	if (cmd == HDIO_GETGEO) {
-		d->geo.start = get_start_sect(inode->i_bdev);
+		d->geo.start = get_start_sect(bdev);
 		if (!copy_to_user((void __user *) arg, &d->geo, sizeof d->geo))
 			return 0;
 		return -EFAULT;
diff -puN drivers/block/ataflop.c~blkdev_ioctl_use_bdev drivers/block/ataflop.c
--- linux/drivers/block/ataflop.c~blkdev_ioctl_use_bdev	2005-05-22 12:47:38.000000000 +0200
+++ linux-petero/drivers/block/ataflop.c	2005-05-22 12:47:38.000000000 +0200
@@ -361,7 +361,7 @@ static void finish_fdc( void );
 static void finish_fdc_done( int dummy );
 static void setup_req_params( int drive );
 static void redo_fd_request( void);
-static int fd_ioctl( struct inode *inode, struct file *filp, unsigned int
+static int fd_ioctl( struct block_device *bdev, struct file *filp, unsigned int
                      cmd, unsigned long param);
 static void fd_probe( int drive );
 static int fd_test_drive_present( int drive );
@@ -1489,10 +1489,10 @@ void do_fd_request(request_queue_t * q)
 	atari_enable_irq( IRQ_MFP_FDC );
 }
 
-static int fd_ioctl(struct inode *inode, struct file *filp,
+static int fd_ioctl(struct block_device *bdev, struct file *filp,
 		    unsigned int cmd, unsigned long param)
 {
-	struct gendisk *disk = inode->i_bdev->bd_disk;
+	struct gendisk *disk = bdev->bd_disk;
 	struct atari_floppy_struct *floppy = disk->private_data;
 	int drive = floppy - unit;
 	int type = floppy->type;
@@ -1666,7 +1666,7 @@ static int fd_ioctl(struct inode *inode,
 		/* invalidate the buffer track to force a reread */
 		BufferDrive = -1;
 		set_bit(drive, &fake_change);
-		check_disk_change(inode->i_bdev);
+		check_disk_change(bdev);
 		return 0;
 	default:
 		return -EINVAL;
diff -puN drivers/block/cciss.c~blkdev_ioctl_use_bdev drivers/block/cciss.c
--- linux/drivers/block/cciss.c~blkdev_ioctl_use_bdev	2005-05-22 12:47:38.000000000 +0200
+++ linux-petero/drivers/block/cciss.c	2005-05-22 12:47:38.000000000 +0200
@@ -133,7 +133,7 @@ static ctlr_info_t *hba[MAX_CTLR];
 static void do_cciss_request(request_queue_t *q);
 static int cciss_open(struct inode *inode, struct file *filep);
 static int cciss_release(struct inode *inode, struct file *filep);
-static int cciss_ioctl(struct inode *inode, struct file *filep, 
+static int cciss_ioctl(struct block_device *bdev, struct file *filep,
 		unsigned int cmd, unsigned long arg);
 
 static int revalidate_allvol(ctlr_info_t *host);
@@ -499,7 +499,7 @@ static int do_ioctl(struct file *f, unsi
 {
 	int ret;
 	lock_kernel();
-	ret = cciss_ioctl(f->f_dentry->d_inode, f, cmd, arg);
+	ret = cciss_ioctl(f->f_dentry->d_inode->i_bdev, f, cmd, arg);
 	unlock_kernel();
 	return ret;
 }
@@ -601,10 +601,9 @@ static int cciss_ioctl32_big_passthru(st
 /*
  * ioctl 
  */
-static int cciss_ioctl(struct inode *inode, struct file *filep, 
+static int cciss_ioctl(struct block_device *bdev, struct file *filep,
 		unsigned int cmd, unsigned long arg)
 {
-	struct block_device *bdev = inode->i_bdev;
 	struct gendisk *disk = bdev->bd_disk;
 	ctlr_info_t *host = get_host(disk);
 	drive_info_struct *drv = get_drv(disk);
@@ -625,7 +624,7 @@ static int cciss_ioctl(struct inode *ino
                         driver_geo.cylinders = drv->cylinders;
                 } else
 			return -ENXIO;
-                driver_geo.start= get_start_sect(inode->i_bdev);
+                driver_geo.start= get_start_sect(bdev);
                 if (copy_to_user(argp, &driver_geo, sizeof(struct hd_geometry)))
                         return  -EFAULT;
                 return(0);
diff -puN drivers/block/cpqarray.c~blkdev_ioctl_use_bdev drivers/block/cpqarray.c
--- linux/drivers/block/cpqarray.c~blkdev_ioctl_use_bdev	2005-05-22 12:47:38.000000000 +0200
+++ linux-petero/drivers/block/cpqarray.c	2005-05-22 13:07:05.000000000 +0200
@@ -159,7 +159,7 @@ static int sendcmd(
 
 static int ida_open(struct inode *inode, struct file *filep);
 static int ida_release(struct inode *inode, struct file *filep);
-static int ida_ioctl(struct inode *inode, struct file *filep, unsigned int cmd, unsigned long arg);
+static int ida_ioctl(struct block_device *bdev, struct file *filep, unsigned int cmd, unsigned long arg);
 static int ida_ctlr_ioctl(ctlr_info_t *h, int dsk, ida_ioctl_t *io);
 
 static void do_ida_request(request_queue_t *q);
@@ -1128,10 +1128,10 @@ static void ida_timer(unsigned long tdat
  *  ida_ioctl does some miscellaneous stuff like reporting drive geometry,
  *  setting readahead and submitting commands from userspace to the controller.
  */
-static int ida_ioctl(struct inode *inode, struct file *filep, unsigned int cmd, unsigned long arg)
+static int ida_ioctl(struct block_device *bdev, struct file *filep, unsigned int cmd, unsigned long arg)
 {
-	drv_info_t *drv = get_drv(inode->i_bdev->bd_disk);
-	ctlr_info_t *host = get_host(inode->i_bdev->bd_disk);
+	drv_info_t *drv = get_drv(bdev->bd_disk);
+	ctlr_info_t *host = get_host(bdev->bd_disk);
 	int error;
 	int diskinfo[4];
 	struct hd_geometry __user *geo = (struct hd_geometry __user *)arg;
@@ -1152,7 +1152,7 @@ static int ida_ioctl(struct inode *inode
 		put_user(diskinfo[0], &geo->heads);
 		put_user(diskinfo[1], &geo->sectors);
 		put_user(diskinfo[2], &geo->cylinders);
-		put_user(get_start_sect(inode->i_bdev), &geo->start);
+		put_user(get_start_sect(bdev), &geo->start);
 		return 0;
 	case IDAGETDRVINFO:
 		if (copy_to_user(&io->c.drv, drv, sizeof(drv_info_t)))
@@ -1182,7 +1182,7 @@ out_passthru:
 		put_user(host->ctlr_sig, (int __user *)arg);
 		return 0;
 	case IDAREVALIDATEVOLS:
-		if (iminor(inode) != 0)
+		if (iminor(bdev->bd_inode) != 0)
 			return -ENXIO;
 		return revalidate_allvol(host);
 	case IDADRIVERVERSION:
diff -puN drivers/block/floppy.c~blkdev_ioctl_use_bdev drivers/block/floppy.c
--- linux/drivers/block/floppy.c~blkdev_ioctl_use_bdev	2005-05-22 12:47:38.000000000 +0200
+++ linux-petero/drivers/block/floppy.c	2005-05-22 12:47:38.000000000 +0200
@@ -3443,14 +3443,14 @@ static int get_floppy_geometry(int drive
 	return 0;
 }
 
-static int fd_ioctl(struct inode *inode, struct file *filp, unsigned int cmd,
+static int fd_ioctl(struct block_device *bdev, struct file *filp, unsigned int cmd,
 		    unsigned long param)
 {
 #define FD_IOCTL_ALLOWED ((filp) && (filp)->private_data)
 #define OUT(c,x) case c: outparam = (const char *) (x); break
 #define IN(c,x,tag) case c: *(x) = inparam. tag ; return 0
 
-	int drive = (long)inode->i_bdev->bd_disk->private_data;
+	int drive = (long)bdev->bd_disk->private_data;
 	int i, type = ITYPE(UDRS->fd_device);
 	int ret;
 	int size;
@@ -3525,11 +3525,11 @@ static int fd_ioctl(struct inode *inode,
 			current_type[drive] = NULL;
 			floppy_sizes[drive] = MAX_DISK_SIZE << 1;
 			UDRS->keep_data = 0;
-			return invalidate_drive(inode->i_bdev);
+			return invalidate_drive(bdev);
 		case FDSETPRM:
 		case FDDEFPRM:
 			return set_geometry(cmd, &inparam.g,
-					    drive, type, inode->i_bdev);
+					    drive, type, bdev);
 		case FDGETPRM:
 			ECALL(get_floppy_geometry(drive, type,
 						  (struct floppy_struct **)
@@ -3560,7 +3560,7 @@ static int fd_ioctl(struct inode *inode,
 		case FDFMTEND:
 		case FDFLUSH:
 			LOCK_FDC(drive, 1);
-			return invalidate_drive(inode->i_bdev);
+			return invalidate_drive(bdev);
 
 		case FDSETEMSGTRESH:
 			UDP->max_errors.reporting =
diff -puN drivers/block/ioctl.c~blkdev_ioctl_use_bdev drivers/block/ioctl.c
--- linux/drivers/block/ioctl.c~blkdev_ioctl_use_bdev	2005-05-22 12:47:38.000000000 +0200
+++ linux-petero/drivers/block/ioctl.c	2005-05-22 12:47:38.000000000 +0200
@@ -133,10 +133,9 @@ static int put_u64(unsigned long arg, u6
 	return put_user(val, (u64 __user *)arg);
 }
 
-int blkdev_ioctl(struct inode *inode, struct file *file, unsigned cmd,
+int blkdev_ioctl(struct block_device *bdev, struct file *file, unsigned cmd,
 			unsigned long arg)
 {
-	struct block_device *bdev = inode->i_bdev;
 	struct gendisk *disk = bdev->bd_disk;
 	struct backing_dev_info *bdi;
 	int ret, n;
@@ -194,7 +193,7 @@ int blkdev_ioctl(struct inode *inode, st
 		if (!capable(CAP_SYS_ADMIN))
 			return -EACCES;
 		if (disk->fops->ioctl) {
-			ret = disk->fops->ioctl(inode, file, cmd, arg);
+			ret = disk->fops->ioctl(bdev, file, cmd, arg);
 			/* -EINVAL to handle old uncorrected drivers */
 			if (ret != -EINVAL && ret != -ENOTTY)
 				return ret;
@@ -204,7 +203,7 @@ int blkdev_ioctl(struct inode *inode, st
 		return 0;
 	case BLKROSET:
 		if (disk->fops->ioctl) {
-			ret = disk->fops->ioctl(inode, file, cmd, arg);
+			ret = disk->fops->ioctl(bdev, file, cmd, arg);
 			/* -EINVAL to handle old uncorrected drivers */
 			if (ret != -EINVAL && ret != -ENOTTY)
 				return ret;
@@ -217,7 +216,7 @@ int blkdev_ioctl(struct inode *inode, st
 		return 0;
 	default:
 		if (disk->fops->ioctl)
-			return disk->fops->ioctl(inode, file, cmd, arg);
+			return disk->fops->ioctl(bdev, file, cmd, arg);
 	}
 	return -ENOTTY;
 }
diff -puN drivers/block/loop.c~blkdev_ioctl_use_bdev drivers/block/loop.c
--- linux/drivers/block/loop.c~blkdev_ioctl_use_bdev	2005-05-22 12:47:38.000000000 +0200
+++ linux-petero/drivers/block/loop.c	2005-05-22 12:47:38.000000000 +0200
@@ -1133,22 +1133,22 @@ loop_get_status64(struct loop_device *lo
 	return err;
 }
 
-static int lo_ioctl(struct inode * inode, struct file * file,
+static int lo_ioctl(struct block_device * bdev, struct file * file,
 	unsigned int cmd, unsigned long arg)
 {
-	struct loop_device *lo = inode->i_bdev->bd_disk->private_data;
+	struct loop_device *lo = bdev->bd_disk->private_data;
 	int err;
 
 	down(&lo->lo_ctl_mutex);
 	switch (cmd) {
 	case LOOP_SET_FD:
-		err = loop_set_fd(lo, file, inode->i_bdev, arg);
+		err = loop_set_fd(lo, file, bdev, arg);
 		break;
 	case LOOP_CHANGE_FD:
-		err = loop_change_fd(lo, file, inode->i_bdev, arg);
+		err = loop_change_fd(lo, file, bdev, arg);
 		break;
 	case LOOP_CLR_FD:
-		err = loop_clr_fd(lo, inode->i_bdev);
+		err = loop_clr_fd(lo, bdev);
 		break;
 	case LOOP_SET_STATUS:
 		err = loop_set_status_old(lo, (struct loop_info __user *) arg);
diff -puN drivers/block/nbd.c~blkdev_ioctl_use_bdev drivers/block/nbd.c
--- linux/drivers/block/nbd.c~blkdev_ioctl_use_bdev	2005-05-22 12:47:38.000000000 +0200
+++ linux-petero/drivers/block/nbd.c	2005-05-22 12:47:38.000000000 +0200
@@ -491,10 +491,10 @@ error_out:
 	return;
 }
 
-static int nbd_ioctl(struct inode *inode, struct file *file,
+static int nbd_ioctl(struct block_device *bdev, struct file *file,
 		     unsigned int cmd, unsigned long arg)
 {
-	struct nbd_device *lo = inode->i_bdev->bd_disk->private_data;
+	struct nbd_device *lo = bdev->bd_disk->private_data;
 	int error;
 	struct request sreq ;
 
@@ -549,7 +549,7 @@ static int nbd_ioctl(struct inode *inode
 		error = -EINVAL;
 		file = fget(arg);
 		if (file) {
-			inode = file->f_dentry->d_inode;
+			struct inode *inode = file->f_dentry->d_inode;
 			if (S_ISSOCK(inode->i_mode)) {
 				lo->file = file;
 				lo->sock = SOCKET_I(inode);
@@ -562,20 +562,20 @@ static int nbd_ioctl(struct inode *inode
 	case NBD_SET_BLKSIZE:
 		lo->blksize = arg;
 		lo->bytesize &= ~(lo->blksize-1);
-		inode->i_bdev->bd_inode->i_size = lo->bytesize;
-		set_blocksize(inode->i_bdev, lo->blksize);
+		bdev->bd_inode->i_size = lo->bytesize;
+		set_blocksize(bdev, lo->blksize);
 		set_capacity(lo->disk, lo->bytesize >> 9);
 		return 0;
 	case NBD_SET_SIZE:
 		lo->bytesize = arg & ~(lo->blksize-1);
-		inode->i_bdev->bd_inode->i_size = lo->bytesize;
-		set_blocksize(inode->i_bdev, lo->blksize);
+		bdev->bd_inode->i_size = lo->bytesize;
+		set_blocksize(bdev, lo->blksize);
 		set_capacity(lo->disk, lo->bytesize >> 9);
 		return 0;
 	case NBD_SET_SIZE_BLOCKS:
 		lo->bytesize = ((u64) arg) * lo->blksize;
-		inode->i_bdev->bd_inode->i_size = lo->bytesize;
-		set_blocksize(inode->i_bdev, lo->blksize);
+		bdev->bd_inode->i_size = lo->bytesize;
+		set_blocksize(bdev, lo->blksize);
 		set_capacity(lo->disk, lo->bytesize >> 9);
 		return 0;
 	case NBD_DO_IT:
@@ -619,7 +619,7 @@ static int nbd_ioctl(struct inode *inode
 		return 0;
 	case NBD_PRINT_DEBUG:
 		printk(KERN_INFO "%s: next = %p, prev = %p, head = %p\n",
-			inode->i_bdev->bd_disk->disk_name,
+			bdev->bd_disk->disk_name,
 			lo->queue_head.next, lo->queue_head.prev,
 			&lo->queue_head);
 		return 0;
diff -puN drivers/block/paride/pcd.c~blkdev_ioctl_use_bdev drivers/block/paride/pcd.c
--- linux/drivers/block/paride/pcd.c~blkdev_ioctl_use_bdev	2005-05-22 12:47:38.000000000 +0200
+++ linux-petero/drivers/block/paride/pcd.c	2005-05-22 12:47:38.000000000 +0200
@@ -235,11 +235,11 @@ static int pcd_block_release(struct inod
 	return cdrom_release(&cd->info, file);
 }
 
-static int pcd_block_ioctl(struct inode *inode, struct file *file,
+static int pcd_block_ioctl(struct block_device *bdev, struct file *file,
 				unsigned cmd, unsigned long arg)
 {
-	struct pcd_unit *cd = inode->i_bdev->bd_disk->private_data;
-	return cdrom_ioctl(file, &cd->info, inode->i_bdev, cmd, arg);
+	struct pcd_unit *cd = bdev->bd_disk->private_data;
+	return cdrom_ioctl(file, &cd->info, bdev, cmd, arg);
 }
 
 static int pcd_block_media_changed(struct gendisk *disk)
diff -puN drivers/block/paride/pd.c~blkdev_ioctl_use_bdev drivers/block/paride/pd.c
--- linux/drivers/block/paride/pd.c~blkdev_ioctl_use_bdev	2005-05-22 12:47:38.000000000 +0200
+++ linux-petero/drivers/block/paride/pd.c	2005-05-22 12:47:38.000000000 +0200
@@ -747,10 +747,10 @@ static int pd_open(struct inode *inode, 
 	return 0;
 }
 
-static int pd_ioctl(struct inode *inode, struct file *file,
+static int pd_ioctl(struct block_device *bdev, struct file *file,
 	 unsigned int cmd, unsigned long arg)
 {
-	struct pd_unit *disk = inode->i_bdev->bd_disk->private_data;
+	struct pd_unit *disk = bdev->bd_disk->private_data;
 	struct hd_geometry __user *geo = (struct hd_geometry __user *) arg;
 	struct hd_geometry g;
 
@@ -769,7 +769,7 @@ static int pd_ioctl(struct inode *inode,
 			g.sectors = disk->sectors;
 			g.cylinders = disk->cylinders;
 		}
-		g.start = get_start_sect(inode->i_bdev);
+		g.start = get_start_sect(bdev);
 		if (copy_to_user(geo, &g, sizeof(struct hd_geometry)))
 			return -EFAULT;
 		return 0;
diff -puN drivers/block/paride/pf.c~blkdev_ioctl_use_bdev drivers/block/paride/pf.c
--- linux/drivers/block/paride/pf.c~blkdev_ioctl_use_bdev	2005-05-22 12:47:38.000000000 +0200
+++ linux-petero/drivers/block/paride/pf.c	2005-05-22 12:47:38.000000000 +0200
@@ -203,7 +203,7 @@ module_param_array(drive3, int, NULL, 0)
 
 static int pf_open(struct inode *inode, struct file *file);
 static void do_pf_request(request_queue_t * q);
-static int pf_ioctl(struct inode *inode, struct file *file,
+static int pf_ioctl(struct block_device *bdev, struct file *file,
 		    unsigned int cmd, unsigned long arg);
 
 static int pf_release(struct inode *inode, struct file *file);
@@ -313,9 +313,9 @@ static int pf_open(struct inode *inode, 
 	return 0;
 }
 
-static int pf_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
+static int pf_ioctl(struct block_device *bdev, struct file *file, unsigned int cmd, unsigned long arg)
 {
-	struct pf_unit *pf = inode->i_bdev->bd_disk->private_data;
+	struct pf_unit *pf = bdev->bd_disk->private_data;
 	struct hd_geometry __user *geo = (struct hd_geometry __user *) arg;
 	struct hd_geometry g;
 	sector_t capacity;
diff -puN drivers/block/pktcdvd.c~blkdev_ioctl_use_bdev drivers/block/pktcdvd.c
--- linux/drivers/block/pktcdvd.c~blkdev_ioctl_use_bdev	2005-05-22 12:47:38.000000000 +0200
+++ linux-petero/drivers/block/pktcdvd.c	2005-05-22 12:47:38.000000000 +0200
@@ -2458,11 +2458,11 @@ out_mem:
 	return ret;
 }
 
-static int pkt_ioctl(struct inode *inode, struct file *file, unsigned int cmd, unsigned long arg)
+static int pkt_ioctl(struct block_device *bdev, struct file *file, unsigned int cmd, unsigned long arg)
 {
-	struct pktcdvd_device *pd = inode->i_bdev->bd_disk->private_data;
+	struct pktcdvd_device *pd = bdev->bd_disk->private_data;
 
-	VPRINTK("pkt_ioctl: cmd %x, dev %d:%d\n", cmd, imajor(inode), iminor(inode));
+	VPRINTK("pkt_ioctl: cmd %x\n", cmd);
 	BUG_ON(!pd);
 
 	switch (cmd) {
@@ -2474,7 +2474,7 @@ static int pkt_ioctl(struct inode *inode
 	case CDROM_LAST_WRITTEN:
 	case CDROM_SEND_PACKET:
 	case SCSI_IOCTL_SEND_COMMAND:
-		return blkdev_ioctl(pd->bdev->bd_inode, file, cmd, arg);
+		return blkdev_ioctl(pd->bdev, file, cmd, arg);
 
 	case CDROMEJECT:
 		/*
@@ -2482,7 +2482,7 @@ static int pkt_ioctl(struct inode *inode
 		 * have to unlock it or else the eject command fails.
 		 */
 		pkt_lock_door(pd, 0);
-		return blkdev_ioctl(pd->bdev->bd_inode, file, cmd, arg);
+		return blkdev_ioctl(pd->bdev, file, cmd, arg);
 
 	default:
 		printk("pktcdvd: Unknown ioctl for %s (%x)\n", pd->name, cmd);
diff -puN drivers/block/ps2esdi.c~blkdev_ioctl_use_bdev drivers/block/ps2esdi.c
--- linux/drivers/block/ps2esdi.c~blkdev_ioctl_use_bdev	2005-05-22 12:47:38.000000000 +0200
+++ linux-petero/drivers/block/ps2esdi.c	2005-05-22 12:47:38.000000000 +0200
@@ -81,7 +81,7 @@ static void (*current_int_handler) (u_in
 static void ps2esdi_normal_interrupt_handler(u_int);
 static void ps2esdi_initial_reset_int_handler(u_int);
 static void ps2esdi_geometry_int_handler(u_int);
-static int ps2esdi_ioctl(struct inode *inode, struct file *file,
+static int ps2esdi_ioctl(struct block_device *bdev, struct file *file,
 			 u_int cmd, u_long arg);
 
 static int ps2esdi_read_status_words(int num_words, int max_words, u_short * buffer);
@@ -1059,10 +1059,10 @@ static void dump_cmd_complete_status(u_i
 
 }
 
-static int ps2esdi_ioctl(struct inode *inode,
+static int ps2esdi_ioctl(struct block_device *bdev,
 			 struct file *file, u_int cmd, u_long arg)
 {
-	struct ps2esdi_i_struct *p = inode->i_bdev->bd_disk->private_data;
+	struct ps2esdi_i_struct *p = bdev->bd_disk->private_data;
 	struct ps2esdi_geometry geom;
 
 	if (cmd != HDIO_GETGEO)
@@ -1071,7 +1071,7 @@ static int ps2esdi_ioctl(struct inode *i
 	geom.heads = p->head;
 	geom.sectors = p->sect;
 	geom.cylinders = p->cyl;
-	geom.start = get_start_sect(inode->i_bdev);
+	geom.start = get_start_sect(bdev);
 	if (copy_to_user((void __user *)arg, &geom, sizeof(geom)))
 		return -EFAULT;
 	return 0;
diff -puN drivers/block/rd.c~blkdev_ioctl_use_bdev drivers/block/rd.c
--- linux/drivers/block/rd.c~blkdev_ioctl_use_bdev	2005-05-22 12:47:38.000000000 +0200
+++ linux-petero/drivers/block/rd.c	2005-05-22 12:47:38.000000000 +0200
@@ -295,11 +295,10 @@ fail:
 	return 0;
 } 
 
-static int rd_ioctl(struct inode *inode, struct file *file,
+static int rd_ioctl(struct block_device *bdev, struct file *file,
 			unsigned int cmd, unsigned long arg)
 {
 	int error;
-	struct block_device *bdev = inode->i_bdev;
 
 	if (cmd != BLKFLSBUF)
 		return -ENOTTY;
diff -puN drivers/block/swim3.c~blkdev_ioctl_use_bdev drivers/block/swim3.c
--- linux/drivers/block/swim3.c~blkdev_ioctl_use_bdev	2005-05-22 12:47:38.000000000 +0200
+++ linux-petero/drivers/block/swim3.c	2005-05-22 12:47:38.000000000 +0200
@@ -244,7 +244,7 @@ static int grab_drive(struct floppy_stat
 		      int interruptible);
 static void release_drive(struct floppy_state *fs);
 static int fd_eject(struct floppy_state *fs);
-static int floppy_ioctl(struct inode *inode, struct file *filp,
+static int floppy_ioctl(struct block_device *bdev, struct file *filp,
 			unsigned int cmd, unsigned long param);
 static int floppy_open(struct inode *inode, struct file *filp);
 static int floppy_release(struct inode *inode, struct file *filp);
@@ -847,10 +847,10 @@ static int fd_eject(struct floppy_state 
 static struct floppy_struct floppy_type =
 	{ 2880,18,2,80,0,0x1B,0x00,0xCF,0x6C,NULL };	/*  7 1.44MB 3.5"   */
 
-static int floppy_ioctl(struct inode *inode, struct file *filp,
+static int floppy_ioctl(struct block_device *bdev, struct file *filp,
 			unsigned int cmd, unsigned long param)
 {
-	struct floppy_state *fs = inode->i_bdev->bd_disk->private_data;
+	struct floppy_state *fs = bdev->bd_disk->private_data;
 	int err;
 		
 	if ((cmd & 0x80) && !capable(CAP_SYS_ADMIN))
diff -puN drivers/block/swim_iop.c~blkdev_ioctl_use_bdev drivers/block/swim_iop.c
--- linux/drivers/block/swim_iop.c~blkdev_ioctl_use_bdev	2005-05-22 12:47:38.000000000 +0200
+++ linux-petero/drivers/block/swim_iop.c	2005-05-22 12:47:38.000000000 +0200
@@ -98,7 +98,7 @@ static void swimiop_receive(struct iop_m
 static void swimiop_status_update(int, struct swim_drvstatus *);
 static int swimiop_eject(struct floppy_state *fs);
 
-static int floppy_ioctl(struct inode *inode, struct file *filp,
+static int floppy_ioctl(struct block_device *bdev, struct file *filp,
 			unsigned int cmd, unsigned long param);
 static int floppy_open(struct inode *inode, struct file *filp);
 static int floppy_release(struct inode *inode, struct file *filp);
@@ -348,10 +348,10 @@ static int swimiop_eject(struct floppy_s
 static struct floppy_struct floppy_type =
 	{ 2880,18,2,80,0,0x1B,0x00,0xCF,0x6C,NULL };	/*  7 1.44MB 3.5"   */
 
-static int floppy_ioctl(struct inode *inode, struct file *filp,
+static int floppy_ioctl(struct block_device *bdev, struct file *filp,
 			unsigned int cmd, unsigned long param)
 {
-	struct floppy_state *fs = inode->i_bdev->bd_disk->private_data;
+	struct floppy_state *fs = bdev->bd_disk->private_data;
 	int err;
 
 	if ((cmd & 0x80) && !capable(CAP_SYS_ADMIN))
diff -puN drivers/block/sx8.c~blkdev_ioctl_use_bdev drivers/block/sx8.c
--- linux/drivers/block/sx8.c~blkdev_ioctl_use_bdev	2005-05-22 12:47:38.000000000 +0200
+++ linux-petero/drivers/block/sx8.c	2005-05-22 12:47:38.000000000 +0200
@@ -383,7 +383,7 @@ struct carm_array_info {
 
 static int carm_init_one (struct pci_dev *pdev, const struct pci_device_id *ent);
 static void carm_remove_one (struct pci_dev *pdev);
-static int carm_bdev_ioctl(struct inode *ino, struct file *fil,
+static int carm_bdev_ioctl(struct block_device *bdev, struct file *fil,
 			   unsigned int cmd, unsigned long arg);
 
 static struct pci_device_id carm_pci_tbl[] = {
@@ -410,11 +410,11 @@ static unsigned long carm_major_alloc;
 
 
 
-static int carm_bdev_ioctl(struct inode *ino, struct file *fil,
+static int carm_bdev_ioctl(struct block_device *bdev, struct file *fil,
 			   unsigned int cmd, unsigned long arg)
 {
 	void __user *usermem = (void __user *) arg;
-	struct carm_port *port = ino->i_bdev->bd_disk->private_data;
+	struct carm_port *port = bdev->bd_disk->private_data;
 	struct hd_geometry geom;
 
 	switch (cmd) {
@@ -425,7 +425,7 @@ static int carm_bdev_ioctl(struct inode 
 		geom.heads = (u8) port->dev_geom_head;
 		geom.sectors = (u8) port->dev_geom_sect;
 		geom.cylinders = port->dev_geom_cyl;
-		geom.start = get_start_sect(ino->i_bdev);
+		geom.start = get_start_sect(bdev);
 
 		if (copy_to_user(usermem, &geom, sizeof(geom)))
 			return -EFAULT;
diff -puN drivers/block/ub.c~blkdev_ioctl_use_bdev drivers/block/ub.c
--- linux/drivers/block/ub.c~blkdev_ioctl_use_bdev	2005-05-22 12:47:38.000000000 +0200
+++ linux-petero/drivers/block/ub.c	2005-05-22 12:47:38.000000000 +0200
@@ -1576,10 +1576,10 @@ static int ub_bd_release(struct inode *i
 /*
  * The ioctl interface.
  */
-static int ub_bd_ioctl(struct inode *inode, struct file *filp,
+static int ub_bd_ioctl(struct block_device *bdev, struct file *filp,
     unsigned int cmd, unsigned long arg)
 {
-	struct gendisk *disk = inode->i_bdev->bd_disk;
+	struct gendisk *disk = bdev->bd_disk;
 	void __user *usermem = (void __user *) arg;
 
 	return scsi_cmd_ioctl(filp, disk, cmd, usermem);
diff -puN drivers/block/umem.c~blkdev_ioctl_use_bdev drivers/block/umem.c
--- linux/drivers/block/umem.c~blkdev_ioctl_use_bdev	2005-05-22 12:47:38.000000000 +0200
+++ linux-petero/drivers/block/umem.c	2005-05-22 12:47:38.000000000 +0200
@@ -817,10 +817,10 @@ static int mm_revalidate(struct gendisk 
 --                            mm_ioctl
 -----------------------------------------------------------------------------------
 */
-static int mm_ioctl(struct inode *i, struct file *f, unsigned int cmd, unsigned long arg)
+static int mm_ioctl(struct block_device *bdev, struct file *f, unsigned int cmd, unsigned long arg)
 {
 	if (cmd == HDIO_GETGEO) {
-		struct cardinfo *card = i->i_bdev->bd_disk->private_data;
+		struct cardinfo *card = bdev->bd_disk->private_data;
 		int size = card->mm_size * (1024 / MM_HARDSECT);
 		struct hd_geometry geo;
 		/*
@@ -830,7 +830,7 @@ static int mm_ioctl(struct inode *i, str
 		 */
 		geo.heads     = 64;
 		geo.sectors   = 32;
-		geo.start     = get_start_sect(i->i_bdev);
+		geo.start     = get_start_sect(bdev);
 		geo.cylinders = size / (geo.heads * geo.sectors);
 
 		if (copy_to_user((void __user *) arg, &geo, sizeof(geo)))
diff -puN drivers/block/viodasd.c~blkdev_ioctl_use_bdev drivers/block/viodasd.c
--- linux/drivers/block/viodasd.c~blkdev_ioctl_use_bdev	2005-05-22 12:47:38.000000000 +0200
+++ linux-petero/drivers/block/viodasd.c	2005-05-22 12:47:38.000000000 +0200
@@ -247,7 +247,7 @@ static int viodasd_release(struct inode 
 
 /* External ioctl entry point.
  */
-static int viodasd_ioctl(struct inode *ino, struct file *fil,
+static int viodasd_ioctl(struct block_device *bdev, struct file *fil,
 			 unsigned int cmd, unsigned long arg)
 {
 	unsigned char sectors;
@@ -264,7 +264,7 @@ static int viodasd_ioctl(struct inode *i
 			return -EINVAL;
 		if (!access_ok(VERIFY_WRITE, geo, sizeof(*geo)))
 			return -EFAULT;
-		gendisk = ino->i_bdev->bd_disk;
+		gendisk = bdev->bd_disk;
 		d = gendisk->private_data;
 		sectors = d->sectors;
 		if (sectors == 0)
@@ -278,7 +278,7 @@ static int viodasd_ioctl(struct inode *i
 		if (__put_user(sectors, &geo->sectors) ||
 		    __put_user(heads, &geo->heads) ||
 		    __put_user(cylinders, &geo->cylinders) ||
-		    __put_user(get_start_sect(ino->i_bdev), &geo->start))
+		    __put_user(get_start_sect(bdev), &geo->start))
 			return -EFAULT;
 		return 0;
 	}
diff -puN drivers/block/xd.c~blkdev_ioctl_use_bdev drivers/block/xd.c
--- linux/drivers/block/xd.c~blkdev_ioctl_use_bdev	2005-05-22 12:47:38.000000000 +0200
+++ linux-petero/drivers/block/xd.c	2005-05-22 12:47:38.000000000 +0200
@@ -330,9 +330,9 @@ static void do_xd_request (request_queue
 }
 
 /* xd_ioctl: handle device ioctl's */
-static int xd_ioctl (struct inode *inode,struct file *file,u_int cmd,u_long arg)
+static int xd_ioctl (struct block_device *bdev,struct file *file,u_int cmd,u_long arg)
 {
-	XD_INFO *p = inode->i_bdev->bd_disk->private_data;
+	XD_INFO *p = bdev->bd_disk->private_data;
 
 	switch (cmd) {
 		case HDIO_GETGEO:
@@ -342,7 +342,7 @@ static int xd_ioctl (struct inode *inode
 			g.heads = p->heads;
 			g.sectors = p->sectors;
 			g.cylinders = p->cylinders;
-			g.start = get_start_sect(inode->i_bdev);
+			g.start = get_start_sect(bdev);
 			return copy_to_user(geom, &g, sizeof(g)) ? -EFAULT : 0;
 		}
 		case HDIO_SET_DMA:
diff -puN drivers/block/xd.h~blkdev_ioctl_use_bdev drivers/block/xd.h
--- linux/drivers/block/xd.h~blkdev_ioctl_use_bdev	2005-05-22 12:47:38.000000000 +0200
+++ linux-petero/drivers/block/xd.h	2005-05-22 12:47:38.000000000 +0200
@@ -105,7 +105,7 @@ static u_char xd_detect (u_char *control
 static u_char xd_initdrives (void (*init_drive)(u_char drive));
 
 static void do_xd_request (request_queue_t * q);
-static int xd_ioctl (struct inode *inode,struct file *file,unsigned int cmd,unsigned long arg);
+static int xd_ioctl (struct block_device *bdev,struct file *file,unsigned int cmd,unsigned long arg);
 static int xd_readwrite (u_char operation,XD_INFO *disk,char *buffer,u_int block,u_int count);
 static void xd_recalibrate (u_char drive);
 
diff -puN drivers/cdrom/aztcd.c~blkdev_ioctl_use_bdev drivers/cdrom/aztcd.c
--- linux/drivers/cdrom/aztcd.c~blkdev_ioctl_use_bdev	2005-05-22 12:47:38.000000000 +0200
+++ linux-petero/drivers/cdrom/aztcd.c	2005-05-22 12:47:38.000000000 +0200
@@ -329,7 +329,7 @@ static int aztGetToc(int multi);
 
 /* Kernel Interface Functions */
 static int check_aztcd_media_change(struct gendisk *disk);
-static int aztcd_ioctl(struct inode *ip, struct file *fp, unsigned int cmd,
+static int aztcd_ioctl(struct block_device *bdev, struct file *fp, unsigned int cmd,
 		       unsigned long arg);
 static int aztcd_open(struct inode *ip, struct file *fp);
 static int aztcd_release(struct inode *inode, struct file *file);
@@ -1154,7 +1154,7 @@ static int check_aztcd_media_change(stru
 /*
  * Kernel IO-controls
 */
-static int aztcd_ioctl(struct inode *ip, struct file *fp, unsigned int cmd,
+static int aztcd_ioctl(struct block_device *bdev, struct file *fp, unsigned int cmd,
 		       unsigned long arg)
 {
 	int i;
@@ -1173,8 +1173,6 @@ static int aztcd_ioctl(struct inode *ip,
 	       cmd, jiffies);
 	printk("aztcd Status %x\n", getAztStatus());
 #endif
-	if (!ip)
-		RETURNM("aztcd_ioctl 1", -EINVAL);
 	if (getAztStatus() < 0)
 		RETURNM("aztcd_ioctl 2", -EIO);
 	if ((!aztTocUpToDate) || (aztDiskChanged)) {
diff -puN drivers/cdrom/cdu31a.c~blkdev_ioctl_use_bdev drivers/cdrom/cdu31a.c
--- linux/drivers/cdrom/cdu31a.c~blkdev_ioctl_use_bdev	2005-05-22 12:47:38.000000000 +0200
+++ linux-petero/drivers/cdrom/cdu31a.c	2005-05-22 12:47:38.000000000 +0200
@@ -2919,7 +2919,7 @@ static int scd_block_release(struct inod
 	return cdrom_release(&scd_info, file);
 }
 
-static int scd_block_ioctl(struct inode *inode, struct file *file,
+static int scd_block_ioctl(struct block_device *bdev, struct file *file,
 				unsigned cmd, unsigned long arg)
 {
 	int retval;
@@ -2937,7 +2937,7 @@ static int scd_block_ioctl(struct inode 
 			retval = scd_tray_move(&scd_info, 0);
 			break;
 		default:
-			retval = cdrom_ioctl(file, &scd_info, inode->i_bdev, cmd, arg);
+			retval = cdrom_ioctl(file, &scd_info, bdev, cmd, arg);
 	}
 	return retval;
 }
diff -puN drivers/cdrom/cm206.c~blkdev_ioctl_use_bdev drivers/cdrom/cm206.c
--- linux/drivers/cdrom/cm206.c~blkdev_ioctl_use_bdev	2005-05-22 12:47:38.000000000 +0200
+++ linux-petero/drivers/cdrom/cm206.c	2005-05-22 12:47:38.000000000 +0200
@@ -1360,10 +1360,10 @@ static int cm206_block_release(struct in
 	return cdrom_release(&cm206_info, file);
 }
 
-static int cm206_block_ioctl(struct inode *inode, struct file *file,
+static int cm206_block_ioctl(struct block_device *bdev, struct file *file,
 				unsigned cmd, unsigned long arg)
 {
-	return cdrom_ioctl(file, &cm206_info, inode->i_bdev, cmd, arg);
+	return cdrom_ioctl(file, &cm206_info, bdev, cmd, arg);
 }
 
 static int cm206_block_media_changed(struct gendisk *disk)
diff -puN drivers/cdrom/gscd.c~blkdev_ioctl_use_bdev drivers/cdrom/gscd.c
--- linux/drivers/cdrom/gscd.c~blkdev_ioctl_use_bdev	2005-05-22 12:47:38.000000000 +0200
+++ linux-petero/drivers/cdrom/gscd.c	2005-05-22 12:47:38.000000000 +0200
@@ -90,7 +90,7 @@ static void gscd_bin2bcd(unsigned char *
 /* Schnittstellen zum Kern/FS */
 
 static void __do_gscd_request(unsigned long dummy);
-static int gscd_ioctl(struct inode *, struct file *, unsigned int,
+static int gscd_ioctl(struct block_device *, struct file *, unsigned int,
 		      unsigned long);
 static int gscd_open(struct inode *, struct file *);
 static int gscd_release(struct inode *, struct file *);
@@ -189,7 +189,7 @@ __setup("gscd=", gscd_setup);
 
 #endif
 
-static int gscd_ioctl(struct inode *ip, struct file *fp, unsigned int cmd,
+static int gscd_ioctl(struct block_device *bdev, struct file *fp, unsigned int cmd,
 		      unsigned long arg)
 {
 	unsigned char to_do[10];
diff -puN drivers/cdrom/mcdx.c~blkdev_ioctl_use_bdev drivers/cdrom/mcdx.c
--- linux/drivers/cdrom/mcdx.c~blkdev_ioctl_use_bdev	2005-05-22 12:47:38.000000000 +0200
+++ linux-petero/drivers/cdrom/mcdx.c	2005-05-22 12:47:38.000000000 +0200
@@ -224,11 +224,11 @@ static int mcdx_block_release(struct ino
 	return cdrom_release(&p->info, file);
 }
 
-static int mcdx_block_ioctl(struct inode *inode, struct file *file,
+static int mcdx_block_ioctl(struct block_device *bdev, struct file *file,
 				unsigned cmd, unsigned long arg)
 {
-	struct s_drive_stuff *p = inode->i_bdev->bd_disk->private_data;
-	return cdrom_ioctl(file, &p->info, inode->i_bdev, cmd, arg);
+	struct s_drive_stuff *p = bdev->bd_disk->private_data;
+	return cdrom_ioctl(file, &p->info, bdev, cmd, arg);
 }
 
 static int mcdx_block_media_changed(struct gendisk *disk)
diff -puN drivers/cdrom/optcd.c~blkdev_ioctl_use_bdev drivers/cdrom/optcd.c
--- linux/drivers/cdrom/optcd.c~blkdev_ioctl_use_bdev	2005-05-22 12:47:38.000000000 +0200
+++ linux-petero/drivers/cdrom/optcd.c	2005-05-22 12:47:38.000000000 +0200
@@ -1713,7 +1713,7 @@ static int cdromreset(void)
 /* VFS calls */
 
 
-static int opt_ioctl(struct inode *ip, struct file *fp,
+static int opt_ioctl(struct block_device *bdev, struct file *fp,
                      unsigned int cmd, unsigned long arg)
 {
 	int status, err, retval = 0;
@@ -1721,9 +1721,6 @@ static int opt_ioctl(struct inode *ip, s
 
 	DEBUG((DEBUG_VFS, "starting opt_ioctl"));
 
-	if (!ip)
-		return -EINVAL;
-
 	if (cmd == CDROMRESET)
 		return cdromreset();
 
diff -puN drivers/cdrom/sbpcd.c~blkdev_ioctl_use_bdev drivers/cdrom/sbpcd.c
--- linux/drivers/cdrom/sbpcd.c~blkdev_ioctl_use_bdev	2005-05-22 12:47:38.000000000 +0200
+++ linux-petero/drivers/cdrom/sbpcd.c	2005-05-22 12:47:38.000000000 +0200
@@ -5369,11 +5369,11 @@ static int sbpcd_block_release(struct in
 	return cdrom_release(p->sbpcd_infop, file);
 }
 
-static int sbpcd_block_ioctl(struct inode *inode, struct file *file,
+static int sbpcd_block_ioctl(struct block_device *bdev, struct file *file,
 				unsigned cmd, unsigned long arg)
 {
-	struct sbpcd_drive *p = inode->i_bdev->bd_disk->private_data;
-	return cdrom_ioctl(file, p->sbpcd_infop, inode->i_bdev, cmd, arg);
+	struct sbpcd_drive *p = bdev->bd_disk->private_data;
+	return cdrom_ioctl(file, p->sbpcd_infop, bdev, cmd, arg);
 }
 
 static int sbpcd_block_media_changed(struct gendisk *disk)
diff -puN drivers/cdrom/sjcd.c~blkdev_ioctl_use_bdev drivers/cdrom/sjcd.c
--- linux/drivers/cdrom/sjcd.c~blkdev_ioctl_use_bdev	2005-05-22 12:47:38.000000000 +0200
+++ linux-petero/drivers/cdrom/sjcd.c	2005-05-22 12:47:38.000000000 +0200
@@ -713,7 +713,7 @@ static int sjcd_tray_open(void)
 /*
  * Do some user commands.
  */
-static int sjcd_ioctl(struct inode *ip, struct file *fp,
+static int sjcd_ioctl(struct block_device *bdev, struct file *fp,
 		      unsigned int cmd, unsigned long arg)
 {
 	void __user *argp = (void __user *)arg;
diff -puN drivers/cdrom/sonycd535.c~blkdev_ioctl_use_bdev drivers/cdrom/sonycd535.c
--- linux/drivers/cdrom/sonycd535.c~blkdev_ioctl_use_bdev	2005-05-22 12:47:38.000000000 +0200
+++ linux-petero/drivers/cdrom/sonycd535.c	2005-05-22 12:47:38.000000000 +0200
@@ -1061,7 +1061,7 @@ sony_get_subchnl_info(void __user *arg)
  * The big ugly ioctl handler.
  */
 static int
-cdu_ioctl(struct inode *inode,
+cdu_ioctl(struct block_device *bdev,
 		  struct file *file,
 		  unsigned int cmd,
 		  unsigned long arg)
diff -puN drivers/cdrom/viocd.c~blkdev_ioctl_use_bdev drivers/cdrom/viocd.c
--- linux/drivers/cdrom/viocd.c~blkdev_ioctl_use_bdev	2005-05-22 12:47:38.000000000 +0200
+++ linux-petero/drivers/cdrom/viocd.c	2005-05-22 12:47:38.000000000 +0200
@@ -197,11 +197,11 @@ static int viocd_blk_release(struct inod
 	return cdrom_release(&di->viocd_info, file);
 }
 
-static int viocd_blk_ioctl(struct inode *inode, struct file *file,
+static int viocd_blk_ioctl(struct block_device *bdev, struct file *file,
 		unsigned cmd, unsigned long arg)
 {
-	struct disk_info *di = inode->i_bdev->bd_disk->private_data;
-	return cdrom_ioctl(file, &di->viocd_info, inode->i_bdev, cmd, arg);
+	struct disk_info *di = bdev->bd_disk->private_data;
+	return cdrom_ioctl(file, &di->viocd_info, bdev, cmd, arg);
 }
 
 static int viocd_blk_media_changed(struct gendisk *disk)
diff -puN drivers/char/raw.c~blkdev_ioctl_use_bdev drivers/char/raw.c
--- linux/drivers/char/raw.c~blkdev_ioctl_use_bdev	2005-05-22 12:47:38.000000000 +0200
+++ linux-petero/drivers/char/raw.c	2005-05-22 12:47:38.000000000 +0200
@@ -122,7 +122,7 @@ raw_ioctl(struct inode *inode, struct fi
 {
 	struct block_device *bdev = filp->private_data;
 
-	return blkdev_ioctl(bdev->bd_inode, NULL, command, arg);
+	return blkdev_ioctl(bdev, NULL, command, arg);
 }
 
 static void bind_device(struct raw_config_request *rq)
diff -puN drivers/ide/ide-cd.c~blkdev_ioctl_use_bdev drivers/ide/ide-cd.c
--- linux/drivers/ide/ide-cd.c~blkdev_ioctl_use_bdev	2005-05-22 12:47:38.000000000 +0200
+++ linux-petero/drivers/ide/ide-cd.c	2005-05-22 12:47:38.000000000 +0200
@@ -3375,16 +3375,15 @@ static int idecd_release(struct inode * 
 	return 0;
 }
 
-static int idecd_ioctl (struct inode *inode, struct file *file,
+static int idecd_ioctl (struct block_device *bdev, struct file *file,
 			unsigned int cmd, unsigned long arg)
 {
-	struct block_device *bdev = inode->i_bdev;
 	struct cdrom_info *info = ide_cd_g(bdev->bd_disk);
 	int err;
 
 	err  = generic_ide_ioctl(info->drive, file, bdev, cmd, arg);
 	if (err == -EINVAL)
-		err = cdrom_ioctl(file, &info->devinfo, inode->i_bdev, cmd, arg);
+		err = cdrom_ioctl(file, &info->devinfo, bdev, cmd, arg);
 
 	return err;
 }
diff -puN drivers/ide/ide-disk.c~blkdev_ioctl_use_bdev drivers/ide/ide-disk.c
--- linux/drivers/ide/ide-disk.c~blkdev_ioctl_use_bdev	2005-05-22 12:47:38.000000000 +0200
+++ linux-petero/drivers/ide/ide-disk.c	2005-05-22 12:47:38.000000000 +0200
@@ -1159,10 +1159,9 @@ static int idedisk_release(struct inode 
 	return 0;
 }
 
-static int idedisk_ioctl(struct inode *inode, struct file *file,
+static int idedisk_ioctl(struct block_device *bdev, struct file *file,
 			unsigned int cmd, unsigned long arg)
 {
-	struct block_device *bdev = inode->i_bdev;
 	struct ide_disk_obj *idkp = ide_disk_g(bdev->bd_disk);
 	return generic_ide_ioctl(idkp->drive, file, bdev, cmd, arg);
 }
diff -puN drivers/ide/ide-floppy.c~blkdev_ioctl_use_bdev drivers/ide/ide-floppy.c
--- linux/drivers/ide/ide-floppy.c~blkdev_ioctl_use_bdev	2005-05-22 12:47:38.000000000 +0200
+++ linux-petero/drivers/ide/ide-floppy.c	2005-05-22 12:47:38.000000000 +0200
@@ -2027,10 +2027,9 @@ static int idefloppy_release(struct inod
 	return 0;
 }
 
-static int idefloppy_ioctl(struct inode *inode, struct file *file,
+static int idefloppy_ioctl(struct block_device *bdev, struct file *file,
 			unsigned int cmd, unsigned long arg)
 {
-	struct block_device *bdev = inode->i_bdev;
 	struct ide_floppy_obj *floppy = ide_floppy_g(bdev->bd_disk);
 	ide_drive_t *drive = floppy->drive;
 	void __user *argp = (void __user *)arg;
diff -puN drivers/ide/ide-tape.c~blkdev_ioctl_use_bdev drivers/ide/ide-tape.c
--- linux/drivers/ide/ide-tape.c~blkdev_ioctl_use_bdev	2005-05-22 12:47:38.000000000 +0200
+++ linux-petero/drivers/ide/ide-tape.c	2005-05-22 12:47:38.000000000 +0200
@@ -4810,10 +4810,9 @@ static int idetape_release(struct inode 
 	return 0;
 }
 
-static int idetape_ioctl(struct inode *inode, struct file *file,
+static int idetape_ioctl(struct block_device *bdev, struct file *file,
 			unsigned int cmd, unsigned long arg)
 {
-	struct block_device *bdev = inode->i_bdev;
 	struct ide_tape_obj *tape = ide_tape_g(bdev->bd_disk);
 	ide_drive_t *drive = tape->drive;
 	int err = generic_ide_ioctl(drive, file, bdev, cmd, arg);
diff -puN drivers/ide/legacy/hd.c~blkdev_ioctl_use_bdev drivers/ide/legacy/hd.c
--- linux/drivers/ide/legacy/hd.c~blkdev_ioctl_use_bdev	2005-05-22 12:47:38.000000000 +0200
+++ linux-petero/drivers/ide/legacy/hd.c	2005-05-22 12:47:38.000000000 +0200
@@ -656,10 +656,10 @@ static void do_hd_request (request_queue
 	enable_irq(HD_IRQ);
 }
 
-static int hd_ioctl(struct inode * inode, struct file * file,
+static int hd_ioctl(struct block_device * bdev, struct file * file,
 	unsigned int cmd, unsigned long arg)
 {
-	struct hd_i_struct *disk = inode->i_bdev->bd_disk->private_data;
+	struct hd_i_struct *disk = bdev->bd_disk->private_data;
 	struct hd_geometry __user *loc = (struct hd_geometry __user *) arg;
 	struct hd_geometry g; 
 
@@ -670,7 +670,7 @@ static int hd_ioctl(struct inode * inode
 	g.heads = disk->head;
 	g.sectors = disk->sect;
 	g.cylinders = disk->cyl;
-	g.start = get_start_sect(inode->i_bdev);
+	g.start = get_start_sect(bdev);
 	return copy_to_user(loc, &g, sizeof g) ? -EFAULT : 0; 
 }
 
diff -puN drivers/md/md.c~blkdev_ioctl_use_bdev drivers/md/md.c
--- linux/drivers/md/md.c~blkdev_ioctl_use_bdev	2005-05-22 12:47:38.000000000 +0200
+++ linux-petero/drivers/md/md.c	2005-05-22 12:47:38.000000000 +0200
@@ -2443,7 +2443,7 @@ static int set_disk_faulty(mddev_t *mdde
 	return 0;
 }
 
-static int md_ioctl(struct inode *inode, struct file *file,
+static int md_ioctl(struct block_device *bdev, struct file *file,
 			unsigned int cmd, unsigned long arg)
 {
 	int err = 0;
@@ -2482,7 +2482,7 @@ static int md_ioctl(struct inode *inode,
 	 * Commands creating/starting a new array:
 	 */
 
-	mddev = inode->i_bdev->bd_disk->private_data;
+	mddev = bdev->bd_disk->private_data;
 
 	if (!mddev) {
 		BUG();
@@ -2619,7 +2619,7 @@ static int md_ioctl(struct inode *inode,
 					(short __user *) &loc->cylinders);
 			if (err)
 				goto abort_unlock;
-			err = put_user (get_start_sect(inode->i_bdev),
+			err = put_user (get_start_sect(bdev),
 						(long __user *) &loc->start);
 			goto done_unlock;
 	}
diff -puN drivers/message/i2o/i2o_block.c~blkdev_ioctl_use_bdev drivers/message/i2o/i2o_block.c
--- linux/drivers/message/i2o/i2o_block.c~blkdev_ioctl_use_bdev	2005-05-22 12:47:38.000000000 +0200
+++ linux-petero/drivers/message/i2o/i2o_block.c	2005-05-22 12:47:38.000000000 +0200
@@ -703,10 +703,10 @@ static int i2o_block_release(struct inod
  *
  *	Return 0 on success or negative error on failure.
  */
-static int i2o_block_ioctl(struct inode *inode, struct file *file,
+static int i2o_block_ioctl(struct block_device *bdev, struct file *file,
 			   unsigned int cmd, unsigned long arg)
 {
-	struct gendisk *disk = inode->i_bdev->bd_disk;
+	struct gendisk *disk = bdev->bd_disk;
 	struct i2o_block_device *dev = disk->private_data;
 	void __user *argp = (void __user *)arg;
 
@@ -721,7 +721,7 @@ static int i2o_block_ioctl(struct inode 
 			struct hd_geometry g;
 			i2o_block_biosparam(get_capacity(disk),
 					    &g.cylinders, &g.heads, &g.sectors);
-			g.start = get_start_sect(inode->i_bdev);
+			g.start = get_start_sect(bdev);
 			return copy_to_user(argp, &g, sizeof(g)) ? -EFAULT : 0;
 		}
 
diff -puN drivers/mmc/mmc_block.c~blkdev_ioctl_use_bdev drivers/mmc/mmc_block.c
--- linux/drivers/mmc/mmc_block.c~blkdev_ioctl_use_bdev	2005-05-22 12:47:38.000000000 +0200
+++ linux-petero/drivers/mmc/mmc_block.c	2005-05-22 12:47:38.000000000 +0200
@@ -109,10 +109,8 @@ static int mmc_blk_release(struct inode 
 }
 
 static int
-mmc_blk_ioctl(struct inode *inode, struct file *filp, unsigned int cmd, unsigned long arg)
+mmc_blk_ioctl(struct block_device *bdev, struct file *filp, unsigned int cmd, unsigned long arg)
 {
-	struct block_device *bdev = inode->i_bdev;
-
 	if (cmd == HDIO_GETGEO) {
 		struct hd_geometry geo;
 
diff -puN drivers/mtd/mtd_blkdevs.c~blkdev_ioctl_use_bdev drivers/mtd/mtd_blkdevs.c
--- linux/drivers/mtd/mtd_blkdevs.c~blkdev_ioctl_use_bdev	2005-05-22 12:47:38.000000000 +0200
+++ linux-petero/drivers/mtd/mtd_blkdevs.c	2005-05-22 12:47:38.000000000 +0200
@@ -196,10 +196,10 @@ static int blktrans_release(struct inode
 }
 
 
-static int blktrans_ioctl(struct inode *inode, struct file *file, 
+static int blktrans_ioctl(struct block_device *bdev, struct file *file,
 			      unsigned int cmd, unsigned long arg)
 {
-	struct mtd_blktrans_dev *dev = inode->i_bdev->bd_disk->private_data;
+	struct mtd_blktrans_dev *dev = bdev->bd_disk->private_data;
 	struct mtd_blktrans_ops *tr = dev->tr;
 
 	switch (cmd) {
@@ -219,7 +219,7 @@ static int blktrans_ioctl(struct inode *
 			if (ret)
 				return ret;
 
-			g.start = get_start_sect(inode->i_bdev);
+			g.start = get_start_sect(bdev);
 			if (copy_to_user((void __user *)arg, &g, sizeof(g)))
 				return -EFAULT;
 			return 0;
diff -puN drivers/s390/block/dasd_int.h~blkdev_ioctl_use_bdev drivers/s390/block/dasd_int.h
--- linux/drivers/s390/block/dasd_int.h~blkdev_ioctl_use_bdev	2005-05-22 12:47:38.000000000 +0200
+++ linux-petero/drivers/s390/block/dasd_int.h	2005-05-22 12:47:38.000000000 +0200
@@ -524,7 +524,7 @@ int  dasd_ioctl_init(void);
 void dasd_ioctl_exit(void);
 int  dasd_ioctl_no_register(struct module *, int, dasd_ioctl_fn_t);
 int  dasd_ioctl_no_unregister(struct module *, int, dasd_ioctl_fn_t);
-int  dasd_ioctl(struct inode *, struct file *, unsigned int, unsigned long);
+int  dasd_ioctl(struct block_device *, struct file *, unsigned int, unsigned long);
 
 /* externals in dasd_proc.c */
 int dasd_proc_init(void);
diff -puN drivers/s390/block/dasd_ioctl.c~blkdev_ioctl_use_bdev drivers/s390/block/dasd_ioctl.c
--- linux/drivers/s390/block/dasd_ioctl.c~blkdev_ioctl_use_bdev	2005-05-22 12:47:38.000000000 +0200
+++ linux-petero/drivers/s390/block/dasd_ioctl.c	2005-05-22 12:47:38.000000000 +0200
@@ -80,10 +80,10 @@ dasd_ioctl_no_unregister(struct module *
 }
 
 int
-dasd_ioctl(struct inode *inp, struct file *filp,
+dasd_ioctl(struct block_device *bdev, struct file *filp,
 	   unsigned int no, unsigned long data)
 {
-	struct block_device *bdev = inp->i_bdev;
+	struct block_device *bdev = bdev;
 	struct dasd_device *device = bdev->bd_disk->private_data;
 	struct dasd_ioctl *ioctl;
 	const char *dir;
diff -puN drivers/s390/block/xpram.c~blkdev_ioctl_use_bdev drivers/s390/block/xpram.c
--- linux/drivers/s390/block/xpram.c~blkdev_ioctl_use_bdev	2005-05-22 12:47:38.000000000 +0200
+++ linux-petero/drivers/s390/block/xpram.c	2005-05-22 12:47:38.000000000 +0200
@@ -328,7 +328,7 @@ fail:
 	return 0;
 }
 
-static int xpram_ioctl (struct inode *inode, struct file *filp,
+static int xpram_ioctl (struct block_device *bdev, struct file *filp,
 		 unsigned int cmd, unsigned long arg)
 {
 	struct hd_geometry __user *geo;
diff -puN drivers/s390/char/tape_block.c~blkdev_ioctl_use_bdev drivers/s390/char/tape_block.c
--- linux/drivers/s390/char/tape_block.c~blkdev_ioctl_use_bdev	2005-05-22 12:47:38.000000000 +0200
+++ linux-petero/drivers/s390/char/tape_block.c	2005-05-22 12:47:38.000000000 +0200
@@ -45,7 +45,7 @@
  */
 static int tapeblock_open(struct inode *, struct file *);
 static int tapeblock_release(struct inode *, struct file *);
-static int tapeblock_ioctl(struct inode *, struct file *, unsigned int,
+static int tapeblock_ioctl(struct block_device *, struct file *, unsigned int,
 				unsigned long);
 static int tapeblock_medium_changed(struct gendisk *);
 static int tapeblock_revalidate_disk(struct gendisk *);
@@ -428,24 +428,24 @@ tapeblock_release(struct inode *inode, s
  */
 static int
 tapeblock_ioctl(
-	struct inode *		inode,
+	struct block_device *	bdev,
 	struct file *		file,
 	unsigned int		command,
 	unsigned long		arg
 ) {
 	int rc;
 	int minor;
-	struct gendisk *disk = inode->i_bdev->bd_disk;
+	struct gendisk *disk = bdev->bd_disk;
 	struct tape_device *device = disk->private_data;
 
 	rc     = 0;
-	disk   = inode->i_bdev->bd_disk;
+	disk   = bdev->bd_disk;
 	if (!disk)
 		BUG();
 	device = disk->private_data;
 	if (!device)
 		BUG();
-	minor  = iminor(inode);
+	minor  = iminor(bdev->bd_inode);
 
 	DBF_LH(6, "tapeblock_ioctl(0x%0x)\n", command);
 	DBF_LH(6, "device = %d:%d\n", tapeblock_major, minor);
diff -puN drivers/scsi/ide-scsi.c~blkdev_ioctl_use_bdev drivers/scsi/ide-scsi.c
--- linux/drivers/scsi/ide-scsi.c~blkdev_ioctl_use_bdev	2005-05-22 12:47:38.000000000 +0200
+++ linux-petero/drivers/scsi/ide-scsi.c	2005-05-22 12:47:38.000000000 +0200
@@ -806,10 +806,9 @@ static int idescsi_ide_release(struct in
 	return 0;
 }
 
-static int idescsi_ide_ioctl(struct inode *inode, struct file *file,
+static int idescsi_ide_ioctl(struct block_device *bdev, struct file *file,
 			unsigned int cmd, unsigned long arg)
 {
-	struct block_device *bdev = inode->i_bdev;
 	struct ide_scsi_obj *scsi = ide_scsi_g(bdev->bd_disk);
 	return generic_ide_ioctl(scsi->drive, file, bdev, cmd, arg);
 }
diff -puN drivers/scsi/sd.c~blkdev_ioctl_use_bdev drivers/scsi/sd.c
--- linux/drivers/scsi/sd.c~blkdev_ioctl_use_bdev	2005-05-22 12:47:38.000000000 +0200
+++ linux-petero/drivers/scsi/sd.c	2005-05-22 12:47:38.000000000 +0200
@@ -563,10 +563,9 @@ static int sd_hdio_getgeo(struct block_d
  *	Note: most ioctls are forward onto the block subsystem or further
  *	down in the scsi subsytem.
  **/
-static int sd_ioctl(struct inode * inode, struct file * filp, 
+static int sd_ioctl(struct block_device * bdev, struct file * filp,
 		    unsigned int cmd, unsigned long arg)
 {
-	struct block_device *bdev = inode->i_bdev;
 	struct gendisk *disk = bdev->bd_disk;
 	struct scsi_device *sdp = scsi_disk(disk)->device;
 	void __user *p = (void __user *)arg;
diff -puN drivers/scsi/sr.c~blkdev_ioctl_use_bdev drivers/scsi/sr.c
--- linux/drivers/scsi/sr.c~blkdev_ioctl_use_bdev	2005-05-22 12:47:38.000000000 +0200
+++ linux-petero/drivers/scsi/sr.c	2005-05-22 12:47:38.000000000 +0200
@@ -487,10 +487,10 @@ static int sr_block_release(struct inode
 	return 0;
 }
 
-static int sr_block_ioctl(struct inode *inode, struct file *file, unsigned cmd,
+static int sr_block_ioctl(struct block_device *bdev, struct file *file, unsigned cmd,
 			  unsigned long arg)
 {
-	struct scsi_cd *cd = scsi_cd(inode->i_bdev->bd_disk);
+	struct scsi_cd *cd = scsi_cd(bdev->bd_disk);
 	struct scsi_device *sdev = cd->device;
 
         /*
@@ -502,7 +502,7 @@ static int sr_block_ioctl(struct inode *
                 case SCSI_IOCTL_GET_BUS_NUMBER:
                         return scsi_ioctl(sdev, cmd, (void __user *)arg);
 	}
-	return cdrom_ioctl(file, &cd->cdi, inode->i_bdev, cmd, arg);
+	return cdrom_ioctl(file, &cd->cdi, bdev, cmd, arg);
 }
 
 static int sr_block_media_changed(struct gendisk *disk)
diff -puN fs/block_dev.c~blkdev_ioctl_use_bdev fs/block_dev.c
--- linux/fs/block_dev.c~blkdev_ioctl_use_bdev	2005-05-22 12:47:38.000000000 +0200
+++ linux-petero/fs/block_dev.c	2005-05-22 12:47:38.000000000 +0200
@@ -780,7 +780,7 @@ static ssize_t blkdev_file_aio_write(str
 static int block_ioctl(struct inode *inode, struct file *file, unsigned cmd,
 			unsigned long arg)
 {
-	return blkdev_ioctl(file->f_mapping->host, file, cmd, arg);
+	return blkdev_ioctl(file->f_mapping->host->i_bdev, file, cmd, arg);
 }
 
 struct address_space_operations def_blk_aops = {
@@ -817,7 +817,7 @@ int ioctl_by_bdev(struct block_device *b
 	int res;
 	mm_segment_t old_fs = get_fs();
 	set_fs(KERNEL_DS);
-	res = blkdev_ioctl(bdev->bd_inode, NULL, cmd, arg);
+	res = blkdev_ioctl(bdev, NULL, cmd, arg);
 	set_fs(old_fs);
 	return res;
 }
diff -puN include/linux/fs.h~blkdev_ioctl_use_bdev include/linux/fs.h
--- linux/include/linux/fs.h~blkdev_ioctl_use_bdev	2005-05-22 12:47:38.000000000 +0200
+++ linux-petero/include/linux/fs.h	2005-05-22 12:47:38.000000000 +0200
@@ -882,7 +882,7 @@ typedef int (*filldir_t)(void *, const c
 struct block_device_operations {
 	int (*open) (struct inode *, struct file *);
 	int (*release) (struct inode *, struct file *);
-	int (*ioctl) (struct inode *, struct file *, unsigned, unsigned long);
+	int (*ioctl) (struct block_device *, struct file *, unsigned, unsigned long);
 	long (*compat_ioctl) (struct file *, unsigned, unsigned long);
 	int (*media_changed) (struct gendisk *);
 	int (*revalidate_disk) (struct gendisk *);
@@ -1290,7 +1290,7 @@ extern struct file_operations def_chr_fo
 extern struct file_operations bad_sock_fops;
 extern struct file_operations def_fifo_fops;
 extern int ioctl_by_bdev(struct block_device *, unsigned, unsigned long);
-extern int blkdev_ioctl(struct inode *, struct file *, unsigned, unsigned long);
+extern int blkdev_ioctl(struct block_device *, struct file *, unsigned, unsigned long);
 extern long compat_blkdev_ioctl(struct file *, unsigned, unsigned long);
 extern int blkdev_get(struct block_device *, mode_t, unsigned);
 extern int blkdev_put(struct block_device *);
_


-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
