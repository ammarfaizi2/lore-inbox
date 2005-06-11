Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261652AbVFKIma@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261652AbVFKIma (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 04:42:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbVFKIm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 04:42:29 -0400
Received: from mail.kroah.org ([69.55.234.183]:6852 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261661AbVFKHsy convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 03:48:54 -0400
Subject: [PATCH] Remove the tty_driver devfs_name field as it's no longer needed
In-Reply-To: <11184761122195@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Sat, 11 Jun 2005 00:48:32 -0700
Message-Id: <11184761123002@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Also fixes all drivers that set this field.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/char/cyclades.c         |    1 -
 drivers/char/epca.c             |    1 -
 drivers/char/esp.c              |    1 -
 drivers/char/hvc_console.c      |    1 -
 drivers/char/hvcs.c             |    1 -
 drivers/char/hvsi.c             |    1 -
 drivers/char/ip2main.c          |    1 -
 drivers/char/isicom.c           |    1 -
 drivers/char/moxa.c             |    1 -
 drivers/char/pty.c              |    2 --
 drivers/char/riscom8.c          |    1 -
 drivers/char/rocket.c           |    1 -
 drivers/char/serial167.c        |    1 -
 drivers/char/stallion.c         |    1 -
 drivers/char/viocons.c          |    1 -
 drivers/char/vme_scc.c          |    1 -
 drivers/char/vt.c               |    1 -
 drivers/isdn/capi/capi.c        |    1 -
 drivers/isdn/i4l/isdn_tty.c     |    1 -
 drivers/macintosh/macserial.c   |    1 -
 drivers/s390/char/tty3270.c     |    1 -
 drivers/s390/net/ctctty.c       |    1 -
 drivers/tc/zs.c                 |    1 -
 drivers/usb/class/bluetty.c     |    5 ++---
 drivers/usb/class/cdc-acm.c     |    1 -
 drivers/usb/gadget/serial.c     |    1 -
 drivers/usb/serial/usb-serial.c |    1 -
 include/linux/tty_driver.h      |    1 -
 net/bluetooth/rfcomm/tty.c      |    1 -
 net/irda/ircomm/ircomm_tty.c    |    1 -
 30 files changed, 2 insertions(+), 33 deletions(-)

--- gregkh-2.6.orig/drivers/char/cyclades.c	2005-06-10 23:28:57.000000000 -0700
+++ gregkh-2.6/drivers/char/cyclades.c	2005-06-10 23:37:25.000000000 -0700
@@ -5286,7 +5286,6 @@
     cy_serial_driver->owner = THIS_MODULE;
     cy_serial_driver->driver_name = "cyclades";
     cy_serial_driver->name = "ttyC";
-    cy_serial_driver->devfs_name = "tts/C";
     cy_serial_driver->major = CYCLADES_MAJOR;
     cy_serial_driver->minor_start = 0;
     cy_serial_driver->type = TTY_DRIVER_TYPE_SERIAL;
--- gregkh-2.6.orig/drivers/char/epca.c	2005-06-10 23:28:57.000000000 -0700
+++ gregkh-2.6/drivers/char/epca.c	2005-06-10 23:37:25.000000000 -0700
@@ -1471,7 +1471,6 @@
 
 	pc_driver->owner = THIS_MODULE;
 	pc_driver->name = "ttyD"; 
-	pc_driver->devfs_name = "tts/D";
 	pc_driver->major = DIGI_MAJOR; 
 	pc_driver->minor_start = 0;
 	pc_driver->type = TTY_DRIVER_TYPE_SERIAL;
--- gregkh-2.6.orig/drivers/char/esp.c	2005-06-10 23:28:57.000000000 -0700
+++ gregkh-2.6/drivers/char/esp.c	2005-06-10 23:37:25.000000000 -0700
@@ -2478,7 +2478,6 @@
 	
 	esp_driver->owner = THIS_MODULE;
 	esp_driver->name = "ttyP";
-	esp_driver->devfs_name = "tts/P";
 	esp_driver->major = ESP_IN_MAJOR;
 	esp_driver->minor_start = 0;
 	esp_driver->type = TTY_DRIVER_TYPE_SERIAL;
--- gregkh-2.6.orig/drivers/char/hvc_console.c	2005-06-10 23:28:57.000000000 -0700
+++ gregkh-2.6/drivers/char/hvc_console.c	2005-06-10 23:37:25.000000000 -0700
@@ -694,7 +694,6 @@
 		return -ENOMEM;
 
 	hvc_driver->owner = THIS_MODULE;
-	hvc_driver->devfs_name = "hvc/";
 	hvc_driver->driver_name = "hvc";
 	hvc_driver->name = "hvc";
 	hvc_driver->major = HVC_MAJOR;
--- gregkh-2.6.orig/drivers/char/hvsi.c	2005-06-10 23:28:57.000000000 -0700
+++ gregkh-2.6/drivers/char/hvsi.c	2005-06-10 23:37:25.000000000 -0700
@@ -1156,7 +1156,6 @@
 		return -ENOMEM;
 
 	hvsi_driver->owner = THIS_MODULE;
-	hvsi_driver->devfs_name = "hvsi/";
 	hvsi_driver->driver_name = "hvsi";
 	hvsi_driver->name = "hvsi";
 	hvsi_driver->major = HVSI_MAJOR;
--- gregkh-2.6.orig/drivers/char/isicom.c	2005-06-10 23:28:57.000000000 -0700
+++ gregkh-2.6/drivers/char/isicom.c	2005-06-10 23:37:25.000000000 -0700
@@ -1814,7 +1814,6 @@
 
 	isicom_normal->owner	= THIS_MODULE;
 	isicom_normal->name 	= "ttyM";
-	isicom_normal->devfs_name = "isicom/";
 	isicom_normal->major	= ISICOM_NMAJOR;
 	isicom_normal->minor_start	= 0;
 	isicom_normal->type	= TTY_DRIVER_TYPE_SERIAL;
--- gregkh-2.6.orig/drivers/char/moxa.c	2005-06-10 23:28:57.000000000 -0700
+++ gregkh-2.6/drivers/char/moxa.c	2005-06-10 23:37:25.000000000 -0700
@@ -340,7 +340,6 @@
 	init_MUTEX(&moxaBuffSem);
 	moxaDriver->owner = THIS_MODULE;
 	moxaDriver->name = "ttya";
-	moxaDriver->devfs_name = "tts/a";
 	moxaDriver->major = ttymajor;
 	moxaDriver->minor_start = 0;
 	moxaDriver->type = TTY_DRIVER_TYPE_SERIAL;
--- gregkh-2.6.orig/drivers/char/pty.c	2005-06-10 23:37:21.000000000 -0700
+++ gregkh-2.6/drivers/char/pty.c	2005-06-10 23:37:36.000000000 -0700
@@ -265,7 +265,6 @@
 	pty_driver->owner = THIS_MODULE;
 	pty_driver->driver_name = "pty_master";
 	pty_driver->name = "pty";
-	pty_driver->devfs_name = "pty/m";
 	pty_driver->major = PTY_MASTER_MAJOR;
 	pty_driver->minor_start = 0;
 	pty_driver->type = TTY_DRIVER_TYPE_PTY;
@@ -283,7 +282,6 @@
 	pty_slave_driver->owner = THIS_MODULE;
 	pty_slave_driver->driver_name = "pty_slave";
 	pty_slave_driver->name = "ttyp";
-	pty_slave_driver->devfs_name = "pty/s";
 	pty_slave_driver->major = PTY_SLAVE_MAJOR;
 	pty_slave_driver->minor_start = 0;
 	pty_slave_driver->type = TTY_DRIVER_TYPE_PTY;
--- gregkh-2.6.orig/drivers/char/riscom8.c	2005-06-10 23:28:57.000000000 -0700
+++ gregkh-2.6/drivers/char/riscom8.c	2005-06-10 23:37:25.000000000 -0700
@@ -1648,7 +1648,6 @@
 	memset(IRQ_to_board, 0, sizeof(IRQ_to_board));
 	riscom_driver->owner = THIS_MODULE;
 	riscom_driver->name = "ttyL";
-	riscom_driver->devfs_name = "tts/L";
 	riscom_driver->major = RISCOM8_NORMAL_MAJOR;
 	riscom_driver->type = TTY_DRIVER_TYPE_SERIAL;
 	riscom_driver->subtype = SERIAL_TYPE_NORMAL;
--- gregkh-2.6.orig/drivers/char/rocket.c	2005-06-10 23:28:57.000000000 -0700
+++ gregkh-2.6/drivers/char/rocket.c	2005-06-10 23:37:36.000000000 -0700
@@ -2367,7 +2367,6 @@
 
 	rocket_driver->owner = THIS_MODULE;
 	rocket_driver->flags = TTY_DRIVER_NO_DEVFS;
-	rocket_driver->devfs_name = "tts/R";
 	rocket_driver->name = "ttyR";
 	rocket_driver->driver_name = "Comtrol RocketPort";
 	rocket_driver->major = TTY_ROCKET_MAJOR;
--- gregkh-2.6.orig/drivers/char/serial167.c	2005-06-10 23:28:57.000000000 -0700
+++ gregkh-2.6/drivers/char/serial167.c	2005-06-10 23:37:25.000000000 -0700
@@ -2251,7 +2251,6 @@
     /* Initialize the tty_driver structure */
     
     cy_serial_driver->owner = THIS_MODULE;
-    cy_serial_driver->devfs_name = "tts/";
     cy_serial_driver->name = "ttyS";
     cy_serial_driver->major = TTY_MAJOR;
     cy_serial_driver->minor_start = 64;
--- gregkh-2.6.orig/drivers/char/stallion.c	2005-06-10 23:37:21.000000000 -0700
+++ gregkh-2.6/drivers/char/stallion.c	2005-06-10 23:37:25.000000000 -0700
@@ -3092,7 +3092,6 @@
 	stl_serial->owner = THIS_MODULE;
 	stl_serial->driver_name = stl_drvname;
 	stl_serial->name = "ttyE";
-	stl_serial->devfs_name = "tts/E";
 	stl_serial->major = STL_SERIALMAJOR;
 	stl_serial->minor_start = 0;
 	stl_serial->type = TTY_DRIVER_TYPE_SERIAL;
--- gregkh-2.6.orig/drivers/char/viocons.c	2005-06-10 23:28:57.000000000 -0700
+++ gregkh-2.6/drivers/char/viocons.c	2005-06-10 23:37:25.000000000 -0700
@@ -1154,7 +1154,6 @@
 	viotty_driver = alloc_tty_driver(VTTY_PORTS);
 	viotty_driver->owner = THIS_MODULE;
 	viotty_driver->driver_name = "vioconsole";
-	viotty_driver->devfs_name = "vcs/";
 	viotty_driver->name = "tty";
 	viotty_driver->name_base = 1;
 	viotty_driver->major = TTY_MAJOR;
--- gregkh-2.6.orig/drivers/char/vme_scc.c	2005-06-10 23:28:57.000000000 -0700
+++ gregkh-2.6/drivers/char/vme_scc.c	2005-06-10 23:37:25.000000000 -0700
@@ -147,7 +147,6 @@
 	scc_driver->owner = THIS_MODULE;
 	scc_driver->driver_name = "scc";
 	scc_driver->name = "ttyS";
-	scc_driver->devfs_name = "tts/";
 	scc_driver->major = TTY_MAJOR;
 	scc_driver->minor_start = SCC_MINOR_BASE;
 	scc_driver->type = TTY_DRIVER_TYPE_SERIAL;
--- gregkh-2.6.orig/drivers/char/vt.c	2005-06-10 23:37:21.000000000 -0700
+++ gregkh-2.6/drivers/char/vt.c	2005-06-10 23:37:25.000000000 -0700
@@ -2592,7 +2592,6 @@
 	if (!console_driver)
 		panic("Couldn't allocate console driver\n");
 	console_driver->owner = THIS_MODULE;
-	console_driver->devfs_name = "vc/";
 	console_driver->name = "tty";
 	console_driver->name_base = 1;
 	console_driver->major = TTY_MAJOR;
--- gregkh-2.6.orig/include/linux/tty_driver.h	2005-06-10 23:28:57.000000000 -0700
+++ gregkh-2.6/include/linux/tty_driver.h	2005-06-10 23:37:36.000000000 -0700
@@ -157,7 +157,6 @@
 	struct cdev cdev;
 	struct module	*owner;
 	const char	*driver_name;
-	const char	*devfs_name;
 	const char	*name;
 	int	name_base;	/* offset of printed name */
 	int	major;		/* major device number */
--- gregkh-2.6.orig/drivers/char/hvcs.c	2005-06-10 23:28:57.000000000 -0700
+++ gregkh-2.6/drivers/char/hvcs.c	2005-06-10 23:37:25.000000000 -0700
@@ -1363,7 +1363,6 @@
 
 	hvcs_tty_driver->driver_name = hvcs_driver_name;
 	hvcs_tty_driver->name = hvcs_device_node;
-	hvcs_tty_driver->devfs_name = hvcs_device_node;
 
 	/*
 	 * We'll let the system assign us a major number, indicated by leaving
--- gregkh-2.6.orig/drivers/char/ip2main.c	2005-06-10 23:37:21.000000000 -0700
+++ gregkh-2.6/drivers/char/ip2main.c	2005-06-10 23:37:36.000000000 -0700
@@ -672,7 +672,6 @@
 
 	ip2_tty_driver->owner		    = THIS_MODULE;
 	ip2_tty_driver->name                 = "ttyF";
-	ip2_tty_driver->devfs_name	    = "tts/F";
 	ip2_tty_driver->driver_name          = pcDriver_name;
 	ip2_tty_driver->major                = IP2_TTY_MAJOR;
 	ip2_tty_driver->minor_start          = 0;
--- gregkh-2.6.orig/drivers/isdn/capi/capi.c	2005-06-10 23:37:21.000000000 -0700
+++ gregkh-2.6/drivers/isdn/capi/capi.c	2005-06-10 23:37:25.000000000 -0700
@@ -1327,7 +1327,6 @@
 
 	drv->owner = THIS_MODULE;
 	drv->driver_name = "capi_nc";
-	drv->devfs_name = "capi/";
 	drv->name = "capi";
 	drv->major = capi_ttymajor;
 	drv->minor_start = 0;
--- gregkh-2.6.orig/drivers/isdn/i4l/isdn_tty.c	2005-06-10 23:28:57.000000000 -0700
+++ gregkh-2.6/drivers/isdn/i4l/isdn_tty.c	2005-06-10 23:37:36.000000000 -0700
@@ -1901,7 +1901,6 @@
 	if (!m->tty_modem)
 		return -ENOMEM;
 	m->tty_modem->name = "ttyI";
-	m->tty_modem->devfs_name = "isdn/ttyI";
 	m->tty_modem->major = ISDN_TTY_MAJOR;
 	m->tty_modem->minor_start = 0;
 	m->tty_modem->type = TTY_DRIVER_TYPE_SERIAL;
--- gregkh-2.6.orig/drivers/macintosh/macserial.c	2005-06-10 23:28:57.000000000 -0700
+++ gregkh-2.6/drivers/macintosh/macserial.c	2005-06-10 23:37:25.000000000 -0700
@@ -2521,7 +2521,6 @@
 
 	serial_driver->owner = THIS_MODULE;
 	serial_driver->driver_name = "macserial";
-	serial_driver->devfs_name = "tts/";
 	serial_driver->name = "ttyS";
 	serial_driver->major = TTY_MAJOR;
 	serial_driver->minor_start = 64;
--- gregkh-2.6.orig/drivers/s390/char/tty3270.c	2005-06-10 23:28:57.000000000 -0700
+++ gregkh-2.6/drivers/s390/char/tty3270.c	2005-06-10 23:37:36.000000000 -0700
@@ -1790,7 +1790,6 @@
 	 * proc_entry, set_termios, flush_buffer, set_ldisc, write_proc
 	 */
 	driver->owner = THIS_MODULE;
-	driver->devfs_name = "ttyTUB/";
 	driver->driver_name = "ttyTUB";
 	driver->name = "ttyTUB";
 	driver->major = IBM_TTY3270_MAJOR;
--- gregkh-2.6.orig/drivers/s390/net/ctctty.c	2005-06-10 23:37:21.000000000 -0700
+++ gregkh-2.6/drivers/s390/net/ctctty.c	2005-06-10 23:37:25.000000000 -0700
@@ -1150,7 +1150,6 @@
 		return -ENOMEM;
 	}
 
-	device->devfs_name = "ctc/" CTC_TTY_NAME;
 	device->name = CTC_TTY_NAME;
 	device->major = CTC_TTY_MAJOR;
 	device->minor_start = 0;
--- gregkh-2.6.orig/drivers/tc/zs.c	2005-06-10 23:28:57.000000000 -0700
+++ gregkh-2.6/drivers/tc/zs.c	2005-06-10 23:37:36.000000000 -0700
@@ -1785,7 +1785,6 @@
 	/* Not all of this is exactly right for us. */
 
 	serial_driver->owner = THIS_MODULE;
-	serial_driver->devfs_name = "tts/";
 	serial_driver->name = "ttyS";
 	serial_driver->major = TTY_MAJOR;
 	serial_driver->minor_start = 64;
--- gregkh-2.6.orig/drivers/usb/class/bluetty.c	2005-06-10 23:28:57.000000000 -0700
+++ gregkh-2.6/drivers/usb/class/bluetty.c	2005-06-10 23:37:36.000000000 -0700
@@ -1118,9 +1118,9 @@
 		     bluetooth->interrupt_in_buffer, buffer_size, bluetooth_int_callback,
 		     bluetooth, endpoint->bInterval);
 
-	/* initialize the devfs nodes for this device and let the user know what bluetooths we are bound to */
+	/* register the tty device and let the user know what bluetooths we are bound to */
 	tty_register_device (bluetooth_tty_driver, minor, &intf->dev);
-	info("Bluetooth converter now attached to ttyUB%d (or usb/ttub/%d for devfs)", minor, minor);
+	info("Bluetooth converter now attached to ttyUB%d", minor);
 
 	bluetooth_table[minor] = bluetooth;
 
@@ -1231,7 +1231,6 @@
 	bluetooth_tty_driver->owner = THIS_MODULE;
 	bluetooth_tty_driver->driver_name = "usb-bluetooth";
 	bluetooth_tty_driver->name = "ttyUB";
-	bluetooth_tty_driver->devfs_name = "usb/ttub/";
 	bluetooth_tty_driver->major = BLUETOOTH_TTY_MAJOR;
 	bluetooth_tty_driver->minor_start = 0;
 	bluetooth_tty_driver->type = TTY_DRIVER_TYPE_SERIAL;
--- gregkh-2.6.orig/drivers/usb/class/cdc-acm.c	2005-06-10 23:28:57.000000000 -0700
+++ gregkh-2.6/drivers/usb/class/cdc-acm.c	2005-06-10 23:37:36.000000000 -0700
@@ -1040,7 +1040,6 @@
 	acm_tty_driver->owner = THIS_MODULE,
 	acm_tty_driver->driver_name = "acm",
 	acm_tty_driver->name = "ttyACM",
-	acm_tty_driver->devfs_name = "usb/acm/",
 	acm_tty_driver->major = ACM_TTY_MAJOR,
 	acm_tty_driver->minor_start = 0,
 	acm_tty_driver->type = TTY_DRIVER_TYPE_SERIAL,
--- gregkh-2.6.orig/drivers/usb/gadget/serial.c	2005-06-10 23:28:57.000000000 -0700
+++ gregkh-2.6/drivers/usb/gadget/serial.c	2005-06-10 23:37:36.000000000 -0700
@@ -663,7 +663,6 @@
 	gs_tty_driver->owner = THIS_MODULE;
 	gs_tty_driver->driver_name = GS_SHORT_NAME;
 	gs_tty_driver->name = "ttygs";
-	gs_tty_driver->devfs_name = "usb/ttygs/";
 	gs_tty_driver->major = GS_MAJOR;
 	gs_tty_driver->minor_start = GS_MINOR_START;
 	gs_tty_driver->type = TTY_DRIVER_TYPE_SERIAL;
--- gregkh-2.6.orig/drivers/usb/serial/usb-serial.c	2005-06-10 23:28:57.000000000 -0700
+++ gregkh-2.6/drivers/usb/serial/usb-serial.c	2005-06-10 23:37:36.000000000 -0700
@@ -1300,7 +1300,6 @@
 
 	usb_serial_tty_driver->owner = THIS_MODULE;
 	usb_serial_tty_driver->driver_name = "usbserial";
-	usb_serial_tty_driver->devfs_name = "usb/tts/";
 	usb_serial_tty_driver->name = 	"ttyUSB";
 	usb_serial_tty_driver->major = SERIAL_TTY_MAJOR;
 	usb_serial_tty_driver->minor_start = 0;
--- gregkh-2.6.orig/net/bluetooth/rfcomm/tty.c	2005-06-10 23:28:57.000000000 -0700
+++ gregkh-2.6/net/bluetooth/rfcomm/tty.c	2005-06-10 23:37:36.000000000 -0700
@@ -901,7 +901,6 @@
 
 	rfcomm_tty_driver->owner	= THIS_MODULE;
 	rfcomm_tty_driver->driver_name	= "rfcomm";
-	rfcomm_tty_driver->devfs_name	= "bluetooth/rfcomm/";
 	rfcomm_tty_driver->name		= "rfcomm";
 	rfcomm_tty_driver->major	= RFCOMM_TTY_MAJOR;
 	rfcomm_tty_driver->minor_start	= RFCOMM_TTY_MINOR;
--- gregkh-2.6.orig/net/irda/ircomm/ircomm_tty.c	2005-06-10 23:28:57.000000000 -0700
+++ gregkh-2.6/net/irda/ircomm/ircomm_tty.c	2005-06-10 23:37:25.000000000 -0700
@@ -124,7 +124,6 @@
 	driver->owner		= THIS_MODULE;
 	driver->driver_name     = "ircomm";
 	driver->name            = "ircomm";
-	driver->devfs_name      = "ircomm";
 	driver->major           = IRCOMM_TTY_MAJOR;
 	driver->minor_start     = IRCOMM_TTY_MINOR;
 	driver->type            = TTY_DRIVER_TYPE_SERIAL;

