Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753408AbWKFQiV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753408AbWKFQiV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 11:38:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753404AbWKFQiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 11:38:21 -0500
Received: from xdsl-664.zgora.dialog.net.pl ([81.168.226.152]:3084 "EHLO
	tuxland.pl") by vger.kernel.org with ESMTP id S1753402AbWKFQiU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 11:38:20 -0500
From: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Organization: tuxland
To: "Florian 'Floe' Echtler" <echtler@fs.tum.de>,
       "Andreas 'ad' Deresch" <aderesch@fs.tum.de>,
       Greg Kroah-Hartman <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 2.6.19-rc4] usb idmouse cleanup
Date: Mon, 6 Nov 2006 17:37:20 +0100
User-Agent: KMail/1.9.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611061737.20994.m.kozlowski@tuxland.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

	Just digging through code and found these needless variable initializations. So here is the patch.

Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>

diff -up linux-2.6.19-rc4-orig/drivers/usb/misc/idmouse.c linux-2.6.19-rc4/drivers/usb/misc/idmouse.c
--- linux-2.6.19-rc4-orig/drivers/usb/misc/idmouse.c    2006-11-06 17:08:21.000000000 +0100
+++ linux-2.6.19-rc4/drivers/usb/misc/idmouse.c 2006-11-06 17:32:50.000000000 +0100
@@ -125,12 +125,12 @@ static DEFINE_MUTEX(disconnect_mutex);
 
 static int idmouse_create_image(struct usb_idmouse *dev)
 {
-       int bytes_read = 0;
-       int bulk_read = 0;
-       int result = 0;
+       int bytes_read;
+       int bulk_read;
+       int result;
 
        memcpy(dev->bulk_in_buffer, HEADER, sizeof(HEADER)-1);
-       bytes_read += sizeof(HEADER)-1;
+       bytes_read = sizeof(HEADER)-1;
 
        /* reset the device and set a fast blink rate */
        result = ftip_command(dev, FTIP_RELEASE, 0, 0);
@@ -208,9 +208,9 @@ static inline void idmouse_delete(struct
 
 static int idmouse_open(struct inode *inode, struct file *file)
 {
-       struct usb_idmouse *dev = NULL;
+       struct usb_idmouse *dev;
        struct usb_interface *interface;
-       int result = 0;
+       int result;
 
        /* prevent disconnects */
        mutex_lock(&disconnect_mutex);
@@ -305,7 +305,7 @@ static ssize_t idmouse_read(struct file 
                                loff_t * ppos)
 {
        struct usb_idmouse *dev;
-       int result = 0;
+       int result;
 
        dev = (struct usb_idmouse *) file->private_data;
 
@@ -329,7 +329,7 @@ static int idmouse_probe(struct usb_inte
                                const struct usb_device_id *id)
 {
        struct usb_device *udev = interface_to_usbdev(interface);
-       struct usb_idmouse *dev = NULL;
+       struct usb_idmouse *dev;
        struct usb_host_interface *iface_desc;
        struct usb_endpoint_descriptor *endpoint;
        int result;
