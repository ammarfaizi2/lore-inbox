Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285935AbSAUNSy>; Mon, 21 Jan 2002 08:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286179AbSAUNSq>; Mon, 21 Jan 2002 08:18:46 -0500
Received: from gw.lowendale.com.au ([203.26.242.120]:3132 "EHLO
	marina.lowendale.com.au") by vger.kernel.org with ESMTP
	id <S285935AbSAUNSc>; Mon, 21 Jan 2002 08:18:32 -0500
Date: Tue, 22 Jan 2002 00:44:01 +1100 (EST)
From: Neale Banks <neale@lowendale.com.au>
To: linux-kernel@vger.kernel.org, saw@saw.sw.com.sg
Subject: [PATCH][2.2] eepro100 - gracefully handle init_etherdev failure
Message-ID: <Pine.LNX.4.05.10201220036450.8853-100000@marina.lowendale.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings,

Appended patch against 2.2.21pre2 is for eepro100 to gracefully handle the
case where init_etherdev() returns NULL.

BTW, in testing this the unpatched eepro100 driver module apeared to get
wedged in an initialising status - is this normal?

Regards,
Neale.

--- linux-2.2.21-pre2-pristine/drivers/net/eepro100.c	Mon Mar 26 02:37:34 2001
+++ linux-2.2.21-pre2-ntb/drivers/net/eepro100.c	Mon Jan 21 21:40:38 2002
@@ -43,6 +43,8 @@
 		Changed command completion time and added debug info as to which
 		CMD timed out. Problem reported by:
 		"Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
+	2002 Jan 21  Neale Banks <neale@lowendale.com.au>
+		Gracefully handle the case where init_etherdev() returns NULL
 */
 
 /*#define USE_IO*/
@@ -698,6 +700,11 @@
 #endif
 
 	dev = init_etherdev(NULL, sizeof(struct speedo_private));
+
+	if (dev == NULL) {
+		printk(KERN_ERR "eepro100: Unable to allocate net_device structure!\n");
+		return NULL;
+	}
 
 	if (dev->mem_start > 0)
 		option = dev->mem_start;

