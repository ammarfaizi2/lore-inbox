Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262742AbTDVACr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Apr 2003 20:02:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262763AbTDVACr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Apr 2003 20:02:47 -0400
Received: from siaab1aa.compuserve.com ([149.174.40.1]:50171 "EHLO
	siaab1aa.compuserve.com") by vger.kernel.org with ESMTP
	id S262742AbTDVACp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Apr 2003 20:02:45 -0400
Date: Mon, 21 Apr 2003 20:12:07 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: booting 2.5.68 with root on software raid and devfs?
To: Pierfrancesco Caci <pf@tippete.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304212014_MC3-1-355B-2825@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I have the suspect that something in the naming of devices has
> changed, but I can't find any reference by googling around.


  Try this:


--- linux-2.5.66-ref/drivers/pci/bus.c	Sat Mar 29 09:16:22 2003
+++ linux-2.5.66-uni/drivers/pci/bus.c	Fri Apr 18 19:08:04 2003
@ -75,7 +75,8 @
  * Add newly discovered PCI devices (which are on the bus->devices
  * list) to the global PCI device list, add the sysfs and procfs
  * entries.  Where a bridge is found, add the discovered bus to
- * the parents list of child buses, and recurse.
+ * the parents list of child buses, and recurse (breadth-first
+ * to be compatible with 2.4)
  *
  * Call hotplug for each new devices.
  */
@ -98,6 +99,12 @
 #endif
 		pci_create_sysfs_dev_files(dev);
 
+	}
+
+	list_for_each_entry(dev, &bus->devices, bus_list) {
+
+		BUG_ON(list_empty(&dev->global_list));
+
 		/*
 		 * If there is an unattached subordinate bus, attach
 		 * it and then scan for unattached PCI devices.



------
 Chuck
