Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267326AbUHWSz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267326AbUHWSz6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 14:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266495AbUHWSyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 14:54:47 -0400
Received: from mail.kroah.org ([69.55.234.183]:15300 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267326AbUHWShK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:37:10 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <1093286086721@kroah.com>
Date: Mon, 23 Aug 2004 11:34:46 -0700
Message-Id: <10932860863693@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1807.56.19, 2004/08/05 15:34:23-07:00, bjorn.helgaas@hp.com

[PATCH] PCI: Document pci_disable_device()

Add documentation for pci_disable_device().  We don't actually
deallocate IRQ resources in pci_disable_device() yet, but I suspect
we'll need to do so soon.

Signed-off-by: Bjorn Helgaas <bjorn.helgaas@hp.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 Documentation/pci.txt |   11 +++++++++--
 1 files changed, 9 insertions(+), 2 deletions(-)


diff -Nru a/Documentation/pci.txt b/Documentation/pci.txt
--- a/Documentation/pci.txt	2004-08-23 11:05:10 -07:00
+++ b/Documentation/pci.txt	2004-08-23 11:05:10 -07:00
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

