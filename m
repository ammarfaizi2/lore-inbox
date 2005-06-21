Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261988AbVFUH3k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261988AbVFUH3k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 03:29:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261990AbVFUH3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 03:29:40 -0400
Received: from mail.kroah.org ([69.55.234.183]:51939 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261988AbVFUGax convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 02:30:53 -0400
Cc: gregkh@suse.de
Subject: [PATCH] devfs: Remove devfs_mk_dir() function from the kernel tree
In-Reply-To: <11193354432926@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 23:30:43 -0700
Message-Id: <11193354432364@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] devfs: Remove devfs_mk_dir() function from the kernel tree

Removes the devfs_mk_dir() function and all callers of it.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 59fc8ea23cb33097e8ca69729cf136174faabced
tree c7b1509693632d22f71f51efeb8adafc75793e0d
parent c33068e42ebb3b3515fe0e382a0aaeae3009135e
author Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 21:15:16 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 23:13:32 -0700

 arch/um/drivers/ubd_kern.c          |    2 --
 drivers/block/acsi_slm.c            |    1 -
 drivers/block/floppy.c              |    2 --
 drivers/block/loop.c                |    2 --
 drivers/block/nbd.c                 |    1 -
 drivers/block/paride/pg.c           |    1 -
 drivers/block/paride/pt.c           |    1 -
 drivers/block/rd.c                  |    2 --
 drivers/block/swim3.c               |    2 --
 drivers/block/sx8.c                 |    2 --
 drivers/block/ub.c                  |    1 -
 drivers/cdrom/sbpcd.c               |    2 --
 drivers/char/ipmi/ipmi_devintf.c    |    2 --
 drivers/char/istallion.c            |    1 -
 drivers/char/lp.c                   |    1 -
 drivers/char/ppdev.c                |    1 -
 drivers/char/pty.c                  |    1 -
 drivers/char/stallion.c             |    1 -
 drivers/char/tipar.c                |    3 ---
 drivers/i2c/i2c-dev.c               |    2 --
 drivers/ide/ide.c                   |    1 -
 drivers/ieee1394/amdtp.c            |    2 --
 drivers/ieee1394/dv1394.c           |    5 -----
 drivers/ieee1394/ieee1394_core.c    |    8 --------
 drivers/ieee1394/video1394.c        |    2 --
 drivers/input/input.c               |    9 ---------
 drivers/md/dm-ioctl.c               |    1 -
 drivers/md/md.c                     |    1 -
 drivers/media/dvb/dvb-core/dvbdev.c |    3 ---
 drivers/mmc/mmc_block.c             |    1 -
 drivers/mtd/mtd_blkdevs.c           |    2 --
 drivers/mtd/mtdchar.c               |    1 -
 drivers/net/wan/cosa.c              |    1 -
 drivers/s390/block/dasd.c           |    3 ---
 drivers/s390/block/xpram.c          |    2 --
 drivers/sbus/char/bpp.c             |    1 -
 drivers/sbus/char/vfc_dev.c         |    1 -
 drivers/scsi/scsi.c                 |    1 -
 drivers/usb/core/file.c             |    2 --
 drivers/usb/input/hiddev.c          |    1 -
 drivers/video/fbmem.c               |    1 -
 fs/coda/psdev.c                     |    1 -
 include/linux/devfs_fs_kernel.h     |    4 ----
 mm/shmem.c                          |    4 +---
 mm/tiny-shmem.c                     |    3 ---
 sound/core/sound.c                  |    1 -
 sound/sound_core.c                  |    1 -
 47 files changed, 1 insertions(+), 93 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -816,7 +816,6 @@ int ubd_init(void)
 {
         int i;
 
-	devfs_mk_dir("ubd");
 	if (register_blkdev(MAJOR_NR, "ubd"))
 		return -1;
 
@@ -830,7 +829,6 @@ int ubd_init(void)
 		char name[sizeof("ubd_nnn\0")];
 
 		snprintf(name, sizeof(name), "ubd_%d", fake_major);
-		devfs_mk_dir(name);
 		if (register_blkdev(fake_major, "ubd"))
 			return -1;
 	}
diff --git a/drivers/block/acsi_slm.c b/drivers/block/acsi_slm.c
--- a/drivers/block/acsi_slm.c
+++ b/drivers/block/acsi_slm.c
@@ -1007,7 +1007,6 @@ int slm_init( void )
 	BufferP = SLMBuffer;
 	SLMState = IDLE;
 	
-	devfs_mk_dir("slm");
 	for (i = 0; i < MAX_SLM; i++) {
 		devfs_mk_cdev(MKDEV(ACSI_MAJOR, i),
 				S_IFCHR|S_IRUSR|S_IWUSR, "slm/%d", i);
diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -4241,8 +4241,6 @@ static int __init floppy_init(void)
 		motor_off_timer[dr].function = motor_off_callback;
 	}
 
-	devfs_mk_dir("floppy");
-
 	err = register_blkdev(FLOPPY_MAJOR, "fd");
 	if (err)
 		goto out_devfs_remove;
diff --git a/drivers/block/loop.c b/drivers/block/loop.c
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1270,8 +1270,6 @@ static int __init loop_init(void)
 			goto out_mem3;
 	}
 
-	devfs_mk_dir("loop");
-
 	for (i = 0; i < max_loop; i++) {
 		struct loop_device *lo = &loop_dev[i];
 		struct gendisk *disk = disks[i];
diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -679,7 +679,6 @@ static int __init nbd_init(void)
 	printk(KERN_INFO "nbd: registered device at major %d\n", NBD_MAJOR);
 	dprintk(DBG_INIT, "nbd: debugflags=0x%x\n", debugflags);
 
-	devfs_mk_dir("nbd");
 	for (i = 0; i < nbds_max; i++) {
 		struct gendisk *disk = nbd_dev[i].disk;
 		nbd_dev[i].file = NULL;
diff --git a/drivers/block/paride/pg.c b/drivers/block/paride/pg.c
--- a/drivers/block/paride/pg.c
+++ b/drivers/block/paride/pg.c
@@ -671,7 +671,6 @@ static int __init pg_init(void)
 		err = PTR_ERR(pg_class);
 		goto out_chrdev;
 	}
-	devfs_mk_dir("pg");
 	for (unit = 0; unit < PG_UNITS; unit++) {
 		struct pg *dev = &devices[unit];
 		if (dev->present) {
diff --git a/drivers/block/paride/pt.c b/drivers/block/paride/pt.c
--- a/drivers/block/paride/pt.c
+++ b/drivers/block/paride/pt.c
@@ -969,7 +969,6 @@ static int __init pt_init(void)
 		goto out_chrdev;
 	}
 
-	devfs_mk_dir("pt");
 	for (unit = 0; unit < PT_UNITS; unit++)
 		if (pt[unit].present) {
 			class_device_create(pt_class, MKDEV(major, unit),
diff --git a/drivers/block/rd.c b/drivers/block/rd.c
--- a/drivers/block/rd.c
+++ b/drivers/block/rd.c
@@ -441,8 +441,6 @@ static int __init rd_init(void)
 		goto out;
 	}
 
-	devfs_mk_dir("rd");
-
 	for (i = 0; i < CONFIG_BLK_DEV_RAM_COUNT; i++) {
 		struct gendisk *disk = rd_disks[i];
 
diff --git a/drivers/block/swim3.c b/drivers/block/swim3.c
--- a/drivers/block/swim3.c
+++ b/drivers/block/swim3.c
@@ -1015,8 +1015,6 @@ int swim3_init(void)
 	int err = -ENOMEM;
 	int i;
 
-	devfs_mk_dir("floppy");
-
 	swim = find_devices("floppy");
 	while (swim && (floppy_count < MAX_FLOPPIES))
 	{
diff --git a/drivers/block/sx8.c b/drivers/block/sx8.c
--- a/drivers/block/sx8.c
+++ b/drivers/block/sx8.c
@@ -1667,8 +1667,6 @@ static int carm_init_one (struct pci_dev
 	if (host->flags & FL_DYN_MAJOR)
 		host->major = rc;
 
-	devfs_mk_dir(DRV_NAME);
-
 	rc = carm_init_disks(host);
 	if (rc)
 		goto err_out_blkdev_disks;
diff --git a/drivers/block/ub.c b/drivers/block/ub.c
--- a/drivers/block/ub.c
+++ b/drivers/block/ub.c
@@ -2315,7 +2315,6 @@ static int __init ub_init(void)
 
 	if ((rc = register_blkdev(UB_MAJOR, DRV_NAME)) != 0)
 		goto err_regblkdev;
-	devfs_mk_dir(DEVFS_NAME);
 
 	if ((rc = usb_register(&ub_driver)) != 0)
 		goto err_register;
diff --git a/drivers/cdrom/sbpcd.c b/drivers/cdrom/sbpcd.c
--- a/drivers/cdrom/sbpcd.c
+++ b/drivers/cdrom/sbpcd.c
@@ -5813,8 +5813,6 @@ int __init sbpcd_init(void)
 		return -ENOMEM;
 	}
 
-	devfs_mk_dir("sbp");
-
 	for (j=0;j<NR_SBPCD;j++)
 	{
 		struct cdrom_device_info * sbpcd_infop;
diff --git a/drivers/char/ipmi/ipmi_devintf.c b/drivers/char/ipmi/ipmi_devintf.c
--- a/drivers/char/ipmi/ipmi_devintf.c
+++ b/drivers/char/ipmi/ipmi_devintf.c
@@ -572,8 +572,6 @@ static __init int init_ipmi_devintf(void
 		ipmi_major = rv;
 	}
 
-	devfs_mk_dir(DEVICE_NAME);
-
 	rv = ipmi_smi_watcher_register(&smi_watcher);
 	if (rv) {
 		unregister_chrdev(ipmi_major, DEVICE_NAME);
diff --git a/drivers/char/istallion.c b/drivers/char/istallion.c
--- a/drivers/char/istallion.c
+++ b/drivers/char/istallion.c
@@ -5241,7 +5241,6 @@ int __init stli_init(void)
 		printk(KERN_ERR "STALLION: failed to register serial memory "
 				"device\n");
 
-	devfs_mk_dir("staliomem");
 	istallion_class = class_create(THIS_MODULE, "staliomem");
 	for (i = 0; i < 4; i++) {
 		devfs_mk_cdev(MKDEV(STL_SIOMEMMAJOR, i),
diff --git a/drivers/char/lp.c b/drivers/char/lp.c
--- a/drivers/char/lp.c
+++ b/drivers/char/lp.c
@@ -906,7 +906,6 @@ static int __init lp_init (void)
 		return -EIO;
 	}
 
-	devfs_mk_dir("printers");
 	lp_class = class_create(THIS_MODULE, "printer");
 	if (IS_ERR(lp_class)) {
 		err = PTR_ERR(lp_class);
diff --git a/drivers/char/ppdev.c b/drivers/char/ppdev.c
--- a/drivers/char/ppdev.c
+++ b/drivers/char/ppdev.c
@@ -781,7 +781,6 @@ static int __init ppdev_init (void)
 		err = PTR_ERR(ppdev_class);
 		goto out_chrdev;
 	}
-	devfs_mk_dir("parports");
 	for (i = 0; i < PARPORT_MAX; i++) {
 		devfs_mk_cdev(MKDEV(PP_MAJOR, i),
 				S_IFCHR | S_IRUGO | S_IWUGO, "parports/%d", i);
diff --git a/drivers/char/pty.c b/drivers/char/pty.c
--- a/drivers/char/pty.c
+++ b/drivers/char/pty.c
@@ -352,7 +352,6 @@ static int pty_unix98_ioctl(struct tty_s
 
 static void __init unix98_pty_init(void)
 {
-	devfs_mk_dir("pts");
 	ptm_driver = alloc_tty_driver(NR_UNIX98_PTY_MAX);
 	if (!ptm_driver)
 		panic("Couldn't allocate Unix98 ptm driver");
diff --git a/drivers/char/stallion.c b/drivers/char/stallion.c
--- a/drivers/char/stallion.c
+++ b/drivers/char/stallion.c
@@ -3088,7 +3088,6 @@ static int __init stl_init(void)
  */
 	if (register_chrdev(STL_SIOMEMMAJOR, "staliomem", &stl_fsiomem))
 		printk("STALLION: failed to register serial board device\n");
-	devfs_mk_dir("staliomem");
 
 	stallion_class = class_create(THIS_MODULE, "staliomem");
 	for (i = 0; i < 4; i++) {
diff --git a/drivers/char/tipar.c b/drivers/char/tipar.c
--- a/drivers/char/tipar.c
+++ b/drivers/char/tipar.c
@@ -502,9 +502,6 @@ tipar_init_module(void)
 		goto out;
 	}
 
-	/* Use devfs with tree: /dev/ticables/par/[0..2] */
-	devfs_mk_dir("ticables/par");
-
 	tipar_class = class_create(THIS_MODULE, "ticables");
 	if (IS_ERR(tipar_class)) {
 		err = PTR_ERR(tipar_class);
diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -522,8 +522,6 @@ static int __init i2c_dev_init(void)
 	if (res)
 		goto out_unreg_class;
 
-	devfs_mk_dir("i2c");
-
 	return 0;
 
 out_unreg_class:
diff --git a/drivers/ide/ide.c b/drivers/ide/ide.c
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -1920,7 +1920,6 @@ EXPORT_SYMBOL_GPL(ide_bus_type);
 static int __init ide_init(void)
 {
 	printk(KERN_INFO "Uniform Multi-Platform E-IDE driver " REVISION "\n");
-	devfs_mk_dir("ide");
 	system_bus_speed = ide_system_bus_speed();
 
 	bus_register(&ide_bus_type);
diff --git a/drivers/ieee1394/amdtp.c b/drivers/ieee1394/amdtp.c
--- a/drivers/ieee1394/amdtp.c
+++ b/drivers/ieee1394/amdtp.c
@@ -1277,8 +1277,6 @@ static int __init amdtp_init_module (voi
  		return -EIO;
  	}
 
-	devfs_mk_dir("amdtp");
-
 	hpsb_register_highlevel(&amdtp_highlevel);
 
 	HPSB_INFO("Loaded AMDTP driver");
diff --git a/drivers/ieee1394/dv1394.c b/drivers/ieee1394/dv1394.c
--- a/drivers/ieee1394/dv1394.c
+++ b/drivers/ieee1394/dv1394.c
@@ -2364,9 +2364,6 @@ static void dv1394_add_host (struct hpsb
 	class_device_create(hpsb_protocol_class, MKDEV(
 		IEEE1394_MAJOR,	IEEE1394_MINOR_BLOCK_DV1394 * 16 + (id<<2)), 
 		NULL, "dv1394-%d", id);
-	devfs_mk_dir("ieee1394/dv/host%d", id);
-	devfs_mk_dir("ieee1394/dv/host%d/NTSC", id);
-	devfs_mk_dir("ieee1394/dv/host%d/PAL", id);
 
 	dv1394_init(ohci, DV1394_NTSC, MODE_RECEIVE);
 	dv1394_init(ohci, DV1394_NTSC, MODE_TRANSMIT);
@@ -2642,8 +2639,6 @@ static int __init dv1394_init_module(voi
 		return ret;
 	}
 
-	devfs_mk_dir("ieee1394/dv");
-
 	hpsb_register_highlevel(&dv1394_highlevel);
 
 	ret = hpsb_register_protocol(&dv1394_driver);
diff --git a/drivers/ieee1394/ieee1394_core.c b/drivers/ieee1394/ieee1394_core.c
--- a/drivers/ieee1394/ieee1394_core.c
+++ b/drivers/ieee1394/ieee1394_core.c
@@ -1092,13 +1092,6 @@ static int __init ieee1394_init(void)
 		goto exit_release_kernel_thread;
 	}
 
-	/* actually this is a non-fatal error */
-	ret = devfs_mk_dir("ieee1394");
-	if (ret < 0) {
-		HPSB_ERR("unable to make devfs dir for device major %d!\n", IEEE1394_MAJOR);
-		goto release_chrdev;
-	}
-
 	ret = bus_register(&ieee1394_bus_type);
 	if (ret < 0) {
 		HPSB_INFO("bus register failed");
@@ -1168,7 +1161,6 @@ release_all_bus:
 	bus_unregister(&ieee1394_bus_type);
 release_devfs:
 	devfs_remove("ieee1394");
-release_chrdev:
 	unregister_chrdev_region(IEEE1394_CORE_DEV, 256);
 exit_release_kernel_thread:
 	if (khpsbpkt_pid >= 0) {
diff --git a/drivers/ieee1394/video1394.c b/drivers/ieee1394/video1394.c
--- a/drivers/ieee1394/video1394.c
+++ b/drivers/ieee1394/video1394.c
@@ -1551,8 +1551,6 @@ static int __init video1394_init_module 
 		return ret;
         }
 
-	devfs_mk_dir(VIDEO1394_DRIVER_NAME);
-
 	hpsb_register_highlevel(&video1394_highlevel);
 
 	ret = hpsb_register_protocol(&video1394_driver);
diff --git a/drivers/input/input.c b/drivers/input/input.c
--- a/drivers/input/input.c
+++ b/drivers/input/input.c
@@ -719,17 +719,8 @@ static int __init input_init(void)
 		remove_proc_entry("handlers", proc_bus_input_dir);
 		remove_proc_entry("input", proc_bus);
 		class_destroy(input_class);
-		return retval;
 	}
 
-	retval = devfs_mk_dir("input");
-	if (retval) {
-		remove_proc_entry("devices", proc_bus_input_dir);
-		remove_proc_entry("handlers", proc_bus_input_dir);
-		remove_proc_entry("input", proc_bus);
-		unregister_chrdev(INPUT_MAJOR, "input");
-		class_destroy(input_class);
-	}
 	return retval;
 }
 
diff --git a/drivers/md/dm-ioctl.c b/drivers/md/dm-ioctl.c
--- a/drivers/md/dm-ioctl.c
+++ b/drivers/md/dm-ioctl.c
@@ -66,7 +66,6 @@ static int dm_hash_init(void)
 {
 	init_buckets(_name_buckets);
 	init_buckets(_uuid_buckets);
-	devfs_mk_dir(DM_DIR);
 	return 0;
 }
 
diff --git a/drivers/md/md.c b/drivers/md/md.c
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -3631,7 +3631,6 @@ static int __init md_init(void)
 		unregister_blkdev(MAJOR_NR, "md");
 		return -1;
 	}
-	devfs_mk_dir("md");
 	blk_register_region(MKDEV(MAJOR_NR, 0), MAX_MD_DEVS, THIS_MODULE,
 				md_probe, NULL, NULL);
 	blk_register_region(MKDEV(mdp_major, 0), MAX_MD_DEVS<<MdpMinorShift, THIS_MODULE,
diff --git a/drivers/media/dvb/dvb-core/dvbdev.c b/drivers/media/dvb/dvb-core/dvbdev.c
--- a/drivers/media/dvb/dvb-core/dvbdev.c
+++ b/drivers/media/dvb/dvb-core/dvbdev.c
@@ -302,7 +302,6 @@ int dvb_register_adapter(struct dvb_adap
 
 	printk ("DVB: registering new adapter (%s).\n", name);
 
-	devfs_mk_dir("dvb/adapter%d", num);
 	adap->num = num;
 	adap->name = name;
 	adap->module = module;
@@ -409,8 +408,6 @@ static int __init init_dvbdev(void)
 		goto error;
 	}
 
-	devfs_mk_dir("dvb");
-
 	dvb_class = class_create(THIS_MODULE, "dvb");
 	if (IS_ERR(dvb_class)) {
 		retval = PTR_ERR(dvb_class);
diff --git a/drivers/mmc/mmc_block.c b/drivers/mmc/mmc_block.c
--- a/drivers/mmc/mmc_block.c
+++ b/drivers/mmc/mmc_block.c
@@ -488,7 +488,6 @@ static int __init mmc_blk_init(void)
 	if (major == 0)
 		major = res;
 
-	devfs_mk_dir("mmc");
 	return mmc_register_driver(&mmc_driver);
 
  out:
diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -411,8 +411,6 @@ int register_mtd_blktrans(struct mtd_blk
 		return ret;
 	} 
 
-	devfs_mk_dir(tr->name);
-
 	INIT_LIST_HEAD(&tr->devs);
 	list_add(&tr->list, &blktrans_majors);
 
diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
--- a/drivers/mtd/mtdchar.c
+++ b/drivers/mtd/mtdchar.c
@@ -45,7 +45,6 @@ static struct mtd_notifier notifier = {
 
 static inline void mtdchar_devfs_init(void)
 {
-	devfs_mk_dir("mtd");
 	register_mtd_user(&notifier);
 }
 
diff --git a/drivers/net/wan/cosa.c b/drivers/net/wan/cosa.c
--- a/drivers/net/wan/cosa.c
+++ b/drivers/net/wan/cosa.c
@@ -393,7 +393,6 @@ static int __init cosa_init(void)
 		err = -ENODEV;
 		goto out;
 	}
-	devfs_mk_dir("cosa");
 	cosa_class = class_create(THIS_MODULE, "cosa");
 	if (IS_ERR(cosa_class)) {
 		err = PTR_ERR(cosa_class);
diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -1995,9 +1995,6 @@ dasd_init(void)
 
 	dasd_diag_discipline_pointer = NULL;
 
-	rc = devfs_mk_dir("dasd");
-	if (rc)
-		goto failed;
 	rc = dasd_devmap_init();
 	if (rc)
 		goto failed;
diff --git a/drivers/s390/block/xpram.c b/drivers/s390/block/xpram.c
--- a/drivers/s390/block/xpram.c
+++ b/drivers/s390/block/xpram.c
@@ -443,8 +443,6 @@ static int __init xpram_setup_blkdev(voi
 	if (rc < 0)
 		goto out;
 
-	devfs_mk_dir("slram");
-
 	/*
 	 * Assign the other needed values: make request function, sizes and
 	 * hardsect size. All the minor devices feature the same value.
diff --git a/drivers/sbus/char/bpp.c b/drivers/sbus/char/bpp.c
--- a/drivers/sbus/char/bpp.c
+++ b/drivers/sbus/char/bpp.c
@@ -1048,7 +1048,6 @@ static int __init bpp_init(void)
 		instances[idx].opened = 0;
 		probeLptPort(idx);
 	}
-	devfs_mk_dir("bpp");
 	for (idx = 0; idx < BPP_NO; idx++) {
 		devfs_mk_cdev(MKDEV(BPP_MAJOR, idx),
 				S_IFCHR | S_IRUSR | S_IWUSR, "bpp/%d", idx);
diff --git a/drivers/sbus/char/vfc_dev.c b/drivers/sbus/char/vfc_dev.c
--- a/drivers/sbus/char/vfc_dev.c
+++ b/drivers/sbus/char/vfc_dev.c
@@ -678,7 +678,6 @@ static int vfc_probe(void)
 		kfree(vfc_dev_lst);
 		return -EIO;
 	}
-	devfs_mk_dir("vfc");
 	instance = 0;
 	for_all_sbusdev(sdev, sbus) {
 		if (strcmp(sdev->prom_name, "vfc") == 0) {
diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -1337,7 +1337,6 @@ static int __init init_scsi(void)
 	for (i = 0; i < NR_CPUS; i++)
 		INIT_LIST_HEAD(&per_cpu(scsi_done_q, i));
 
-	devfs_mk_dir("scsi");
 	open_softirq(SCSI_SOFTIRQ, scsi_softirq, NULL);
 	register_scsi_cpu();
 	printk(KERN_NOTICE "SCSI subsystem initialized\n");
diff --git a/drivers/usb/core/file.c b/drivers/usb/core/file.c
--- a/drivers/usb/core/file.c
+++ b/drivers/usb/core/file.c
@@ -88,8 +88,6 @@ int usb_major_init(void)
 		goto out;
 	}
 
-	devfs_mk_dir("usb");
-
 out:
 	return error;
 }
diff --git a/drivers/usb/input/hiddev.c b/drivers/usb/input/hiddev.c
--- a/drivers/usb/input/hiddev.c
+++ b/drivers/usb/input/hiddev.c
@@ -833,7 +833,6 @@ static /* const */ struct usb_driver hid
 
 int __init hiddev_init(void)
 {
-	devfs_mk_dir("usb/hid");
 	return usb_register(&hiddev_driver);
 }
 
diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1193,7 +1193,6 @@ fbmem_init(void)
 {
 	create_proc_read_entry("fb", 0, NULL, fbmem_read_proc, NULL);
 
-	devfs_mk_dir("fb");
 	if (register_chrdev(FB_MAJOR,"fb",&fb_fops))
 		printk("unable to get major %d for fb devs\n", FB_MAJOR);
 
diff --git a/fs/coda/psdev.c b/fs/coda/psdev.c
--- a/fs/coda/psdev.c
+++ b/fs/coda/psdev.c
@@ -368,7 +368,6 @@ static int init_coda_psdev(void)
 		err = PTR_ERR(coda_psdev_class);
 		goto out_chrdev;
 	}		
-	devfs_mk_dir ("coda");
 	for (i = 0; i < MAX_CODADEVS; i++) {
 		class_device_create(coda_psdev_class, MKDEV(CODA_PSDEV_MAJOR,i),
 				NULL, "cfs%d", i);
diff --git a/include/linux/devfs_fs_kernel.h b/include/linux/devfs_fs_kernel.h
--- a/include/linux/devfs_fs_kernel.h
+++ b/include/linux/devfs_fs_kernel.h
@@ -19,10 +19,6 @@ static inline int devfs_mk_symlink(const
 {
 	return 0;
 }
-static inline int devfs_mk_dir(const char *fmt, ...)
-{
-	return 0;
-}
 static inline void devfs_remove(const char *fmt, ...)
 {
 }
diff --git a/mm/shmem.c b/mm/shmem.c
--- a/mm/shmem.c
+++ b/mm/shmem.c
@@ -2219,9 +2219,7 @@ static int __init init_tmpfs(void)
 		printk(KERN_ERR "Could not register tmpfs\n");
 		goto out2;
 	}
-#ifdef CONFIG_TMPFS
-	devfs_mk_dir("shm");
-#endif
+
 	shm_mnt = do_kern_mount(tmpfs_fs_type.name, MS_NOUSER,
 				tmpfs_fs_type.name, NULL);
 	if (IS_ERR(shm_mnt)) {
diff --git a/mm/tiny-shmem.c b/mm/tiny-shmem.c
--- a/mm/tiny-shmem.c
+++ b/mm/tiny-shmem.c
@@ -32,9 +32,6 @@ static struct vfsmount *shm_mnt;
 static int __init init_tmpfs(void)
 {
 	register_filesystem(&tmpfs_fs_type);
-#ifdef CONFIG_TMPFS
-	devfs_mk_dir("shm");
-#endif
 	shm_mnt = kern_mount(&tmpfs_fs_type);
 	return 0;
 }
diff --git a/sound/core/sound.c b/sound/core/sound.c
--- a/sound/core/sound.c
+++ b/sound/core/sound.c
@@ -340,7 +340,6 @@ static int __init alsa_sound_init(void)
 		INIT_LIST_HEAD(&snd_minors_hash[card]);
 	if ((err = snd_oss_init_module()) < 0)
 		return err;
-	devfs_mk_dir("snd");
 	if (register_chrdev(major, "alsa", &snd_fops)) {
 		snd_printk(KERN_ERR "unable to register native major device number %d\n", major);
 		devfs_remove("snd");
diff --git a/sound/sound_core.c b/sound/sound_core.c
--- a/sound/sound_core.c
+++ b/sound/sound_core.c
@@ -571,7 +571,6 @@ static int __init init_soundcore(void)
 		printk(KERN_ERR "soundcore: sound device already in use.\n");
 		return -EBUSY;
 	}
-	devfs_mk_dir ("sound");
 	sound_class = class_create(THIS_MODULE, "sound");
 	if (IS_ERR(sound_class))
 		return PTR_ERR(sound_class);

