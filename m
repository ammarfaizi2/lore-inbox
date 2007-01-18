Return-Path: <linux-kernel-owner+w=401wt.eu-S1751711AbXARAEH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751711AbXARAEH (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 19:04:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751441AbXARAEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 19:04:06 -0500
Received: from mail.sierrawireless.com ([204.50.29.40]:51077 "EHLO
	mx1.sierrawireless.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867AbXARAEF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 19:04:05 -0500
Message-ID: <45AEB982.7020705@sierrawireless.com>
Date: Wed, 17 Jan 2007 16:04:18 -0800
From: Kevin Lloyd <klloyd@sierrawireless.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061219)
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: gregkh@suse.de, linux-usb-devel@lists.sourceforge.net,
       linux-usb-users@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       torvalds@osdl.org, Peter Kucmeroski <PKucmeroski@novell.com>,
       Jason Ganovsky <JGanovsky@novell.com>
Subject: [PATCH 2.6.20-rc5 01/01] usb: Sierra Wireless auto set D0
References: <45AC2B68.9060904@sierrawireless.com> <20070117215635.GA14495@kroah.com>
In-Reply-To: <20070117215635.GA14495@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 17 Jan 2007 23:59:13.0247 (UTC) FILETIME=[7CD7CEF0:01C73A93]
X-TM-AS-Product-Ver: SMEX-7.2.0.1122-3.6.1039-14942.000
X-TM-AS-Result: No--7.829600-5.000000-2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

from: Kevin Lloyd <linux@sierrawireless.com>

This patch ensures that the device is turned on when inserted into the system.
It also adds more VID/PIDs and matches the N_OUT_URB with the airprime driver.

Signed-off-by: Kevin Lloyd <linux@sierrawireless.com>

--- 

--- linux-2.6.20-rc5/drivers/usb/serial/sierra.c.orig	2007-01-15 15:17:15.000000000 -0800
+++ linux-2.6.20-rc5/drivers/usb/serial/sierra.c	2007-01-17 15:41:59.000000000 -0800
@@ -13,10 +13,9 @@
   Portions based on the option driver by Matthias Urlichs <smurf@smurf.noris.de>
   Whom based his on the Keyspan driver by Hugh Blemings <hugh@blemings.org>
 
-  History:
 */
 
-#define DRIVER_VERSION "v.1.0.5"
+#define DRIVER_VERSION "v.1.0.6"
 #define DRIVER_AUTHOR "Kevin Lloyd <linux@sierrawireless.com>"
 #define DRIVER_DESC "USB Driver for Sierra Wireless USB modems"
 
@@ -31,14 +30,15 @@
 
 
 static struct usb_device_id id_table [] = {
+	{ USB_DEVICE(0x1199, 0x0017) },	/* Sierra Wireless EM5625 */
 	{ USB_DEVICE(0x1199, 0x0018) },	/* Sierra Wireless MC5720 */
+	{ USB_DEVICE(0x1199, 0x0218) },	/* Sierra Wireless MC5720 */
 	{ USB_DEVICE(0x1199, 0x0020) },	/* Sierra Wireless MC5725 */
-	{ USB_DEVICE(0x1199, 0x0017) },	/* Sierra Wireless EM5625 */
 	{ USB_DEVICE(0x1199, 0x0019) },	/* Sierra Wireless AirCard 595 */
-	{ USB_DEVICE(0x1199, 0x0218) },	/* Sierra Wireless MC5720 */
+	{ USB_DEVICE(0x1199, 0x0021) },	/* Sierra Wireless AirCard 597E */
 	{ USB_DEVICE(0x1199, 0x6802) },	/* Sierra Wireless MC8755 */
+	{ USB_DEVICE(0x1199, 0x6804) },	/* Sierra Wireless MC8755 */
 	{ USB_DEVICE(0x1199, 0x6803) },	/* Sierra Wireless MC8765 */
-	{ USB_DEVICE(0x1199, 0x6804) },	/* Sierra Wireless MC8755 for Europe */
 	{ USB_DEVICE(0x1199, 0x6812) },	/* Sierra Wireless MC8775 */
 	{ USB_DEVICE(0x1199, 0x6820) },	/* Sierra Wireless AirCard 875 */
 
@@ -55,14 +55,15 @@ static struct usb_device_id id_table_1po
 };
 
 static struct usb_device_id id_table_3port [] = {
+	{ USB_DEVICE(0x1199, 0x0017) },	/* Sierra Wireless EM5625 */
 	{ USB_DEVICE(0x1199, 0x0018) },	/* Sierra Wireless MC5720 */
+	{ USB_DEVICE(0x1199, 0x0218) },	/* Sierra Wireless MC5720 */
 	{ USB_DEVICE(0x1199, 0x0020) },	/* Sierra Wireless MC5725 */
-	{ USB_DEVICE(0x1199, 0x0017) },	/* Sierra Wireless EM5625 */
 	{ USB_DEVICE(0x1199, 0x0019) },	/* Sierra Wireless AirCard 595 */
-	{ USB_DEVICE(0x1199, 0x0218) },	/* Sierra Wireless MC5720 */
+	{ USB_DEVICE(0x1199, 0x0021) },	/* Sierra Wireless AirCard 597E */
 	{ USB_DEVICE(0x1199, 0x6802) },	/* Sierra Wireless MC8755 */
+	{ USB_DEVICE(0x1199, 0x6804) },	/* Sierra Wireless MC8755 */
 	{ USB_DEVICE(0x1199, 0x6803) },	/* Sierra Wireless MC8765 */
-	{ USB_DEVICE(0x1199, 0x6804) },	/* Sierra Wireless MC8755 for Europe */
 	{ USB_DEVICE(0x1199, 0x6812) },	/* Sierra Wireless MC8775 */
 	{ USB_DEVICE(0x1199, 0x6820) },	/* Sierra Wireless AirCard 875 */
 	{ }
@@ -81,7 +82,7 @@ static int debug;
 
 /* per port private data */
 #define N_IN_URB	4
-#define N_OUT_URB	1
+#define N_OUT_URB	4
 #define IN_BUFLEN	4096
 #define OUT_BUFLEN	128
 
@@ -396,6 +397,8 @@ static int sierra_open(struct usb_serial
 	struct usb_serial *serial = port->serial;
 	int i, err;
 	struct urb *urb;
+	int result;
+	__u16 set_mode_dzero = 0x0000;
 
 	portdata = usb_get_serial_port_data(port);
 
@@ -442,6 +445,11 @@ static int sierra_open(struct usb_serial
 
 	port->tty->low_latency = 1;
 
+	/*set mode to D0 */
+	result = usb_control_msg(serial->dev,
+			usb_rcvctrlpipe(serial->dev, 0),
+			0x00,0x40,set_mode_dzero,0,NULL,0,USB_CTRL_SET_TIMEOUT);
+
 	sierra_send_setup(port);
 
 	return (0);


