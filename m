Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265655AbTGDCAU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 22:00:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265656AbTGDB7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 21:59:19 -0400
Received: from granite.he.net ([216.218.226.66]:25358 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S265655AbTGDByx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 21:54:53 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10572845523547@kroah.com>
Subject: [PATCH] PCI and sysfs fixes for 2.5.74
In-Reply-To: <20030704020634.GA4316@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Thu, 3 Jul 2003 19:09:12 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1361, 2003/07/02 11:08:01-07:00, greg@kroah.com

[PATCH] PCI: change WARN_ON(irqs_disabled()) to WARN_ON(in_interrupt()) to keep the fusion drivers happy.


 drivers/pci/search.c |    9 +++++----
 1 files changed, 5 insertions(+), 4 deletions(-)


diff -Nru a/drivers/pci/search.c b/drivers/pci/search.c
--- a/drivers/pci/search.c	Thu Jul  3 18:17:17 2003
+++ b/drivers/pci/search.c	Thu Jul  3 18:17:17 2003
@@ -9,6 +9,7 @@
 
 #include <linux/pci.h>
 #include <linux/module.h>
+#include <linux/interrupt.h>
 
 spinlock_t pci_bus_lock = SPIN_LOCK_UNLOCKED;
 
@@ -66,7 +67,7 @@
 	struct list_head *n;
 	struct pci_bus *b = NULL;
 
-	WARN_ON(irqs_disabled());
+	WARN_ON(in_interrupt());
 	spin_lock(&pci_bus_lock);
 	n = from ? from->node.next : pci_root_buses.next;
 	if (n != &pci_root_buses)
@@ -125,7 +126,7 @@
 	struct list_head *n;
 	struct pci_dev *dev;
 
-	WARN_ON(irqs_disabled());
+	WARN_ON(in_interrupt());
 	spin_lock(&pci_bus_lock);
 	n = from ? from->global_list.next : pci_devices.next;
 
@@ -190,7 +191,7 @@
 	struct list_head *n;
 	struct pci_dev *dev;
 
-	WARN_ON(irqs_disabled());
+	WARN_ON(in_interrupt());
 	spin_lock(&pci_bus_lock);
 	n = from ? from->global_list.next : pci_devices.next;
 
@@ -256,7 +257,7 @@
 	struct list_head *n;
 	struct pci_dev *dev;
 
-	WARN_ON(irqs_disabled());
+	WARN_ON(in_interrupt());
 	spin_lock(&pci_bus_lock);
 	n = from ? from->global_list.prev : pci_devices.prev;
 

