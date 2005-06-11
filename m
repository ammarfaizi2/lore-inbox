Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261673AbVFKIk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbVFKIk2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 04:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261652AbVFKIjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 04:39:44 -0400
Received: from mail.kroah.org ([69.55.234.183]:6596 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261660AbVFKHsx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 03:48:53 -0400
Subject: [PATCH] Remove devfs_mk_dir() function from the kernel tree
In-Reply-To: <1118476111192@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Sat, 11 Jun 2005 00:48:31 -0700
Message-Id: <11184761113507@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Removes the devfs_mk_dir() function and all callers of it.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
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
 47 files changed, 1 insertion(+), 93 deletions(-)

--- gregkh-2.6.orig/drivers/usb/core/file.c	2005-06-10 23:29:07.000000000 -0700
+++ gregkh-2.6/drivers/usb/core/file.c	2005-06-10 23:38:18.000000000 -0700
@@ -88,8 +88,6 @@
 		goto out;
 	}
 
-	devfs_mk_dir("usb");
-
 out:
 	return error;
 }
--- gregkh-2.6.orig/drivers/usb/input/hiddev.c	2005-06-10 23:29:07.000000000 -0700
+++ gregkh-2.6/drivers/usb/input/hiddev.c	2005-06-10 23:38:15.000000000 -0700
@@ -833,7 +833,6 @@
 
 int __init hiddev_init(void)
 {
-	devfs_mk_dir("usb/hid");
 	return usb_register(&hiddev_driver);
 }
 
--- gregkh-2.6.orig/drivers/block/floppy.c	2005-06-10 23:29:07.000000000 -0700
+++ gregkh-2.6/drivers/block/floppy.c	2005-06-10 23:38:20.000000000 -0700
@@ -4241,8 +4241,6 @@
 		motor_off_timer[dr].function = motor_off_callback;
 	}
 
-	devfs_mk_dir("floppy");
-
 	err = register_blkdev(FLOPPY_MAJOR, "fd");
 	if (err)
 		goto out_devfs_remove;
--- gregkh-2.6.orig/drivers/block/loop.c	2005-06-10 23:29:07.000000000 -0700
+++ gregkh-2.6/drivers/block/loop.c	2005-06-10 23:38:15.000000000 -0700
@@ -1270,8 +1270,6 @@
 			goto out_mem3;
 	}
 
-	devfs_mk_dir("loop");
-
 	for (i = 0; i < max_loop; i++) {
 		struct loop_device *lo = &loop_dev[i];
 		struct gendisk *disk = disks[i];
--- gregkh-2.6.orig/drivers/block/nbd.c	2005-06-10 23:29:07.000000000 -0700
+++ gregkh-2.6/drivers/block/nbd.c	2005-06-10 23:38:15.000000000 -0700
@@ -679,7 +679,6 @@
 	printk(KERN_INFO "nbd: registered device at major %d\n", NBD_MAJOR);
 	dprintk(DBG_INIT, "nbd: debugflags=0x%x\n", debugflags);
 
-	devfs_mk_dir("nbd");
 	for (i = 0; i < nbds_max; i++) {
 		struct gendisk *disk = nbd_dev[i].disk;
 		nbd_dev[i].file = NULL;
--- gregkh-2.6.orig/drivers/block/sx8.c	2005-06-10 23:29:07.000000000 -0700
+++ gregkh-2.6/drivers/block/sx8.c	2005-06-10 23:38:15.000000000 -0700
@@ -1667,8 +1667,6 @@
 	if (host->flags & FL_DYN_MAJOR)
 		host->major = rc;
 
-	devfs_mk_dir(DRV_NAME);
-
 	rc = carm_init_disks(host);
 	if (rc)
 		goto err_out_blkdev_disks;
--- gregkh-2.6.orig/drivers/block/ub.c	2005-06-10 23:29:07.000000000 -0700
+++ gregkh-2.6/drivers/block/ub.c	2005-06-10 23:38:15.000000000 -0700
@@ -2315,7 +2315,6 @@
 
 	if ((rc = register_blkdev(UB_MAJOR, DRV_NAME)) != 0)
 		goto err_regblkdev;
-	devfs_mk_dir(DEVFS_NAME);
 
 	if ((rc = usb_register(&ub_driver)) != 0)
 		goto err_register;
--- gregkh-2.6.orig/drivers/block/acsi_slm.c	2005-06-10 23:29:07.000000000 -0700
+++ gregkh-2.6/drivers/block/acsi_slm.c	2005-06-10 23:38:18.000000000 -0700
@@ -1007,7 +1007,6 @@
 	BufferP = SLMBuffer;
 	SLMState = IDLE;
 	
-	devfs_mk_dir("slm");
 	for (i = 0; i < MAX_SLM; i++) {
 		devfs_mk_cdev(MKDEV(ACSI_MAJOR, i),
 				S_IFCHR|S_IRUSR|S_IWUSR, "slm/%d", i);
--- gregkh-2.6.orig/drivers/block/rd.c	2005-06-10 23:29:07.000000000 -0700
+++ gregkh-2.6/drivers/block/rd.c	2005-06-10 23:38:15.000000000 -0700
@@ -441,8 +441,6 @@
 		goto out;
 	}
 
-	devfs_mk_dir("rd");
-
 	for (i = 0; i < CONFIG_BLK_DEV_RAM_COUNT; i++) {
 		struct gendisk *disk = rd_disks[i];
 
--- gregkh-2.6.orig/drivers/block/swim3.c	2005-06-10 23:29:07.000000000 -0700
+++ gregkh-2.6/drivers/block/swim3.c	2005-06-10 23:38:12.000000000 -0700
@@ -1015,8 +1015,6 @@
 	int err = -ENOMEM;
 	int i;
 
-	devfs_mk_dir("floppy");
-
 	swim = find_devices("floppy");
 	while (swim && (floppy_count < MAX_FLOPPIES))
 	{
--- gregkh-2.6.orig/drivers/char/ipmi/ipmi_devintf.c	2005-06-10 23:29:07.000000000 -0700
+++ gregkh-2.6/drivers/char/ipmi/ipmi_devintf.c	2005-06-10 23:38:18.000000000 -0700
@@ -572,8 +572,6 @@
 		ipmi_major = rv;
 	}
 
-	devfs_mk_dir(DEVICE_NAME);
-
 	rv = ipmi_smi_watcher_register(&smi_watcher);
 	if (rv) {
 		unregister_chrdev(ipmi_major, DEVICE_NAME);
--- gregkh-2.6.orig/drivers/char/istallion.c	2005-06-10 23:29:07.000000000 -0700
+++ gregkh-2.6/drivers/char/istallion.c	2005-06-10 23:38:18.000000000 -0700
@@ -5241,7 +5241,6 @@
 		printk(KERN_ERR "STALLION: failed to register serial memory "
 				"device\n");
 
-	devfs_mk_dir("staliomem");
 	istallion_class = class_create(THIS_MODULE, "staliomem");
 	for (i = 0; i < 4; i++) {
 		devfs_mk_cdev(MKDEV(STL_SIOMEMMAJOR, i),
--- gregkh-2.6.orig/drivers/char/lp.c	2005-06-10 23:29:07.000000000 -0700
+++ gregkh-2.6/drivers/char/lp.c	2005-06-10 23:38:18.000000000 -0700
@@ -906,7 +906,6 @@
 		return -EIO;
 	}
 
-	devfs_mk_dir("printers");
 	lp_class = class_create(THIS_MODULE, "printer");
 	if (IS_ERR(lp_class)) {
 		err = PTR_ERR(lp_class);
--- gregkh-2.6.orig/drivers/char/ppdev.c	2005-06-10 23:29:07.000000000 -0700
+++ gregkh-2.6/drivers/char/ppdev.c	2005-06-10 23:38:18.000000000 -0700
@@ -781,7 +781,6 @@
 		err = PTR_ERR(ppdev_class);
 		goto out_chrdev;
 	}
-	devfs_mk_dir("parports");
 	for (i = 0; i < PARPORT_MAX; i++) {
 		devfs_mk_cdev(MKDEV(PP_MAJOR, i),
 				S_IFCHR | S_IRUGO | S_IWUGO, "parports/%d", i);
--- gregkh-2.6.orig/drivers/char/pty.c	2005-06-10 23:29:07.000000000 -0700
+++ gregkh-2.6/drivers/char/pty.c	2005-06-10 23:38:12.000000000 -0700
@@ -352,7 +352,6 @@
 
 static void __init unix98_pty_init(void)
 {
-	devfs_mk_dir("pts");
 	ptm_driver = alloc_tty_driver(NR_UNIX98_PTY_MAX);
 	if (!ptm_driver)
 		panic("Couldn't allocate Unix98 ptm driver");
--- gregkh-2.6.orig/drivers/char/stallion.c	2005-06-10 23:29:07.000000000 -0700
+++ gregkh-2.6/drivers/char/stallion.c	2005-06-10 23:38:18.000000000 -0700
@@ -3088,7 +3088,6 @@
  */
 	if (register_chrdev(STL_SIOMEMMAJOR, "staliomem", &stl_fsiomem))
 		printk("STALLION: failed to register serial board device\n");
-	devfs_mk_dir("staliomem");
 
 	stallion_class = class_create(THIS_MODULE, "staliomem");
 	for (i = 0; i < 4; i++) {
--- gregkh-2.6.orig/drivers/char/tipar.c	2005-06-10 23:29:07.000000000 -0700
+++ gregkh-2.6/drivers/char/tipar.c	2005-06-10 23:38:18.000000000 -0700
@@ -502,9 +502,6 @@
 		goto out;
 	}
 
-	/* Use devfs with tree: /dev/ticables/par/[0..2] */
-	devfs_mk_dir("ticables/par");
-
 	tipar_class = class_create(THIS_MODULE, "ticables");
 	if (IS_ERR(tipar_class)) {
 		err = PTR_ERR(tipar_class);
--- gregkh-2.6.orig/drivers/ieee1394/dv1394.c	2005-06-10 23:29:07.000000000 -0700
+++ gregkh-2.6/drivers/ieee1394/dv1394.c	2005-06-10 23:38:18.000000000 -0700
@@ -2364,9 +2364,6 @@
 	class_device_create(hpsb_protocol_class, MKDEV(
 		IEEE1394_MAJOR,	IEEE1394_MINOR_BLOCK_DV1394 * 16 + (id<<2)), 
 		NULL, "dv1394-%d", id);
-	devfs_mk_dir("ieee1394/dv/host%d", id);
-	devfs_mk_dir("ieee1394/dv/host%d/NTSC", id);
-	devfs_mk_dir("ieee1394/dv/host%d/PAL", id);
 
 	dv1394_init(ohci, DV1394_NTSC, MODE_RECEIVE);
 	dv1394_init(ohci, DV1394_NTSC, MODE_TRANSMIT);
@@ -2642,8 +2639,6 @@
 		return ret;
 	}
 
-	devfs_mk_dir("ieee1394/dv");
-
 	hpsb_register_highlevel(&dv1394_highlevel);
 
 	ret = hpsb_register_protocol(&dv1394_driver);
--- gregkh-2.6.orig/sound/core/sound.c	2005-06-10 23:29:07.000000000 -0700
+++ gregkh-2.6/sound/core/sound.c	2005-06-10 23:38:18.000000000 -0700
@@ -340,7 +340,6 @@
 		INIT_LIST_HEAD(&snd_minors_hash[card]);
 	if ((err = snd_oss_init_module()) < 0)
 		return err;
-	devfs_mk_dir("snd");
 	if (register_chrdev(major, "alsa", &snd_fops)) {
 		snd_printk(KERN_ERR "unable to register native major device number %d\n", major);
 		devfs_remove("snd");
--- gregkh-2.6.orig/sound/sound_core.c	2005-06-10 23:29:07.000000000 -0700
+++ gregkh-2.6/sound/sound_core.c	2005-06-10 23:38:18.000000000 -0700
@@ -571,7 +571,6 @@
 		printk(KERN_ERR "soundcore: sound device already in use.\n");
 		return -EBUSY;
 	}
-	devfs_mk_dir ("sound");
 	sound_class = class_create(THIS_MODULE, "sound");
 	if (IS_ERR(sound_class))
 		return PTR_ERR(sound_class);
--- gregkh-2.6.orig/arch/um/drivers/ubd_kern.c	2005-06-10 23:29:07.000000000 -0700
+++ gregkh-2.6/arch/um/drivers/ubd_kern.c	2005-06-10 23:38:22.000000000 -0700
@@ -816,7 +816,6 @@
 {
         int i;
 
-	devfs_mk_dir("ubd");
 	if (register_blkdev(MAJOR_NR, "ubd"))
 		return -1;
 
@@ -830,7 +829,6 @@
 		char name[sizeof("ubd_nnn\0")];
 
 		snprintf(name, sizeof(name), "ubd_%d", fake_major);
-		devfs_mk_dir(name);
 		if (register_blkdev(fake_major, "ubd"))
 			return -1;
 	}
--- gregkh-2.6.orig/drivers/block/paride/pg.c	2005-06-10 23:29:07.000000000 -0700
+++ gregkh-2.6/drivers/block/paride/pg.c	2005-06-10 23:38:18.000000000 -0700
@@ -671,7 +671,6 @@
 		err = PTR_ERR(pg_class);
 		goto out_chrdev;
 	}
-	devfs_mk_dir("pg");
 	for (unit = 0; unit < PG_UNITS; unit++) {
 		struct pg *dev = &devices[unit];
 		if (dev->present) {
--- gregkh-2.6.orig/drivers/block/paride/pt.c	2005-06-10 23:29:07.000000000 -0700
+++ gregkh-2.6/drivers/block/paride/pt.c	2005-06-10 23:38:18.000000000 -0700
@@ -969,7 +969,6 @@
 		goto out_chrdev;
 	}
 
-	devfs_mk_dir("pt");
 	for (unit = 0; unit < PT_UNITS; unit++)
 		if (pt[unit].present) {
 			class_device_create(pt_class, MKDEV(major, unit),
--- gregkh-2.6.orig/drivers/cdrom/sbpcd.c	2005-06-10 23:29:07.000000000 -0700
+++ gregkh-2.6/drivers/cdrom/sbpcd.c	2005-06-10 23:38:15.000000000 -0700
@@ -5813,8 +5813,6 @@
 		return -ENOMEM;
 	}
 
-	devfs_mk_dir("sbp");
-
 	for (j=0;j<NR_SBPCD;j++)
 	{
 		struct cdrom_device_info * sbpcd_infop;
--- gregkh-2.6.orig/drivers/input/input.c	2005-06-10 23:29:07.000000000 -0700
+++ gregkh-2.6/drivers/input/input.c	2005-06-10 23:38:15.000000000 -0700
@@ -719,17 +719,8 @@
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
 
--- gregkh-2.6.orig/drivers/md/md.c	2005-06-10 23:29:07.000000000 -0700
+++ gregkh-2.6/drivers/md/md.c	2005-06-10 23:38:20.000000000 -0700
@@ -3631,7 +3631,6 @@
 		unregister_blkdev(MAJOR_NR, "md");
 		return -1;
 	}
-	devfs_mk_dir("md");
 	blk_register_region(MKDEV(MAJOR_NR, 0), MAX_MD_DEVS, THIS_MODULE,
 				md_probe, NULL, NULL);
 	blk_register_region(MKDEV(mdp_major, 0), MAX_MD_DEVS<<MdpMinorShift, THIS_MODULE,
--- gregkh-2.6.orig/mm/shmem.c	2005-06-10 23:29:07.000000000 -0700
+++ gregkh-2.6/mm/shmem.c	2005-06-10 23:38:12.000000000 -0700
@@ -2219,9 +2219,7 @@
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
--- gregkh-2.6.orig/mm/tiny-shmem.c	2005-06-10 23:29:07.000000000 -0700
+++ gregkh-2.6/mm/tiny-shmem.c	2005-06-10 23:38:12.000000000 -0700
@@ -32,9 +32,6 @@
 static int __init init_tmpfs(void)
 {
 	register_filesystem(&tmpfs_fs_type);
-#ifdef CONFIG_TMPFS
-	devfs_mk_dir("shm");
-#endif
 	shm_mnt = kern_mount(&tmpfs_fs_type);
 	return 0;
 }
--- gregkh-2.6.orig/drivers/i2c/i2c-dev.c	2005-06-10 23:29:07.000000000 -0700
+++ gregkh-2.6/drivers/i2c/i2c-dev.c	2005-06-10 23:38:18.000000000 -0700
@@ -521,8 +521,6 @@
 	if (res)
 		goto out_unreg_class;
 
-	devfs_mk_dir("i2c");
-
 	return 0;
 
 out_unreg_class:
--- gregkh-2.6.orig/drivers/media/dvb/dvb-core/dvbdev.c	2005-06-10 23:29:07.000000000 -0700
+++ gregkh-2.6/drivers/media/dvb/dvb-core/dvbdev.c	2005-06-10 23:38:18.000000000 -0700
@@ -302,7 +302,6 @@
 
 	printk ("DVB: registering new adapter (%s).\n", name);
 
-	devfs_mk_dir("dvb/adapter%d", num);
 	adap->num = num;
 	adap->name = name;
 	adap->module = module;
@@ -409,8 +408,6 @@
 		goto error;
 	}
 
-	devfs_mk_dir("dvb");
-
 	dvb_class = class_create(THIS_MODULE, "dvb");
 	if (IS_ERR(dvb_class)) {
 		retval = PTR_ERR(dvb_class);
--- gregkh-2.6.orig/drivers/net/wan/cosa.c	2005-06-10 23:29:07.000000000 -0700
+++ gregkh-2.6/drivers/net/wan/cosa.c	2005-06-10 23:38:18.000000000 -0700
@@ -393,7 +393,6 @@
 		err = -ENODEV;
 		goto out;
 	}
-	devfs_mk_dir("cosa");
 	cosa_class = class_create(THIS_MODULE, "cosa");
 	if (IS_ERR(cosa_class)) {
 		err = PTR_ERR(cosa_class);
--- gregkh-2.6.orig/drivers/s390/block/dasd.c	2005-06-10 23:29:07.000000000 -0700
+++ gregkh-2.6/drivers/s390/block/dasd.c	2005-06-10 23:38:15.000000000 -0700
@@ -1995,9 +1995,6 @@
 
 	dasd_diag_discipline_pointer = NULL;
 
-	rc = devfs_mk_dir("dasd");
-	if (rc)
-		goto failed;
 	rc = dasd_devmap_init();
 	if (rc)
 		goto failed;
--- gregkh-2.6.orig/drivers/s390/block/xpram.c	2005-06-10 23:29:07.000000000 -0700
+++ gregkh-2.6/drivers/s390/block/xpram.c	2005-06-10 23:38:15.000000000 -0700
@@ -443,8 +443,6 @@
 	if (rc < 0)
 		goto out;
 
-	devfs_mk_dir("slram");
-
 	/*
 	 * Assign the other needed values: make request function, sizes and
 	 * hardsect size. All the minor devices feature the same value.
--- gregkh-2.6.orig/drivers/scsi/scsi.c	2005-06-10 23:29:07.000000000 -0700
+++ gregkh-2.6/drivers/scsi/scsi.c	2005-06-10 23:38:15.000000000 -0700
@@ -1335,7 +1335,6 @@
 	for (i = 0; i < NR_CPUS; i++)
 		INIT_LIST_HEAD(&per_cpu(scsi_done_q, i));
 
-	devfs_mk_dir("scsi");
 	open_softirq(SCSI_SOFTIRQ, scsi_softirq, NULL);
 	register_scsi_cpu();
 	printk(KERN_NOTICE "SCSI subsystem initialized\n");
--- gregkh-2.6.orig/drivers/video/fbmem.c	2005-06-10 23:29:07.000000000 -0700
+++ gregkh-2.6/drivers/video/fbmem.c	2005-06-10 23:38:18.000000000 -0700
@@ -1193,7 +1193,6 @@
 {
 	create_proc_read_entry("fb", 0, NULL, fbmem_read_proc, NULL);
 
-	devfs_mk_dir("fb");
 	if (register_chrdev(FB_MAJOR,"fb",&fb_fops))
 		printk("unable to get major %d for fb devs\n", FB_MAJOR);
 
--- gregkh-2.6.orig/drivers/ide/ide.c	2005-06-10 23:29:07.000000000 -0700
+++ gregkh-2.6/drivers/ide/ide.c	2005-06-10 23:38:15.000000000 -0700
@@ -1920,7 +1920,6 @@
 static int __init ide_init(void)
 {
 	printk(KERN_INFO "Uniform Multi-Platform E-IDE driver " REVISION "\n");
-	devfs_mk_dir("ide");
 	system_bus_speed = ide_system_bus_speed();
 
 	bus_register(&ide_bus_type);
--- gregkh-2.6.orig/drivers/ieee1394/amdtp.c	2005-06-10 23:29:07.000000000 -0700
+++ gregkh-2.6/drivers/ieee1394/amdtp.c	2005-06-10 23:38:18.000000000 -0700
@@ -1277,8 +1277,6 @@
  		return -EIO;
  	}
 
-	devfs_mk_dir("amdtp");
-
 	hpsb_register_highlevel(&amdtp_highlevel);
 
 	HPSB_INFO("Loaded AMDTP driver");
--- gregkh-2.6.orig/drivers/ieee1394/ieee1394_core.c	2005-06-10 23:29:07.000000000 -0700
+++ gregkh-2.6/drivers/ieee1394/ieee1394_core.c	2005-06-10 23:38:15.000000000 -0700
@@ -1092,13 +1092,6 @@
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
@@ -1168,7 +1161,6 @@
 	bus_unregister(&ieee1394_bus_type);
 release_devfs:
 	devfs_remove("ieee1394");
-release_chrdev:
 	unregister_chrdev_region(IEEE1394_CORE_DEV, 256);
 exit_release_kernel_thread:
 	if (khpsbpkt_pid >= 0) {
--- gregkh-2.6.orig/drivers/ieee1394/video1394.c	2005-06-10 23:29:07.000000000 -0700
+++ gregkh-2.6/drivers/ieee1394/video1394.c	2005-06-10 23:38:18.000000000 -0700
@@ -1551,8 +1551,6 @@
 		return ret;
         }
 
-	devfs_mk_dir(VIDEO1394_DRIVER_NAME);
-
 	hpsb_register_highlevel(&video1394_highlevel);
 
 	ret = hpsb_register_protocol(&video1394_driver);
--- gregkh-2.6.orig/drivers/md/dm-ioctl.c	2005-06-10 23:29:07.000000000 -0700
+++ gregkh-2.6/drivers/md/dm-ioctl.c	2005-06-10 23:38:20.000000000 -0700
@@ -66,7 +66,6 @@
 {
 	init_buckets(_name_buckets);
 	init_buckets(_uuid_buckets);
-	devfs_mk_dir(DM_DIR);
 	return 0;
 }
 
--- gregkh-2.6.orig/drivers/mmc/mmc_block.c	2005-06-10 23:29:07.000000000 -0700
+++ gregkh-2.6/drivers/mmc/mmc_block.c	2005-06-10 23:38:15.000000000 -0700
@@ -488,7 +488,6 @@
 	if (major == 0)
 		major = res;
 
-	devfs_mk_dir("mmc");
 	return mmc_register_driver(&mmc_driver);
 
  out:
--- gregkh-2.6.orig/drivers/mtd/mtd_blkdevs.c	2005-06-10 23:29:07.000000000 -0700
+++ gregkh-2.6/drivers/mtd/mtd_blkdevs.c	2005-06-10 23:38:15.000000000 -0700
@@ -411,8 +411,6 @@
 		return ret;
 	} 
 
-	devfs_mk_dir(tr->name);
-
 	INIT_LIST_HEAD(&tr->devs);
 	list_add(&tr->list, &blktrans_majors);
 
--- gregkh-2.6.orig/drivers/mtd/mtdchar.c	2005-06-10 23:29:07.000000000 -0700
+++ gregkh-2.6/drivers/mtd/mtdchar.c	2005-06-10 23:38:18.000000000 -0700
@@ -45,7 +45,6 @@
 
 static inline void mtdchar_devfs_init(void)
 {
-	devfs_mk_dir("mtd");
 	register_mtd_user(&notifier);
 }
 
--- gregkh-2.6.orig/drivers/sbus/char/bpp.c	2005-06-10 23:29:07.000000000 -0700
+++ gregkh-2.6/drivers/sbus/char/bpp.c	2005-06-10 23:38:18.000000000 -0700
@@ -1048,7 +1048,6 @@
 		instances[idx].opened = 0;
 		probeLptPort(idx);
 	}
-	devfs_mk_dir("bpp");
 	for (idx = 0; idx < BPP_NO; idx++) {
 		devfs_mk_cdev(MKDEV(BPP_MAJOR, idx),
 				S_IFCHR | S_IRUSR | S_IWUSR, "bpp/%d", idx);
--- gregkh-2.6.orig/drivers/sbus/char/vfc_dev.c	2005-06-10 23:29:07.000000000 -0700
+++ gregkh-2.6/drivers/sbus/char/vfc_dev.c	2005-06-10 23:38:18.000000000 -0700
@@ -678,7 +678,6 @@
 		kfree(vfc_dev_lst);
 		return -EIO;
 	}
-	devfs_mk_dir("vfc");
 	instance = 0;
 	for_all_sbusdev(sdev, sbus) {
 		if (strcmp(sdev->prom_name, "vfc") == 0) {
--- gregkh-2.6.orig/fs/coda/psdev.c	2005-06-10 23:29:07.000000000 -0700
+++ gregkh-2.6/fs/coda/psdev.c	2005-06-10 23:38:18.000000000 -0700
@@ -368,7 +368,6 @@
 		err = PTR_ERR(coda_psdev_class);
 		goto out_chrdev;
 	}		
-	devfs_mk_dir ("coda");
 	for (i = 0; i < MAX_CODADEVS; i++) {
 		class_device_create(coda_psdev_class, MKDEV(CODA_PSDEV_MAJOR,i),
 				NULL, "cfs%d", i);
--- gregkh-2.6.orig/include/linux/devfs_fs_kernel.h	2005-06-10 23:37:16.000000000 -0700
+++ gregkh-2.6/include/linux/devfs_fs_kernel.h	2005-06-10 23:38:22.000000000 -0700
@@ -19,10 +19,6 @@
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

