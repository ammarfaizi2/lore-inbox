Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264455AbTFUOH5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jun 2003 10:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262525AbTFUOH5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jun 2003 10:07:57 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:28912 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264455AbTFUOHz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jun 2003 10:07:55 -0400
Date: Sat, 21 Jun 2003 16:21:53 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org
Subject: [2.5 patch] fix buggy comparison in cpqphp_pci.c
Message-ID: <20030621142153.GU29247@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

I don't understand the code good enough to be sure my patch is correct, 
but the current code is definitely buggy:

0xFF is the maximum value for an u8, so tdevice < 0x100 is _always_ 
true.

cu
Adrian

--- linux-2.5.72-mm2/drivers/pci/hotplug/cpqphp_pci.c.old	2003-06-21 16:16:14.000000000 +0200
+++ linux-2.5.72-mm2/drivers/pci/hotplug/cpqphp_pci.c	2003-06-21 16:16:45.000000000 +0200
@@ -198,7 +198,7 @@
 
 	ctrl->pci_bus->number = bus_num;
 
-	for (tdevice = 0; tdevice < 0x100; tdevice++) {
+	for (tdevice = 0; tdevice < 0xFF; tdevice++) {
 		//Scan for access first
 		if (PCI_RefinedAccessConfig(ctrl->pci_bus, tdevice, 0x08, &work) == -1)
 			continue;
@@ -210,7 +210,7 @@
 			return 0;
 		}
 	}
-	for (tdevice = 0; tdevice < 0x100; tdevice++) {
+	for (tdevice = 0; tdevice < 0xFF; tdevice++) {
 		//Scan for access first
 		if (PCI_RefinedAccessConfig(ctrl->pci_bus, tdevice, 0x08, &work) == -1)
 			continue;
