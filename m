Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S261237AbVCEXji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261237AbVCEXji (ORCPT <rfc822;akpm@zip.com.au>);
	Sat, 5 Mar 2005 18:39:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbVCEXjY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 18:39:24 -0500
Received: from vms040pub.verizon.net ([206.46.252.40]:32645 "EHLO
	vms040pub.verizon.net") by vger.kernel.org with ESMTP
	id S261248AbVCEXiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 18:38:14 -0500
Date: Sat, 05 Mar 2005 17:38:14 -0600 (CST)
Date-warning: Date header was inserted by vms040.mailsrvcs.net
From: James Nelson <james4765@cwazy.co.uk>
Subject: [PATCH 11/13] safe_serial: Clean up printk()'s in
 drivers/usb/serial/safe_serial.c
In-reply-to: <20050305233712.7648.24364.93822@localhost.localdomain>
To: linux-kernel@vger.kernel.org
Cc: akpm@osdl.org, James Nelson <james4765@cwazy.co.uk>
Message-id: <20050305233813.7648.19618.74442@localhost.localdomain>
References: <20050305233712.7648.24364.93822@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix missing KERN_ constants in buffer dump loops in drivers/usb/serial/safe_serial.c

Signed-off-by: James Nelson <james4765@gmail.com>

diff -Nurp -x dontdiff-osdl --exclude='*~' linux-2.6.11-mm1-original/drivers/usb/serial/safe_serial.c linux-2.6.11-mm1/drivers/usb/serial/safe_serial.c
--- linux-2.6.11-mm1-original/drivers/usb/serial/safe_serial.c	2005-03-05 13:29:48.000000000 -0500
+++ linux-2.6.11-mm1/drivers/usb/serial/safe_serial.c	2005-03-05 16:04:23.000000000 -0500
@@ -227,7 +227,10 @@ static void safe_read_bulk_callback (str
 		unsigned char *cp = port->read_urb->transfer_buffer;
 		for (i = 0; i < port->read_urb->actual_length; i++) {
 			if ((i % 32) == 0) {
-				printk ("\nru[%02x] ", i);
+				if (i == 0)
+					printk (KERN_DEBUG "start");
+				printk ("\n")
+				printk (KERN_DEBUG "ru[%02x] ", i);
 			}
 			printk ("%02x ", *cp++);
 		}
@@ -345,7 +348,10 @@ static int safe_write (struct usb_serial
 		unsigned char *cp = port->write_urb->transfer_buffer;
 		for (i = 0; i < port->write_urb->transfer_buffer_length; i++) {
 			if ((i % 32) == 0) {
-				printk ("\nsu[%02x] ", i);
+				if (i ==0)
+					printk (KERN_DEBUG "start");
+				printk ("\n");
+				printk (KERN_DEBUG "su[%02x] ", i);
 			}
 			printk ("%02x ", *cp++);
 		}
