Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264375AbTFECB5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 22:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264380AbTFECB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 22:01:56 -0400
Received: from granite.he.net ([216.218.226.66]:53510 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S264375AbTFECBz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 22:01:55 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10547787473298@kroah.com>
Subject: Re: [PATCH] PCI and PCI Hotplug changes and fixes for 2.5.70
In-Reply-To: <10547787461884@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 4 Jun 2003 19:05:47 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1254.4.3, 2003/06/03 16:41:35-07:00, greg@kroah.com

[PATCH] PCI: make pools_lock and pci_lock static.

No one is using them outside the pci core.


 drivers/pci/access.c |    3 +--
 drivers/pci/pool.c   |    2 +-
 include/linux/pci.h  |    2 --
 3 files changed, 2 insertions(+), 5 deletions(-)


diff -Nru a/drivers/pci/access.c b/drivers/pci/access.c
--- a/drivers/pci/access.c	Wed Jun  4 18:12:15 2003
+++ b/drivers/pci/access.c	Wed Jun  4 18:12:15 2003
@@ -7,7 +7,7 @@
  * configuration space.
  */
 
-spinlock_t pci_lock = SPIN_LOCK_UNLOCKED;
+static spinlock_t pci_lock = SPIN_LOCK_UNLOCKED;
 
 /*
  *  Wrappers for all PCI configuration access functions.  They just check
@@ -60,4 +60,3 @@
 EXPORT_SYMBOL(pci_bus_write_config_byte);
 EXPORT_SYMBOL(pci_bus_write_config_word);
 EXPORT_SYMBOL(pci_bus_write_config_dword);
-EXPORT_SYMBOL(pci_lock);
diff -Nru a/drivers/pci/pool.c b/drivers/pci/pool.c
--- a/drivers/pci/pool.c	Wed Jun  4 18:12:15 2003
+++ b/drivers/pci/pool.c	Wed Jun  4 18:12:15 2003
@@ -31,7 +31,7 @@
 #define	POOL_TIMEOUT_JIFFIES	((100 /* msec */ * HZ) / 1000)
 #define	POOL_POISON_BYTE	0xa7
 
-DECLARE_MUTEX (pools_lock);
+static DECLARE_MUTEX (pools_lock);
 
 static ssize_t
 show_pools (struct device *dev, char *buf)
diff -Nru a/include/linux/pci.h b/include/linux/pci.h
--- a/include/linux/pci.h	Wed Jun  4 18:12:15 2003
+++ b/include/linux/pci.h	Wed Jun  4 18:12:15 2003
@@ -606,8 +606,6 @@
 	return pci_bus_write_config_dword (dev->bus, dev->devfn, where, val);
 }
 
-extern spinlock_t pci_lock;
-
 int pci_enable_device(struct pci_dev *dev);
 int pci_enable_device_bars(struct pci_dev *dev, int mask);
 void pci_disable_device(struct pci_dev *dev);

