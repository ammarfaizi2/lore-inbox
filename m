Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261252AbUL2AMg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261252AbUL2AMg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Dec 2004 19:12:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbUL2AMg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Dec 2004 19:12:36 -0500
Received: from mail.dif.dk ([193.138.115.101]:15549 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261252AbUL2AMZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Dec 2004 19:12:25 -0500
Date: Wed, 29 Dec 2004 01:23:26 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Eric van der Maarel <H.T.M.v.d.Maarel@marin.nl>
Cc: Eberhard Moenkeberg <emoenke@gwdg.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: [PATCH] add proper message levels to printk's in drivers/cdrom/isp16.c
Message-ID: <Pine.LNX.4.61.0412290118050.3528@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, 

Here's a patch to add apropriate message levels to the printk's in 
drivers/cdrom/isp16.c
Please consider applying (compile tested only due to lack of hardware).

Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -up linux-2.6.10-orig/drivers/cdrom/isp16.c linux-2.6.10/drivers/cdrom/isp16.c
--- linux-2.6.10-orig/drivers/cdrom/isp16.c	2004-12-24 22:35:28.000000000 +0100
+++ linux-2.6.10/drivers/cdrom/isp16.c	2004-12-29 01:16:20.000000000 +0100
@@ -121,17 +121,17 @@ int __init isp16_init(void)
 	       ISP16_VERSION_MAJOR, ISP16_VERSION_MINOR);
 
 	if (!strcmp(isp16_cdrom_type, "noisp16")) {
-		printk("ISP16: no cdrom interface configured.\n");
+		printk(KERN_ERR "ISP16: no cdrom interface configured.\n");
 		return 0;
 	}
 
 	if (!request_region(ISP16_IO_BASE, ISP16_IO_SIZE, "isp16")) {
-		printk("ISP16: i/o ports already in use.\n");
+		printk(KERN_ERR "ISP16: i/o ports already in use.\n");
 		goto out;
 	}
 
 	if ((isp16_type = isp16_detect()) < 0) {
-		printk("ISP16: no cdrom interface found.\n");
+		printk(KERN_ERR "ISP16: no cdrom interface found.\n");
 		goto cleanup_out;
 	}
 
@@ -150,15 +150,15 @@ int __init isp16_init(void)
 	else if (!strcmp(isp16_cdrom_type, "Mitsumi"))
 		expected_drive = ISP16_MITSUMI;
 	else {
-		printk("ISP16: %s not supported by cdrom interface.\n",
+		printk(KERN_ERR "ISP16: %s not supported by cdrom interface.\n",
 		       isp16_cdrom_type);
 		goto cleanup_out;
 	}
 
 	if (isp16_cdi_config(isp16_cdrom_base, expected_drive,
 			     isp16_cdrom_irq, isp16_cdrom_dma) < 0) {
-		printk
-		    ("ISP16: cdrom interface has not been properly configured.\n");
+		printk(KERN_ERR 
+		       "ISP16: cdrom interface has not been properly configured.\n");
 		goto cleanup_out;
 	}
 	printk(KERN_INFO
@@ -262,7 +262,7 @@ isp16_cdi_config(int base, u_char drive_
 	u_char i;
 
 	if ((drive_type == ISP16_MITSUMI) && (dma != 0))
-		printk("ISP16: Mitsumi cdrom drive has no dma support.\n");
+		printk(KERN_WARNING "ISP16: Mitsumi cdrom drive has no dma support.\n");
 
 	switch (base) {
 	case 0x340:
@@ -278,9 +278,9 @@ isp16_cdi_config(int base, u_char drive_
 		base_code = ISP16_BASE_320;
 		break;
 	default:
-		printk
-		    ("ISP16: base address 0x%03X not supported by cdrom interface.\n",
-		     base);
+		printk(KERN_ERR 
+		       "ISP16: base address 0x%03X not supported by cdrom interface.\n",
+		       base);
 		return -1;
 	}
 	switch (irq) {
@@ -289,12 +289,12 @@ isp16_cdi_config(int base, u_char drive_
 		break;		/* disable irq */
 	case 5:
 		irq_code = ISP16_IRQ_5;
-		printk("ISP16: irq 5 shouldn't be used by cdrom interface,"
+		printk(KERN_WARNING "ISP16: irq 5 shouldn't be used by cdrom interface,"
 		       " due to possible conflicts with the sound card.\n");
 		break;
 	case 7:
 		irq_code = ISP16_IRQ_7;
-		printk("ISP16: irq 7 shouldn't be used by cdrom interface,"
+		printk(KERN_WARNING "ISP16: irq 7 shouldn't be used by cdrom interface,"
 		       " due to possible conflicts with the sound card.\n");
 		break;
 	case 3:
@@ -310,7 +310,7 @@ isp16_cdi_config(int base, u_char drive_
 		irq_code = ISP16_IRQ_11;
 		break;
 	default:
-		printk("ISP16: irq %d not supported by cdrom interface.\n",
+		printk(KERN_ERR "ISP16: irq %d not supported by cdrom interface.\n",
 		       irq);
 		return -1;
 	}
@@ -319,7 +319,7 @@ isp16_cdi_config(int base, u_char drive_
 		dma_code = ISP16_DMA_X;
 		break;		/* disable dma */
 	case 1:
-		printk("ISP16: dma 1 cannot be used by cdrom interface,"
+		printk(KERN_ERR "ISP16: dma 1 cannot be used by cdrom interface,"
 		       " due to conflict with the sound card.\n");
 		return -1;
 		break;
@@ -336,7 +336,7 @@ isp16_cdi_config(int base, u_char drive_
 		dma_code = ISP16_DMA_7;
 		break;
 	default:
-		printk("ISP16: dma %d not supported by cdrom interface.\n",
+		printk(KERN_ERR "ISP16: dma %d not supported by cdrom interface.\n",
 		       dma);
 		return -1;
 	}
@@ -345,9 +345,9 @@ isp16_cdi_config(int base, u_char drive_
 	    drive_type != ISP16_PANASONIC1 && drive_type != ISP16_SANYO0 &&
 	    drive_type != ISP16_SANYO1 && drive_type != ISP16_MITSUMI &&
 	    drive_type != ISP16_DRIVE_X) {
-		printk
-		    ("ISP16: drive type (code 0x%02X) not supported by cdrom"
-		     " interface.\n", drive_type);
+		printk(KERN_ERR 
+		       "ISP16: drive type (code 0x%02X) not supported by cdrom"
+		       " interface.\n", drive_type);
 		return -1;
 	}
 



