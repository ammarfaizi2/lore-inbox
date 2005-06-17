Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261220AbVFQWg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261220AbVFQWg2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 18:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbVFQWg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 18:36:28 -0400
Received: from [62.101.100.8] ([62.101.100.8]:28886 "EHLO smtpout1.reply.it")
	by vger.kernel.org with ESMTP id S261220AbVFQWgW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 18:36:22 -0400
From: "Daniele Gaffuri" <d.gaffuri@reply.it>
To: <linux-kernel@vger.kernel.org>
Cc: <gregkh@suse.de>
Subject: [PATCH] Hidden SMBus bridge on Toshiba Tecra M2
Date: Sat, 18 Jun 2005 00:36:18 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Thread-Index: AcVzjPpaq8vrbdUnQR26e3yURkpPvA==
Message-ID: <TO1FRES03HbOEMBRWtC0000452f@to1fres03.replynet.prv>
X-OriginalArrivalTime: 17 Jun 2005 22:36:21.0349 (UTC) FILETIME=[FC2F2150:01C5738C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a trivial patch, against 2.6.12-rc6, to unhide SMBus on Toshiba
Centrino laptops using Intel 82855PM chipset.

--- linux-2.6.12-rc6/drivers/pci/quirks.c	2005-06-17
23:49:32.000000000 +0200
+++ linux/drivers/pci/quirks.c	2005-06-18 00:06:45.000000000 +0200
@@ -822,6 +822,11 @@
 			case 0x0001: /* Toshiba Satellite A40 */
 				asus_hides_smbus = 1;
 			}
+		if (dev->device ==  PCI_DEVICE_ID_INTEL_82855PM_HB)
+			switch(dev->subsystem_device) {
+			case 0x0001: /* Toshiba Tecra M2 */
+				asus_hides_smbus = 1;
+			}
        } else if (unlikely(dev->subsystem_vendor == PCI_VENDOR_ID_SAMSUNG))
{
                if (dev->device ==  PCI_DEVICE_ID_INTEL_82855PM_HB)
                        switch(dev->subsystem_device) {

Tested on Toshiba Tecra M2.

Daniele 

