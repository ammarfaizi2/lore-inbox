Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262929AbVAQWVn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262929AbVAQWVn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 17:21:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262928AbVAQWVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 17:21:10 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:21663 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262929AbVAQWCH convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 17:02:07 -0500
Cc: tglx@linutronix.de
Subject: [PATCH] PCI: Lock initializer cleanup - batch 4
In-Reply-To: <11059993123253@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 17 Jan 2005 14:01:53 -0800
Message-Id: <11059993132995@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2329.2.7, 2005/01/14 15:58:57-08:00, tglx@linutronix.de

[PATCH] PCI: Lock initializer cleanup - batch 4

Use the new lock initializers DEFINE_SPIN_LOCK and DEFINE_RW_LOCK

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/access.c |    2 +-
 drivers/pci/msi.c    |    2 +-
 drivers/pci/search.c |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)


diff -Nru a/drivers/pci/access.c b/drivers/pci/access.c
--- a/drivers/pci/access.c	2005-01-17 13:55:40 -08:00
+++ b/drivers/pci/access.c	2005-01-17 13:55:40 -08:00
@@ -7,7 +7,7 @@
  * configuration space.
  */
 
-static spinlock_t pci_lock = SPIN_LOCK_UNLOCKED;
+static DEFINE_SPINLOCK(pci_lock);
 
 /*
  *  Wrappers for all PCI configuration access functions.  They just check
diff -Nru a/drivers/pci/msi.c b/drivers/pci/msi.c
--- a/drivers/pci/msi.c	2005-01-17 13:55:40 -08:00
+++ b/drivers/pci/msi.c	2005-01-17 13:55:40 -08:00
@@ -22,7 +22,7 @@
 
 #include "msi.h"
 
-static spinlock_t msi_lock = SPIN_LOCK_UNLOCKED;
+static DEFINE_SPINLOCK(msi_lock);
 static struct msi_desc* msi_desc[NR_IRQS] = { [0 ... NR_IRQS-1] = NULL };
 static kmem_cache_t* msi_cachep;
 
diff -Nru a/drivers/pci/search.c b/drivers/pci/search.c
--- a/drivers/pci/search.c	2005-01-17 13:55:40 -08:00
+++ b/drivers/pci/search.c	2005-01-17 13:55:40 -08:00
@@ -13,7 +13,7 @@
 #include <linux/interrupt.h>
 #include "pci.h"
 
-spinlock_t pci_bus_lock = SPIN_LOCK_UNLOCKED;
+DEFINE_SPINLOCK(pci_bus_lock);
 
 static struct pci_bus * __devinit
 pci_do_find_bus(struct pci_bus* bus, unsigned char busnr)

