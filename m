Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317354AbSG3WyV>; Tue, 30 Jul 2002 18:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317361AbSG3WyV>; Tue, 30 Jul 2002 18:54:21 -0400
Received: from 12-231-243-94.client.attbi.com ([12.231.243.94]:9478 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S317354AbSG3WxE>;
	Tue, 30 Jul 2002 18:53:04 -0400
Date: Tue, 30 Jul 2002 15:55:06 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, rgooch@atnf.csiro.au
Subject: Re: [BK PATCH] devfs cleanups for 2.5.29
Message-ID: <20020730225506.GC17826@kroah.com>
References: <20020730225359.GA17826@kroah.com> <20020730225442.GB17826@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020730225442.GB17826@kroah.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.2.21 (i586)
Reply-By: Tue, 02 Jul 2002 21:52:39 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.544   -> 1.545  
#	 drivers/ide/probe.c	1.65    -> 1.66   
#	drivers/block/ps2esdi.c	1.39    -> 1.40   
#	drivers/cdrom/gscd.c	1.18    -> 1.19   
#	drivers/block/loop.c	1.52    -> 1.53   
#	 drivers/cdrom/mcd.c	1.16    -> 1.17   
#	    drivers/ide/hd.c	1.27    -> 1.28   
#	drivers/cdrom/cdu31a.c	1.20    -> 1.21   
#	drivers/block/floppy.c	1.33    -> 1.34   
#	drivers/cdrom/sbpcd.c	1.23    -> 1.24   
#	     fs/devfs/base.c	1.46    -> 1.47   
#	   drivers/scsi/sd.c	1.45    -> 1.46   
#	drivers/cdrom/optcd.c	1.14    -> 1.15   
#	   drivers/scsi/sr.c	1.30    -> 1.31   
#	  drivers/block/xd.c	1.30    -> 1.31   
#	     drivers/md/md.c	1.89    -> 1.90   
#	drivers/cdrom/sonycd535.c	1.18    -> 1.19   
#	drivers/cdrom/cm206.c	1.17    -> 1.18   
#	drivers/block/swim3.c	1.13    -> 1.14   
#	drivers/mtd/mtdblock.c	1.20    -> 1.21   
#	drivers/cdrom/mcdx.c	1.17    -> 1.18   
#	drivers/block/acsi.c	1.27    -> 1.28   
#	    drivers/md/lvm.c	1.30    -> 1.31   
#	drivers/cdrom/sjcd.c	1.14    -> 1.15   
#	include/linux/devfs_fs_kernel.h	1.13    -> 1.14   
#	drivers/s390/block/xpram.c	1.23    -> 1.24   
#	drivers/block/DAC960.c	1.32    -> 1.33   
#	drivers/s390/block/dasd_genhd.c	1.2     -> 1.3    
#	drivers/block/paride/pd.c	1.28    -> 1.29   
#	drivers/cdrom/aztcd.c	1.16    -> 1.17   
#	drivers/s390/char/tapeblock.c	1.12    -> 1.13   
#	      fs/block_dev.c	1.75    -> 1.76   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/07/30	greg@kroah.com	1.545
# Removed devfs_register_blkdev and devfs_unregister_blkdev.
# 
# Use register_blkdev and unregister_blkdev as before, and everything will work just fine.
# --------------------------------------------
#
diff -Nru a/drivers/block/DAC960.c b/drivers/block/DAC960.c
--- a/drivers/block/DAC960.c	Tue Jul 30 15:50:01 2002
+++ b/drivers/block/DAC960.c	Tue Jul 30 15:50:01 2002
@@ -1934,7 +1934,7 @@
   /*
     Register the Block Device Major Number for this DAC960 Controller.
   */
-  if (devfs_register_blkdev(MajorNumber, "dac960",
+  if (register_blkdev(MajorNumber, "dac960",
 			    &DAC960_BlockDeviceOperations) < 0)
     {
       DAC960_Error("UNABLE TO ACQUIRE MAJOR NUMBER %d - DETACHING\n",
@@ -1993,7 +1993,7 @@
   /*
     Unregister the Block Device Major Number for this DAC960 Controller.
   */
-  devfs_unregister_blkdev(MajorNumber, "dac960");
+  unregister_blkdev(MajorNumber, "dac960");
   /*
     Remove the I/O Request Queue.
   */
diff -Nru a/drivers/block/acsi.c b/drivers/block/acsi.c
--- a/drivers/block/acsi.c	Tue Jul 30 15:50:01 2002
+++ b/drivers/block/acsi.c	Tue Jul 30 15:50:01 2002
@@ -56,7 +56,6 @@
 #include <linux/fs.h>
 #include <linux/kernel.h>
 #include <linux/genhd.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/delay.h>
 #include <linux/mm.h>
 #include <linux/major.h>
@@ -1741,14 +1740,14 @@
 	int err = 0;
 	if (!MACH_IS_ATARI || !ATARIHW_PRESENT(ACSI))
 		return 0;
-	if (devfs_register_blkdev( MAJOR_NR, "ad", &acsi_fops )) {
+	if (register_blkdev( MAJOR_NR, "ad", &acsi_fops )) {
 		printk( KERN_ERR "Unable to get major %d for ACSI\n", MAJOR_NR );
 		return -EBUSY;
 	}
 	if (!(acsi_buffer =
 		  (char *)atari_stram_alloc(ACSI_BUFFER_SIZE, "acsi"))) {
 		printk( KERN_ERR "Unable to get ACSI ST-Ram buffer.\n" );
-		devfs_unregister_blkdev( MAJOR_NR, "ad" );
+		unregister_blkdev( MAJOR_NR, "ad" );
 		return -ENOMEM;
 	}
 	phys_acsi_buffer = virt_to_phys( acsi_buffer );
@@ -1786,7 +1785,7 @@
 	blk_cleanup_queue(BLK_DEFAULT_QUEUE(MAJOR_NR));
 	atari_stram_free( acsi_buffer );
 
-	if (devfs_unregister_blkdev( MAJOR_NR, "ad" ) != 0)
+	if (unregister_blkdev( MAJOR_NR, "ad" ) != 0)
 		printk( KERN_ERR "acsi: cleanup_module failed\n");
 
 	del_gendisk(&acsi_gendisk);
diff -Nru a/drivers/block/floppy.c b/drivers/block/floppy.c
--- a/drivers/block/floppy.c	Tue Jul 30 15:50:01 2002
+++ b/drivers/block/floppy.c	Tue Jul 30 15:50:01 2002
@@ -4233,7 +4233,7 @@
 	raw_cmd = NULL;
 
 	devfs_handle = devfs_mk_dir (NULL, "floppy", NULL);
-	if (devfs_register_blkdev(MAJOR_NR,"fd",&floppy_fops)) {
+	if (register_blkdev(MAJOR_NR,"fd",&floppy_fops)) {
 		printk("Unable to get major %d for floppy\n",MAJOR_NR);
 		return -EBUSY;
 	}
@@ -4266,7 +4266,7 @@
 	use_virtual_dma = can_use_virtual_dma & 1;
 	fdc_state[0].address = FDC1;
 	if (fdc_state[0].address == -1) {
-		devfs_unregister_blkdev(MAJOR_NR,"fd");
+		unregister_blkdev(MAJOR_NR,"fd");
 		del_timer(&fd_timeout);
 		blk_cleanup_queue(BLK_DEFAULT_QUEUE(MAJOR_NR));
 		return -ENODEV;
@@ -4279,7 +4279,7 @@
 	if (floppy_grab_irq_and_dma()){
 		del_timer(&fd_timeout);
 		blk_cleanup_queue(BLK_DEFAULT_QUEUE(MAJOR_NR));
-		devfs_unregister_blkdev(MAJOR_NR,"fd");
+		unregister_blkdev(MAJOR_NR,"fd");
 		return -EBUSY;
 	}
 
@@ -4342,7 +4342,7 @@
 		if (usage_count)
 			floppy_release_irq_and_dma();
 		blk_cleanup_queue(BLK_DEFAULT_QUEUE(MAJOR_NR));
-		devfs_unregister_blkdev(MAJOR_NR,"fd");
+		unregister_blkdev(MAJOR_NR,"fd");
 	}
 	
 	for (drive = 0; drive < N_DRIVE; drive++) {
@@ -4539,7 +4539,7 @@
 	int dummy;
 		
 	devfs_unregister (devfs_handle);
-	devfs_unregister_blkdev(MAJOR_NR, "fd");
+	unregister_blkdev(MAJOR_NR, "fd");
 
 	blk_cleanup_queue(BLK_DEFAULT_QUEUE(MAJOR_NR));
 	/* eject disk, if any */
diff -Nru a/drivers/block/loop.c b/drivers/block/loop.c
--- a/drivers/block/loop.c	Tue Jul 30 15:50:01 2002
+++ b/drivers/block/loop.c	Tue Jul 30 15:50:01 2002
@@ -1027,7 +1027,7 @@
 		max_loop = 8;
 	}
 
-	if (devfs_register_blkdev(MAJOR_NR, "loop", &lo_fops)) {
+	if (register_blkdev(MAJOR_NR, "loop", &lo_fops)) {
 		printk(KERN_WARNING "Unable to get major number %d for loop"
 				    " device\n", MAJOR_NR);
 		return -EIO;
@@ -1078,7 +1078,7 @@
 void loop_exit(void) 
 {
 	devfs_unregister(devfs_handle);
-	if (devfs_unregister_blkdev(MAJOR_NR, "loop"))
+	if (unregister_blkdev(MAJOR_NR, "loop"))
 		printk(KERN_WARNING "loop: cannot unregister blkdev\n");
 
 	kfree(loop_dev);
diff -Nru a/drivers/block/paride/pd.c b/drivers/block/paride/pd.c
--- a/drivers/block/paride/pd.c	Tue Jul 30 15:50:01 2002
+++ b/drivers/block/paride/pd.c	Tue Jul 30 15:50:01 2002
@@ -940,7 +940,7 @@
 	int unit;
 
 	if (disable) return -1;
-        if (devfs_register_blkdev(MAJOR_NR,name,&pd_fops)) {
+        if (register_blkdev(MAJOR_NR,name,&pd_fops)) {
                 printk("%s: unable to get major number %d\n",
                         name,major);
                 return -1;
@@ -958,7 +958,7 @@
 	pd_init_units();
 	pd_gendisk.nr_real = pd_detect();
         if (!pd_gendisk.nr_real) {
-		devfs_unregister_blkdev(MAJOR_NR, name);
+		unregister_blkdev(MAJOR_NR, name);
 		del_gendisk(&pd_gendisk);
 		for (unit=0; unit<PD_UNITS; unit++) 
 			if (PD.present)
@@ -971,7 +971,7 @@
 static void __exit pd_exit(void)
 {
 	int unit;
-	devfs_unregister_blkdev(MAJOR_NR, name);
+	unregister_blkdev(MAJOR_NR, name);
 	del_gendisk(&pd_gendisk);
 	for (unit=0; unit<PD_UNITS; unit++) 
 		if (PD.present)
diff -Nru a/drivers/block/ps2esdi.c b/drivers/block/ps2esdi.c
--- a/drivers/block/ps2esdi.c	Tue Jul 30 15:50:01 2002
+++ b/drivers/block/ps2esdi.c	Tue Jul 30 15:50:01 2002
@@ -43,7 +43,6 @@
 #include <linux/kernel.h>
 #include <linux/genhd.h>
 #include <linux/ps2esdi.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/blk.h>
 #include <linux/blkpg.h>
 #include <linux/mca.h>
@@ -168,7 +167,7 @@
 
 	/* register the device - pass the name, major number and operations
 	   vector .                                                 */
-	if (devfs_register_blkdev(MAJOR_NR, "ed", &ps2esdi_fops)) {
+	if (register_blkdev(MAJOR_NR, "ed", &ps2esdi_fops)) {
 		printk("%s: Unable to get major number %d\n", DEVICE_NAME, MAJOR_NR);
 		return -1;
 	}
@@ -182,7 +181,7 @@
 	if (error) {
 		printk(KERN_WARNING "PS2ESDI: error initialising"
 			" device, releasing resources\n");
-		devfs_unregister_blkdev(MAJOR_NR, "ed");
+		unregister_blkdev(MAJOR_NR, "ed");
 		blk_cleanup_queue(BLK_DEFAULT_QUEUE(MAJOR_NR));
 		del_gendisk(&ps2esdi_gendisk);
 		blk_clear(MAJOR_NR);
@@ -233,7 +232,7 @@
 	release_region(io_base, 4);
 	free_dma(dma_arb_level);
 	free_irq(PS2ESDI_IRQ, &ps2esdi_gendisk);
-	devfs_unregister_blkdev(MAJOR_NR, "ed");
+	unregister_blkdev(MAJOR_NR, "ed");
 	blk_cleanup_queue(BLK_DEFAULT_QUEUE(MAJOR_NR));
 	del_gendisk(&ps2esdi_gendisk);
 	blk_clear(MAJOR_NR);
diff -Nru a/drivers/block/swim3.c b/drivers/block/swim3.c
--- a/drivers/block/swim3.c	Tue Jul 30 15:50:01 2002
+++ b/drivers/block/swim3.c	Tue Jul 30 15:50:01 2002
@@ -1034,7 +1034,7 @@
 
 	if (floppy_count > 0)
 	{
-		if (devfs_register_blkdev(MAJOR_NR, "fd", &floppy_fops)) {
+		if (register_blkdev(MAJOR_NR, "fd", &floppy_fops)) {
 			printk(KERN_ERR "Unable to get major %d for floppy\n",
 			       MAJOR_NR);
 			return -EBUSY;
diff -Nru a/drivers/block/xd.c b/drivers/block/xd.c
--- a/drivers/block/xd.c	Tue Jul 30 15:50:01 2002
+++ b/drivers/block/xd.c	Tue Jul 30 15:50:01 2002
@@ -164,7 +164,7 @@
 	init_timer (&xd_timer); xd_timer.function = xd_wakeup;
 	init_timer (&xd_watchdog_int); xd_watchdog_int.function = xd_watchdog;
 
-	if (devfs_register_blkdev(MAJOR_NR,"xd",&xd_fops)) {
+	if (register_blkdev(MAJOR_NR,"xd",&xd_fops)) {
 		printk("xd: Unable to get major number %d\n",MAJOR_NR);
 		return -1;
 	}
@@ -1085,7 +1085,7 @@
 	printk(KERN_INFO "XD: Loaded as a module.\n");
 	if (!xd_drives) {
 		/* no drives detected - unload module */
-		devfs_unregister_blkdev(MAJOR_NR, "xd");
+		unregister_blkdev(MAJOR_NR, "xd");
 		xd_done();
 		return (-1);
 	}
@@ -1095,7 +1095,7 @@
 
 void cleanup_module(void)
 {
-	devfs_unregister_blkdev(MAJOR_NR, "xd");
+	unregister_blkdev(MAJOR_NR, "xd");
 	xd_done();
 	devfs_unregister (devfs_handle);
 	if (xd_drives) {
diff -Nru a/drivers/cdrom/aztcd.c b/drivers/cdrom/aztcd.c
--- a/drivers/cdrom/aztcd.c	Tue Jul 30 15:50:01 2002
+++ b/drivers/cdrom/aztcd.c	Tue Jul 30 15:50:01 2002
@@ -1931,7 +1931,7 @@
 	}
 	devfs_register(NULL, "aztcd", DEVFS_FL_DEFAULT, MAJOR_NR, 0,
 		       S_IFBLK | S_IRUGO | S_IWUGO, &azt_fops, NULL);
-	if (devfs_register_blkdev(MAJOR_NR, "aztcd", &azt_fops) != 0) {
+	if (register_blkdev(MAJOR_NR, "aztcd", &azt_fops) != 0) {
 		printk(KERN_WARNING "aztcd: Unable to get major %d for Aztech"
 		       " CD-ROM\n", MAJOR_NR);
 		ret = -EIO;
@@ -1958,7 +1958,7 @@
 void __exit aztcd_exit(void)
 {
 	devfs_find_and_unregister(NULL, "aztcd", 0, 0, DEVFS_SPECIAL_BLK, 0);
-	if ((devfs_unregister_blkdev(MAJOR_NR, "aztcd") == -EINVAL)) {
+	if ((unregister_blkdev(MAJOR_NR, "aztcd") == -EINVAL)) {
 		printk("What's that: can't unregister aztcd\n");
 		return;
 	}
diff -Nru a/drivers/cdrom/cdu31a.c b/drivers/cdrom/cdu31a.c
--- a/drivers/cdrom/cdu31a.c	Tue Jul 30 15:50:01 2002
+++ b/drivers/cdrom/cdu31a.c	Tue Jul 30 15:50:01 2002
@@ -3367,7 +3367,7 @@
 		if (!request_region(cdu31a_port, 4, "cdu31a"))
 			goto errout3;
 
-		if (devfs_register_blkdev(MAJOR_NR, "cdu31a", &scd_bdops)) {
+		if (register_blkdev(MAJOR_NR, "cdu31a", &scd_bdops)) {
 			printk("Unable to get major %d for CDU-31a\n",
 			       MAJOR_NR);
 			goto errout2;
@@ -3460,7 +3460,7 @@
       errout0:
 	printk("Unable to register CDU-31a with Uniform cdrom driver\n");
 	blk_cleanup_queue(BLK_DEFAULT_QUEUE(MAJOR_NR));
-	if (devfs_unregister_blkdev(MAJOR_NR, "cdu31a")) {
+	if (unregister_blkdev(MAJOR_NR, "cdu31a")) {
 		printk("Can't unregister block device for cdu31a\n");
 	}
       errout2:
@@ -3477,7 +3477,7 @@
 		    ("Can't unregister cdu31a from Uniform cdrom driver\n");
 		return;
 	}
-	if ((devfs_unregister_blkdev(MAJOR_NR, "cdu31a") == -EINVAL)) {
+	if ((unregister_blkdev(MAJOR_NR, "cdu31a") == -EINVAL)) {
 		printk("Can't unregister cdu31a\n");
 		return;
 	}
diff -Nru a/drivers/cdrom/cm206.c b/drivers/cdrom/cm206.c
--- a/drivers/cdrom/cm206.c	Tue Jul 30 15:50:01 2002
+++ b/drivers/cdrom/cm206.c	Tue Jul 30 15:50:01 2002
@@ -1367,7 +1367,7 @@
 			printk("Can't unregister cdrom cm206\n");
 			return;
 		}
-		if (devfs_unregister_blkdev(MAJOR_NR, "cm206")) {
+		if (unregister_blkdev(MAJOR_NR, "cm206")) {
 			printk("Can't unregister major cm206\n");
 			return;
 		}
@@ -1490,7 +1490,7 @@
 		return -EIO;
 	}
 	printk(".\n");
-	if (devfs_register_blkdev(MAJOR_NR, "cm206", &cm206_bdops) != 0) {
+	if (register_blkdev(MAJOR_NR, "cm206", &cm206_bdops) != 0) {
 		printk(KERN_INFO "Cannot register for major %d!\n",
 		       MAJOR_NR);
 		cleanup(3);
diff -Nru a/drivers/cdrom/gscd.c b/drivers/cdrom/gscd.c
--- a/drivers/cdrom/gscd.c	Tue Jul 30 15:50:01 2002
+++ b/drivers/cdrom/gscd.c	Tue Jul 30 15:50:01 2002
@@ -934,7 +934,7 @@
 	CLEAR_TIMER;
 
 	devfs_find_and_unregister(NULL, "gscd", 0, 0, DEVFS_SPECIAL_BLK, 0);
-	if ((devfs_unregister_blkdev(MAJOR_NR, "gscd") == -EINVAL)) {
+	if ((unregister_blkdev(MAJOR_NR, "gscd") == -EINVAL)) {
 		printk("What's that: can't unregister GoldStar-module\n");
 		return;
 	}
@@ -1012,7 +1012,7 @@
 		i++;
 	}
 
-	if (devfs_register_blkdev(MAJOR_NR, "gscd", &gscd_fops) != 0) {
+	if (register_blkdev(MAJOR_NR, "gscd", &gscd_fops) != 0) {
 		printk(KERN_WARNING "GSCD: Unable to get major %d for GoldStar "
 		       "CD-ROM\n", MAJOR_NR);
 		ret = -EIO;
diff -Nru a/drivers/cdrom/mcd.c b/drivers/cdrom/mcd.c
--- a/drivers/cdrom/mcd.c	Tue Jul 30 15:50:01 2002
+++ b/drivers/cdrom/mcd.c	Tue Jul 30 15:50:01 2002
@@ -1039,7 +1039,7 @@
 	case 2:
 		release_region(mcd_port, 4);
 	case 1:
-		if (devfs_unregister_blkdev(MAJOR_NR, "mcd")) {
+		if (unregister_blkdev(MAJOR_NR, "mcd")) {
 			printk(KERN_WARNING "Can't unregister major mcd\n");
 			return;
 		}
@@ -1065,7 +1065,7 @@
 		return -EIO;
 	}
 
-	if (devfs_register_blkdev(MAJOR_NR, "mcd", &mcd_bdops) != 0) {
+	if (register_blkdev(MAJOR_NR, "mcd", &mcd_bdops) != 0) {
 		printk(KERN_ERR "mcd: Unable to get major %d for Mitsumi CD-ROM\n", MAJOR_NR);
 		return -EIO;
 	}
diff -Nru a/drivers/cdrom/mcdx.c b/drivers/cdrom/mcdx.c
--- a/drivers/cdrom/mcdx.c	Tue Jul 30 15:50:01 2002
+++ b/drivers/cdrom/mcdx.c	Tue Jul 30 15:50:01 2002
@@ -1166,7 +1166,7 @@
 	}
 
 	xtrace(INIT, "init() register blkdev\n");
-	if (devfs_register_blkdev(MAJOR_NR, "mcdx", &mcdx_bdops) != 0) {
+	if (register_blkdev(MAJOR_NR, "mcdx", &mcdx_bdops) != 0) {
 		release_region((unsigned long) stuffp->wreg_data,
 			       MCDX_IO_SIZE);
 		xwarn("%s=0x%3p,%d: Init failed. Can't get major %d.\n",
@@ -1222,7 +1222,7 @@
 			       MCDX_IO_SIZE);
 		free_irq(stuffp->irq, NULL);
 		kfree(stuffp);
-		if (devfs_unregister_blkdev(MAJOR_NR, "mcdx") != 0)
+		if (unregister_blkdev(MAJOR_NR, "mcdx") != 0)
 			xwarn("cleanup() unregister_blkdev() failed\n");
 		blk_cleanup_queue(BLK_DEFAULT_QUEUE(MAJOR_NR));
 		return 2;
diff -Nru a/drivers/cdrom/optcd.c b/drivers/cdrom/optcd.c
--- a/drivers/cdrom/optcd.c	Tue Jul 30 15:50:01 2002
+++ b/drivers/cdrom/optcd.c	Tue Jul 30 15:50:01 2002
@@ -2031,8 +2031,7 @@
 		DEBUG((DEBUG_VFS, "exec_cmd COMINITDOUBLE: %02x", -status));
 		return -EIO;
 	}
-	if (devfs_register_blkdev(MAJOR_NR, "optcd", &opt_fops) != 0)
-	{
+	if (register_blkdev(MAJOR_NR, "optcd", &opt_fops) != 0) {
 		printk(KERN_ERR "optcd: unable to get major %d\n", MAJOR_NR);
 		release_region(optcd_port, 4);
 		return -EIO;
@@ -2052,7 +2051,7 @@
 void __exit optcd_exit(void)
 {
 	devfs_find_and_unregister(NULL, "optcd", 0, 0, DEVFS_SPECIAL_BLK, 0);
-	if (devfs_unregister_blkdev(MAJOR_NR, "optcd") == -EINVAL) {
+	if (unregister_blkdev(MAJOR_NR, "optcd") == -EINVAL) {
 		printk(KERN_ERR "optcd: what's that: can't unregister\n");
 		return;
 	}
diff -Nru a/drivers/cdrom/sbpcd.c b/drivers/cdrom/sbpcd.c
--- a/drivers/cdrom/sbpcd.c	Tue Jul 30 15:50:01 2002
+++ b/drivers/cdrom/sbpcd.c	Tue Jul 30 15:50:01 2002
@@ -5771,7 +5771,7 @@
 	OUT(MIXER_data,0xCC); /* one nibble per channel, max. value: 0xFF */
 #endif /* SOUND_BASE */
 
-	if (devfs_register_blkdev(MAJOR_NR, major_name, &sbpcd_bdops) != 0)
+	if (register_blkdev(MAJOR_NR, major_name, &sbpcd_bdops) != 0)
 	{
 		msg(DBG_INF, "Can't get MAJOR %d for Matsushita CDROM\n", MAJOR_NR);
 #ifdef MODULE
@@ -5806,7 +5806,7 @@
 		if (D_S[j].sbp_buf==NULL)
 		{
 			msg(DBG_INF,"data buffer (%d frames) not available.\n",D_S[j].sbp_bufsiz);
-			if ((devfs_unregister_blkdev(MAJOR_NR, major_name) == -EINVAL))
+			if ((unregister_blkdev(MAJOR_NR, major_name) == -EINVAL))
 			{
 				printk("Can't unregister %s\n", major_name);
 			}
@@ -5858,7 +5858,7 @@
 {
 	int j;
 	
-	if ((devfs_unregister_blkdev(MAJOR_NR, major_name) == -EINVAL))
+	if ((unregister_blkdev(MAJOR_NR, major_name) == -EINVAL))
 	{
 		msg(DBG_INF, "What's that: can't unregister %s.\n", major_name);
 		return;
diff -Nru a/drivers/cdrom/sjcd.c b/drivers/cdrom/sjcd.c
--- a/drivers/cdrom/sjcd.c	Tue Jul 30 15:50:01 2002
+++ b/drivers/cdrom/sjcd.c	Tue Jul 30 15:50:01 2002
@@ -1680,7 +1680,7 @@
 	printk("SJCD: sjcd=0x%x: ", sjcd_base);
 #endif
 
-	if (devfs_register_blkdev(MAJOR_NR, "sjcd", &sjcd_fops) != 0) {
+	if (register_blkdev(MAJOR_NR, "sjcd", &sjcd_fops) != 0) {
 		printk("SJCD: Unable to get major %d for Sanyo CD-ROM\n",
 		       MAJOR_NR);
 		return (-EIO);
@@ -1789,7 +1789,7 @@
 
 static int sjcd_cleanup(void)
 {
-	if ((devfs_unregister_blkdev(MAJOR_NR, "sjcd") == -EINVAL))
+	if ((unregister_blkdev(MAJOR_NR, "sjcd") == -EINVAL))
 		printk("SJCD: cannot unregister device.\n");
 	else {
 		release_region(sjcd_base, 4);
diff -Nru a/drivers/cdrom/sonycd535.c b/drivers/cdrom/sonycd535.c
--- a/drivers/cdrom/sonycd535.c	Tue Jul 30 15:50:01 2002
+++ b/drivers/cdrom/sonycd535.c	Tue Jul 30 15:50:01 2002
@@ -1572,7 +1572,7 @@
 								MAJOR_NR, 0,
 								S_IFBLK | S_IRUGO | S_IWUGO,
 								&cdu_fops, NULL);
-				if (devfs_register_blkdev(MAJOR_NR, CDU535_HANDLE, &cdu_fops)) {
+				if (register_blkdev(MAJOR_NR, CDU535_HANDLE, &cdu_fops)) {
 					printk("Unable to get major %d for %s\n",
 							MAJOR_NR, CDU535_MESSAGE_NAME);
 					return -EIO;
@@ -1585,7 +1585,7 @@
 					kmalloc(sizeof *sony_toc, GFP_KERNEL);
 				if (sony_toc == NULL) {
 					blk_cleanup_queue(BLK_DEFAULT_QUEUE(MAJOR_NR));
-					devfs_unregister_blkdev(MAJOR_NR, CDU535_HANDLE);
+					unregister_blkdev(MAJOR_NR, CDU535_HANDLE);
 					devfs_unregister(sony_devfs_handle);
 					return -ENOMEM;
 				}
@@ -1594,7 +1594,7 @@
 				if (last_sony_subcode == NULL) {
 					blk_cleanup_queue(BLK_DEFAULT_QUEUE(MAJOR_NR));
 					kfree(sony_toc);
-					devfs_unregister_blkdev(MAJOR_NR, CDU535_HANDLE);
+					unregister_blkdev(MAJOR_NR, CDU535_HANDLE);
 					devfs_unregister(sony_devfs_handle);
 					return -ENOMEM;
 				}
@@ -1604,7 +1604,7 @@
 					blk_cleanup_queue(BLK_DEFAULT_QUEUE(MAJOR_NR));
 					kfree(sony_toc);
 					kfree(last_sony_subcode);
-					devfs_unregister_blkdev(MAJOR_NR, CDU535_HANDLE);
+					unregister_blkdev(MAJOR_NR, CDU535_HANDLE);
 					devfs_unregister(sony_devfs_handle);
 					return -ENOMEM;
 				}
@@ -1618,7 +1618,7 @@
 						kfree(sony_buffer);
 						kfree(sony_toc);
 						kfree(last_sony_subcode);
-						devfs_unregister_blkdev(MAJOR_NR, CDU535_HANDLE);
+						unregister_blkdev(MAJOR_NR, CDU535_HANDLE);
 						devfs_unregister(sony_devfs_handle);
 						return -ENOMEM;
 					}
@@ -1643,7 +1643,7 @@
 		kfree(sony_buffer);
 		kfree(sony_toc);
 		kfree(last_sony_subcode);
-		devfs_unregister_blkdev(MAJOR_NR, CDU535_HANDLE);
+		unregister_blkdev(MAJOR_NR, CDU535_HANDLE);
 		devfs_unregister(sony_devfs_handle);
 		if (sony535_irq_used)
 			free_irq(sony535_irq_used, NULL);
@@ -1702,7 +1702,7 @@
 	kfree(sony_toc);
 	devfs_find_and_unregister(NULL, CDU535_HANDLE, 0, 0,
 				  DEVFS_SPECIAL_BLK, 0);
-	if (devfs_unregister_blkdev(MAJOR_NR, CDU535_HANDLE) == -EINVAL)
+	if (unregister_blkdev(MAJOR_NR, CDU535_HANDLE) == -EINVAL)
 		printk("Uh oh, couldn't unregister " CDU535_HANDLE "\n");
 	else
 		printk(KERN_INFO CDU535_HANDLE " module released\n");
diff -Nru a/drivers/ide/hd.c b/drivers/ide/hd.c
--- a/drivers/ide/hd.c	Tue Jul 30 15:50:01 2002
+++ b/drivers/ide/hd.c	Tue Jul 30 15:50:01 2002
@@ -35,7 +35,6 @@
 #include <linux/sched.h>
 #include <linux/timer.h>
 #include <linux/fs.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/kernel.h>
 #include <linux/hdreg.h>
 #include <linux/genhd.h>
@@ -818,7 +817,7 @@
 
 int __init hd_init(void)
 {
-	if (devfs_register_blkdev(MAJOR_NR,"hd",&hd_fops)) {
+	if (register_blkdev(MAJOR_NR,"hd",&hd_fops)) {
 		printk("hd: unable to get major %d for hard disk\n",MAJOR_NR);
 		return -1;
 	}
diff -Nru a/drivers/ide/probe.c b/drivers/ide/probe.c
--- a/drivers/ide/probe.c	Tue Jul 30 15:50:01 2002
+++ b/drivers/ide/probe.c	Tue Jul 30 15:50:01 2002
@@ -1089,7 +1089,7 @@
 	}
 #endif
 
-	if (devfs_register_blkdev(ch->major, ch->name, ide_fops)) {
+	if (register_blkdev(ch->major, ch->name, ide_fops)) {
 		printk("%s: UNABLE TO GET MAJOR NUMBER %d\n", ch->name, ch->major);
 
 		return;
diff -Nru a/drivers/md/lvm.c b/drivers/md/lvm.c
--- a/drivers/md/lvm.c	Tue Jul 30 15:50:01 2002
+++ b/drivers/md/lvm.c	Tue Jul 30 15:50:01 2002
@@ -213,7 +213,6 @@
 #include <linux/proc_fs.h>
 #include <linux/blkdev.h>
 #include <linux/genhd.h>
-#include <linux/devfs_fs_kernel.h>
 #include <linux/smp_lock.h>
 #include <asm/ioctl.h>
 #include <asm/uaccess.h>
@@ -395,9 +394,8 @@
 		return -EIO;
 	}
 
-	if (devfs_register_blkdev(MAJOR_NR, lvm_name, &lvm_blk_dops) < 0)
-	{
-		printk("%s -- devfs_register_blkdev failed\n", lvm_name);
+	if (register_blkdev(MAJOR_NR, lvm_name, &lvm_blk_dops) < 0) {
+		printk("%s -- register_blkdev failed\n", lvm_name);
 		if (unregister_chrdev(LVM_CHAR_MAJOR, lvm_name) < 0)
 			printk(KERN_ERR
 			       "%s -- unregister_chrdev failed\n",
@@ -445,8 +443,8 @@
 	if (unregister_chrdev(LVM_CHAR_MAJOR, lvm_name) < 0)
 		printk(KERN_ERR "%s -- unregister_chrdev failed\n",
 		       lvm_name);
-	if (devfs_unregister_blkdev(MAJOR_NR, lvm_name) < 0)
-		printk(KERN_ERR "%s -- devfs_unregister_blkdev failed\n",
+	if (unregister_blkdev(MAJOR_NR, lvm_name) < 0)
+		printk(KERN_ERR "%s -- unregister_blkdev failed\n",
 		       lvm_name);
 
 	del_gendisk(&lvm_gendisk);
diff -Nru a/drivers/md/md.c b/drivers/md/md.c
--- a/drivers/md/md.c	Tue Jul 30 15:50:01 2002
+++ b/drivers/md/md.c	Tue Jul 30 15:50:01 2002
@@ -3207,8 +3207,7 @@
 			MD_MAJOR_VERSION, MD_MINOR_VERSION,
 			MD_PATCHLEVEL_VERSION, MAX_MD_DEVS, MD_SB_DISKS);
 
-	if (devfs_register_blkdev (MAJOR_NR, "md", &md_fops))
-	{
+	if (register_blkdev (MAJOR_NR, "md", &md_fops)) {
 		printk(KERN_ALERT "md: Unable to get major %d for md\n", MAJOR_NR);
 		return (-1);
 	}
@@ -3568,7 +3567,7 @@
 	md_unregister_thread(md_recovery_thread);
 	devfs_unregister(devfs_handle);
 
-	devfs_unregister_blkdev(MAJOR_NR,"md");
+	unregister_blkdev(MAJOR_NR,"md");
 	unregister_reboot_notifier(&md_notifier);
 	unregister_sysctl_table(raid_table_header);
 #ifdef CONFIG_PROC_FS
diff -Nru a/drivers/mtd/mtdblock.c b/drivers/mtd/mtdblock.c
--- a/drivers/mtd/mtdblock.c	Tue Jul 30 15:50:01 2002
+++ b/drivers/mtd/mtdblock.c	Tue Jul 30 15:50:01 2002
@@ -593,22 +593,14 @@
 	int i;
 
 	spin_lock_init(&mtdblks_lock);
-#ifdef CONFIG_DEVFS_FS
-	if (devfs_register_blkdev(MTD_BLOCK_MAJOR, DEVICE_NAME, &mtd_fops))
-	{
-		printk(KERN_NOTICE "Can't allocate major number %d for Memory Technology Devices.\n",
-			MTD_BLOCK_MAJOR);
-		return -EAGAIN;
-	}
-
-	devfs_dir_handle = devfs_mk_dir(NULL, DEVICE_NAME, NULL);
-	register_mtd_user(&notifier);
-#else
 	if (register_blkdev(MAJOR_NR,DEVICE_NAME,&mtd_fops)) {
 		printk(KERN_NOTICE "Can't allocate major number %d for Memory Technology Devices.\n",
 		       MTD_BLOCK_MAJOR);
 		return -EAGAIN;
 	}
+#ifdef CONFIG_DEVFS_FS
+	devfs_dir_handle = devfs_mk_dir(NULL, DEVICE_NAME, NULL);
+	register_mtd_user(&notifier);
 #endif
 	
 	/* We fill it in at open() time. */
@@ -630,10 +622,8 @@
 #ifdef CONFIG_DEVFS_FS
 	unregister_mtd_user(&notifier);
 	devfs_unregister(devfs_dir_handle);
-	devfs_unregister_blkdev(MTD_BLOCK_MAJOR, DEVICE_NAME);
-#else
-	unregister_blkdev(MAJOR_NR,DEVICE_NAME);
 #endif
+	unregister_blkdev(MAJOR_NR,DEVICE_NAME);
 	blk_cleanup_queue(BLK_DEFAULT_QUEUE(MAJOR_NR));
 	blk_size[MAJOR_NR] = NULL;
 }
diff -Nru a/drivers/s390/block/dasd_genhd.c b/drivers/s390/block/dasd_genhd.c
--- a/drivers/s390/block/dasd_genhd.c	Tue Jul 30 15:50:01 2002
+++ b/drivers/s390/block/dasd_genhd.c	Tue Jul 30 15:50:01 2002
@@ -92,8 +92,7 @@
 	}
 
 	/* Register block device. */
-	new_major = devfs_register_blkdev(major, "dasd",
-					  &dasd_device_operations);
+	new_major = register_blkdev(major, "dasd", &dasd_device_operations);
 	if (new_major < 0) {
 		MESSAGE(KERN_WARNING,
 			"Cannot register to major no %d, rc = %d", major, rc);
@@ -168,7 +167,7 @@
 	bs = blk_size[major];
 	blk_clear(major);
 
-	rc = devfs_unregister_blkdev(major, "dasd");
+	rc = unregister_blkdev(major, "dasd");
 	if (rc < 0)
 		MESSAGE(KERN_WARNING,
 			"Cannot unregister from major no %d, rc = %d",
diff -Nru a/drivers/s390/block/xpram.c b/drivers/s390/block/xpram.c
--- a/drivers/s390/block/xpram.c	Tue Jul 30 15:50:01 2002
+++ b/drivers/s390/block/xpram.c	Tue Jul 30 15:50:01 2002
@@ -449,7 +449,7 @@
 	/*
 	 * Register xpram major.
 	 */
-	rc = devfs_register_blkdev(XPRAM_MAJOR, XPRAM_NAME, &xpram_devops);
+	rc = register_blkdev(XPRAM_MAJOR, XPRAM_NAME, &xpram_devops);
 	if (rc < 0) {
 		PRINT_ERR("Can't get xpram major %d\n", XPRAM_MAJOR);
 		return rc;
@@ -489,7 +489,7 @@
 static void __exit xpram_exit(void)
 {
 	blk_clear(XPRAM_MAJOR);
-	devfs_unregister_blkdev(XPRAM_MAJOR, XPRAM_NAME);
+	unregister_blkdev(XPRAM_MAJOR, XPRAM_NAME);
 	devfs_unregister(xpram_devfs_handle);
 	unregister_sys_device(&xpram_sys_device);
 }
diff -Nru a/drivers/s390/char/tapeblock.c b/drivers/s390/char/tapeblock.c
--- a/drivers/s390/char/tapeblock.c	Tue Jul 30 15:50:01 2002
+++ b/drivers/s390/char/tapeblock.c	Tue Jul 30 15:50:01 2002
@@ -97,11 +97,7 @@
 	tape_dev_t* td;
 	tape_init();
 	/* Register the tape major number to the kernel */
-#ifdef CONFIG_DEVFS_FS
-	result = devfs_register_blkdev(tapeblock_major, "tBLK", &tapeblock_fops);
-#else
 	result = register_blkdev(tapeblock_major, "tBLK", &tapeblock_fops);
-#endif
 	if (result < 0) {
 		PRINT_WARN(KERN_ERR "tape: can't get major %d for block device\n", tapeblock_major);
 		result=-ENODEV;
@@ -149,11 +145,7 @@
 out_undo_blk_size:
 	kfree(blk_size[tapeblock_major]);
 out_undo_bdev:
-#ifdef CONFIG_DEVFS_FS
-	devfs_unregister_blkdev(tapeblock_major, "tBLK");
-#else
 	unregister_blkdev(tapeblock_major, "tBLK");
-#endif
 	result=-ENOMEM;
 	blk_size[tapeblock_major]=
 	hardsect_size[tapeblock_major]=
@@ -181,11 +173,7 @@
 		max_sectors[tapeblock_major]=NULL;
 	}
 
-#ifdef CONFIG_DEVFS_FS
-	devfs_unregister_blkdev(tapeblock_major, "tBLK");
-#else
 	unregister_blkdev(tapeblock_major, "tBLK");
-#endif
 
 out:
 	return;
diff -Nru a/drivers/scsi/sd.c b/drivers/scsi/sd.c
--- a/drivers/scsi/sd.c	Tue Jul 30 15:50:01 2002
+++ b/drivers/scsi/sd.c	Tue Jul 30 15:50:01 2002
@@ -1198,8 +1198,7 @@
 
 	if (!sd_registered) {
 		for (k = 0; k < N_USED_SD_MAJORS; k++) {
-			if (devfs_register_blkdev(SD_MAJOR(k), "sd",
-						  &sd_fops)) {
+			if (register_blkdev(SD_MAJOR(k), "sd", &sd_fops)) {
 				printk(KERN_NOTICE "Unable to get major %d "
 				       "for SCSI disk\n", SD_MAJOR(k));
 				return 1;
@@ -1296,7 +1295,7 @@
 		sd_dsk_arr = NULL;
 	}
 	for (k = 0; k < N_USED_SD_MAJORS; k++) {
-		devfs_unregister_blkdev(SD_MAJOR(k), "sd");
+		unregister_blkdev(SD_MAJOR(k), "sd");
 	}
 	sd_registered--;
 	return 1;
@@ -1560,7 +1559,7 @@
 	SCSI_LOG_HLQUEUE(3, printk("exit_sd: exiting sd driver\n"));
 	scsi_unregister_device(&sd_template);
 	for (k = 0; k < N_USED_SD_MAJORS; k++)
-		devfs_unregister_blkdev(SD_MAJOR(k), "sd");
+		unregister_blkdev(SD_MAJOR(k), "sd");
 
 	sd_registered--;
 	if (sd_dsk_arr != NULL) {
diff -Nru a/drivers/scsi/sr.c b/drivers/scsi/sr.c
--- a/drivers/scsi/sr.c	Tue Jul 30 15:50:01 2002
+++ b/drivers/scsi/sr.c	Tue Jul 30 15:50:01 2002
@@ -702,7 +702,7 @@
 		return 0;
 
 	if (!sr_registered) {
-		if (devfs_register_blkdev(MAJOR_NR, "sr", &sr_bdops)) {
+		if (register_blkdev(MAJOR_NR, "sr", &sr_bdops)) {
 			printk("Unable to get major %d for SCSI-CD\n", MAJOR_NR);
 			return 1;
 		}
@@ -714,7 +714,7 @@
 	sr_template.dev_max = sr_template.dev_noticed + SR_EXTRA_DEVS;
 	scsi_CDs = kmalloc(sr_template.dev_max * sizeof(Scsi_CD), GFP_ATOMIC);
 	if (!scsi_CDs)
-		goto cleanup_devfs;
+		goto cleanup_dev;
 	memset(scsi_CDs, 0, sr_template.dev_max * sizeof(Scsi_CD));
 
 	sr_sizes = kmalloc(sr_template.dev_max * sizeof(int), GFP_ATOMIC);
@@ -725,8 +725,8 @@
 
 cleanup_cds:
 	kfree(scsi_CDs);
-cleanup_devfs:
-	devfs_unregister_blkdev(MAJOR_NR, "sr");
+cleanup_dev:
+	unregister_blkdev(MAJOR_NR, "sr");
 	sr_registered--;
 	return 1;
 }
@@ -869,7 +869,7 @@
 static void __exit exit_sr(void)
 {
 	scsi_unregister_device(&sr_template);
-	devfs_unregister_blkdev(MAJOR_NR, "sr");
+	unregister_blkdev(MAJOR_NR, "sr");
 	sr_registered--;
 	if (scsi_CDs != NULL) {
 		kfree(scsi_CDs);
diff -Nru a/fs/block_dev.c b/fs/block_dev.c
--- a/fs/block_dev.c	Tue Jul 30 15:50:01 2002
+++ b/fs/block_dev.c	Tue Jul 30 15:50:01 2002
@@ -453,6 +453,8 @@
 
 int register_blkdev(unsigned int major, const char * name, struct block_device_operations *bdops)
 {
+	if (devfs_should_register_blkdev())
+		return 0;
 	if (major == 0) {
 		for (major = MAX_BLKDEV-1; major > 0; major--) {
 			if (blkdevs[major].bdops == NULL) {
@@ -474,6 +476,8 @@
 
 int unregister_blkdev(unsigned int major, const char * name)
 {
+	if (devfs_should_unregister_blkdev())
+		return 0;
 	if (major >= MAX_BLKDEV)
 		return -EINVAL;
 	if (!blkdevs[major].bdops)
diff -Nru a/fs/devfs/base.c b/fs/devfs/base.c
--- a/fs/devfs/base.c	Tue Jul 30 15:50:01 2002
+++ b/fs/devfs/base.c	Tue Jul 30 15:50:01 2002
@@ -2241,22 +2241,18 @@
 
 
 /**
- *	devfs_register_blkdev - Optionally register a conventional block driver.
- *	@major: The major number for the driver.
- *	@name: The name of the driver (as seen in /proc/devices).
- *	@bdops: The &block_device_operations structure pointer.
+ *	devfs_should_register_blkdev - should we register a conventional block driver.
  *
- *	This function will register a block driver provided the "devfs=only"
- *	option was not provided at boot time.
- *	Returns 0 on success, else a negative error code on failure.
+ *	If the "devfs=only" option was provided at boot time, this function will
+ *	return -1, otherwise 0 is returned.
  */
 
-int devfs_register_blkdev (unsigned int major, const char *name,
-			   struct block_device_operations *bdops)
+int devfs_should_register_blkdev (void)
 {
-    if (boot_options & OPTION_ONLY) return 0;
-    return register_blkdev (major, name, bdops);
-}   /*  End Function devfs_register_blkdev  */
+    if (boot_options & OPTION_ONLY)
+	    return -1;
+    return 0;
+}
 
 
 /**
@@ -2273,20 +2269,18 @@
 
 
 /**
- *	devfs_unregister_blkdev - Optionally unregister a conventional block driver.
- *	@major: The major number for the driver.
- *	@name: The name of the driver (as seen in /proc/devices).
+ *	devfs_should_unregister_blkdev - should we unregister a conventional block driver.
  *
- *	This function will unregister a block driver provided the "devfs=only"
- *	option was not provided at boot time.
- *	Returns 0 on success, else a negative error code on failure.
+ *	If the "devfs=only" option was provided at boot time, this function will
+ *	return -1, otherwise 0 is returned.
  */
 
-int devfs_unregister_blkdev (unsigned int major, const char *name)
+int devfs_should_unregister_blkdev (void)
 {
-    if (boot_options & OPTION_ONLY) return 0;
-    return unregister_blkdev (major, name);
-}   /*  End Function devfs_unregister_blkdev  */
+    if (boot_options & OPTION_ONLY)
+	    return -1;
+    return 0;
+}
 
 /**
  *	devfs_setup - Process kernel boot options.
@@ -2375,8 +2369,6 @@
 EXPORT_SYMBOL(devfs_auto_unregister);
 EXPORT_SYMBOL(devfs_get_unregister_slave);
 EXPORT_SYMBOL(devfs_get_name);
-EXPORT_SYMBOL(devfs_register_blkdev);
-EXPORT_SYMBOL(devfs_unregister_blkdev);
 
 
 /**
diff -Nru a/include/linux/devfs_fs_kernel.h b/include/linux/devfs_fs_kernel.h
--- a/include/linux/devfs_fs_kernel.h	Tue Jul 30 15:50:01 2002
+++ b/include/linux/devfs_fs_kernel.h	Tue Jul 30 15:50:01 2002
@@ -95,10 +95,9 @@
 extern devfs_handle_t devfs_get_unregister_slave (devfs_handle_t master);
 extern const char *devfs_get_name (devfs_handle_t de, unsigned int *namelen);
 extern int devfs_should_register_chrdev (void);
-extern int devfs_register_blkdev (unsigned int major, const char *name,
-				  struct block_device_operations *bdops);
+extern int devfs_should_register_blkdev (void);
 extern int devfs_should_unregister_chrdev (void);
-extern int devfs_unregister_blkdev (unsigned int major, const char *name);
+extern int devfs_should_unregister_blkdev (void);
 
 extern void devfs_register_tape (devfs_handle_t de);
 extern void devfs_register_series (devfs_handle_t dir, const char *format,
@@ -242,18 +241,17 @@
 {
     return 0;
 }
-static inline int devfs_register_blkdev (unsigned int major, const char *name,
-					 struct block_device_operations *bdops)
+static inline int devfs_should_register_blkdev (void)
 {
-    return register_blkdev (major, name, bdops);
+    return 0;
 }
-static inline int devfs_unregister_chrdev (void)
+static inline int devfs_should_unregister_chrdev (void)
 {
     return 0;
 }
-static inline int devfs_unregister_blkdev (unsigned int major,const char *name)
+static inline int devfs_should_unregister_blkdev (void)
 {
-    return unregister_blkdev (major, name);
+    return 0;
 }
 
 static inline void devfs_register_tape (devfs_handle_t de)
