Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266155AbUHWTIt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266155AbUHWTIt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 15:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267427AbUHWTG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 15:06:57 -0400
Received: from mail.kroah.org ([69.55.234.183]:6596 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267278AbUHWSgz convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:36:55 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <10932860863820@kroah.com>
Date: Mon, 23 Aug 2004 11:34:46 -0700
Message-Id: <1093286086721@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1807.56.18, 2004/08/05 15:33:44-07:00, johnrose@austin.ibm.com

[PATCH] PCI: rpaphp build break - remove eeh register

The following patch removes eeh function calls that currently break the
RPA PCI Hotplug module.  The functions in question were rejected from
mainline, and an alternate solution is being worked.


 drivers/pci/hotplug/rpaphp_core.c |    8 --------
 1 files changed, 8 deletions(-)


diff -Nru a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
--- a/drivers/pci/hotplug/rpaphp_core.c	2004-08-23 11:05:15 -07:00
+++ b/drivers/pci/hotplug/rpaphp_core.c	2004-08-23 11:05:15 -07:00
@@ -54,8 +54,6 @@
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
 
-void eeh_register_disable_func(int (*)(struct pci_dev *));
-
 module_param(debug, bool, 0644);
 
 static int enable_slot(struct hotplug_slot *slot);
@@ -407,18 +405,12 @@
 {
 	info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
 
-	/* let EEH know they can use hotplug */
-	eeh_register_disable_func(&rpaphp_disable_slot);
-
 	/* read all the PRA info from the system */
 	return init_rpa();
 }
 
 static void __exit rpaphp_exit(void)
 {
-	/* let EEH know we are going away */
-	eeh_register_disable_func(NULL);
-
 	cleanup_slots();
 }
 

