Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133098AbRDZEmD>; Thu, 26 Apr 2001 00:42:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133099AbRDZElv>; Thu, 26 Apr 2001 00:41:51 -0400
Received: from ohiper1-111.apex.net ([209.250.47.126]:15114 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S133098AbRDZElp>; Thu, 26 Apr 2001 00:41:45 -0400
Date: Wed, 25 Apr 2001 23:39:39 -0500
From: Steven Walter <srwalter@yahoo.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] to detect ActionTec PCI modem
Message-ID: <20010425233939.A29065@hapablap.dyn.dhs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
X-Uptime: 11:36pm  up 1 day,  6:43,  1 user,  load average: 0.15, 0.20, 0.26
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch modifies serial.c to detect the ActionTec PCI modem.  This
particular device has a class of PCI_CLASS_COMMUNICATION_OTHER, so it
isn't detected by the current catch-all rule that detects devices of
"PCI_CLASS_COMMUNICATION_SERIAL".

Patch is against kernel 2.4.3.  Tested to compiled and run.  Comments
welcome.
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell

--- clean-2.4.3/drivers/char/serial.c	Fri Mar 30 23:15:33 2001
+++ linux/drivers/char/serial.c	Tue Apr 24 16:32:02 2001
@@ -4706,6 +4728,8 @@
 
 
 static struct pci_device_id serial_pci_tbl[] __devinitdata = {
+       { PCI_VENDOR_ID_ATT, PCI_DEVICE_ID_ATT_VENUS_MODEM,
+         PCI_ANY_ID, PCI_ANY_ID, },
        { PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
 	 PCI_CLASS_COMMUNICATION_SERIAL << 8, 0xffff00, },
        { 0, }
