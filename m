Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751790AbWBWWM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751790AbWBWWM4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 17:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751791AbWBWWM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 17:12:56 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:33208 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751790AbWBWWM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 17:12:56 -0500
Date: Thu, 23 Feb 2006 17:12:51 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Greg KH <greg@kroah.com>
cc: Kernel development list <linux-kernel@vger.kernel.org>
Subject: [PATCH] Move pci_dev_put outside a spinlock
Message-ID: <Pine.LNX.4.44L0.0602231710110.4579-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg:

This patch (as659) fixes a might_sleep problem in the PCI core, by moving 
a call to pci_dev_put() outside the scope of a spinlock.

Alan Stern



Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

Maybe this has already been fixed; if so the fix isn't in your 
development tree for 2.6.16-rc4.

Index: usb-2.6/drivers/pci/search.c
===================================================================
--- usb-2.6.orig/drivers/pci/search.c
+++ usb-2.6/drivers/pci/search.c
@@ -246,9 +246,9 @@ pci_get_subsys(unsigned int vendor, unsi
 	}
 	dev = NULL;
 exit:
-	pci_dev_put(from);
 	dev = pci_dev_get(dev);
 	spin_unlock(&pci_bus_lock);
+	pci_dev_put(from);
 	return dev;
 }
 

