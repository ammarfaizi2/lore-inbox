Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261162AbVCAAnK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261162AbVCAAnK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 19:43:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbVCAAl5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 19:41:57 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:26123 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261168AbVCAAji (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 19:39:38 -0500
Date: Tue, 1 Mar 2005 01:39:35 +0100
From: Adrian Bunk <bunk@stusta.de>
To: gregkh@suse.de
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/usb/serial/: make some functions static
Message-ID: <20050301003935.GC4021@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes some needlessly global functions static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/usb/serial/ftdi_sio.c   |   12 +++++++-----
 drivers/usb/serial/garmin_gps.c |    4 ++--
 drivers/usb/serial/ipw.c        |    4 ++--
 3 files changed, 11 insertions(+), 9 deletions(-)

--- linux-2.6.11-rc4-mm1-full/drivers/usb/serial/ftdi_sio.c.old	2005-02-28 23:31:03.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/usb/serial/ftdi_sio.c	2005-02-28 23:32:13.000000000 +0100
@@ -1187,7 +1187,7 @@
  * ***************************************************************************
  */
 
-ssize_t show_latency_timer(struct device *dev, char *buf)
+static ssize_t show_latency_timer(struct device *dev, char *buf)
 {
 	struct usb_serial_port *port = to_usb_serial_port(dev);
 	struct ftdi_private *priv = usb_get_serial_port_data(port);
@@ -1214,7 +1214,8 @@
 }
 
 /* Write a new value of the latency timer, in units of milliseconds. */
-ssize_t store_latency_timer(struct device *dev, const char *valbuf, size_t count)
+static ssize_t store_latency_timer(struct device *dev, const char *valbuf,
+				   size_t count)
 {
 	struct usb_serial_port *port = to_usb_serial_port(dev);
 	struct ftdi_private *priv = usb_get_serial_port_data(port);
@@ -1244,7 +1245,8 @@
 
 /* Write an event character directly to the FTDI register.  The ASCII
    value is in the low 8 bits, with the enable bit in the 9th bit. */
-ssize_t store_event_char(struct device *dev, const char *valbuf, size_t count)
+static ssize_t store_event_char(struct device *dev, const char *valbuf,
+				size_t count)
 {
 	struct usb_serial_port *port = to_usb_serial_port(dev);
 	struct ftdi_private *priv = usb_get_serial_port_data(port);
@@ -1275,7 +1277,7 @@
 static DEVICE_ATTR(latency_timer, S_IWUGO | S_IRUGO, show_latency_timer, store_latency_timer);
 static DEVICE_ATTR(event_char, S_IWUGO, NULL, store_event_char);
 
-void create_sysfs_attrs(struct usb_serial *serial)
+static void create_sysfs_attrs(struct usb_serial *serial)
 {	
 	struct ftdi_private *priv;
 	struct usb_device *udev;
@@ -1292,7 +1294,7 @@
 	}
 }
 
-void remove_sysfs_attrs(struct usb_serial *serial)
+static void remove_sysfs_attrs(struct usb_serial *serial)
 {
 	struct ftdi_private *priv;
 	struct usb_device *udev;
--- linux-2.6.11-rc4-mm1-full/drivers/usb/serial/garmin_gps.c.old	2005-02-28 23:32:28.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/usb/serial/garmin_gps.c	2005-02-28 23:32:50.000000000 +0100
@@ -614,8 +614,8 @@
  *
  * return <0 on error, 0 if packet is incomplete or > 0 if packet was sent
  */
-int gsp_send(struct garmin_data * garmin_data_p, const unsigned char *buf,
-              int count)
+static int gsp_send(struct garmin_data * garmin_data_p,
+		    const unsigned char *buf, int count)
 {
 	const unsigned char *src;
 	unsigned char *dst;
--- linux-2.6.11-rc4-mm1-full/drivers/usb/serial/ipw.c.old	2005-02-28 23:33:10.000000000 +0100
+++ linux-2.6.11-rc4-mm1-full/drivers/usb/serial/ipw.c	2005-02-28 23:33:43.000000000 +0100
@@ -457,7 +457,7 @@
 
 
 
-int usb_ipw_init(void)
+static int usb_ipw_init(void)
 {
 	int retval;
 
@@ -473,7 +473,7 @@
 	return 0;
 }
 
-void usb_ipw_exit(void)
+static void usb_ipw_exit(void)
 {
 	usb_deregister(&usb_ipw_driver);
 	usb_serial_deregister(&ipw_device);

