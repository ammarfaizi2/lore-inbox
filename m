Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261298AbSJLRSZ>; Sat, 12 Oct 2002 13:18:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261299AbSJLRR5>; Sat, 12 Oct 2002 13:17:57 -0400
Received: from mx2.airmail.net ([209.196.77.99]:65296 "EHLO mx2.airmail.net")
	by vger.kernel.org with ESMTP id <S261298AbSJLRQK>;
	Sat, 12 Oct 2002 13:16:10 -0400
Date: Sat, 12 Oct 2002 11:43:45 -0500
From: Art Haas <ahaas@neosoft.com>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] C99 designated initializers for drivers/block
Message-ID: <20021012164345.GG633@debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

Here's a set of patches for converting drivers/block to use C99 named
initializers. The patches are all against 2.5.42.

Art Haas

--- linux-2.5.42/drivers/block/DAC960.c.old	2002-10-07 15:45:21.000000000 -0500
+++ linux-2.5.42/drivers/block/DAC960.c	2002-10-12 09:51:18.000000000 -0500
@@ -82,11 +82,11 @@
 */
 
 static struct block_device_operations DAC960_BlockDeviceOperations = {
-	owner:		THIS_MODULE,
-	open:		DAC960_Open,
-	release:	DAC960_Release,
-	ioctl:		DAC960_IOCTL,
-	revalidate:	DAC960_revalidate,
+	.owner		= THIS_MODULE,
+	.open		= DAC960_Open,
+	.release	= DAC960_Release,
+	.ioctl		= DAC960_IOCTL,
+	.revalidate	= DAC960_revalidate,
 };
 
 
--- linux-2.5.42/drivers/block/acsi.c.old	2002-10-07 15:45:21.000000000 -0500
+++ linux-2.5.42/drivers/block/acsi.c	2002-10-12 09:51:17.000000000 -0500
@@ -372,7 +372,7 @@
 /************************* End of Prototypes **************************/
 
 
-struct timer_list acsi_timer = { function: acsi_times_out };
+struct timer_list acsi_timer = { .function = acsi_times_out };
 
 
 #ifdef CONFIG_ATARI_SLM
@@ -1598,12 +1598,12 @@
 #endif
 
 static struct block_device_operations acsi_fops = {
-	owner:			THIS_MODULE,
-	open:			acsi_open,
-	release:		acsi_release,
-	ioctl:			acsi_ioctl,
-	check_media_change:	acsi_media_change,
-	revalidate:		acsi_revalidate,
+	.owner			= THIS_MODULE,
+	.open			= acsi_open,
+	.release		= acsi_release,
+	.ioctl			= acsi_ioctl,
+	.check_media_change	= acsi_media_change,
+	.revalidate		= acsi_revalidate,
 };
 
 #ifdef CONFIG_ATARI_SLM_MODULE
--- linux-2.5.42/drivers/block/acsi_slm.c.old	2002-08-02 08:16:16.000000000 -0500
+++ linux-2.5.42/drivers/block/acsi_slm.c	2002-10-12 09:51:16.000000000 -0500
@@ -270,15 +270,15 @@
 /************************* End of Prototypes **************************/
 
 
-static struct timer_list slm_timer = { function: slm_test_ready };
+static struct timer_list slm_timer = { .function = slm_test_ready };
 
 static struct file_operations slm_fops = {
-	owner:		THIS_MODULE,
-	read:		slm_read,
-	write:		slm_write,
-	ioctl:		slm_ioctl,
-	open:		slm_open,
-	release:	slm_release,
+	.owner		= THIS_MODULE,
+	.read		= slm_read,
+	.write		= slm_write,
+	.ioctl		= slm_ioctl,
+	.open		= slm_open,
+	.release	= slm_release,
 };
 
 
--- linux-2.5.42/drivers/block/ataflop.c.old	2002-10-07 15:45:21.000000000 -0500
+++ linux-2.5.42/drivers/block/ataflop.c	2002-10-12 09:51:17.000000000 -0500
@@ -392,15 +392,15 @@
 /************************* End of Prototypes **************************/
 
 static struct timer_list motor_off_timer =
-	{ function: fd_motor_off_timer };
+	{ .function = fd_motor_off_timer };
 static struct timer_list readtrack_timer =
-	{ function: fd_readtrack_check };
+	{ .function = fd_readtrack_check };
 
 static struct timer_list timeout_timer =
-	{ function: fd_times_out };
+	{ .function = fd_times_out };
 
 static struct timer_list fd_timer =
-	{ function: check_change };
+	{ .function = check_change };
 	
 static inline void
 start_motor_off_timer(void)
@@ -1914,12 +1914,12 @@
 }
 
 static struct block_device_operations floppy_fops = {
-	owner:			THIS_MODULE,
-	open:			floppy_open,
-	release:		floppy_release,
-	ioctl:			fd_ioctl,
-	check_media_change:	check_floppy_change,
-	revalidate:		floppy_revalidate,
+	.owner			= THIS_MODULE,
+	.open			= floppy_open,
+	.release		= floppy_release,
+	.ioctl			= fd_ioctl,
+	.check_media_change	= check_floppy_change,
+	.revalidate		= floppy_revalidate,
 };
 
 static struct gendisk *floppy_find(int minor)
--- linux-2.5.42/drivers/block/cciss.c.old	2002-10-12 09:46:42.000000000 -0500
+++ linux-2.5.42/drivers/block/cciss.c	2002-10-12 09:51:18.000000000 -0500
@@ -125,11 +125,11 @@
 #endif /* CONFIG_PROC_FS */
 
 static struct block_device_operations cciss_fops  = {
-	owner:			THIS_MODULE,
-	open:			cciss_open, 
-	release:        	cciss_release,
-        ioctl:			cciss_ioctl,
-	revalidate:		cciss_revalidate,
+	.owner			= THIS_MODULE,
+	.open			= cciss_open, 
+	.release        	= cciss_release,
+        .ioctl			= cciss_ioctl,
+	.revalidate		= cciss_revalidate,
 };
 
 #include "cciss_scsi.c"		/* For SCSI tape support */
@@ -2514,10 +2514,10 @@
 }	
 
 static struct pci_driver cciss_pci_driver = {
-	name:		"cciss",
-	probe:		cciss_init_one,
-	remove:		__devexit_p(cciss_remove_one),
-	id_table:	cciss_pci_device_id, /* id_table */
+	.name		= "cciss",
+	.probe		= cciss_init_one,
+	.remove		= __devexit_p(cciss_remove_one),
+	.id_table	= cciss_pci_device_id, /* id_table */
 };
 
 /*
--- linux-2.5.42/drivers/block/cciss_scsi.c.old	2002-07-05 18:42:18.000000000 -0500
+++ linux-2.5.42/drivers/block/cciss_scsi.c	2002-10-12 09:51:17.000000000 -0500
@@ -73,14 +73,14 @@
 #endif
 
 static struct cciss_scsi_hba_t ccissscsi[MAX_CTLR] = {
-	{ name: "cciss0", ndevices: 0 },
-	{ name: "cciss1", ndevices: 0 },
-	{ name: "cciss2", ndevices: 0 },
-	{ name: "cciss3", ndevices: 0 },
-	{ name: "cciss4", ndevices: 0 },
-	{ name: "cciss5", ndevices: 0 },
-	{ name: "cciss6", ndevices: 0 },
-	{ name: "cciss7", ndevices: 0 },
+	{ .name = "cciss0", .ndevices = 0 },
+	{ .name = "cciss1", .ndevices = 0 },
+	{ .name = "cciss2", .ndevices = 0 },
+	{ .name = "cciss3", .ndevices = 0 },
+	{ .name = "cciss4", .ndevices = 0 },
+	{ .name = "cciss5", .ndevices = 0 },
+	{ .name = "cciss6", .ndevices = 0 },
+	{ .name = "cciss7", .ndevices = 0 },
 };
 
 /* We need one Scsi_Host_Template *per controller* instead of 
--- linux-2.5.42/drivers/block/cpqarray.c.old	2002-10-12 09:46:42.000000000 -0500
+++ linux-2.5.42/drivers/block/cpqarray.c	2002-10-12 09:51:17.000000000 -0500
@@ -163,11 +163,11 @@
 #endif
 
 static struct block_device_operations ida_fops  = {
-	owner:		THIS_MODULE,
-	open:		ida_open,
-	release:	ida_release,
-	ioctl:		ida_ioctl,
-	revalidate:	ida_revalidate,
+	.owner		= THIS_MODULE,
+	.open		= ida_open,
+	.release	= ida_release,
+	.ioctl		= ida_ioctl,
+	.revalidate	= ida_revalidate,
 };
 
 
--- linux-2.5.42/drivers/block/elevator.c.old	2002-10-07 15:45:22.000000000 -0500
+++ linux-2.5.42/drivers/block/elevator.c	2002-10-12 09:51:18.000000000 -0500
@@ -348,9 +348,9 @@
 }
 
 elevator_t elevator_noop = {
-	elevator_merge_fn:		elevator_noop_merge,
-	elevator_next_req_fn:		elevator_noop_next_request,
-	elevator_add_req_fn:		elevator_noop_add_request,
+	.elevator_merge_fn		= elevator_noop_merge,
+	.elevator_next_req_fn		= elevator_noop_next_request,
+	.elevator_add_req_fn		= elevator_noop_add_request,
 };
 
 module_init(elevator_global_init);
--- linux-2.5.42/drivers/block/floppy.c.old	2002-10-12 09:46:42.000000000 -0500
+++ linux-2.5.42/drivers/block/floppy.c	2002-10-12 09:51:17.000000000 -0500
@@ -628,7 +628,7 @@
 }
 
 typedef void (*timeout_fn)(unsigned long);
-static struct timer_list fd_timeout ={ function: (timeout_fn) floppy_shutdown };
+static struct timer_list fd_timeout ={ .function = (timeout_fn) floppy_shutdown };
 
 static const char *timeout_message;
 
@@ -3956,12 +3956,12 @@
 }
 
 static struct block_device_operations floppy_fops = {
-	owner:			THIS_MODULE,
-	open:			floppy_open,
-	release:		floppy_release,
-	ioctl:			fd_ioctl,
-	check_media_change:	check_floppy_change,
-	revalidate:		floppy_revalidate,
+	.owner			= THIS_MODULE,
+	.open			= floppy_open,
+	.release		= floppy_release,
+	.ioctl			= fd_ioctl,
+	.check_media_change	= check_floppy_change,
+	.revalidate		= floppy_revalidate,
 };
 
 static void __init register_devfs_entries (int drive)
--- linux-2.5.42/drivers/block/genhd.c.old	2002-10-12 09:46:42.000000000 -0500
+++ linux-2.5.42/drivers/block/genhd.c	2002-10-12 09:51:17.000000000 -0500
@@ -194,10 +194,10 @@
 }
 
 struct seq_operations partitions_op = {
-	start:	part_start,
-	next:	part_next,
-	stop:	part_stop,
-	show:	show_partition
+	.start	= part_start,
+	.next	= part_next,
+	.stop	= part_stop,
+	.show	= show_partition
 };
 #endif
 
--- linux-2.5.42/drivers/block/loop.c.old	2002-10-12 09:46:42.000000000 -0500
+++ linux-2.5.42/drivers/block/loop.c	2002-10-12 09:51:16.000000000 -0500
@@ -137,15 +137,15 @@
 }
 
 struct loop_func_table none_funcs = { 
-	number: LO_CRYPT_NONE,
-	transfer: transfer_none,
-	init: none_status,
+	.number = LO_CRYPT_NONE,
+	.transfer = transfer_none,
+	.init = none_status,
 }; 	
 
 struct loop_func_table xor_funcs = { 
-	number: LO_CRYPT_XOR,
-	transfer: transfer_xor,
-	init: xor_status
+	.number = LO_CRYPT_XOR,
+	.transfer = transfer_xor,
+	.init = xor_status
 }; 	
 
 /* xfer_funcs[0] is special - its release function is never called */ 
@@ -992,10 +992,10 @@
 }
 
 static struct block_device_operations lo_fops = {
-	owner:		THIS_MODULE,
-	open:		lo_open,
-	release:	lo_release,
-	ioctl:		lo_ioctl,
+	.owner		= THIS_MODULE,
+	.open		= lo_open,
+	.release	= lo_release,
+	.ioctl		= lo_ioctl,
 };
 
 /*
--- linux-2.5.42/drivers/block/nbd.c.old	2002-10-07 15:45:22.000000000 -0500
+++ linux-2.5.42/drivers/block/nbd.c	2002-10-12 09:51:17.000000000 -0500
@@ -485,10 +485,10 @@
 
 static struct block_device_operations nbd_fops =
 {
-	owner:		THIS_MODULE,
-	open:		nbd_open,
-	release:	nbd_release,
-	ioctl:		nbd_ioctl,
+	.owner		= THIS_MODULE,
+	.open		= nbd_open,
+	.release	= nbd_release,
+	.ioctl		= nbd_ioctl,
 };
 
 /*
--- linux-2.5.42/drivers/block/ps2esdi.c.old	2002-10-12 09:46:42.000000000 -0500
+++ linux-2.5.42/drivers/block/ps2esdi.c	2002-10-12 09:51:16.000000000 -0500
@@ -110,7 +110,7 @@
 static int no_int_yet;
 static int ps2esdi_drives;
 static u_short io_base;
-static struct timer_list esdi_timer = { function: ps2esdi_reset_timer };
+static struct timer_list esdi_timer = { .function = ps2esdi_reset_timer };
 static int reset_status;
 static int ps2esdi_slot = -1;
 static int tp720esdi = 0;	/* Is it Integrated ESDI of ThinkPad-720? */
--- linux-2.5.42/drivers/block/rd.c.old	2002-10-12 09:46:42.000000000 -0500
+++ linux-2.5.42/drivers/block/rd.c	2002-10-12 09:51:17.000000000 -0500
@@ -140,10 +140,10 @@
 }
 
 static struct address_space_operations ramdisk_aops = {
-	readpage: ramdisk_readpage,
-	writepage: fail_writepage,
-	prepare_write: ramdisk_prepare_write,
-	commit_write: ramdisk_commit_write,
+	.readpage = ramdisk_readpage,
+	.writepage = fail_writepage,
+	.prepare_write = ramdisk_prepare_write,
+	.commit_write = ramdisk_commit_write,
 };
 
 static int rd_blkdev_pagecache_IO(int rw, struct bio_vec *vec,
@@ -347,8 +347,8 @@
 
 
 static struct file_operations initrd_fops = {
-	read:		initrd_read,
-	release:	initrd_release,
+	.read		= initrd_read,
+	.release	= initrd_release,
 };
 
 #endif
@@ -389,9 +389,9 @@
 }
 
 static struct block_device_operations rd_bd_op = {
-	owner:		THIS_MODULE,
-	open:		rd_open,
-	ioctl:		rd_ioctl,
+	.owner		= THIS_MODULE,
+	.open		= rd_open,
+	.ioctl		= rd_ioctl,
 };
 
 /* Before freeing the module, invalidate all of the protected buffers! */
--- linux-2.5.42/drivers/block/swim3.c.old	2002-10-07 15:45:22.000000000 -0500
+++ linux-2.5.42/drivers/block/swim3.c	2002-10-12 09:51:17.000000000 -0500
@@ -1002,11 +1002,11 @@
 }
 
 static struct block_device_operations floppy_fops = {
-	open:			floppy_open,
-	release:		floppy_release,
-	ioctl:			floppy_ioctl,
-	check_media_change:	floppy_check_change,
-	revalidate:		floppy_revalidate,
+	.open			= floppy_open,
+	.release		= floppy_release,
+	.ioctl			= floppy_ioctl,
+	.check_media_change	= floppy_check_change,
+	.revalidate		= floppy_revalidate,
 };
 
 static devfs_handle_t floppy_devfs_handle;
--- linux-2.5.42/drivers/block/swim_iop.c.old	2002-10-07 15:45:22.000000000 -0500
+++ linux-2.5.42/drivers/block/swim_iop.c	2002-10-12 09:51:16.000000000 -0500
@@ -118,11 +118,11 @@
 static void start_request(struct floppy_state *fs);
 
 static struct block_device_operations floppy_fops = {
-	open:			floppy_open,
-	release:		floppy_release,
-	ioctl:			floppy_ioctl,
-	check_media_change:	floppy_check_change,
-	revalidate:		floppy_revalidate,
+	.open			= floppy_open,
+	.release		= floppy_release,
+	.ioctl			= floppy_ioctl,
+	.check_media_change	= floppy_check_change,
+	.revalidate		= floppy_revalidate,
 };
 
 /*
--- linux-2.5.42/drivers/block/umem.c.old	2002-10-12 09:46:42.000000000 -0500
+++ linux-2.5.42/drivers/block/umem.c	2002-10-12 09:51:17.000000000 -0500
@@ -882,11 +882,11 @@
 -----------------------------------------------------------------------------------
 */
 static struct block_device_operations mm_fops = {
-	owner:		THIS_MODULE,
-	open:		mm_open,
-	ioctl:		mm_ioctl,
-	revalidate:	mm_revalidate,
-	check_media_change: mm_check_change,
+	.owner		= THIS_MODULE,
+	.open		= mm_open,
+	.ioctl		= mm_ioctl,
+	.revalidate	= mm_revalidate,
+	.check_media_change = mm_check_change,
 };
 /*
 -----------------------------------------------------------------------------------
@@ -1143,18 +1143,18 @@
 }
 
 static const struct pci_device_id __devinitdata mm_pci_ids[] = { {
-	vendor:		PCI_VENDOR_ID_MICRO_MEMORY,
-	device:		PCI_DEVICE_ID_MICRO_MEMORY_5415CN,
+	.vendor		= PCI_VENDOR_ID_MICRO_MEMORY,
+	.device		= PCI_DEVICE_ID_MICRO_MEMORY_5415CN,
 	}, { /* end: all zeroes */ }
 };
 
 MODULE_DEVICE_TABLE(pci, mm_pci_ids);
 
 static struct pci_driver mm_pci_driver = {
-	name:		"umem",
-	id_table:	mm_pci_ids,
-	probe:		mm_pci_probe,
-	remove:		mm_pci_remove,
+	.name		= "umem",
+	.id_table	= mm_pci_ids,
+	.probe		= mm_pci_probe,
+	.remove		= mm_pci_remove,
 };
 /*
 -----------------------------------------------------------------------------------
--- linux-2.5.42/drivers/block/xd.c.old	2002-10-07 15:45:22.000000000 -0500
+++ linux-2.5.42/drivers/block/xd.c	2002-10-12 09:51:17.000000000 -0500
@@ -129,9 +129,9 @@
 static struct gendisk *xd_gendisk[2];
 
 static struct block_device_operations xd_fops = {
-	owner:		THIS_MODULE,
-	open:		xd_open,
-	ioctl:		xd_ioctl,
+	.owner		= THIS_MODULE,
+	.open		= xd_open,
+	.ioctl		= xd_ioctl,
 };
 static DECLARE_WAIT_QUEUE_HEAD(xd_wait_int);
 static u_char xd_drives, xd_irq = 5, xd_dma = 3, xd_maxsectors;
-- 
They that can give up essential liberty to obtain a little temporary safety
deserve neither liberty nor safety.
 -- Benjamin Franklin, Historical Review of Pennsylvania, 1759
