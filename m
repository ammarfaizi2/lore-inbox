Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261599AbVDRCMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261599AbVDRCMg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Apr 2005 22:12:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261603AbVDRCMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Apr 2005 22:12:36 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:58118 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261599AbVDRCM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Apr 2005 22:12:29 -0400
Date: Mon, 18 Apr 2005 04:12:28 +0200
From: Adrian Bunk <bunk@stusta.de>
To: pe1rxq@amsat.org
Cc: greg@kroah.com, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/usb/net/zd1201.c: make some code static
Message-ID: <20050418021228.GE3625@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes some needlessly global code static.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/usb/net/zd1201.c |   20 +++++++++++---------
 1 files changed, 11 insertions(+), 9 deletions(-)

--- linux-2.6.12-rc2-mm3-full/drivers/usb/net/zd1201.c.old	2005-04-18 03:16:40.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/usb/net/zd1201.c	2005-04-18 03:18:49.000000000 +0200
@@ -45,7 +45,7 @@
 MODULE_DEVICE_TABLE(usb, zd1201_table);
 
 
-int zd1201_fw_upload(struct usb_device *dev, int apfw)
+static int zd1201_fw_upload(struct usb_device *dev, int apfw)
 {
 	const struct firmware *fw_entry;
 	char* data;
@@ -112,7 +112,7 @@
 	return err;
 }
 
-void zd1201_usbfree(struct urb *urb, struct pt_regs *regs)
+static void zd1201_usbfree(struct urb *urb, struct pt_regs *regs)
 {
 	struct zd1201 *zd = urb->context;
 
@@ -143,7 +143,8 @@
 
 	total: 4 + 2 + 2 + 2 + 2 + 4 = 16
 */
-int zd1201_docmd(struct zd1201 *zd, int cmd, int parm0, int parm1, int parm2)
+static int zd1201_docmd(struct zd1201 *zd, int cmd, int parm0,
+			int parm1, int parm2)
 {
 	unsigned char *command;
 	int ret;
@@ -176,7 +177,7 @@
 }
 
 /* Callback after sending out a packet */
-void zd1201_usbtx(struct urb *urb, struct pt_regs *regs)
+static void zd1201_usbtx(struct urb *urb, struct pt_regs *regs)
 {
 	struct zd1201 *zd = urb->context;
 	netif_wake_queue(zd->dev);
@@ -184,7 +185,7 @@
 }
 
 /* Incomming data */
-void zd1201_usbrx(struct urb *urb, struct pt_regs *regs)
+static void zd1201_usbrx(struct urb *urb, struct pt_regs *regs)
 {
 	struct zd1201 *zd = urb->context;
 	int free = 0;
@@ -614,7 +615,7 @@
 	return (zd1201_setconfig(zd, rid, &zdval, sizeof(__le16), 1));
 }
 
-int zd1201_drvr_start(struct zd1201 *zd)
+static int zd1201_drvr_start(struct zd1201 *zd)
 {
 	int err, i;
 	short max;
@@ -1740,7 +1741,8 @@
 	.private_args 		= (struct iw_priv_args *) zd1201_private_args,
 };
 
-int zd1201_probe(struct usb_interface *interface, const struct usb_device_id *id)
+static int zd1201_probe(struct usb_interface *interface,
+			const struct usb_device_id *id)
 {
 	struct zd1201 *zd;
 	struct usb_device *usb;
@@ -1852,7 +1854,7 @@
 	return err;
 }
 
-void zd1201_disconnect(struct usb_interface *interface)
+static void zd1201_disconnect(struct usb_interface *interface)
 {
 	struct zd1201 *zd=(struct zd1201 *)usb_get_intfdata(interface);
 	struct hlist_node *node, *node2;
@@ -1919,7 +1921,7 @@
 
 #endif
 
-struct usb_driver zd1201_usb = {
+static struct usb_driver zd1201_usb = {
 	.owner = THIS_MODULE,
 	.name = "zd1201",
 	.probe = zd1201_probe,

