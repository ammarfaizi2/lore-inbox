Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317266AbSFXDzJ>; Sun, 23 Jun 2002 23:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317267AbSFXDzI>; Sun, 23 Jun 2002 23:55:08 -0400
Received: from nycsmtp2fb.rdc-nyc.rr.com ([24.29.99.78]:12809 "EHLO si.rr.com")
	by vger.kernel.org with ESMTP id <S317266AbSFXDzH>;
	Sun, 23 Jun 2002 23:55:07 -0400
Date: Sun, 23 Jun 2002 23:46:23 -0400 (EDT)
From: Frank Davis <fdavis@si.rr.com>
X-X-Sender: fdavis@localhost.localdomain
To: linux-kernel@vger.kernel.org
cc: fdavis@si.rr.com
Subject: [PATCH] 2.5.24 : drivers/scsi/inia100.c
Message-ID: <Pine.LNX.4.44.0206232343280.909-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello all,
  This patch adds the DMA mapping check (1st step for 
Documentation/DMA-mapping.txt compliance). Please review.

Regards,
Frank

--- drivers/scsi/inia100.c.old	Wed Feb 13 21:27:00 2002
+++ drivers/scsi/inia100.c	Sun Jun 23 23:30:10 2002
@@ -248,7 +248,10 @@
 					continue;
 				if (iAdapters >= MAX_SUPPORTED_ADAPTERS)
 					break;	/* Never greater than maximum   */
-
+				if(pci_set_dma_mask(pdev, 0xffffffff))
+				{
+					printk(KERN_WARNING "inia100 : No suitable DMA available.\n");
+				}
 				if (i == 0) {
 					/*
 					   printk("inia100: The RAID controller is not supported by\n");

