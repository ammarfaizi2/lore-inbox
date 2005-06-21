Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261960AbVFUHBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbVFUHBK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 03:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261586AbVFUG6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 02:58:47 -0400
Received: from mail.kroah.org ([69.55.234.183]:59107 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262037AbVFUGbA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 02:31:00 -0400
Cc: gregkh@suse.de
Subject: [PATCH] devfs: Last little devfs cleanups throughout the kernel tree.
In-Reply-To: <11193354452744@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 23:30:45 -0700
Message-Id: <11193354453133@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] devfs: Last little devfs cleanups throughout the kernel tree.

Just removes a few unused #defines and fixes some comments due to
devfs now being gone.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit a4e6714c13c7aacb009dbbeb8b706e065c4ff994
tree f0586a30acd0e61baa18919a65e9baa14ada7418
parent 7a8f493a5d2a57b5ab6302044c44d185755cf46d
author Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 21:15:16 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 23:13:42 -0700

 drivers/block/viodasd.c                           |    1 -
 drivers/cdrom/viocd.c                             |    1 -
 drivers/md/dm.c                                   |    2 +-
 drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c |   11 -----------
 drivers/serial/dz.c                               |    4 ----
 drivers/serial/serial_core.c                      |    2 +-
 drivers/usb/usb-skeleton.c                        |    4 ++--
 7 files changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/block/viodasd.c b/drivers/block/viodasd.c
--- a/drivers/block/viodasd.c
+++ b/drivers/block/viodasd.c
@@ -59,7 +59,6 @@ MODULE_LICENSE("GPL");
  * numbers 0-255 we get a maximum of 32 disks.
  */
 #define VIOD_GENHD_NAME		"iseries/vd"
-#define VIOD_GENHD_DEVFS_NAME	"iseries/disc"
 
 #define VIOD_VERS		"1.64"
 
diff --git a/drivers/cdrom/viocd.c b/drivers/cdrom/viocd.c
--- a/drivers/cdrom/viocd.c
+++ b/drivers/cdrom/viocd.c
@@ -51,7 +51,6 @@
 #include <asm/iSeries/vio.h>
 
 #define VIOCD_DEVICE			"iseries/vcd"
-#define VIOCD_DEVICE_DEVFS		"iseries/vcd"
 
 #define VIOCD_VERS "1.06"
 
diff --git a/drivers/md/dm.c b/drivers/md/dm.c
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -150,7 +150,7 @@ static void local_exit(void)
 	bioset_free(dm_set);
 
 	if (unregister_blkdev(_major, _name) < 0)
-		DMERR("devfs_unregister_blkdev failed");
+		DMERR("unregister_blkdev failed");
 
 	_major = 0;
 
diff --git a/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c b/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c
--- a/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c
+++ b/drivers/media/dvb/ttusb-budget/dvb-ttusb-budget.c
@@ -123,10 +123,6 @@ struct ttusb {
 
 	int revision;
 
-#if 0
-	devfs_handle_t stc_devfs_handle;
-#endif
-
 	struct dvb_frontend* fe;
 };
 
@@ -1529,13 +1525,6 @@ static int ttusb_probe(struct usb_interf
 		return -ENODEV;
 	}
 
-#if 0
-	ttusb->stc_devfs_handle =
-	    devfs_register(ttusb->adapter->devfs_handle, TTUSB_BUDGET_NAME,
-			   DEVFS_FL_DEFAULT, 0, 192,
-			   S_IFCHR | S_IRUSR | S_IWUSR | S_IRGRP | S_IWGRP
-			   | S_IROTH | S_IWOTH, &stc_fops, ttusb);
-#endif
 	usb_set_intfdata(intf, (void *) ttusb);
 
 	frontend_init(ttusb);
diff --git a/drivers/serial/dz.c b/drivers/serial/dz.c
--- a/drivers/serial/dz.c
+++ b/drivers/serial/dz.c
@@ -771,11 +771,7 @@ void __init dz_serial_console_init(void)
 static struct uart_driver dz_reg = {
 	.owner			= THIS_MODULE,
 	.driver_name		= "serial",
-#ifdef CONFIG_DEVFS
-	.dev_name		= "tts/%d",
-#else
 	.dev_name		= "ttyS%d",
-#endif
 	.major			= TTY_MAJOR,
 	.minor			= 64,
 	.nr			= DZ_NB_PORT,
diff --git a/drivers/serial/serial_core.c b/drivers/serial/serial_core.c
--- a/drivers/serial/serial_core.c
+++ b/drivers/serial/serial_core.c
@@ -2218,7 +2218,7 @@ int uart_remove_one_port(struct uart_dri
 	down(&port_sem);
 
 	/*
-	 * Remove the devices from devfs
+	 * Remove the devices from sysfs
 	 */
 	tty_unregister_device(drv->tty_driver, port->line);
 
diff --git a/drivers/usb/usb-skeleton.c b/drivers/usb/usb-skeleton.c
--- a/drivers/usb/usb-skeleton.c
+++ b/drivers/usb/usb-skeleton.c
@@ -218,9 +218,9 @@ static struct file_operations skel_fops 
 	.release =	skel_release,
 };
 
-/* 
+/*
  * usb class driver info in order to get a minor number from the usb core,
- * and to have the device registered with devfs and the driver core
+ * and to have the device registered with sysfs.
  */
 static struct usb_class_driver skel_class = {
 	.name =		"skel%d",

