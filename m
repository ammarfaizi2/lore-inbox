Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262977AbUCPBV5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 20:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262918AbUCPACr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 19:02:47 -0500
Received: from mail.kroah.org ([65.200.24.183]:431 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262868AbUCPABu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:01:50 -0500
Subject: Re: [PATCH] Driver Core update for 2.6.4
In-Reply-To: <10793951492441@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 15 Mar 2004 15:59:09 -0800
Message-Id: <10793951493102@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1608.84.14, 2004/03/12 16:22:36-08:00, greg@kroah.com

remove cdev_set_name completely as it is not needed.


 drivers/char/tty_io.c          |    7 -------
 drivers/ieee1394/amdtp.c       |    1 -
 drivers/ieee1394/dv1394.c      |    1 -
 drivers/ieee1394/raw1394.c     |    1 -
 drivers/ieee1394/video1394.c   |    1 -
 drivers/s390/char/tape_class.c |    3 ---
 drivers/scsi/sg.c              |    1 -
 drivers/scsi/st.c              |    1 -
 include/linux/cdev.h           |    2 --
 9 files changed, 18 deletions(-)


diff -Nru a/drivers/char/tty_io.c b/drivers/char/tty_io.c
--- a/drivers/char/tty_io.c	Mon Mar 15 15:28:23 2004
+++ b/drivers/char/tty_io.c	Mon Mar 15 15:28:23 2004
@@ -2274,9 +2274,6 @@
 		driver->termios_locked = NULL;
 	}
 
-	cdev_set_name(&driver->cdev, driver->name);
-	for (s = strchr(driver->cdev.kobj.name, '/'); s; s = strchr(s, '/'))
-		*s = '!';
 	cdev_init(&driver->cdev, &tty_fops);
 	driver->cdev.owner = driver->owner;
 	error = cdev_add(&driver->cdev, dev, driver->num);
@@ -2414,7 +2411,6 @@
  */
 static int __init tty_init(void)
 {
-	cdev_set_name(&tty_cdev, "dev.tty");
 	cdev_init(&tty_cdev, &tty_fops);
 	if (cdev_add(&tty_cdev, MKDEV(TTYAUX_MAJOR, 0), 1) ||
 	    register_chrdev_region(MKDEV(TTYAUX_MAJOR, 0), 1, "/dev/tty") < 0)
@@ -2422,7 +2418,6 @@
 	devfs_mk_cdev(MKDEV(TTYAUX_MAJOR, 0), S_IFCHR|S_IRUGO|S_IWUGO, "tty");
 	class_simple_device_add(tty_class, MKDEV(TTYAUX_MAJOR, 0), NULL, "tty");
 
-	cdev_set_name(&console_cdev, "dev.console");
 	cdev_init(&console_cdev, &console_fops);
 	if (cdev_add(&console_cdev, MKDEV(TTYAUX_MAJOR, 1), 1) ||
 	    register_chrdev_region(MKDEV(TTYAUX_MAJOR, 1), 1, "/dev/console") < 0)
@@ -2431,7 +2426,6 @@
 	class_simple_device_add(tty_class, MKDEV(TTYAUX_MAJOR, 1), NULL, "console");
 
 #ifdef CONFIG_UNIX98_PTYS
-	cdev_set_name(&ptmx_cdev, "dev.ptmx");
 	cdev_init(&ptmx_cdev, &tty_fops);
 	if (cdev_add(&ptmx_cdev, MKDEV(TTYAUX_MAJOR, 2), 1) ||
 	    register_chrdev_region(MKDEV(TTYAUX_MAJOR, 2), 1, "/dev/ptmx") < 0)
@@ -2441,7 +2435,6 @@
 #endif
 
 #ifdef CONFIG_VT
-	cdev_set_name(&vc0_cdev, "dev.vc0");
 	cdev_init(&vc0_cdev, &console_fops);
 	if (cdev_add(&vc0_cdev, MKDEV(TTY_MAJOR, 0), 1) ||
 	    register_chrdev_region(MKDEV(TTY_MAJOR, 0), 1, "/dev/vc/0") < 0)
diff -Nru a/drivers/ieee1394/amdtp.c b/drivers/ieee1394/amdtp.c
--- a/drivers/ieee1394/amdtp.c	Mon Mar 15 15:28:23 2004
+++ b/drivers/ieee1394/amdtp.c	Mon Mar 15 15:28:23 2004
@@ -1266,7 +1266,6 @@
 {
 	cdev_init(&amdtp_cdev, &amdtp_fops);
 	amdtp_cdev.owner = THIS_MODULE;
-	cdev_set_name(&amdtp_cdev, "amdtp");
 	if (cdev_add(&amdtp_cdev, IEEE1394_AMDTP_DEV, 16)) {
 		HPSB_ERR("amdtp: unable to add char device");
  		return -EIO;
diff -Nru a/drivers/ieee1394/dv1394.c b/drivers/ieee1394/dv1394.c
--- a/drivers/ieee1394/dv1394.c	Mon Mar 15 15:28:23 2004
+++ b/drivers/ieee1394/dv1394.c	Mon Mar 15 15:28:23 2004
@@ -2616,7 +2616,6 @@
 
 	cdev_init(&dv1394_cdev, &dv1394_fops);
 	dv1394_cdev.owner = THIS_MODULE;
-	cdev_set_name(&dv1394_cdev, "dv1394");
 	ret = cdev_add(&dv1394_cdev, IEEE1394_DV1394_DEV, 16);
 	if (ret) {
 		printk(KERN_ERR "dv1394: unable to register character device\n");
diff -Nru a/drivers/ieee1394/raw1394.c b/drivers/ieee1394/raw1394.c
--- a/drivers/ieee1394/raw1394.c	Mon Mar 15 15:28:23 2004
+++ b/drivers/ieee1394/raw1394.c	Mon Mar 15 15:28:23 2004
@@ -2746,7 +2746,6 @@
 
 	cdev_init(&raw1394_cdev, &raw1394_fops);
 	raw1394_cdev.owner = THIS_MODULE;
-	cdev_set_name(&raw1394_cdev, RAW1394_DEVICE_NAME);
 	ret = cdev_add(&raw1394_cdev, IEEE1394_RAW1394_DEV, 1);
 	if (ret) {
 		/* jmc: leaves reference to (static) raw1394_cdev */
diff -Nru a/drivers/ieee1394/video1394.c b/drivers/ieee1394/video1394.c
--- a/drivers/ieee1394/video1394.c	Mon Mar 15 15:28:23 2004
+++ b/drivers/ieee1394/video1394.c	Mon Mar 15 15:28:23 2004
@@ -1457,7 +1457,6 @@
 
 	cdev_init(&video1394_cdev, &video1394_fops);
 	video1394_cdev.owner = THIS_MODULE;
-	cdev_set_name(&video1394_cdev, VIDEO1394_DRIVER_NAME);
 	ret = cdev_add(&video1394_cdev, IEEE1394_VIDEO1394_DEV, 16);
 	if (ret) {
 		PRINT_G(KERN_ERR, "video1394: unable to get minor device block");
diff -Nru a/drivers/s390/char/tape_class.c b/drivers/s390/char/tape_class.c
--- a/drivers/s390/char/tape_class.c	Mon Mar 15 15:28:23 2004
+++ b/drivers/s390/char/tape_class.c	Mon Mar 15 15:28:23 2004
@@ -46,9 +46,6 @@
 	cdev->owner = fops->owner;
 	cdev->ops   = fops;
 	cdev->dev   = dev;
-	cdev_set_name(cdev, devname);
-	for (s = strchr(cdev->kobj.name, '/'); s; s = strchr(s, '/'))
-		*s = '!';
 
 	rc = cdev_add(cdev, cdev->dev, 1);
 	if (rc) {
diff -Nru a/drivers/scsi/sg.c b/drivers/scsi/sg.c
--- a/drivers/scsi/sg.c	Mon Mar 15 15:28:23 2004
+++ b/drivers/scsi/sg.c	Mon Mar 15 15:28:23 2004
@@ -1409,7 +1409,6 @@
 	SCSI_LOG_TIMEOUT(3, printk("sg_add: dev=%d \n", k));
 	memset(sdp, 0, sizeof(*sdp));
 	sprintf(disk->disk_name, "sg%d", k);
-	cdev_set_name(cdev, disk->disk_name);
 	cdev->owner = THIS_MODULE;
 	cdev->ops = &sg_fops;
 	disk->major = SCSI_GENERIC_MAJOR;
diff -Nru a/drivers/scsi/st.c b/drivers/scsi/st.c
--- a/drivers/scsi/st.c	Mon Mar 15 15:28:23 2004
+++ b/drivers/scsi/st.c	Mon Mar 15 15:28:23 2004
@@ -3888,7 +3888,6 @@
 				       dev_num);
 				goto out_free_tape;
 			}
-			cdev_set_name(cdev, "%sm%d%s", disk->disk_name, mode, j ? "n" : "");
 			cdev->owner = THIS_MODULE;
 			cdev->ops = &st_fops;
 
diff -Nru a/include/linux/cdev.h b/include/linux/cdev.h
--- a/include/linux/cdev.h	Mon Mar 15 15:28:23 2004
+++ b/include/linux/cdev.h	Mon Mar 15 15:28:23 2004
@@ -25,7 +25,5 @@
 
 void cd_forget(struct inode *);
 
-#define cdev_set_name(cdev, args...) kobject_set_name(&((cdev)->kobj), ##args)
-
 #endif
 #endif

