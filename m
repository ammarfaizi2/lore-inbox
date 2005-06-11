Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261669AbVFKII2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261669AbVFKII2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 04:08:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261663AbVFKII1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 04:08:27 -0400
Received: from mail.kroah.org ([69.55.234.183]:964 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261648AbVFKHsn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 03:48:43 -0400
Subject: [PATCH] Remove the gendisk devfs_name field as it's no longer needed
In-Reply-To: <11184761112634@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Sat, 11 Jun 2005 00:48:31 -0700
Message-Id: <11184761113549@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


And remove the now unneeded number field.
Also fixes all drivers that set these fields.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/um/drivers/ubd_kern.c      |    8 ++------
 drivers/block/DAC960.c          |    1 -
 drivers/block/acsi.c            |    5 +----
 drivers/block/cciss.c           |    1 -
 drivers/block/cpqarray.c        |    2 --
 drivers/block/loop.c            |    1 -
 drivers/block/nbd.c             |    1 -
 drivers/block/ps2esdi.c         |    1 -
 drivers/block/rd.c              |    1 -
 drivers/block/swim3.c           |    1 -
 drivers/block/sx8.c             |    1 -
 drivers/block/ub.c              |    2 --
 drivers/block/umem.c            |    1 -
 drivers/block/viodasd.c         |    2 --
 drivers/block/xd.c              |    1 -
 drivers/block/z2ram.c           |    1 -
 drivers/cdrom/aztcd.c           |    1 -
 drivers/cdrom/gscd.c            |    1 -
 drivers/cdrom/optcd.c           |    1 -
 drivers/cdrom/sbpcd.c           |    1 -
 drivers/cdrom/sjcd.c            |    1 -
 drivers/cdrom/sonycd535.c       |    1 -
 drivers/cdrom/viocd.c           |    2 --
 drivers/ide/ide-cd.c            |    2 --
 drivers/ide/ide-disk.c          |    1 -
 drivers/ide/ide-floppy.c        |    1 -
 drivers/md/md.c                 |    7 ++-----
 drivers/message/i2o/i2o_block.c |    1 -
 drivers/mmc/mmc_block.c         |    1 -
 drivers/mtd/mtd_blkdevs.c       |    2 --
 drivers/s390/block/dasd_genhd.c |    2 --
 drivers/s390/block/xpram.c      |    1 -
 drivers/scsi/osst.c             |    1 -
 drivers/scsi/sd.c               |    2 --
 drivers/scsi/sr.c               |    2 --
 drivers/scsi/st.c               |    2 --
 include/linux/genhd.h           |    2 --
 37 files changed, 5 insertions(+), 60 deletions(-)

--- gregkh-2.6.orig/drivers/block/loop.c	2005-06-10 23:37:21.000000000 -0700
+++ gregkh-2.6/drivers/block/loop.c	2005-06-10 23:37:22.000000000 -0700
@@ -1286,7 +1286,6 @@
 		disk->first_minor = i;
 		disk->fops = &lo_fops;
 		sprintf(disk->disk_name, "loop%d", i);
-		sprintf(disk->devfs_name, "loop/%d", i);
 		disk->private_data = lo;
 		disk->queue = lo->lo_queue;
 	}
--- gregkh-2.6.orig/drivers/block/rd.c	2005-06-10 23:37:21.000000000 -0700
+++ gregkh-2.6/drivers/block/rd.c	2005-06-10 23:37:22.000000000 -0700
@@ -456,7 +456,6 @@
 		disk->queue = rd_queue[i];
 		disk->flags |= GENHD_FL_SUPPRESS_PARTITION_INFO;
 		sprintf(disk->disk_name, "ram%d", i);
-		sprintf(disk->devfs_name, "rd/%d", i);
 		set_capacity(disk, rd_size * 2);
 		add_disk(rd_disks[i]);
 	}
--- gregkh-2.6.orig/drivers/ide/ide-cd.c	2005-06-10 23:29:00.000000000 -0700
+++ gregkh-2.6/drivers/ide/ide-cd.c	2005-06-10 23:37:22.000000000 -0700
@@ -3469,8 +3469,6 @@
 	drive->driver_data = info;
 
 	g->minors = 1;
-	snprintf(g->devfs_name, sizeof(g->devfs_name),
-			"%s/cd", drive->devfs_name);
 	g->driverfs_dev = &drive->gendev;
 	g->flags = GENHD_FL_CD | GENHD_FL_REMOVABLE;
 	if (ide_cdrom_setup(drive)) {
--- gregkh-2.6.orig/drivers/ide/ide-disk.c	2005-06-10 23:29:00.000000000 -0700
+++ gregkh-2.6/drivers/ide/ide-disk.c	2005-06-10 23:37:54.000000000 -0700
@@ -1244,7 +1244,6 @@
 		drive->attach = 1;
 
 	g->minors = 1 << PARTN_BITS;
-	strcpy(g->devfs_name, drive->devfs_name);
 	g->driverfs_dev = &drive->gendev;
 	g->flags = drive->removable ? GENHD_FL_REMOVABLE : 0;
 	set_capacity(g, idedisk_capacity(drive));
--- gregkh-2.6.orig/drivers/ide/ide-floppy.c	2005-06-10 23:29:00.000000000 -0700
+++ gregkh-2.6/drivers/ide/ide-floppy.c	2005-06-10 23:37:22.000000000 -0700
@@ -2169,7 +2169,6 @@
 
 	g->minors = 1 << PARTN_BITS;
 	g->driverfs_dev = &drive->gendev;
-	strcpy(g->devfs_name, drive->devfs_name);
 	g->flags = drive->removable ? GENHD_FL_REMOVABLE : 0;
 	g->fops = &idefloppy_ops;
 	drive->attach = 1;
--- gregkh-2.6.orig/include/linux/genhd.h	2005-06-10 23:29:00.000000000 -0700
+++ gregkh-2.6/include/linux/genhd.h	2005-06-10 23:37:22.000000000 -0700
@@ -110,8 +110,6 @@
 	sector_t capacity;
 
 	int flags;
-	char devfs_name[64];		/* devfs crap */
-	int number;			/* more of the same */
 	struct device *driverfs_dev;
 	struct kobject kobj;
 
--- gregkh-2.6.orig/drivers/block/ub.c	2005-06-10 23:37:21.000000000 -0700
+++ gregkh-2.6/drivers/block/ub.c	2005-06-10 23:37:22.000000000 -0700
@@ -32,7 +32,6 @@
 #include <scsi/scsi.h>
 
 #define DRV_NAME "ub"
-#define DEVFS_NAME DRV_NAME
 
 #define UB_MAJOR 180
 
@@ -2151,7 +2150,6 @@
 
 	lun->disk = disk;
 	sprintf(disk->disk_name, DRV_NAME "%c", lun->id + 'a');
-	sprintf(disk->devfs_name, DEVFS_NAME "/%c", lun->id + 'a');
 	disk->major = UB_MAJOR;
 	disk->first_minor = lun->id * UB_MINORS_PER_MAJOR;
 	disk->fops = &ub_bd_fops;
--- gregkh-2.6.orig/drivers/mmc/mmc_block.c	2005-06-10 23:37:21.000000000 -0700
+++ gregkh-2.6/drivers/mmc/mmc_block.c	2005-06-10 23:37:22.000000000 -0700
@@ -344,7 +344,6 @@
 		 */
 
 		sprintf(md->disk->disk_name, "mmcblk%d", devidx);
-		sprintf(md->disk->devfs_name, "mmc/blk%d", devidx);
 
 		md->block_bits = card->csd.read_blkbits;
 
--- gregkh-2.6.orig/drivers/scsi/sd.c	2005-06-10 23:29:00.000000000 -0700
+++ gregkh-2.6/drivers/scsi/sd.c	2005-06-10 23:37:22.000000000 -0700
@@ -1594,8 +1594,6 @@
 			'a' + m1, 'a' + m2, 'a' + m3);
 	}
 
-	strcpy(gd->devfs_name, sdp->devfs_name);
-
 	gd->private_data = &sdkp->driver;
 
 	sd_revalidate_disk(gd);
--- gregkh-2.6.orig/drivers/scsi/osst.c	2005-06-10 23:37:21.000000000 -0700
+++ gregkh-2.6/drivers/scsi/osst.c	2005-06-10 23:37:22.000000000 -0700
@@ -5801,7 +5801,6 @@
 		snprintf(name, 8, "%s%s", "n", tape_name(tpnt));
 		osst_sysfs_add(MKDEV(OSST_MAJOR, dev_num + 128), dev, tpnt, name);
 	}
-	drive->number = -1;
 
 	printk(KERN_INFO
 		"osst :I: Attached OnStream %.5s tape at scsi%d, channel %d, id %d, lun %d as %s\n",
--- gregkh-2.6.orig/drivers/scsi/sr.c	2005-06-10 23:29:00.000000000 -0700
+++ gregkh-2.6/drivers/scsi/sr.c	2005-06-10 23:37:22.000000000 -0700
@@ -622,8 +622,6 @@
 	get_capabilities(cd);
 	sr_vendor_init(cd);
 
-	snprintf(disk->devfs_name, sizeof(disk->devfs_name),
-			"%s/cd", sdev->devfs_name);
 	disk->driverfs_dev = &sdev->sdev_gendev;
 	set_capacity(disk, cd->capacity);
 	disk->private_data = &cd->driver;
--- gregkh-2.6.orig/drivers/scsi/st.c	2005-06-10 23:37:21.000000000 -0700
+++ gregkh-2.6/drivers/scsi/st.c	2005-06-10 23:37:22.000000000 -0700
@@ -3983,8 +3983,6 @@
 		do_create_class_files(tpnt, dev_num, mode);
 	}
 
-	disk->number = -1;
-
 	printk(KERN_WARNING
 	"Attached scsi tape %s at scsi%d, channel %d, id %d, lun %d\n",
 	       tape_name(tpnt), SDp->host->host_no, SDp->channel, SDp->id, SDp->lun);
--- gregkh-2.6.orig/drivers/cdrom/aztcd.c	2005-06-10 23:29:00.000000000 -0700
+++ gregkh-2.6/drivers/cdrom/aztcd.c	2005-06-10 23:37:22.000000000 -0700
@@ -1918,7 +1918,6 @@
 	azt_disk->first_minor = 0;
 	azt_disk->fops = &azt_fops;
 	sprintf(azt_disk->disk_name, "aztcd");
-	sprintf(azt_disk->devfs_name, "aztcd");
 	azt_disk->queue = azt_queue;
 	add_disk(azt_disk);
 	azt_invalidate_buffers();
--- gregkh-2.6.orig/drivers/cdrom/gscd.c	2005-06-10 23:29:00.000000000 -0700
+++ gregkh-2.6/drivers/cdrom/gscd.c	2005-06-10 23:37:22.000000000 -0700
@@ -955,7 +955,6 @@
 	gscd_disk->first_minor = 0;
 	gscd_disk->fops = &gscd_fops;
 	sprintf(gscd_disk->disk_name, "gscd");
-	sprintf(gscd_disk->devfs_name, "gscd");
 
 	if (register_blkdev(MAJOR_NR, "gscd")) {
 		ret = -EIO;
--- gregkh-2.6.orig/drivers/cdrom/optcd.c	2005-06-10 23:29:00.000000000 -0700
+++ gregkh-2.6/drivers/cdrom/optcd.c	2005-06-10 23:37:22.000000000 -0700
@@ -2033,7 +2033,6 @@
 	optcd_disk->first_minor = 0;
 	optcd_disk->fops = &opt_fops;
 	sprintf(optcd_disk->disk_name, "optcd");
-	sprintf(optcd_disk->devfs_name, "optcd");
 
 	if (!request_region(optcd_port, 4, "optcd")) {
 		printk(KERN_ERR "optcd: conflict, I/O port 0x%x already used\n",
--- gregkh-2.6.orig/drivers/cdrom/sbpcd.c	2005-06-10 23:37:21.000000000 -0700
+++ gregkh-2.6/drivers/cdrom/sbpcd.c	2005-06-10 23:37:22.000000000 -0700
@@ -5873,7 +5873,6 @@
 		disk->fops = &sbpcd_bdops;
 		strcpy(disk->disk_name, sbpcd_infop->name);
 		disk->flags = GENHD_FL_CD;
-		sprintf(disk->devfs_name, "sbp/c0t%d", p->drv_id);
 		p->disk = disk;
 		if (register_cdrom(sbpcd_infop))
 		{
--- gregkh-2.6.orig/drivers/cdrom/sjcd.c	2005-06-10 23:29:00.000000000 -0700
+++ gregkh-2.6/drivers/cdrom/sjcd.c	2005-06-10 23:37:22.000000000 -0700
@@ -1695,7 +1695,6 @@
 	sjcd_disk->first_minor = 0,
 	sjcd_disk->fops = &sjcd_fops,
 	sprintf(sjcd_disk->disk_name, "sjcd");
-	sprintf(sjcd_disk->devfs_name, "sjcd");
 
 	if (!request_region(sjcd_base, 4,"sjcd")) {
 		printk
--- gregkh-2.6.orig/drivers/cdrom/sonycd535.c	2005-06-10 23:29:00.000000000 -0700
+++ gregkh-2.6/drivers/cdrom/sonycd535.c	2005-06-10 23:37:22.000000000 -0700
@@ -1590,7 +1590,6 @@
 	cdu_disk->first_minor = 0;
 	cdu_disk->fops = &cdu_fops;
 	sprintf(cdu_disk->disk_name, "cdu");
-	sprintf(cdu_disk->devfs_name, "cdu535");
 
 	if (!request_region(sony535_cd_base_io, 4, CDU535_HANDLE)) {
 		printk(KERN_WARNING"sonycd535: Unable to request region 0x%x\n",
--- gregkh-2.6.orig/drivers/cdrom/viocd.c	2005-06-10 23:29:00.000000000 -0700
+++ gregkh-2.6/drivers/cdrom/viocd.c	2005-06-10 23:37:33.000000000 -0700
@@ -690,8 +690,6 @@
 	gendisk->first_minor = deviceno;
 	strncpy(gendisk->disk_name, c->name,
 			sizeof(gendisk->disk_name));
-	snprintf(gendisk->devfs_name, sizeof(gendisk->devfs_name),
-			VIOCD_DEVICE_DEVFS "%d", deviceno);
 	blk_queue_max_hw_segments(q, 1);
 	blk_queue_max_phys_segments(q, 1);
 	blk_queue_max_sectors(q, 4096 / 512);
--- gregkh-2.6.orig/drivers/md/md.c	2005-06-10 23:37:21.000000000 -0700
+++ gregkh-2.6/drivers/md/md.c	2005-06-10 23:37:22.000000000 -0700
@@ -1470,13 +1470,10 @@
 	}
 	disk->major = MAJOR(dev);
 	disk->first_minor = unit << shift;
-	if (partitioned) {
+	if (partitioned)
 		sprintf(disk->disk_name, "md_d%d", unit);
-		sprintf(disk->devfs_name, "md/d%d", unit);
-	} else {
+	else
 		sprintf(disk->disk_name, "md%d", unit);
-		sprintf(disk->devfs_name, "md/%d", unit);
-	}
 	disk->fops = &md_fops;
 	disk->private_data = mddev;
 	disk->queue = mddev->queue;
--- gregkh-2.6.orig/drivers/block/DAC960.c	2005-06-10 23:29:00.000000000 -0700
+++ gregkh-2.6/drivers/block/DAC960.c	2005-06-10 23:37:22.000000000 -0700
@@ -2546,7 +2546,6 @@
 	blk_queue_max_sectors(RequestQueue, Controller->MaxBlocksPerCommand);
 	disk->queue = RequestQueue;
 	sprintf(disk->disk_name, "rd/c%dd%d", Controller->ControllerNumber, n);
-	sprintf(disk->devfs_name, "rd/host%d/target%d", Controller->ControllerNumber, n);
 	disk->major = MajorNumber;
 	disk->first_minor = n << DAC960_MaxPartitionsBits;
 	disk->fops = &DAC960_BlockDeviceOperations;
--- gregkh-2.6.orig/drivers/block/acsi.c	2005-06-10 23:29:00.000000000 -0700
+++ gregkh-2.6/drivers/block/acsi.c	2005-06-10 23:37:22.000000000 -0700
@@ -1731,13 +1731,10 @@
 		struct gendisk *disk = acsi_gendisk[i];
 		sprintf(disk->disk_name, "ad%c", 'a'+i);
 		aip = &acsi_info[NDevices];
-		sprintf(disk->devfs_name, "ad/target%d/lun%d", aip->target, aip->lun);
 		disk->major = ACSI_MAJOR;
 		disk->first_minor = i << 4;
-		if (acsi_info[i].type != HARDDISK) {
+		if (acsi_info[i].type != HARDDISK)
 			disk->minors = 1;
-			strcat(disk->devfs_name, "/disc");
-		}
 		disk->fops = &acsi_fops;
 		disk->private_data = &acsi_info[i];
 		set_capacity(disk, acsi_info[i].size);
--- gregkh-2.6.orig/drivers/block/cciss.c	2005-06-10 23:29:00.000000000 -0700
+++ gregkh-2.6/drivers/block/cciss.c	2005-06-10 23:37:22.000000000 -0700
@@ -2843,7 +2843,6 @@
 		struct gendisk *disk = hba[i]->gendisk[j];
 
 		sprintf(disk->disk_name, "cciss/c%dd%d", i, j);
-		sprintf(disk->devfs_name, "cciss/host%d/target%d", i, j);
 		disk->major = hba[i]->major;
 		disk->first_minor = j << NWD_SHIFT;
 		disk->fops = &cciss_fops;
--- gregkh-2.6.orig/drivers/block/cpqarray.c	2005-06-10 23:37:21.000000000 -0700
+++ gregkh-2.6/drivers/block/cpqarray.c	2005-06-10 23:37:22.000000000 -0700
@@ -1803,8 +1803,6 @@
 
 				}
 
-				sprintf(disk->devfs_name, "ida/c%dd%d", ctlr, log_unit);
-
 				info_p->phys_drives =
 				    sense_config_buf->ctlr_phys_drv;
 				info_p->drv_assign_map
--- gregkh-2.6.orig/drivers/block/nbd.c	2005-06-10 23:37:21.000000000 -0700
+++ gregkh-2.6/drivers/block/nbd.c	2005-06-10 23:37:22.000000000 -0700
@@ -693,7 +693,6 @@
 		disk->private_data = &nbd_dev[i];
 		disk->flags |= GENHD_FL_SUPPRESS_PARTITION_INFO;
 		sprintf(disk->disk_name, "nbd%d", i);
-		sprintf(disk->devfs_name, "nbd/%d", i);
 		set_capacity(disk, 0x7ffffc00ULL << 1); /* 2 TB */
 		add_disk(disk);
 	}
--- gregkh-2.6.orig/drivers/block/ps2esdi.c	2005-06-10 23:29:00.000000000 -0700
+++ gregkh-2.6/drivers/block/ps2esdi.c	2005-06-10 23:37:22.000000000 -0700
@@ -422,7 +422,6 @@
 		disk->major = PS2ESDI_MAJOR;
 		disk->first_minor = i<<6;
 		sprintf(disk->disk_name, "ed%c", 'a'+i);
-		sprintf(disk->devfs_name, "ed/target%d", i);
 		disk->fops = &ps2esdi_fops;
 		ps2esdi_gendisk[i] = disk;
 	}
--- gregkh-2.6.orig/drivers/block/swim3.c	2005-06-10 23:37:21.000000000 -0700
+++ gregkh-2.6/drivers/block/swim3.c	2005-06-10 23:37:22.000000000 -0700
@@ -1057,7 +1057,6 @@
 		disk->queue = swim3_queue;
 		disk->flags |= GENHD_FL_REMOVABLE;
 		sprintf(disk->disk_name, "fd%d", i);
-		sprintf(disk->devfs_name, "floppy/%d", i);
 		set_capacity(disk, 2880);
 		add_disk(disk);
 	}
--- gregkh-2.6.orig/drivers/block/sx8.c	2005-06-10 23:37:21.000000000 -0700
+++ gregkh-2.6/drivers/block/sx8.c	2005-06-10 23:37:22.000000000 -0700
@@ -1504,7 +1504,6 @@
 		port->disk = disk;
 		sprintf(disk->disk_name, DRV_NAME "/%u",
 			(unsigned int) (host->id * CARM_MAX_PORTS) + i);
-		sprintf(disk->devfs_name, DRV_NAME "/%u_%u", host->id, i);
 		disk->major = host->major;
 		disk->first_minor = i * CARM_MINORS_PER_MAJOR;
 		disk->fops = &carm_bd_ops;
--- gregkh-2.6.orig/drivers/block/umem.c	2005-06-10 23:29:00.000000000 -0700
+++ gregkh-2.6/drivers/block/umem.c	2005-06-10 23:37:22.000000000 -0700
@@ -1205,7 +1205,6 @@
 	for (i = 0; i < num_cards; i++) {
 		struct gendisk *disk = mm_gendisk[i];
 		sprintf(disk->disk_name, "umem%c", 'a'+i);
-		sprintf(disk->devfs_name, "umem/card%d", i);
 		spin_lock_init(&cards[i].lock);
 		disk->major = major_nr;
 		disk->first_minor  = i << MM_SHIFT;
--- gregkh-2.6.orig/drivers/block/viodasd.c	2005-06-10 23:29:00.000000000 -0700
+++ gregkh-2.6/drivers/block/viodasd.c	2005-06-10 23:37:33.000000000 -0700
@@ -551,8 +551,6 @@
 	else
 		snprintf(g->disk_name, sizeof(g->disk_name),
 				VIOD_GENHD_NAME "%c", 'a' + (dev_no % 26));
-	snprintf(g->devfs_name, sizeof(g->devfs_name),
-			"%s%d", VIOD_GENHD_DEVFS_NAME, dev_no);
 	g->fops = &viodasd_fops;
 	g->queue = q;
 	g->private_data = d;
--- gregkh-2.6.orig/drivers/block/xd.c	2005-06-10 23:29:00.000000000 -0700
+++ gregkh-2.6/drivers/block/xd.c	2005-06-10 23:37:22.000000000 -0700
@@ -211,7 +211,6 @@
 		disk->major = XT_DISK_MAJOR;
 		disk->first_minor = i<<6;
 		sprintf(disk->disk_name, "xd%c", i+'a');
-		sprintf(disk->devfs_name, "xd/target%d", i);
 		disk->fops = &xd_fops;
 		disk->private_data = p;
 		disk->queue = xd_queue;
--- gregkh-2.6.orig/drivers/block/z2ram.c	2005-06-10 23:29:00.000000000 -0700
+++ gregkh-2.6/drivers/block/z2ram.c	2005-06-10 23:37:22.000000000 -0700
@@ -354,7 +354,6 @@
     z2ram_gendisk->first_minor = 0;
     z2ram_gendisk->fops = &z2_fops;
     sprintf(z2ram_gendisk->disk_name, "z2ram");
-    strcpy(z2ram_gendisk->devfs_name, z2ram_gendisk->disk_name);
 
     z2ram_gendisk->queue = z2_queue;
     add_disk(z2ram_gendisk);
--- gregkh-2.6.orig/arch/um/drivers/ubd_kern.c	2005-06-10 23:37:21.000000000 -0700
+++ gregkh-2.6/arch/um/drivers/ubd_kern.c	2005-06-10 23:37:22.000000000 -0700
@@ -628,14 +628,10 @@
 	disk->first_minor = unit << UBD_SHIFT;
 	disk->fops = &ubd_blops;
 	set_capacity(disk, size / 512);
-	if(major == MAJOR_NR){
+	if(major == MAJOR_NR)
 		sprintf(disk->disk_name, "ubd%c", 'a' + unit);
-		sprintf(disk->devfs_name, "ubd/disc%d", unit);
-	}
-	else {
+	else
 		sprintf(disk->disk_name, "ubd_fake%d", unit);
-		sprintf(disk->devfs_name, "ubd_fake/disc%d", unit);
-	}
 
 	/* sysfs register (not for ide fake devices) */
 	if (major == MAJOR_NR) {
--- gregkh-2.6.orig/drivers/message/i2o/i2o_block.c	2005-06-10 23:29:00.000000000 -0700
+++ gregkh-2.6/drivers/message/i2o/i2o_block.c	2005-06-10 23:37:22.000000000 -0700
@@ -1079,7 +1079,6 @@
 	gd = i2o_blk_dev->gd;
 	gd->first_minor = unit << 4;
 	sprintf(gd->disk_name, "i2o/hd%c", 'a' + unit);
-	sprintf(gd->devfs_name, "i2o/hd%c", 'a' + unit);
 	gd->driverfs_dev = &i2o_dev->device;
 
 	/* setup request queue */
--- gregkh-2.6.orig/drivers/mtd/mtd_blkdevs.c	2005-06-10 23:37:21.000000000 -0700
+++ gregkh-2.6/drivers/mtd/mtd_blkdevs.c	2005-06-10 23:37:22.000000000 -0700
@@ -291,8 +291,6 @@
 	
 	snprintf(gd->disk_name, sizeof(gd->disk_name),
 		 "%s%c", tr->name, (tr->part_bits?'a':'0') + new->devnum);
-	snprintf(gd->devfs_name, sizeof(gd->devfs_name),
-		 "%s/%c", tr->name, (tr->part_bits?'a':'0') + new->devnum);
 
 	/* 2.5 has capacity in units of 512 bytes while still
 	   having BLOCK_SIZE_BITS set to 10. Just to keep us amused. */
--- gregkh-2.6.orig/drivers/s390/block/dasd_genhd.c	2005-06-10 23:29:00.000000000 -0700
+++ gregkh-2.6/drivers/s390/block/dasd_genhd.c	2005-06-10 23:37:22.000000000 -0700
@@ -73,8 +73,6 @@
 	}
 	len += sprintf(gdp->disk_name + len, "%c", 'a'+(device->devindex%26));
 
- 	sprintf(gdp->devfs_name, "dasd/%s", device->cdev->dev.bus_id);
-
 	if (feature_ro)
 		set_disk_ro(gdp, 1);
 	gdp->private_data = device;
--- gregkh-2.6.orig/drivers/s390/block/xpram.c	2005-06-10 23:37:21.000000000 -0700
+++ gregkh-2.6/drivers/s390/block/xpram.c	2005-06-10 23:37:22.000000000 -0700
@@ -470,7 +470,6 @@
 		disk->private_data = &xpram_devices[i];
 		disk->queue = xpram_queue;
 		sprintf(disk->disk_name, "slram%d", i);
-		sprintf(disk->devfs_name, "slram/%d", i);
 		set_capacity(disk, xpram_sizes[i] << 1);
 		add_disk(disk);
 	}

