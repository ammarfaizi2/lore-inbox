Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266774AbUHCU0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266774AbUHCU0e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 16:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266827AbUHCU0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 16:26:34 -0400
Received: from atlrel7.hp.com ([156.153.255.213]:3053 "EHLO atlrel7.hp.com")
	by vger.kernel.org with ESMTP id S266774AbUHCU0b (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 16:26:31 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Greg Kroah-Hartman <greg@kroah.com>
Subject: [PATCH] Document pci_disable_device()
Date: Tue, 3 Aug 2004 14:26:29 -0600
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200408031426.29228.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation for pci_disable_device().  We don't actually
deallocate IRQ resources in pci_disable_device() yet, but I suspect
we'll need to do so soon.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>

===== Documentation/pci.txt 1.12 vs edited =====
--- 1.12/Documentation/pci.txt	2004-06-11 15:09:58 -06:00
+++ edited/Documentation/pci.txt	2004-08-03 14:20:22 -06:00
@@ -25,6 +25,7 @@
 	Discover resources (addresses and IRQ numbers) provided by the device
 	Allocate these resources
 	Communicate with the device
+	Disable the device
 
 Most of these topics are covered by the following sections, for the rest
 look at <linux/pci.h>, it's hopefully well commented.
@@ -162,8 +163,8 @@
 count on these devices by calling pci_dev_put().
 
 
-3. Enabling devices
-~~~~~~~~~~~~~~~~~~~
+3. Enabling and disabling devices
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    Before you do anything with the device you've found, you need to enable
 it by calling pci_enable_device() which enables I/O and memory regions of
 the device, allocates an IRQ if necessary, assigns missing resources if
@@ -179,6 +180,12 @@
 and also ensures that the cache line size register is set correctly.
 Make sure to check the return value of pci_set_mwi(), not all architectures
 may support Memory-Write-Invalidate.
+
+   If your driver decides to stop using the device (e.g., there was an
+error while setting it up or the driver module is being unloaded), it
+should call pci_disable_device() to deallocate any IRQ resources, disable
+PCI bus-mastering, etc.  You should not do anything with the device after
+calling pci_disable_device().
 
 4. How to access PCI config space
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
