Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261740AbVFUHCH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261740AbVFUHCH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 03:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261629AbVFUHB2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 03:01:28 -0400
Received: from mail.kroah.org ([69.55.234.183]:58083 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262001AbVFUGa6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 02:30:58 -0400
Cc: gregkh@suse.de
Subject: [PATCH] devfs: Remove the tty_driver devfs_name field as it's no longer needed
In-Reply-To: <11193354443273@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 20 Jun 2005 23:30:44 -0700
Message-Id: <11193354441545@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] devfs: Remove the tty_driver devfs_name field as it's no longer needed

Also fixes all drivers that set this field.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
commit 6016070ebcf5d293914273424f8de465f66a7802
tree 943794cf39d122b255bcb70ccbad675a9cc9dca6
parent 556f38ebd8f2209a27cee28bc1ca8f84eef048e6
author Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 21:15:16 -0700
committer Greg Kroah-Hartman <gregkh@suse.de> Mon, 20 Jun 2005 23:13:39 -0700

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

diff --git a/drivers/char/cyclades.c b/drivers/char/cyclades.c
--- a/drivers/char/cyclades.c
+++ b/drivers/char/cyclades.c
@@ -5286,7 +5286,6 @@ cy_init(void)
     cy_serial_driver->owner = THIS_MODULE;
     cy_serial_driver->driver_name = "cyclades";
     cy_serial_driver->name = "ttyC";
-    cy_serial_driver->devfs_name = "tts/C";
     cy_serial_driver->major = CYCLADES_MAJOR;
     cy_serial_driver->minor_start = 0;
     cy_serial_driver->type = TTY_DRIVER_TYPE_SERIAL;
diff --git a/drivers/char/epca.c b/drivers/char/epca.c
--- a/drivers/char/epca.c
+++ b/drivers/char/epca.c
@@ -1471,7 +1471,6 @@ int __init pc_init(void)
 
 	pc_driver->owner = THIS_MODULE;
 	pc_driver->name = "ttyD"; 
-	pc_driver->devfs_name = "tts/D";
 	pc_driver->major = DIGI_MAJOR; 
 	pc_driver->minor_start = 0;
 	pc_driver->type = TTY_DRIVER_TYPE_SERIAL;
diff --git a/drivers/char/esp.c b/drivers/char/esp.c
--- a/drivers/char/esp.c
+++ b/drivers/char/esp.c
@@ -2478,7 +2478,6 @@ static int __init espserial_init(void)
 	
 	esp_driver->owner = THIS_MODULE;
 	esp_driver->name = "ttyP";
-	esp_driver->devfs_name = "tts/P";
 	esp_driver->major = ESP_IN_MAJOR;
 	esp_driver->minor_start = 0;
 	esp_driver->type = TTY_DRIVER_TYPE_SERIAL;
diff --git a/drivers/char/hvc_console.c b/drivers/char/hvc_console.c
--- a/drivers/char/hvc_console.c
+++ b/drivers/char/hvc_console.c
@@ -694,7 +694,6 @@ int __init hvc_init(void)
 		return -ENOMEM;
 
 	hvc_driver->owner = THIS_MODULE;
-	hvc_driver->devfs_name = "hvc/";
 	hvc_driver->driver_name = "hvc";
 	hvc_driver->name = "hvc";
 	hvc_driver->major = HVC_MAJOR;
diff --git a/drivers/char/hvcs.c b/drivers/char/hvcs.c
--- a/drivers/char/hvcs.c
+++ b/drivers/char/hvcs.c
@@ -1363,7 +1363,6 @@ static int __init hvcs_module_init(void)
 
 	hvcs_tty_driver->driver_name = hvcs_driver_name;
 	hvcs_tty_driver->name = hvcs_device_node;
-	hvcs_tty_driver->devfs_name = hvcs_device_node;
 
 	/*
 	 * We'll let the system assign us a major number, indicated by leaving
diff --git a/drivers/char/hvsi.c b/drivers/char/hvsi.c
--- a/drivers/char/hvsi.c
+++ b/drivers/char/hvsi.c
@@ -1156,7 +1156,6 @@ static int __init hvsi_init(void)
 		return -ENOMEM;
 
 	hvsi_driver->owner = THIS_MODULE;
-	hvsi_driver->devfs_name = "hvsi/";
 	hvsi_driver->driver_name = "hvsi";
 	hvsi_driver->name = "hvsi";
 	hvsi_driver->major = HVSI_MAJOR;
diff --git a/drivers/char/ip2main.c b/drivers/char/ip2main.c
--- a/drivers/char/ip2main.c
+++ b/drivers/char/ip2main.c
@@ -672,7 +672,6 @@ ip2_loadmain(int *iop, int *irqp, unsign
 
 	ip2_tty_driver->owner		    = THIS_MODULE;
 	ip2_tty_driver->name                 = "ttyF";
-	ip2_tty_driver->devfs_name	    = "tts/F";
 	ip2_tty_driver->driver_name          = pcDriver_name;
 	ip2_tty_driver->major                = IP2_TTY_MAJOR;
 	ip2_tty_driver->minor_start          = 0;
diff --git a/drivers/char/isicom.c b/drivers/char/isicom.c
--- a/drivers/char/isicom.c
+++ b/drivers/char/isicom.c
@@ -1814,7 +1814,6 @@ static int __init register_drivers(void)
 
 	isicom_normal->owner	= THIS_MODULE;
 	isicom_normal->name 	= "ttyM";
-	isicom_normal->devfs_name = "isicom/";
 	isicom_normal->major	= ISICOM_NMAJOR;
 	isicom_normal->minor_start	= 0;
 	isicom_normal->type	= TTY_DRIVER_TYPE_SERIAL;
diff --git a/drivers/char/moxa.c b/drivers/char/moxa.c
--- a/drivers/char/moxa.c
+++ b/drivers/char/moxa.c
@@ -340,7 +340,6 @@ static int __init moxa_init(void)
 	init_MUTEX(&moxaBuffSem);
 	moxaDriver->owner = THIS_MODULE;
 	moxaDriver->name = "ttya";
-	moxaDriver->devfs_name = "tts/a";
 	moxaDriver->major = ttymajor;
 	moxaDriver->minor_start = 0;
 	moxaDriver->type = TTY_DRIVER_TYPE_SERIAL;
diff --git a/drivers/char/pty.c b/drivers/char/pty.c
--- a/drivers/char/pty.c
+++ b/drivers/char/pty.c
@@ -265,7 +265,6 @@ static void __init legacy_pty_init(void)
 	pty_driver->owner = THIS_MODULE;
 	pty_driver->driver_name = "pty_master";
 	pty_driver->name = "pty";
-	pty_driver->devfs_name = "pty/m";
 	pty_driver->major = PTY_MASTER_MAJOR;
 	pty_driver->minor_start = 0;
 	pty_driver->type = TTY_DRIVER_TYPE_PTY;
@@ -283,7 +282,6 @@ static void __init legacy_pty_init(void)
 	pty_slave_driver->owner = THIS_MODULE;
 	pty_slave_driver->driver_name = "pty_slave";
 	pty_slave_driver->name = "ttyp";
-	pty_slave_driver->devfs_name = "pty/s";
 	pty_slave_driver->major = PTY_SLAVE_MAJOR;
 	pty_slave_driver->minor_start = 0;
 	pty_slave_driver->type = TTY_DRIVER_TYPE_PTY;
diff --git a/drivers/char/riscom8.c b/drivers/char/riscom8.c
--- a/drivers/char/riscom8.c
+++ b/drivers/char/riscom8.c
@@ -1648,7 +1648,6 @@ static inline int rc_init_drivers(void)
 	memset(IRQ_to_board, 0, sizeof(IRQ_to_board));
 	riscom_driver->owner = THIS_MODULE;
 	riscom_driver->name = "ttyL";
-	riscom_driver->devfs_name = "tts/L";
 	riscom_driver->major = RISCOM8_NORMAL_MAJOR;
 	riscom_driver->type = TTY_DRIVER_TYPE_SERIAL;
 	riscom_driver->subtype = SERIAL_TYPE_NORMAL;
diff --git a/drivers/char/rocket.c b/drivers/char/rocket.c
--- a/drivers/char/rocket.c
+++ b/drivers/char/rocket.c
@@ -2367,7 +2367,6 @@ int __init rp_init(void)
 
 	rocket_driver->owner = THIS_MODULE;
 	rocket_driver->flags = TTY_DRIVER_NO_DEVFS;
-	rocket_driver->devfs_name = "tts/R";
 	rocket_driver->name = "ttyR";
 	rocket_driver->driver_name = "Comtrol RocketPort";
 	rocket_driver->major = TTY_ROCKET_MAJOR;
diff --git a/drivers/char/serial167.c b/drivers/char/serial167.c
--- a/drivers/char/serial167.c
+++ b/drivers/char/serial167.c
@@ -2251,7 +2251,6 @@ scrn[1] = '\0';
     /* Initialize the tty_driver structure */
     
     cy_serial_driver->owner = THIS_MODULE;
-    cy_serial_driver->devfs_name = "tts/";
     cy_serial_driver->name = "ttyS";
     cy_serial_driver->major = TTY_MAJOR;
     cy_serial_driver->minor_start = 64;
diff --git a/drivers/char/stallion.c b/drivers/char/stallion.c
--- a/drivers/char/stallion.c
+++ b/drivers/char/stallion.c
@@ -3092,7 +3092,6 @@ static int __init stl_init(void)
 	stl_serial->owner = THIS_MODULE;
 	stl_serial->driver_name = stl_drvname;
 	stl_serial->name = "ttyE";
-	stl_serial->devfs_name = "tts/E";
 	stl_serial->major = STL_SERIALMAJOR;
 	stl_serial->minor_start = 0;
 	stl_serial->type = TTY_DRIVER_TYPE_SERIAL;
diff --git a/drivers/char/viocons.c b/drivers/char/viocons.c
--- a/drivers/char/viocons.c
+++ b/drivers/char/viocons.c
@@ -1154,7 +1154,6 @@ static int __init viocons_init2(void)
 	viotty_driver = alloc_tty_driver(VTTY_PORTS);
 	viotty_driver->owner = THIS_MODULE;
 	viotty_driver->driver_name = "vioconsole";
-	viotty_driver->devfs_name = "vcs/";
 	viotty_driver->name = "tty";
 	viotty_driver->name_base = 1;
 	viotty_driver->major = TTY_MAJOR;
diff --git a/drivers/char/vme_scc.c b/drivers/char/vme_scc.c
--- a/drivers/char/vme_scc.c
+++ b/drivers/char/vme_scc.c
@@ -147,7 +147,6 @@ static int scc_init_drivers(void)
 	scc_driver->owner = THIS_MODULE;
 	scc_driver->driver_name = "scc";
 	scc_driver->name = "ttyS";
-	scc_driver->devfs_name = "tts/";
 	scc_driver->major = TTY_MAJOR;
 	scc_driver->minor_start = SCC_MINOR_BASE;
 	scc_driver->type = TTY_DRIVER_TYPE_SERIAL;
diff --git a/drivers/char/vt.c b/drivers/char/vt.c
--- a/drivers/char/vt.c
+++ b/drivers/char/vt.c
@@ -2592,7 +2592,6 @@ int __init vty_init(void)
 	if (!console_driver)
 		panic("Couldn't allocate console driver\n");
 	console_driver->owner = THIS_MODULE;
-	console_driver->devfs_name = "vc/";
 	console_driver->name = "tty";
 	console_driver->name_base = 1;
 	console_driver->major = TTY_MAJOR;
diff --git a/drivers/isdn/capi/capi.c b/drivers/isdn/capi/capi.c
--- a/drivers/isdn/capi/capi.c
+++ b/drivers/isdn/capi/capi.c
@@ -1327,7 +1327,6 @@ static int capinc_tty_init(void)
 
 	drv->owner = THIS_MODULE;
 	drv->driver_name = "capi_nc";
-	drv->devfs_name = "capi/";
 	drv->name = "capi";
 	drv->major = capi_ttymajor;
 	drv->minor_start = 0;
diff --git a/drivers/isdn/i4l/isdn_tty.c b/drivers/isdn/i4l/isdn_tty.c
--- a/drivers/isdn/i4l/isdn_tty.c
+++ b/drivers/isdn/i4l/isdn_tty.c
@@ -1901,7 +1901,6 @@ isdn_tty_modem_init(void)
 	if (!m->tty_modem)
 		return -ENOMEM;
 	m->tty_modem->name = "ttyI";
-	m->tty_modem->devfs_name = "isdn/ttyI";
 	m->tty_modem->major = ISDN_TTY_MAJOR;
 	m->tty_modem->minor_start = 0;
 	m->tty_modem->type = TTY_DRIVER_TYPE_SERIAL;
diff --git a/drivers/macintosh/macserial.c b/drivers/macintosh/macserial.c
--- a/drivers/macintosh/macserial.c
+++ b/drivers/macintosh/macserial.c
@@ -2521,7 +2521,6 @@ no_dma:		
 
 	serial_driver->owner = THIS_MODULE;
 	serial_driver->driver_name = "macserial";
-	serial_driver->devfs_name = "tts/";
 	serial_driver->name = "ttyS";
 	serial_driver->major = TTY_MAJOR;
 	serial_driver->minor_start = 64;
diff --git a/drivers/s390/char/tty3270.c b/drivers/s390/char/tty3270.c
--- a/drivers/s390/char/tty3270.c
+++ b/drivers/s390/char/tty3270.c
@@ -1790,7 +1790,6 @@ tty3270_init(void)
 	 * proc_entry, set_termios, flush_buffer, set_ldisc, write_proc
 	 */
 	driver->owner = THIS_MODULE;
-	driver->devfs_name = "ttyTUB/";
 	driver->driver_name = "ttyTUB";
 	driver->name = "ttyTUB";
 	driver->major = IBM_TTY3270_MAJOR;
diff --git a/drivers/s390/net/ctctty.c b/drivers/s390/net/ctctty.c
--- a/drivers/s390/net/ctctty.c
+++ b/drivers/s390/net/ctctty.c
@@ -1150,7 +1150,6 @@ ctc_tty_init(void)
 		return -ENOMEM;
 	}
 
-	device->devfs_name = "ctc/" CTC_TTY_NAME;
 	device->name = CTC_TTY_NAME;
 	device->major = CTC_TTY_MAJOR;
 	device->minor_start = 0;
diff --git a/drivers/tc/zs.c b/drivers/tc/zs.c
--- a/drivers/tc/zs.c
+++ b/drivers/tc/zs.c
@@ -1785,7 +1785,6 @@ int __init zs_init(void)
 	/* Not all of this is exactly right for us. */
 
 	serial_driver->owner = THIS_MODULE;
-	serial_driver->devfs_name = "tts/";
 	serial_driver->name = "ttyS";
 	serial_driver->major = TTY_MAJOR;
 	serial_driver->minor_start = 64;
diff --git a/drivers/usb/class/bluetty.c b/drivers/usb/class/bluetty.c
--- a/drivers/usb/class/bluetty.c
+++ b/drivers/usb/class/bluetty.c
@@ -1118,9 +1118,9 @@ static int usb_bluetooth_probe (struct u
 		     bluetooth->interrupt_in_buffer, buffer_size, bluetooth_int_callback,
 		     bluetooth, endpoint->bInterval);
 
-	/* initialize the devfs nodes for this device and let the user know what bluetooths we are bound to */
+	/* register the tty device and let the user know what bluetooths we are bound to */
 	tty_register_device (bluetooth_tty_driver, minor, &intf->dev);
-	info("Bluetooth converter now attached to ttyUB%d (or usb/ttub/%d for devfs)", minor, minor);
+	info("Bluetooth converter now attached to ttyUB%d", minor);
 
 	bluetooth_table[minor] = bluetooth;
 
@@ -1231,7 +1231,6 @@ static int usb_bluetooth_init(void)
 	bluetooth_tty_driver->owner = THIS_MODULE;
 	bluetooth_tty_driver->driver_name = "usb-bluetooth";
 	bluetooth_tty_driver->name = "ttyUB";
-	bluetooth_tty_driver->devfs_name = "usb/ttub/";
 	bluetooth_tty_driver->major = BLUETOOTH_TTY_MAJOR;
 	bluetooth_tty_driver->minor_start = 0;
 	bluetooth_tty_driver->type = TTY_DRIVER_TYPE_SERIAL;
diff --git a/drivers/usb/class/cdc-acm.c b/drivers/usb/class/cdc-acm.c
--- a/drivers/usb/class/cdc-acm.c
+++ b/drivers/usb/class/cdc-acm.c
@@ -898,7 +898,6 @@ static int __init acm_init(void)
 	acm_tty_driver->owner = THIS_MODULE,
 	acm_tty_driver->driver_name = "acm",
 	acm_tty_driver->name = "ttyACM",
-	acm_tty_driver->devfs_name = "usb/acm/",
 	acm_tty_driver->major = ACM_TTY_MAJOR,
 	acm_tty_driver->minor_start = 0,
 	acm_tty_driver->type = TTY_DRIVER_TYPE_SERIAL,
diff --git a/drivers/usb/gadget/serial.c b/drivers/usb/gadget/serial.c
--- a/drivers/usb/gadget/serial.c
+++ b/drivers/usb/gadget/serial.c
@@ -663,7 +663,6 @@ static int __init gs_module_init(void)
 	gs_tty_driver->owner = THIS_MODULE;
 	gs_tty_driver->driver_name = GS_SHORT_NAME;
 	gs_tty_driver->name = "ttygs";
-	gs_tty_driver->devfs_name = "usb/ttygs/";
 	gs_tty_driver->major = GS_MAJOR;
 	gs_tty_driver->minor_start = GS_MINOR_START;
 	gs_tty_driver->type = TTY_DRIVER_TYPE_SERIAL;
diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -1299,7 +1299,6 @@ static int __init usb_serial_init(void)
 
 	usb_serial_tty_driver->owner = THIS_MODULE;
 	usb_serial_tty_driver->driver_name = "usbserial";
-	usb_serial_tty_driver->devfs_name = "usb/tts/";
 	usb_serial_tty_driver->name = 	"ttyUSB";
 	usb_serial_tty_driver->major = SERIAL_TTY_MAJOR;
 	usb_serial_tty_driver->minor_start = 0;
diff --git a/include/linux/tty_driver.h b/include/linux/tty_driver.h
--- a/include/linux/tty_driver.h
+++ b/include/linux/tty_driver.h
@@ -157,7 +157,6 @@ struct tty_driver {
 	struct cdev cdev;
 	struct module	*owner;
 	const char	*driver_name;
-	const char	*devfs_name;
 	const char	*name;
 	int	name_base;	/* offset of printed name */
 	int	major;		/* major device number */
diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
--- a/net/bluetooth/rfcomm/tty.c
+++ b/net/bluetooth/rfcomm/tty.c
@@ -901,7 +901,6 @@ int rfcomm_init_ttys(void)
 
 	rfcomm_tty_driver->owner	= THIS_MODULE;
 	rfcomm_tty_driver->driver_name	= "rfcomm";
-	rfcomm_tty_driver->devfs_name	= "bluetooth/rfcomm/";
 	rfcomm_tty_driver->name		= "rfcomm";
 	rfcomm_tty_driver->major	= RFCOMM_TTY_MAJOR;
 	rfcomm_tty_driver->minor_start	= RFCOMM_TTY_MINOR;
diff --git a/net/irda/ircomm/ircomm_tty.c b/net/irda/ircomm/ircomm_tty.c
--- a/net/irda/ircomm/ircomm_tty.c
+++ b/net/irda/ircomm/ircomm_tty.c
@@ -124,7 +124,6 @@ static int __init ircomm_tty_init(void)
 	driver->owner		= THIS_MODULE;
 	driver->driver_name     = "ircomm";
 	driver->name            = "ircomm";
-	driver->devfs_name      = "ircomm";
 	driver->major           = IRCOMM_TTY_MAJOR;
 	driver->minor_start     = IRCOMM_TTY_MINOR;
 	driver->type            = TTY_DRIVER_TYPE_SERIAL;

