Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263934AbTJOS0T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 14:26:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263933AbTJOS0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 14:26:18 -0400
Received: from mail.kroah.org ([65.200.24.183]:50353 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263927AbTJOS0G convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 14:26:06 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <1066242289283@kroah.com>
Subject: Re: [PATCH] PCI fixes for 2.6.0-test7
In-Reply-To: <10662422891492@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 15 Oct 2003 11:24:49 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1347.1.2, 2003/10/13 11:06:38-07:00, greg@kroah.com

PCI: fix up probe functions for synclink drivers
  
Can not be marked __init, must be marked __devinit or not at all.
If it is marked __init, then oops can happen by a user writing to the
"new_id" file from sysfs.


 drivers/char/synclink.c   |    4 ++--
 drivers/char/synclinkmp.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)


diff -Nru a/drivers/char/synclink.c b/drivers/char/synclink.c
--- a/drivers/char/synclink.c	Wed Oct 15 11:18:47 2003
+++ b/drivers/char/synclink.c	Wed Oct 15 11:18:47 2003
@@ -8020,8 +8020,8 @@
 
 #endif /* ifdef CONFIG_SYNCLINK_SYNCPPP */
 
-static int __init synclink_init_one (struct pci_dev *dev,
-				     const struct pci_device_id *ent)
+static int __devinit synclink_init_one (struct pci_dev *dev,
+					const struct pci_device_id *ent)
 {
 	struct mgsl_struct *info;
 
diff -Nru a/drivers/char/synclinkmp.c b/drivers/char/synclinkmp.c
--- a/drivers/char/synclinkmp.c	Wed Oct 15 11:18:47 2003
+++ b/drivers/char/synclinkmp.c	Wed Oct 15 11:18:47 2003
@@ -5451,8 +5451,8 @@
 }
 
 
-static int __init synclinkmp_init_one (struct pci_dev *dev,
-				       const struct pci_device_id *ent)
+static int __devinit synclinkmp_init_one (struct pci_dev *dev,
+					  const struct pci_device_id *ent)
 {
 	if (pci_enable_device(dev)) {
 		printk("error enabling pci device %p\n", dev);

