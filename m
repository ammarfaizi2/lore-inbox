Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266646AbUHCPmR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266646AbUHCPmR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Aug 2004 11:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266695AbUHCPmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Aug 2004 11:42:17 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:2179 "EHLO e31.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S266646AbUHCPl7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Aug 2004 11:41:59 -0400
Subject: [PATCH] rpaphp build break - remove eeh register
From: John Rose <johnrose@austin.ibm.com>
To: greg@kroah.com
Cc: lkml <linux-kernel@vger.kernel.org>, Linas Vepstas <linas@us.ibm.com>
Content-Type: text/plain
Message-Id: <1091548044.13500.4.camel@sinatra.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 03 Aug 2004 10:47:25 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg-

The following patch removes eeh function calls that currently break the
RPA PCI Hotplug module.  The functions in question were rejected from
mainline, and an alternate solution is being worked.

Thanks-
John

diff -Nru a/drivers/pci/hotplug/rpaphp_core.c b/drivers/pci/hotplug/rpaphp_core.c
--- a/drivers/pci/hotplug/rpaphp_core.c	Tue Aug  3 10:38:57 2004
+++ b/drivers/pci/hotplug/rpaphp_core.c	Tue Aug  3 10:38:57 2004
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
 

