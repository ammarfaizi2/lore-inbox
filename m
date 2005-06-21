Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261600AbVFUHVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbVFUHVK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 03:21:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbVFUHVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 03:21:10 -0400
Received: from mail.kroah.org ([69.55.234.183]:55523 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261992AbVFUGa4 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 02:30:56 -0400
Cc: gregkh@suse.de
Subject: [PATCH] devfs: Remove devfs_mk_cdev() function from the kernel tree
In-Reply-To: <11193354432648@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 23:30:43 -0700
Message-Id: <11193354434057@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] devfs: Remove devfs_mk_cdev() function from the kernel tree

Removes the devfs_mk_cdev() function and all callers of it.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 5015d86152443ad3b64c594a32b33d58f030bf70
tree f5ac5b87a4ea1baa75dc70c6af76bcc9c1b0d06a
parent dea1b4e2a9037726b8a4f2c1d00a0de940cff8ad
author Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 21:15:16 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 23:13:33 -0700

 arch/sparc64/solaris/socksys.c          |    2 -
 drivers/block/acsi_slm.c                |    4 ---
 drivers/block/paride/pg.c               |   11 +-------
 drivers/block/paride/pt.c               |   16 -----------
 drivers/char/dsp56k.c                   |    8 ------
 drivers/char/dtlk.c                     |    3 --
 drivers/char/ftape/zftape/zftape-init.c |   18 -------------
 drivers/char/ip2main.c                  |   17 ------------
 drivers/char/ipmi/ipmi_devintf.c        |    3 --
 drivers/char/istallion.c                |    6 +---
 drivers/char/lp.c                       |    2 -
 drivers/char/mem.c                      |    7 +----
 drivers/char/misc.c                     |    9 +-----
 drivers/char/ppdev.c                    |    4 ---
 drivers/char/raw.c                      |    8 ------
 drivers/char/stallion.c                 |    6 +---
 drivers/char/tipar.c                    |   10 -------
 drivers/char/tty_io.c                   |    7 -----
 drivers/char/vc_screen.c                |    8 ------
 drivers/char/viotape.c                  |    4 ---
 drivers/i2c/i2c-dev.c                   |    2 -
 drivers/ide/ide-tape.c                  |    7 -----
 drivers/ieee1394/amdtp.c                |    3 --
 drivers/ieee1394/dv1394.c               |   12 --------
 drivers/ieee1394/raw1394.c              |    4 ---
 drivers/ieee1394/video1394.c            |    3 --
 drivers/input/evdev.c                   |    2 -
 drivers/input/joydev.c                  |    2 -
 drivers/input/mousedev.c                |    4 ---
 drivers/input/tsdev.c                   |    4 ---
 drivers/isdn/capi/capi.c                |    2 -
 drivers/isdn/hardware/eicon/divamnt.c   |    1 -
 drivers/isdn/hardware/eicon/divasi.c    |    1 -
 drivers/isdn/hardware/eicon/divasmain.c |    1 -
 drivers/macintosh/adb.c                 |    2 -
 drivers/media/dvb/dvb-core/dvbdev.c     |    4 ---
 drivers/media/video/videodev.c          |    6 +---
 drivers/mtd/mtdchar.c                   |   44 -------------------------------
 drivers/net/ppp_generic.c               |    7 -----
 drivers/net/wan/cosa.c                  |    7 -----
 drivers/sbus/char/bpp.c                 |    4 ---
 drivers/sbus/char/vfc_dev.c             |    4 ---
 drivers/scsi/ch.c                       |    2 -
 drivers/scsi/osst.c                     |   13 +--------
 drivers/scsi/sg.c                       |    3 --
 drivers/scsi/st.c                       |   13 ---------
 drivers/telephony/phonedev.c            |    2 -
 drivers/usb/core/file.c                 |    1 -
 drivers/video/fbmem.c                   |    2 -
 fs/coda/psdev.c                         |   11 +-------
 include/linux/devfs_fs_kernel.h         |    4 ---
 sound/core/sound.c                      |   10 -------
 sound/oss/soundcard.c                   |   10 +------
 sound/sound_core.c                      |    2 -
 54 files changed, 11 insertions(+), 341 deletions(-)

diff --git a/arch/sparc64/solaris/socksys.c b/arch/sparc64/solaris/socksys.c
--- a/arch/sparc64/solaris/socksys.c
+++ b/arch/sparc64/solaris/socksys.c
@@ -190,8 +190,6 @@ init_socksys(void)
 		return ret;
 	}
 
-	devfs_mk_cdev(MKDEV(30, 0), S_IFCHR|S_IRUSR|S_IWUSR, "socksys");
-
 	file = fcheck(ret);
 	/* N.B. Is this valid? Suppose the f_ops are in a module ... */
 	socksys_file_ops = *file->f_op;
diff --git a/drivers/block/acsi_slm.c b/drivers/block/acsi_slm.c
--- a/drivers/block/acsi_slm.c
+++ b/drivers/block/acsi_slm.c
@@ -1007,10 +1007,6 @@ int slm_init( void )
 	BufferP = SLMBuffer;
 	SLMState = IDLE;
 	
-	for (i = 0; i < MAX_SLM; i++) {
-		devfs_mk_cdev(MKDEV(ACSI_MAJOR, i),
-				S_IFCHR|S_IRUSR|S_IWUSR, "slm/%d", i);
-	}
 	return 0;
 }
 
diff --git a/drivers/block/paride/pg.c b/drivers/block/paride/pg.c
--- a/drivers/block/paride/pg.c
+++ b/drivers/block/paride/pg.c
@@ -673,22 +673,13 @@ static int __init pg_init(void)
 	}
 	for (unit = 0; unit < PG_UNITS; unit++) {
 		struct pg *dev = &devices[unit];
-		if (dev->present) {
+		if (dev->present)
 			class_device_create(pg_class, MKDEV(major, unit),
 					NULL, "pg%u", unit);
-			err = devfs_mk_cdev(MKDEV(major, unit),
-				      S_IFCHR | S_IRUSR | S_IWUSR, "pg/%u",
-				      unit);
-			if (err) 
-				goto out_class;
-		}
 	}
 	err = 0;
 	goto out;
 
-out_class:
-	class_device_destroy(pg_class, MKDEV(major, unit));
-	class_destroy(pg_class);
 out_chrdev:
 	unregister_chrdev(major, "pg");
 out:
diff --git a/drivers/block/paride/pt.c b/drivers/block/paride/pt.c
--- a/drivers/block/paride/pt.c
+++ b/drivers/block/paride/pt.c
@@ -973,27 +973,11 @@ static int __init pt_init(void)
 		if (pt[unit].present) {
 			class_device_create(pt_class, MKDEV(major, unit),
 					NULL, "pt%d", unit);
-			err = devfs_mk_cdev(MKDEV(major, unit),
-				      S_IFCHR | S_IRUSR | S_IWUSR,
-				      "pt/%d", unit);
-			if (err) {
-				class_device_destroy(pt_class, MKDEV(major, unit));
-				goto out_class;
-			}
 			class_device_create(pt_class, MKDEV(major, unit + 128),
 					NULL, "pt%dn", unit);
-			err = devfs_mk_cdev(MKDEV(major, unit + 128),
-				      S_IFCHR | S_IRUSR | S_IWUSR,
-				      "pt/%dn", unit);
-			if (err) {
-				class_device_destroy(pt_class, MKDEV(major, unit + 128));
-				goto out_class;
-			}
 		}
 	goto out;
 
-out_class:
-	class_destroy(pt_class);
 out_chrdev:
 	unregister_chrdev(major, "pt");
 out:
diff --git a/drivers/char/dsp56k.c b/drivers/char/dsp56k.c
--- a/drivers/char/dsp56k.c
+++ b/drivers/char/dsp56k.c
@@ -517,17 +517,9 @@ static int __init dsp56k_init_driver(voi
 	}
 	class_device_create(dsp56k_class, MKDEV(DSP56K_MAJOR, 0), NULL, "dsp56k");
 
-	err = devfs_mk_cdev(MKDEV(DSP56K_MAJOR, 0),
-		      S_IFCHR | S_IRUSR | S_IWUSR, "dsp56k");
-	if(err)
-		goto out_class;
-
 	printk(banner);
 	goto out;
 
-out_class:
-	class_device_destroy(dsp56k_class, MKDEV(DSP56K_MAJOR, 0));
-	class_destroy(dsp56k_class);
 out_chrdev:
 	unregister_chrdev(DSP56K_MAJOR, "dsp56k");
 out:
diff --git a/drivers/char/dtlk.c b/drivers/char/dtlk.c
--- a/drivers/char/dtlk.c
+++ b/drivers/char/dtlk.c
@@ -337,9 +337,6 @@ static int __init dtlk_init(void)
 	if (dtlk_dev_probe() == 0)
 		printk(", MAJOR %d\n", dtlk_major);
 
-	devfs_mk_cdev(MKDEV(dtlk_major, DTLK_MINOR),
-		       S_IFCHR | S_IRUSR | S_IWUSR, "dtlk");
-
 	init_timer(&dtlk_timer);
 	dtlk_timer.function = dtlk_timer_tick;
 	init_waitqueue_head(&dtlk_process_list);
diff --git a/drivers/char/ftape/zftape/zftape-init.c b/drivers/char/ftape/zftape/zftape-init.c
--- a/drivers/char/ftape/zftape/zftape-init.c
+++ b/drivers/char/ftape/zftape/zftape-init.c
@@ -332,29 +332,11 @@ KERN_INFO
 	zft_class = class_create(THIS_MODULE, "zft");
 	for (i = 0; i < 4; i++) {
 		class_device_create(zft_class, MKDEV(QIC117_TAPE_MAJOR, i), NULL, "qft%i", i);
-		devfs_mk_cdev(MKDEV(QIC117_TAPE_MAJOR, i),
-				S_IFCHR | S_IRUSR | S_IWUSR,
-				"qft%i", i);
 		class_device_create(zft_class, MKDEV(QIC117_TAPE_MAJOR, i + 4), NULL, "nqft%i", i);
-		devfs_mk_cdev(MKDEV(QIC117_TAPE_MAJOR, i + 4),
-				S_IFCHR | S_IRUSR | S_IWUSR,
-				"nqft%i", i);
 		class_device_create(zft_class, MKDEV(QIC117_TAPE_MAJOR, i + 16), NULL, "zqft%i", i);
-		devfs_mk_cdev(MKDEV(QIC117_TAPE_MAJOR, i + 16),
-				S_IFCHR | S_IRUSR | S_IWUSR,
-				"zqft%i", i);
 		class_device_create(zft_class, MKDEV(QIC117_TAPE_MAJOR, i + 20), NULL, "nzqft%i", i);
-		devfs_mk_cdev(MKDEV(QIC117_TAPE_MAJOR, i + 20),
-				S_IFCHR | S_IRUSR | S_IWUSR,
-				"nzqft%i", i);
 		class_device_create(zft_class, MKDEV(QIC117_TAPE_MAJOR, i + 32), NULL, "rawqft%i", i);
-		devfs_mk_cdev(MKDEV(QIC117_TAPE_MAJOR, i + 32),
-				S_IFCHR | S_IRUSR | S_IWUSR,
-				"rawqft%i", i);
 		class_device_create(zft_class, MKDEV(QIC117_TAPE_MAJOR, i + 36), NULL, "nrawrawqft%i", i);
-		devfs_mk_cdev(MKDEV(QIC117_TAPE_MAJOR, i + 36),
-				S_IFCHR | S_IRUSR | S_IWUSR,
-				"nrawqft%i", i);
 	}
 
 #ifdef CONFIG_ZFT_COMPRESSOR
diff --git a/drivers/char/ip2main.c b/drivers/char/ip2main.c
--- a/drivers/char/ip2main.c
+++ b/drivers/char/ip2main.c
@@ -724,25 +724,8 @@ ip2_loadmain(int *iop, int *irqp, unsign
 			if ( NULL != ( pB = i2BoardPtrTable[i] ) ) {
 				class_device_create(ip2_class, MKDEV(IP2_IPL_MAJOR,
 						4 * i), NULL, "ipl%d", i);
-				err = devfs_mk_cdev(MKDEV(IP2_IPL_MAJOR, 4 * i),
-						S_IRUSR | S_IWUSR | S_IRGRP | S_IFCHR,
-						"ip2/ipl%d", i);
-				if (err) {
-					class_device_destroy(ip2_class,
-						MKDEV(IP2_IPL_MAJOR, 4 * i));
-					goto out_class;
-				}
-
 				class_device_create(ip2_class, MKDEV(IP2_IPL_MAJOR,
 						4 * i + 1), NULL, "stat%d", i);
-				err = devfs_mk_cdev(MKDEV(IP2_IPL_MAJOR, 4 * i + 1),
-						S_IRUSR | S_IWUSR | S_IRGRP | S_IFCHR,
-						"ip2/stat%d", i);
-				if (err) {
-					class_device_destroy(ip2_class,
-						MKDEV(IP2_IPL_MAJOR, 4 * i + 1));
-					goto out_class;
-				}
 
 			    for ( box = 0; box < ABS_MAX_BOXES; ++box )
 			    {
diff --git a/drivers/char/ipmi/ipmi_devintf.c b/drivers/char/ipmi/ipmi_devintf.c
--- a/drivers/char/ipmi/ipmi_devintf.c
+++ b/drivers/char/ipmi/ipmi_devintf.c
@@ -526,9 +526,6 @@ static void ipmi_new_smi(int if_num)
 {
 	dev_t dev = MKDEV(ipmi_major, if_num);
 
-	devfs_mk_cdev(dev, S_IFCHR | S_IRUSR | S_IWUSR,
-		      "ipmidev/%d", if_num);
-
 	class_device_create(ipmi_class, dev, NULL, "ipmi%d", if_num);
 }
 
diff --git a/drivers/char/istallion.c b/drivers/char/istallion.c
--- a/drivers/char/istallion.c
+++ b/drivers/char/istallion.c
@@ -5242,13 +5242,9 @@ int __init stli_init(void)
 				"device\n");
 
 	istallion_class = class_create(THIS_MODULE, "staliomem");
-	for (i = 0; i < 4; i++) {
-		devfs_mk_cdev(MKDEV(STL_SIOMEMMAJOR, i),
-			       S_IFCHR | S_IRUSR | S_IWUSR,
-			       "staliomem/%d", i);
+	for (i = 0; i < 4; i++)
 		class_device_create(istallion_class, MKDEV(STL_SIOMEMMAJOR, i),
 				NULL, "staliomem%d", i);
-	}
 
 /*
  *	Set up the tty driver structure and register us as a driver.
diff --git a/drivers/char/lp.c b/drivers/char/lp.c
--- a/drivers/char/lp.c
+++ b/drivers/char/lp.c
@@ -806,8 +806,6 @@ static int lp_register(int nr, struct pa
 
 	class_device_create(lp_class, MKDEV(LP_MAJOR, nr), NULL,
 				"lp%d", nr);
-	devfs_mk_cdev(MKDEV(LP_MAJOR, nr), S_IFCHR | S_IRUGO | S_IWUGO,
-			"printers/%d", nr);
 
 	printk(KERN_INFO "lp%d: using %s (%s).\n", nr, port->name, 
 	       (port->irq == PARPORT_IRQ_NONE)?"polling":"interrupt-driven");
diff --git a/drivers/char/mem.c b/drivers/char/mem.c
--- a/drivers/char/mem.c
+++ b/drivers/char/mem.c
@@ -866,13 +866,10 @@ static int __init chr_dev_init(void)
 		printk("unable to get major %d for memory devs\n", MEM_MAJOR);
 
 	mem_class = class_create(THIS_MODULE, "mem");
-	for (i = 0; i < ARRAY_SIZE(devlist); i++) {
+	for (i = 0; i < ARRAY_SIZE(devlist); i++)
 		class_device_create(mem_class, MKDEV(MEM_MAJOR, devlist[i].minor),
 					NULL, devlist[i].name);
-		devfs_mk_cdev(MKDEV(MEM_MAJOR, devlist[i].minor),
-				S_IFCHR | devlist[i].mode, devlist[i].name);
-	}
-	
+
 	return 0;
 }
 
diff --git a/drivers/char/misc.c b/drivers/char/misc.c
--- a/drivers/char/misc.c
+++ b/drivers/char/misc.c
@@ -208,7 +208,7 @@ int misc_register(struct miscdevice * mi
 {
 	struct miscdevice *c;
 	dev_t dev;
-	int err;
+	int err = 0;
 
 	down(&misc_sem);
 	list_for_each_entry(c, &misc_list, list) {
@@ -245,13 +245,6 @@ int misc_register(struct miscdevice * mi
 		goto out;
 	}
 
-	err = devfs_mk_cdev(dev, S_IFCHR|S_IRUSR|S_IWUSR|S_IRGRP, 
-			    misc->devfs_name);
-	if (err) {
-		class_device_destroy(misc_class, dev);
-		goto out;
-	}
-
 	/*
 	 * Add it to the front, so that later devices can "override"
 	 * earlier defaults
diff --git a/drivers/char/ppdev.c b/drivers/char/ppdev.c
--- a/drivers/char/ppdev.c
+++ b/drivers/char/ppdev.c
@@ -781,10 +781,6 @@ static int __init ppdev_init (void)
 		err = PTR_ERR(ppdev_class);
 		goto out_chrdev;
 	}
-	for (i = 0; i < PARPORT_MAX; i++) {
-		devfs_mk_cdev(MKDEV(PP_MAJOR, i),
-				S_IFCHR | S_IRUGO | S_IWUGO, "parports/%d", i);
-	}
 	if (parport_register_driver(&pp_driver)) {
 		printk (KERN_WARNING CHRDEV ": unable to register with parport\n");
 		goto out_class;
diff --git a/drivers/char/raw.c b/drivers/char/raw.c
--- a/drivers/char/raw.c
+++ b/drivers/char/raw.c
@@ -287,7 +287,6 @@ static struct cdev raw_cdev = {
 
 static int __init raw_init(void)
 {
-	int i;
 	dev_t dev = MKDEV(RAW_MAJOR, 0);
 
 	if (register_chrdev_region(dev, MAX_RAW_MINORS, "raw"))
@@ -309,13 +308,6 @@ static int __init raw_init(void)
 	}
 	class_device_create(raw_class, MKDEV(RAW_MAJOR, 0), NULL, "rawctl");
 
-	devfs_mk_cdev(MKDEV(RAW_MAJOR, 0),
-		      S_IFCHR | S_IRUGO | S_IWUGO,
-		      "raw/rawctl");
-	for (i = 1; i < MAX_RAW_MINORS; i++)
-		devfs_mk_cdev(MKDEV(RAW_MAJOR, i),
-			      S_IFCHR | S_IRUGO | S_IWUGO,
-			      "raw/raw%d", i);
 	return 0;
 
 error:
diff --git a/drivers/char/stallion.c b/drivers/char/stallion.c
--- a/drivers/char/stallion.c
+++ b/drivers/char/stallion.c
@@ -3090,12 +3090,8 @@ static int __init stl_init(void)
 		printk("STALLION: failed to register serial board device\n");
 
 	stallion_class = class_create(THIS_MODULE, "staliomem");
-	for (i = 0; i < 4; i++) {
-		devfs_mk_cdev(MKDEV(STL_SIOMEMMAJOR, i),
-				S_IFCHR|S_IRUSR|S_IWUSR,
-				"staliomem/%d", i);
+	for (i = 0; i < 4; i++)
 		class_device_create(stallion_class, MKDEV(STL_SIOMEMMAJOR, i), NULL, "staliomem%d", i);
-	}
 
 	stl_serial->owner = THIS_MODULE;
 	stl_serial->driver_name = stl_drvname;
diff --git a/drivers/char/tipar.c b/drivers/char/tipar.c
--- a/drivers/char/tipar.c
+++ b/drivers/char/tipar.c
@@ -438,12 +438,6 @@ tipar_register(int nr, struct parport *p
 
 	class_device_create(tipar_class, MKDEV(TIPAR_MAJOR,
 			TIPAR_MINOR + nr), NULL, "par%d", nr);
-	/* Use devfs, tree: /dev/ticables/par/[0..2] */
-	err = devfs_mk_cdev(MKDEV(TIPAR_MAJOR, TIPAR_MINOR + nr),
-			S_IFCHR | S_IRUGO | S_IWUGO,
-			"ticables/par/%d", nr);
-	if (err)
-		goto out_class;
 
 	/* Display informations */
 	pr_info("tipar%d: using %s (%s)\n", nr, port->name, (port->irq ==
@@ -455,11 +449,7 @@ tipar_register(int nr, struct parport *p
 		pr_info("tipar%d: link cable not found\n", nr);
 
 	err = 0;
-	goto out;
 
-out_class:
-	class_device_destroy(tipar_class, MKDEV(TIPAR_MAJOR, TIPAR_MINOR + nr));
-	class_destroy(tipar_class);
 out:
 	return err;
 }
diff --git a/drivers/char/tty_io.c b/drivers/char/tty_io.c
--- a/drivers/char/tty_io.c
+++ b/drivers/char/tty_io.c
@@ -2680,9 +2680,6 @@ void tty_register_device(struct tty_driv
 		return;
 	}
 
-	devfs_mk_cdev(dev, S_IFCHR | S_IRUSR | S_IWUSR,
-			"%s%d", driver->devfs_name, index + driver->name_base);
-
 	if (driver->type == TTY_DRIVER_TYPE_PTY)
 		pty_line_name(driver, index, name);
 	else
@@ -2946,14 +2943,12 @@ static int __init tty_init(void)
 	if (cdev_add(&tty_cdev, MKDEV(TTYAUX_MAJOR, 0), 1) ||
 	    register_chrdev_region(MKDEV(TTYAUX_MAJOR, 0), 1, "/dev/tty") < 0)
 		panic("Couldn't register /dev/tty driver\n");
-	devfs_mk_cdev(MKDEV(TTYAUX_MAJOR, 0), S_IFCHR|S_IRUGO|S_IWUGO, "tty");
 	class_device_create(tty_class, MKDEV(TTYAUX_MAJOR, 0), NULL, "tty");
 
 	cdev_init(&console_cdev, &console_fops);
 	if (cdev_add(&console_cdev, MKDEV(TTYAUX_MAJOR, 1), 1) ||
 	    register_chrdev_region(MKDEV(TTYAUX_MAJOR, 1), 1, "/dev/console") < 0)
 		panic("Couldn't register /dev/console driver\n");
-	devfs_mk_cdev(MKDEV(TTYAUX_MAJOR, 1), S_IFCHR|S_IRUSR|S_IWUSR, "console");
 	class_device_create(tty_class, MKDEV(TTYAUX_MAJOR, 1), NULL, "console");
 
 #ifdef CONFIG_UNIX98_PTYS
@@ -2961,7 +2956,6 @@ static int __init tty_init(void)
 	if (cdev_add(&ptmx_cdev, MKDEV(TTYAUX_MAJOR, 2), 1) ||
 	    register_chrdev_region(MKDEV(TTYAUX_MAJOR, 2), 1, "/dev/ptmx") < 0)
 		panic("Couldn't register /dev/ptmx driver\n");
-	devfs_mk_cdev(MKDEV(TTYAUX_MAJOR, 2), S_IFCHR|S_IRUGO|S_IWUGO, "ptmx");
 	class_device_create(tty_class, MKDEV(TTYAUX_MAJOR, 2), NULL, "ptmx");
 #endif
 
@@ -2970,7 +2964,6 @@ static int __init tty_init(void)
 	if (cdev_add(&vc0_cdev, MKDEV(TTY_MAJOR, 0), 1) ||
 	    register_chrdev_region(MKDEV(TTY_MAJOR, 0), 1, "/dev/vc/0") < 0)
 		panic("Couldn't register /dev/tty0 driver\n");
-	devfs_mk_cdev(MKDEV(TTY_MAJOR, 0), S_IFCHR|S_IRUSR|S_IWUSR, "vc/0");
 	class_device_create(tty_class, MKDEV(TTY_MAJOR, 0), NULL, "tty0");
 
 	vty_init();
diff --git a/drivers/char/vc_screen.c b/drivers/char/vc_screen.c
--- a/drivers/char/vc_screen.c
+++ b/drivers/char/vc_screen.c
@@ -478,12 +478,6 @@ static struct class *vc_class;
 
 void vcs_make_devfs(struct tty_struct *tty)
 {
-	devfs_mk_cdev(MKDEV(VCS_MAJOR, tty->index + 1),
-			S_IFCHR|S_IRUSR|S_IWUSR,
-			"vcc/%u", tty->index + 1);
-	devfs_mk_cdev(MKDEV(VCS_MAJOR, tty->index + 129),
-			S_IFCHR|S_IRUSR|S_IWUSR,
-			"vcc/a%u", tty->index + 1);
 	class_device_create(vc_class, MKDEV(VCS_MAJOR, tty->index + 1), NULL, "vcs%u", tty->index + 1);
 	class_device_create(vc_class, MKDEV(VCS_MAJOR, tty->index + 129), NULL, "vcsa%u", tty->index + 1);
 }
@@ -501,8 +495,6 @@ int __init vcs_init(void)
 		panic("unable to get major %d for vcs device", VCS_MAJOR);
 	vc_class = class_create(THIS_MODULE, "vc");
 
-	devfs_mk_cdev(MKDEV(VCS_MAJOR, 0), S_IFCHR|S_IRUSR|S_IWUSR, "vcc/0");
-	devfs_mk_cdev(MKDEV(VCS_MAJOR, 128), S_IFCHR|S_IRUSR|S_IWUSR, "vcc/a0");
 	class_device_create(vc_class, MKDEV(VCS_MAJOR, 0), NULL, "vcs");
 	class_device_create(vc_class, MKDEV(VCS_MAJOR, 128), NULL, "vcsa");
 	return 0;
diff --git a/drivers/char/viotape.c b/drivers/char/viotape.c
--- a/drivers/char/viotape.c
+++ b/drivers/char/viotape.c
@@ -959,10 +959,6 @@ static int viotape_probe(struct vio_dev 
 			"iseries!vt%d", i);
 	class_device_create(tape_class, MKDEV(VIOTAPE_MAJOR, i | 0x80),
 			NULL, "iseries!nvt%d", i);
-	devfs_mk_cdev(MKDEV(VIOTAPE_MAJOR, i), S_IFCHR | S_IRUSR | S_IWUSR,
-			"iseries/vt%d", i);
-	devfs_mk_cdev(MKDEV(VIOTAPE_MAJOR, i | 0x80),
-			S_IFCHR | S_IRUSR | S_IWUSR, "iseries/nvt%d", i);
 	sprintf(tapename, "iseries/vt%d", i);
 	printk(VIOTAPE_KERN_INFO "tape %s is iSeries "
 			"resource %10.10s type %4.4s, model %3.3s\n",
diff --git a/drivers/i2c/i2c-dev.c b/drivers/i2c/i2c-dev.c
--- a/drivers/i2c/i2c-dev.c
+++ b/drivers/i2c/i2c-dev.c
@@ -433,8 +433,6 @@ static int i2cdev_attach_adapter(struct 
 	if (IS_ERR(i2c_dev))
 		return PTR_ERR(i2c_dev);
 
-	devfs_mk_cdev(MKDEV(I2C_MAJOR, i2c_dev->minor),
-			S_IFCHR|S_IRUSR|S_IWUSR, "i2c/%d", i2c_dev->minor);
 	dev_dbg(&adap->dev, "Registered as minor %d\n", i2c_dev->minor);
 
 	/* register this i2c device with the driver core */
diff --git a/drivers/ide/ide-tape.c b/drivers/ide/ide-tape.c
--- a/drivers/ide/ide-tape.c
+++ b/drivers/ide/ide-tape.c
@@ -4878,13 +4878,6 @@ static int ide_tape_probe(struct device 
 
 	idetape_setup(drive, tape, minor);
 
-	devfs_mk_cdev(MKDEV(HWIF(drive)->major, minor),
-			S_IFCHR | S_IRUGO | S_IWUGO,
-			"%s/mt", drive->devfs_name);
-	devfs_mk_cdev(MKDEV(HWIF(drive)->major, minor + 128),
-			S_IFCHR | S_IRUGO | S_IWUGO,
-			"%s/mtn", drive->devfs_name);
-
 	g->number = -1;
 	g->fops = &idetape_block_ops;
 	ide_register_region(g);
diff --git a/drivers/ieee1394/amdtp.c b/drivers/ieee1394/amdtp.c
--- a/drivers/ieee1394/amdtp.c
+++ b/drivers/ieee1394/amdtp.c
@@ -1238,9 +1238,6 @@ static void amdtp_add_host(struct hpsb_h
 
 	INIT_LIST_HEAD(&ah->stream_list);
 	spin_lock_init(&ah->stream_list_lock);
-
-	devfs_mk_cdev(MKDEV(IEEE1394_MAJOR, minor),
-			S_IFCHR|S_IRUSR|S_IWUSR, "amdtp/%d", ah->host->id);
 }
 
 static void amdtp_remove_host(struct hpsb_host *host)
diff --git a/drivers/ieee1394/dv1394.c b/drivers/ieee1394/dv1394.c
--- a/drivers/ieee1394/dv1394.c
+++ b/drivers/ieee1394/dv1394.c
@@ -2278,21 +2278,9 @@ static int dv1394_init(struct ti_ohci *o
 	list_add_tail(&video->list, &dv1394_cards);
 	spin_unlock_irqrestore(&dv1394_cards_lock, flags);
 
-	if (devfs_mk_cdev(MKDEV(IEEE1394_MAJOR,
-				IEEE1394_MINOR_BLOCK_DV1394*16 + video->id),
-			S_IFCHR|S_IRUGO|S_IWUGO,
-			 "ieee1394/dv/host%d/%s/%s",
-			 (video->id>>2),
-			 (video->pal_or_ntsc == DV1394_NTSC ? "NTSC" : "PAL"),
-			 (video->mode == MODE_RECEIVE ? "in" : "out")) < 0)
-			goto err_free;
-
 	debug_printk("dv1394: dv1394_init() OK on ID %d\n", video->id);
 
 	return 0;
-
- err_free:
-	kfree(video);
  err:
 	return -1;
 }
diff --git a/drivers/ieee1394/raw1394.c b/drivers/ieee1394/raw1394.c
--- a/drivers/ieee1394/raw1394.c
+++ b/drivers/ieee1394/raw1394.c
@@ -2907,10 +2907,6 @@ static int __init init_raw1394(void)
 		ret = -EFAULT;
 		goto out_unreg;
 	}
-	
-	devfs_mk_cdev(MKDEV(
-		IEEE1394_MAJOR, IEEE1394_MINOR_BLOCK_RAW1394 * 16),
-		S_IFCHR | S_IRUSR | S_IWUSR, RAW1394_DEVICE_NAME);
 
 	cdev_init(&raw1394_cdev, &raw1394_fops);
 	raw1394_cdev.owner = THIS_MODULE;
diff --git a/drivers/ieee1394/video1394.c b/drivers/ieee1394/video1394.c
--- a/drivers/ieee1394/video1394.c
+++ b/drivers/ieee1394/video1394.c
@@ -1373,9 +1373,6 @@ static void video1394_add_host (struct h
 	class_device_create(hpsb_protocol_class, MKDEV(
 		IEEE1394_MAJOR,	minor), 
 		NULL, "%s-%d", VIDEO1394_DRIVER_NAME, ohci->host->id);
-	devfs_mk_cdev(MKDEV(IEEE1394_MAJOR, minor),
-		       S_IFCHR | S_IRUSR | S_IWUSR,
-		       "%s/%d", VIDEO1394_DRIVER_NAME, ohci->host->id);
 }
 
 
diff --git a/drivers/input/evdev.c b/drivers/input/evdev.c
--- a/drivers/input/evdev.c
+++ b/drivers/input/evdev.c
@@ -429,8 +429,6 @@ static struct input_handle *evdev_connec
 
 	evdev_table[minor] = evdev;
 
-	devfs_mk_cdev(MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + minor),
-			S_IFCHR|S_IRUGO|S_IWUSR, "input/event%d", minor);
 	class_device_create(input_class,
 			MKDEV(INPUT_MAJOR, EVDEV_MINOR_BASE + minor),
 			dev->dev, "event%d", minor);
diff --git a/drivers/input/joydev.c b/drivers/input/joydev.c
--- a/drivers/input/joydev.c
+++ b/drivers/input/joydev.c
@@ -450,8 +450,6 @@ static struct input_handle *joydev_conne
 
 	joydev_table[minor] = joydev;
 
-	devfs_mk_cdev(MKDEV(INPUT_MAJOR, JOYDEV_MINOR_BASE + minor),
-			S_IFCHR|S_IRUGO|S_IWUSR, "input/js%d", minor);
 	class_device_create(input_class,
 			MKDEV(INPUT_MAJOR, JOYDEV_MINOR_BASE + minor),
 			dev->dev, "js%d", minor);
diff --git a/drivers/input/mousedev.c b/drivers/input/mousedev.c
--- a/drivers/input/mousedev.c
+++ b/drivers/input/mousedev.c
@@ -645,8 +645,6 @@ static struct input_handle *mousedev_con
 
 	mousedev_table[minor] = mousedev;
 
-	devfs_mk_cdev(MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + minor),
-			S_IFCHR|S_IRUGO|S_IWUSR, "input/mouse%d", minor);
 	class_device_create(input_class,
 			MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + minor),
 			dev->dev, "mouse%d", minor);
@@ -734,8 +732,6 @@ static int __init mousedev_init(void)
 	mousedev_mix.exist = 1;
 	mousedev_mix.minor = MOUSEDEV_MIX;
 
-	devfs_mk_cdev(MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + MOUSEDEV_MIX),
-			S_IFCHR|S_IRUGO|S_IWUSR, "input/mice");
 	class_device_create(input_class,
 			MKDEV(INPUT_MAJOR, MOUSEDEV_MINOR_BASE + MOUSEDEV_MIX), NULL, "mice");
 
diff --git a/drivers/input/tsdev.c b/drivers/input/tsdev.c
--- a/drivers/input/tsdev.c
+++ b/drivers/input/tsdev.c
@@ -410,10 +410,6 @@ static struct input_handle *tsdev_connec
 
 	tsdev_table[minor] = tsdev;
 
-	devfs_mk_cdev(MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + minor),
-			S_IFCHR|S_IRUGO|S_IWUSR, "input/ts%d", minor);
-	devfs_mk_cdev(MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + minor + TSDEV_MINORS/2),
-			S_IFCHR|S_IRUGO|S_IWUSR, "input/tsraw%d", minor);
 	class_device_create(input_class,
 			MKDEV(INPUT_MAJOR, TSDEV_MINOR_BASE + minor),
 			dev->dev, "ts%d", minor);
diff --git a/drivers/isdn/capi/capi.c b/drivers/isdn/capi/capi.c
--- a/drivers/isdn/capi/capi.c
+++ b/drivers/isdn/capi/capi.c
@@ -1506,8 +1506,6 @@ static int __init capi_init(void)
 	}
 
 	class_device_create(capi_class, MKDEV(capi_major, 0), NULL, "capi");
-	devfs_mk_cdev(MKDEV(capi_major, 0), S_IFCHR | S_IRUSR | S_IWUSR,
-			"isdn/capi20");
 
 #ifdef CONFIG_ISDN_CAPI_MIDDLEWARE
 	if (capinc_tty_init() < 0) {
diff --git a/drivers/isdn/hardware/eicon/divamnt.c b/drivers/isdn/hardware/eicon/divamnt.c
--- a/drivers/isdn/hardware/eicon/divamnt.c
+++ b/drivers/isdn/hardware/eicon/divamnt.c
@@ -190,7 +190,6 @@ static int DIVA_INIT_FUNCTION divas_main
 		       DRIVERLNAME);
 		return (0);
 	}
-	devfs_mk_cdev(MKDEV(major, 0), S_IFCHR|S_IRUSR|S_IWUSR, DEVNAME);
 
 	return (1);
 }
diff --git a/drivers/isdn/hardware/eicon/divasi.c b/drivers/isdn/hardware/eicon/divasi.c
--- a/drivers/isdn/hardware/eicon/divasi.c
+++ b/drivers/isdn/hardware/eicon/divasi.c
@@ -157,7 +157,6 @@ static int DIVA_INIT_FUNCTION divas_idi_
 		       DRIVERLNAME);
 		return (0);
 	}
-	devfs_mk_cdev(MKDEV(major, 0), S_IFCHR|S_IRUSR|S_IWUSR, DEVNAME);
 
 	return (1);
 }
diff --git a/drivers/isdn/hardware/eicon/divasmain.c b/drivers/isdn/hardware/eicon/divasmain.c
--- a/drivers/isdn/hardware/eicon/divasmain.c
+++ b/drivers/isdn/hardware/eicon/divasmain.c
@@ -690,7 +690,6 @@ static int DIVA_INIT_FUNCTION divas_regi
 		       DRIVERLNAME);
 		return (0);
 	}
-	devfs_mk_cdev(MKDEV(major, 0), S_IFCHR|S_IRUSR|S_IWUSR, DEVNAME);
 
 	return (1);
 }
diff --git a/drivers/macintosh/adb.c b/drivers/macintosh/adb.c
--- a/drivers/macintosh/adb.c
+++ b/drivers/macintosh/adb.c
@@ -900,8 +900,6 @@ adbdev_init(void)
 		return;
 	}
 
-	devfs_mk_cdev(MKDEV(ADB_MAJOR, 0), S_IFCHR | S_IRUSR | S_IWUSR, "adb");
-
 	adb_dev_class = class_create(THIS_MODULE, "adb");
 	if (IS_ERR(adb_dev_class))
 		return;
diff --git a/drivers/media/dvb/dvb-core/dvbdev.c b/drivers/media/dvb/dvb-core/dvbdev.c
--- a/drivers/media/dvb/dvb-core/dvbdev.c
+++ b/drivers/media/dvb/dvb-core/dvbdev.c
@@ -231,10 +231,6 @@ int dvb_register_device(struct dvb_adapt
 
 	list_add_tail (&dvbdev->list_head, &adap->device_list);
 
-	devfs_mk_cdev(MKDEV(DVB_MAJOR, nums2minor(adap->num, type, id)),
-			S_IFCHR | S_IRUSR | S_IWUSR,
-			"dvb/adapter%d/%s%d", adap->num, dnames[type], id);
-
 	class_device_create(dvb_class, MKDEV(DVB_MAJOR, nums2minor(adap->num, type, id)),
 			    NULL, "dvb%d.%s%d", adap->num, dnames[type], id);
 
diff --git a/drivers/media/video/videodev.c b/drivers/media/video/videodev.c
--- a/drivers/media/video/videodev.c
+++ b/drivers/media/video/videodev.c
@@ -329,9 +329,6 @@ int video_register_device(struct video_d
 	vfd->minor=i;
 	up(&videodev_lock);
 
-	sprintf(vfd->devfs_name, "v4l/%s%d", name_base, i - base);
-	devfs_mk_cdev(MKDEV(VIDEO_MAJOR, vfd->minor),
-			S_IFCHR | S_IRUSR | S_IWUSR, vfd->devfs_name);
 	init_MUTEX(&vfd->lock);
 
 	/* sysfs class */
@@ -340,7 +337,8 @@ int video_register_device(struct video_d
 		vfd->class_dev.dev = vfd->dev;
 	vfd->class_dev.class       = &video_class;
 	vfd->class_dev.devt       = MKDEV(VIDEO_MAJOR, vfd->minor);
-	strlcpy(vfd->class_dev.class_id, vfd->devfs_name + 4, BUS_ID_SIZE);
+	sprintf(vfd->devfs_name, "%s%d", name_base, i - base);
+	strlcpy(vfd->class_dev.class_id, vfd->devfs_name, BUS_ID_SIZE);
 	class_device_register(&vfd->class_dev);
 	class_device_create_file(&vfd->class_dev,
 				 &class_device_attr_name);
diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
--- a/drivers/mtd/mtdchar.c
+++ b/drivers/mtd/mtdchar.c
@@ -15,48 +15,6 @@
 #include <linux/fs.h>
 #include <asm/uaccess.h>
 
-#ifdef CONFIG_DEVFS_FS
-#include <linux/devfs_fs_kernel.h>
-
-static void mtd_notify_add(struct mtd_info* mtd)
-{
-	if (!mtd)
-		return;
-
-	devfs_mk_cdev(MKDEV(MTD_CHAR_MAJOR, mtd->index*2),
-		      S_IFCHR | S_IRUGO | S_IWUGO, "mtd/%d", mtd->index);
-		
-	devfs_mk_cdev(MKDEV(MTD_CHAR_MAJOR, mtd->index*2+1),
-		      S_IFCHR | S_IRUGO, "mtd/%dro", mtd->index);
-}
-
-static void mtd_notify_remove(struct mtd_info* mtd)
-{
-	if (!mtd)
-		return;
-	devfs_remove("mtd/%d", mtd->index);
-	devfs_remove("mtd/%dro", mtd->index);
-}
-
-static struct mtd_notifier notifier = {
-	.add	= mtd_notify_add,
-	.remove	= mtd_notify_remove,
-};
-
-static inline void mtdchar_devfs_init(void)
-{
-	register_mtd_user(&notifier);
-}
-
-static inline void mtdchar_devfs_exit(void)
-{
-	unregister_mtd_user(&notifier);
-	devfs_remove("mtd");
-}
-#else /* !DEVFS */
-#define mtdchar_devfs_init() do { } while(0)
-#define mtdchar_devfs_exit() do { } while(0)
-#endif
 
 static loff_t mtd_lseek (struct file *file, loff_t offset, int orig)
 {
@@ -542,13 +500,11 @@ static int __init init_mtdchar(void)
 		return -EAGAIN;
 	}
 
-	mtdchar_devfs_init();
 	return 0;
 }
 
 static void __exit cleanup_mtdchar(void)
 {
-	mtdchar_devfs_exit();
 	unregister_chrdev(MTD_CHAR_MAJOR, "mtd");
 }
 
diff --git a/drivers/net/ppp_generic.c b/drivers/net/ppp_generic.c
--- a/drivers/net/ppp_generic.c
+++ b/drivers/net/ppp_generic.c
@@ -864,10 +864,6 @@ static int __init ppp_init(void)
 			goto out_chrdev;
 		}
 		class_device_create(ppp_class, MKDEV(PPP_MAJOR, 0), NULL, "ppp");
-		err = devfs_mk_cdev(MKDEV(PPP_MAJOR, 0),
-				S_IFCHR|S_IRUSR|S_IWUSR, "ppp");
-		if (err)
-			goto out_class;
 	}
 
 out:
@@ -875,9 +871,6 @@ out:
 		printk(KERN_ERR "failed to register PPP device (%d)\n", err);
 	return err;
 
-out_class:
-	class_device_destroy(ppp_class, MKDEV(PPP_MAJOR,0));
-	class_destroy(ppp_class);
 out_chrdev:
 	unregister_chrdev(PPP_MAJOR, "ppp");
 	goto out;
diff --git a/drivers/net/wan/cosa.c b/drivers/net/wan/cosa.c
--- a/drivers/net/wan/cosa.c
+++ b/drivers/net/wan/cosa.c
@@ -401,13 +401,6 @@ static int __init cosa_init(void)
 	for (i=0; i<nr_cards; i++) {
 		class_device_create(cosa_class, MKDEV(cosa_major, i),
 				NULL, "cosa%d", i);
-		err = devfs_mk_cdev(MKDEV(cosa_major, i),
-				S_IFCHR|S_IRUSR|S_IWUSR,
-				"cosa/%d", i);
-		if (err) {
-			class_device_destroy(cosa_class, MKDEV(cosa_major, i));
-			goto out_chrdev;		
-		}
 	}
 	err = 0;
 	goto out;
diff --git a/drivers/sbus/char/bpp.c b/drivers/sbus/char/bpp.c
--- a/drivers/sbus/char/bpp.c
+++ b/drivers/sbus/char/bpp.c
@@ -1048,10 +1048,6 @@ static int __init bpp_init(void)
 		instances[idx].opened = 0;
 		probeLptPort(idx);
 	}
-	for (idx = 0; idx < BPP_NO; idx++) {
-		devfs_mk_cdev(MKDEV(BPP_MAJOR, idx),
-				S_IFCHR | S_IRUSR | S_IWUSR, "bpp/%d", idx);
-	}
 
 	return 0;
 }
diff --git a/drivers/sbus/char/vfc_dev.c b/drivers/sbus/char/vfc_dev.c
--- a/drivers/sbus/char/vfc_dev.c
+++ b/drivers/sbus/char/vfc_dev.c
@@ -165,10 +165,6 @@ int init_vfc_device(struct sbus_dev *sde
 		return -EINVAL;
 	if (init_vfc_hw(dev))
 		return -EIO;
-
-	devfs_mk_cdev(MKDEV(VFC_MAJOR, instance),
-			S_IFCHR | S_IRUSR | S_IWUSR,
-			"vfc/%d", instance);
 	return 0;
 }
 
diff --git a/drivers/scsi/ch.c b/drivers/scsi/ch.c
--- a/drivers/scsi/ch.c
+++ b/drivers/scsi/ch.c
@@ -940,8 +940,6 @@ static int ch_probe(struct device *dev)
 	if (init)
 		ch_init_elem(ch);
 
-	devfs_mk_cdev(MKDEV(SCSI_CHANGER_MAJOR,ch->minor),
-		      S_IFCHR | S_IRUGO | S_IWUGO, ch->name);
 	class_device_create(ch_sysfs_class,
 			    MKDEV(SCSI_CHANGER_MAJOR,ch->minor),
 			    dev, "s%s", ch->name);
diff --git a/drivers/scsi/osst.c b/drivers/scsi/osst.c
--- a/drivers/scsi/osst.c
+++ b/drivers/scsi/osst.c
@@ -5668,7 +5668,7 @@ static int osst_probe(struct device *dev
 	struct st_partstat * STps;
 	struct osst_buffer * buffer;
 	struct gendisk	   * drive;
-	int		     i, mode, dev_num;
+	int		     i, dev_num;
 
 	if (SDp->type != TYPE_TAPE || !osst_supports(SDp))
 		return -ENODEV;
@@ -5804,17 +5804,6 @@ static int osst_probe(struct device *dev
 		snprintf(name, 8, "%s%s", "n", tape_name(tpnt));
 		osst_sysfs_add(MKDEV(OSST_MAJOR, dev_num + 128), dev, tpnt, name);
 	}
-	for (mode = 0; mode < ST_NBR_MODES; ++mode) {
-		/*  Rewind entry  */
-		devfs_mk_cdev(MKDEV(OSST_MAJOR, dev_num + (mode << 5)),
-				S_IFCHR | S_IRUGO | S_IWUGO,
-				"%s/ot%s", SDp->devfs_name, osst_formats[mode]);
-
-		/*  No-rewind entry  */
-		devfs_mk_cdev(MKDEV(OSST_MAJOR, dev_num + (mode << 5) + 128),
-				S_IFCHR | S_IRUGO | S_IWUGO,
-				"%s/ot%sn", SDp->devfs_name, osst_formats[mode]);
-	}
 	drive->number = -1;
 
 	printk(KERN_INFO
diff --git a/drivers/scsi/sg.c b/drivers/scsi/sg.c
--- a/drivers/scsi/sg.c
+++ b/drivers/scsi/sg.c
@@ -1539,9 +1539,6 @@ sg_add(struct class_device *cl_dev)
 	k = error;
 	sdp = sg_dev_arr[k];
 
-	devfs_mk_cdev(MKDEV(SCSI_GENERIC_MAJOR, k),
-			S_IFCHR | S_IRUSR | S_IWUSR | S_IRGRP,
-			"%s/generic", scsidp->devfs_name);
 	error = cdev_add(cdev, MKDEV(SCSI_GENERIC_MAJOR, k), 1);
 	if (error) {
 		devfs_remove("%s/generic", scsidp->devfs_name);
diff --git a/drivers/scsi/st.c b/drivers/scsi/st.c
--- a/drivers/scsi/st.c
+++ b/drivers/scsi/st.c
@@ -3991,19 +3991,6 @@ static int st_probe(struct device *dev)
 		do_create_class_files(tpnt, dev_num, mode);
 	}
 
-	for (mode = 0; mode < ST_NBR_MODES; ++mode) {
-		/* Make sure that the minor numbers corresponding to the four
-		   first modes always get the same names */
-		i = mode << (4 - ST_NBR_MODE_BITS);
-		/*  Rewind entry  */
-		devfs_mk_cdev(MKDEV(SCSI_TAPE_MAJOR, TAPE_MINOR(dev_num, mode, 0)),
-			      S_IFCHR | S_IRUGO | S_IWUGO,
-			      "%s/mt%s", SDp->devfs_name, st_formats[i]);
-		/*  No-rewind entry  */
-		devfs_mk_cdev(MKDEV(SCSI_TAPE_MAJOR, TAPE_MINOR(dev_num, mode, 1)),
-			      S_IFCHR | S_IRUGO | S_IWUGO,
-			      "%s/mt%sn", SDp->devfs_name, st_formats[i]);
-	}
 	disk->number = -1;
 
 	printk(KERN_WARNING
diff --git a/drivers/telephony/phonedev.c b/drivers/telephony/phonedev.c
--- a/drivers/telephony/phonedev.c
+++ b/drivers/telephony/phonedev.c
@@ -105,8 +105,6 @@ int phone_register_device(struct phone_d
 		if (phone_device[i] == NULL) {
 			phone_device[i] = p;
 			p->minor = i;
-			devfs_mk_cdev(MKDEV(PHONE_MAJOR,i),
-				S_IFCHR|S_IRUSR|S_IWUSR, "phone/%d", i);
 			up(&phone_lock);
 			return 0;
 		}
diff --git a/drivers/usb/core/file.c b/drivers/usb/core/file.c
--- a/drivers/usb/core/file.c
+++ b/drivers/usb/core/file.c
@@ -162,7 +162,6 @@ int usb_register_dev(struct usb_interfac
 
 	/* handle the devfs registration */
 	snprintf(name, BUS_ID_SIZE, class_driver->name, minor - minor_base);
-	devfs_mk_cdev(MKDEV(USB_MAJOR, minor), class_driver->mode, name);
 
 	/* create a usb class device for this usb interface */
 	temp = strrchr(name, '/');
diff --git a/drivers/video/fbmem.c b/drivers/video/fbmem.c
--- a/drivers/video/fbmem.c
+++ b/drivers/video/fbmem.c
@@ -1099,8 +1099,6 @@ register_framebuffer(struct fb_info *fb_
 
 	registered_fb[i] = fb_info;
 
-	devfs_mk_cdev(MKDEV(FB_MAJOR, i),
-			S_IFCHR | S_IRUGO | S_IWUGO, "fb/%d", i);
 	event.info = fb_info;
 	notifier_call_chain(&fb_notifier_list,
 			    FB_EVENT_FB_REGISTERED, &event);
diff --git a/fs/coda/psdev.c b/fs/coda/psdev.c
--- a/fs/coda/psdev.c
+++ b/fs/coda/psdev.c
@@ -368,21 +368,12 @@ static int init_coda_psdev(void)
 		err = PTR_ERR(coda_psdev_class);
 		goto out_chrdev;
 	}		
-	for (i = 0; i < MAX_CODADEVS; i++) {
+	for (i = 0; i < MAX_CODADEVS; i++)
 		class_device_create(coda_psdev_class, MKDEV(CODA_PSDEV_MAJOR,i),
 				NULL, "cfs%d", i);
-		err = devfs_mk_cdev(MKDEV(CODA_PSDEV_MAJOR, i),
-				S_IFCHR|S_IRUSR|S_IWUSR, "coda/%d", i);
-		if (err)
-			goto out_class;
-	}
 	coda_sysctl_init();
 	goto out;
 
-out_class:
-	for (i = 0; i < MAX_CODADEVS; i++) 
-		class_device_destroy(coda_psdev_class, MKDEV(CODA_PSDEV_MAJOR, i));
-	class_destroy(coda_psdev_class);
 out_chrdev:
 	unregister_chrdev(CODA_PSDEV_MAJOR, "coda");
 out:
diff --git a/include/linux/devfs_fs_kernel.h b/include/linux/devfs_fs_kernel.h
--- a/include/linux/devfs_fs_kernel.h
+++ b/include/linux/devfs_fs_kernel.h
@@ -7,10 +7,6 @@
 #include <linux/types.h>
 #include <asm/semaphore.h>
 
-static inline int devfs_mk_cdev(dev_t dev, umode_t mode, const char *fmt, ...)
-{
-	return 0;
-}
 static inline void devfs_remove(const char *fmt, ...)
 {
 }
diff --git a/sound/core/sound.c b/sound/core/sound.c
--- a/sound/core/sound.c
+++ b/sound/core/sound.c
@@ -39,7 +39,6 @@
 static int major = CONFIG_SND_MAJOR;
 int snd_major;
 static int cards_limit = 1;
-static int device_mode = S_IFCHR | S_IRUGO | S_IWUGO;
 
 MODULE_AUTHOR("Jaroslav Kysela <perex@suse.cz>");
 MODULE_DESCRIPTION("Advanced Linux Sound Architecture driver for soundcards.");
@@ -48,10 +47,6 @@ module_param(major, int, 0444);
 MODULE_PARM_DESC(major, "Major # for sound driver.");
 module_param(cards_limit, int, 0444);
 MODULE_PARM_DESC(cards_limit, "Count of auto-loadable soundcards.");
-#ifdef CONFIG_DEVFS_FS
-module_param(device_mode, int, 0444);
-MODULE_PARM_DESC(device_mode, "Device file permission mask for devfs.");
-#endif
 MODULE_ALIAS_CHARDEV_MAJOR(CONFIG_SND_MAJOR);
 
 /* this one holds the actual max. card number currently available.
@@ -227,8 +222,6 @@ int snd_register_device(int type, snd_ca
 		return -EBUSY;
 	}
 	list_add_tail(&preg->list, &snd_minors_hash[SNDRV_MINOR_CARD(minor)]);
-	if (strncmp(name, "controlC", 8) || card->number >= cards_limit)
-		devfs_mk_cdev(MKDEV(major, minor), S_IFCHR | device_mode, "snd/%s", name);
 	if (card)
 		device = card->dev;
 	class_device_create(sound_class, MKDEV(major, minor), device, "%s", name);
@@ -330,7 +323,6 @@ int __exit snd_minor_info_done(void)
 
 static int __init alsa_sound_init(void)
 {
-	short controlnum;
 	int err;
 	int card;
 
@@ -353,8 +345,6 @@ static int __init alsa_sound_init(void)
 		return -ENOMEM;
 	}
 	snd_info_minor_register();
-	for (controlnum = 0; controlnum < cards_limit; controlnum++)
-		devfs_mk_cdev(MKDEV(major, controlnum<<5), S_IFCHR | device_mode, "snd/controlC%d", controlnum);
 #ifndef MODULE
 	printk(KERN_INFO "Advanced Linux Sound Architecture Driver Version " CONFIG_SND_VERSION CONFIG_SND_DATE ".\n");
 #endif
diff --git a/sound/oss/soundcard.c b/sound/oss/soundcard.c
--- a/sound/oss/soundcard.c
+++ b/sound/oss/soundcard.c
@@ -564,9 +564,6 @@ static int __init oss_init(void)
 	sound_dmap_flag = (dmabuf > 0 ? 1 : 0);
 
 	for (i = 0; i < sizeof (dev_list) / sizeof *dev_list; i++) {
-		devfs_mk_cdev(MKDEV(SOUND_MAJOR, dev_list[i].minor),
-				S_IFCHR | dev_list[i].mode,
-				"sound/%s", dev_list[i].name);
 		class_device_create(sound_class,
 				    MKDEV(SOUND_MAJOR, dev_list[i].minor),
 				    NULL, "%s", dev_list[i].name);
@@ -574,15 +571,10 @@ static int __init oss_init(void)
 		if (!dev_list[i].num)
 			continue;
 
-		for (j = 1; j < *dev_list[i].num; j++) {
-			devfs_mk_cdev(MKDEV(SOUND_MAJOR,
-						dev_list[i].minor + (j*0x10)),
-					S_IFCHR | dev_list[i].mode,
-					"sound/%s%d", dev_list[i].name, j);
+		for (j = 1; j < *dev_list[i].num; j++)
 			class_device_create(sound_class,
 					    MKDEV(SOUND_MAJOR, dev_list[i].minor + (j*0x10)),
 					    NULL, "%s%d", dev_list[i].name, j);
-		}
 	}
 
 	if (sound_nblocks >= 1024)
diff --git a/sound/sound_core.c b/sound/sound_core.c
--- a/sound/sound_core.c
+++ b/sound/sound_core.c
@@ -172,8 +172,6 @@ static int sound_insert_unit(struct soun
 	else
 		sprintf(s->name, "sound/%s%d", name, r / SOUND_STEP);
 
-	devfs_mk_cdev(MKDEV(SOUND_MAJOR, s->unit_minor),
-			S_IFCHR | mode, s->name);
 	class_device_create(sound_class, MKDEV(SOUND_MAJOR, s->unit_minor),
 				NULL, s->name+6);
 	return r;

