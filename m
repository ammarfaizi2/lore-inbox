Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274483AbSKEDEt>; Mon, 4 Nov 2002 22:04:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274491AbSKEDEt>; Mon, 4 Nov 2002 22:04:49 -0500
Received: from dp.samba.org ([66.70.73.150]:18104 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S274483AbSKEDEo>;
	Mon, 4 Nov 2002 22:04:44 -0500
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: [PATCH] Initializer conversions for drivers/block
Date: Tue, 05 Nov 2002 13:59:35 +1100
Message-Id: <20021105031120.52D152C292@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a few left in drivers/block.

Linus, please apply.
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: Designated initializers for drivers/block
Author: Rusty Russell
Status: Trivial

D: The old form of designated initializers are obsolete: we need to
D: replace them with the ISO C forms before 2.6.  Gcc has always supported
D: both forms anyway.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .9822-linux-2.5.44/drivers/block/acsi.c .9822-linux-2.5.44.updated/drivers/block/acsi.c
--- .9822-linux-2.5.44/drivers/block/acsi.c	2002-10-19 17:48:02.000000000 +1000
+++ .9822-linux-2.5.44.updated/drivers/block/acsi.c	2002-10-21 17:53:07.000000000 +1000
@@ -373,7 +373,7 @@ static int acsi_revalidate (struct gendi
 /************************* End of Prototypes **************************/
 
 
-struct timer_list acsi_timer = { function: acsi_times_out };
+struct timer_list acsi_timer = { .function = acsi_times_out };
 
 
 #ifdef CONFIG_ATARI_SLM
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .9822-linux-2.5.44/drivers/block/acsi_slm.c .9822-linux-2.5.44.updated/drivers/block/acsi_slm.c
--- .9822-linux-2.5.44/drivers/block/acsi_slm.c	2002-08-02 11:15:07.000000000 +1000
+++ .9822-linux-2.5.44.updated/drivers/block/acsi_slm.c	2002-10-21 17:53:07.000000000 +1000
@@ -273,12 +273,12 @@ static int slm_get_pagesize( int device,
 static struct timer_list slm_timer = { function: slm_test_ready };
 
 static struct file_operations slm_fops = {
-	owner:		THIS_MODULE,
-	read:		slm_read,
-	write:		slm_write,
-	ioctl:		slm_ioctl,
-	open:		slm_open,
-	release:	slm_release,
+	.owner =	THIS_MODULE,
+	.read =		slm_read,
+	.write =	slm_write,
+	.ioctl =	slm_ioctl,
+	.open =		slm_open,
+	.release =	slm_release,
 };
 
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .9822-linux-2.5.44/drivers/block/cciss.c .9822-linux-2.5.44.updated/drivers/block/cciss.c
--- .9822-linux-2.5.44/drivers/block/cciss.c	2002-10-19 17:48:02.000000000 +1000
+++ .9822-linux-2.5.44.updated/drivers/block/cciss.c	2002-10-21 17:53:07.000000000 +1000
@@ -2505,10 +2505,10 @@ static void __devexit cciss_remove_one (
 }	
 
 static struct pci_driver cciss_pci_driver = {
-	name:		"cciss",
-	probe:		cciss_init_one,
-	remove:		__devexit_p(cciss_remove_one),
-	id_table:	cciss_pci_device_id, /* id_table */
+	.name =		"cciss",
+	.probe =	cciss_init_one,
+	.remove =	__devexit_p(cciss_remove_one),
+	.id_table =	cciss_pci_device_id, /* id_table */
 };
 
 /*
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .9822-linux-2.5.44/drivers/block/elevator.c .9822-linux-2.5.44.updated/drivers/block/elevator.c
--- .9822-linux-2.5.44/drivers/block/elevator.c	2002-10-15 15:29:54.000000000 +1000
+++ .9822-linux-2.5.44.updated/drivers/block/elevator.c	2002-10-21 17:53:07.000000000 +1000
@@ -348,9 +348,9 @@ inline struct list_head *elv_get_sort_he
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
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .9822-linux-2.5.44/drivers/block/genhd.c .9822-linux-2.5.44.updated/drivers/block/genhd.c
--- .9822-linux-2.5.44/drivers/block/genhd.c	2002-10-19 17:48:02.000000000 +1000
+++ .9822-linux-2.5.44.updated/drivers/block/genhd.c	2002-10-21 17:53:07.000000000 +1000
@@ -239,10 +239,10 @@ static int show_partition(struct seq_fil
 }
 
 struct seq_operations partitions_op = {
-	start:	part_start,
-	next:	part_next,
-	stop:	part_stop,
-	show:	show_partition
+	.start =part_start,
+	.next =	part_next,
+	.stop =	part_stop,
+	.show =	show_partition
 };
 #endif
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .9822-linux-2.5.44/drivers/block/loop.c .9822-linux-2.5.44.updated/drivers/block/loop.c
--- .9822-linux-2.5.44/drivers/block/loop.c	2002-10-19 17:48:02.000000000 +1000
+++ .9822-linux-2.5.44.updated/drivers/block/loop.c	2002-10-21 17:53:07.000000000 +1000
@@ -137,15 +137,15 @@ static int xor_status(struct loop_device
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
@@ -971,10 +971,10 @@ static int lo_release(struct inode *inod
 }
 
 static struct block_device_operations lo_fops = {
-	owner:		THIS_MODULE,
-	open:		lo_open,
-	release:	lo_release,
-	ioctl:		lo_ioctl,
+	.owner =	THIS_MODULE,
+	.open =		lo_open,
+	.release =	lo_release,
+	.ioctl =	lo_ioctl,
 };
 
 /*
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .9822-linux-2.5.44/drivers/block/nbd.c .9822-linux-2.5.44.updated/drivers/block/nbd.c
--- .9822-linux-2.5.44/drivers/block/nbd.c	2002-10-19 17:48:02.000000000 +1000
+++ .9822-linux-2.5.44.updated/drivers/block/nbd.c	2002-10-21 17:53:07.000000000 +1000
@@ -466,10 +466,10 @@ static int nbd_release(struct inode *ino
 
 static struct block_device_operations nbd_fops =
 {
-	owner:		THIS_MODULE,
-	open:		nbd_open,
-	release:	nbd_release,
-	ioctl:		nbd_ioctl,
+	.owner =	THIS_MODULE,
+	.open =		nbd_open,
+	.release =	nbd_release,
+	.ioctl =	nbd_ioctl,
 };
 
 /*
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .9822-linux-2.5.44/drivers/block/paride/pg.c .9822-linux-2.5.44.updated/drivers/block/paride/pg.c
--- .9822-linux-2.5.44/drivers/block/paride/pg.c	2002-08-02 11:15:07.000000000 +1000
+++ .9822-linux-2.5.44.updated/drivers/block/paride/pg.c	2002-10-21 17:53:07.000000000 +1000
@@ -254,11 +254,11 @@ static char pg_scratch[512];            
 /* kernel glue structures */
 
 static struct file_operations pg_fops = {
-	owner:		THIS_MODULE,
-	read:		pg_read,
-	write:		pg_write,
-	open:		pg_open,
-	release:	pg_release,
+	.owner =	THIS_MODULE,
+	.read =		pg_read,
+	.write =	pg_write,
+	.open =		pg_open,
+	.release =	pg_release,
 };
 
 void pg_init_units( void )
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .9822-linux-2.5.44/drivers/block/paride/pt.c .9822-linux-2.5.44.updated/drivers/block/paride/pt.c
--- .9822-linux-2.5.44/drivers/block/paride/pt.c	2002-08-02 11:15:07.000000000 +1000
+++ .9822-linux-2.5.44.updated/drivers/block/paride/pt.c	2002-10-21 17:53:07.000000000 +1000
@@ -256,12 +256,12 @@ static char pt_scratch[512];            
 /* kernel glue structures */
 
 static struct file_operations pt_fops = {
-	owner:		THIS_MODULE,
-	read:		pt_read,
-	write:		pt_write,
-	ioctl:		pt_ioctl,
-	open:		pt_open,
-	release:	pt_release,
+	.owner =	THIS_MODULE,
+	.read =		pt_read,
+	.write =	pt_write,
+	.ioctl =	pt_ioctl,
+	.open =		pt_open,
+	.release =	pt_release,
 };
 
 void pt_init_units( void )
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .9822-linux-2.5.44/drivers/block/ps2esdi.c .9822-linux-2.5.44.updated/drivers/block/ps2esdi.c
--- .9822-linux-2.5.44/drivers/block/ps2esdi.c	2002-10-16 15:01:15.000000000 +1000
+++ .9822-linux-2.5.44.updated/drivers/block/ps2esdi.c	2002-10-21 17:53:07.000000000 +1000
@@ -96,7 +96,7 @@ static int ps2esdi_read_status_words(int
 
 static void dump_cmd_complete_status(u_int int_ret_code);
 
-static void ps2esdi_get_device_cfg(void);
+ static void ps2esdi_get_device_cfg(void);
 
 static void ps2esdi_reset_timer(unsigned long unused);
 
@@ -107,7 +107,7 @@ static DECLARE_WAIT_QUEUE_HEAD(ps2esdi_i
 static int no_int_yet;
 static int ps2esdi_drives;
 static u_short io_base;
-static struct timer_list esdi_timer = { function: ps2esdi_reset_timer };
+static struct timer_list esdi_timer = { .function = ps2esdi_reset_timer };
 static int reset_status;
 static int ps2esdi_slot = -1;
 static int tp720esdi = 0;	/* Is it Integrated ESDI of ThinkPad-720? */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .9822-linux-2.5.44/drivers/block/rd.c .9822-linux-2.5.44.updated/drivers/block/rd.c
--- .9822-linux-2.5.44/drivers/block/rd.c	2002-10-19 17:48:02.000000000 +1000
+++ .9822-linux-2.5.44.updated/drivers/block/rd.c	2002-10-21 17:53:07.000000000 +1000
@@ -141,10 +141,10 @@ static int ramdisk_commit_write(struct f
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
@@ -346,8 +346,8 @@ static int initrd_release(struct inode *
 
 
 static struct file_operations initrd_fops = {
-	read:		initrd_read,
-	release:	initrd_release,
+	.read =		initrd_read,
+	.release =	initrd_release,
 };
 
 #endif
@@ -394,9 +394,9 @@ static int rd_open(struct inode * inode,
 }
 
 static struct block_device_operations rd_bd_op = {
-	owner:		THIS_MODULE,
-	open:		rd_open,
-	ioctl:		rd_ioctl,
+	.owner =	THIS_MODULE,
+	.open =		rd_open,
+	.ioctl =	rd_ioctl,
 };
 
 /* Before freeing the module, invalidate all of the protected buffers! */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal .9822-linux-2.5.44/drivers/block/umem.c .9822-linux-2.5.44.updated/drivers/block/umem.c
--- .9822-linux-2.5.44/drivers/block/umem.c	2002-10-19 17:48:02.000000000 +1000
+++ .9822-linux-2.5.44.updated/drivers/block/umem.c	2002-10-21 17:53:07.000000000 +1000
@@ -1122,18 +1122,18 @@ static void mm_pci_remove(struct pci_dev
 }
 
 static const struct pci_device_id __devinitdata mm_pci_ids[] = { {
-	vendor:		PCI_VENDOR_ID_MICRO_MEMORY,
-	device:		PCI_DEVICE_ID_MICRO_MEMORY_5415CN,
+	.vendor =	PCI_VENDOR_ID_MICRO_MEMORY,
+	.device =	PCI_DEVICE_ID_MICRO_MEMORY_5415CN,
 	}, { /* end: all zeroes */ }
 };
 
 MODULE_DEVICE_TABLE(pci, mm_pci_ids);
 
 static struct pci_driver mm_pci_driver = {
-	name:		"umem",
-	id_table:	mm_pci_ids,
-	probe:		mm_pci_probe,
-	remove:		mm_pci_remove,
+	.name =		"umem",
+	.id_table =	mm_pci_ids,
+	.probe =	mm_pci_probe,
+	.remove =	mm_pci_remove,
 };
 /*
 -----------------------------------------------------------------------------------
