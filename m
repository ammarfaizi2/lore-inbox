Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270106AbUJTHb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270106AbUJTHb0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 03:31:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269671AbUJSXCl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Oct 2004 19:02:41 -0400
Received: from mail.kroah.org ([69.55.234.183]:62345 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S270080AbUJSWqW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Oct 2004 18:46:22 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.9
User-Agent: Mutt/1.5.6i
In-Reply-To: <10982257382805@kroah.com>
Date: Tue, 19 Oct 2004 15:42:19 -0700
Message-Id: <10982257393129@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1997.37.55, 2004/10/06 13:52:33-07:00, greg@kroah.com

[PATCH] PCI: remove pci_module_init() usage from drivers/pci/hotplug/*

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/hotplug/cpcihp_zt5550.c |    2 +-
 drivers/pci/hotplug/cpqphp_core.c   |    4 ++--
 drivers/pci/hotplug/ibmphp_ebda.c   |    2 +-
 drivers/pci/hotplug/pciehp_core.c   |    4 ++--
 drivers/pci/hotplug/shpchp_core.c   |    4 ++--
 5 files changed, 8 insertions(+), 8 deletions(-)


diff -Nru a/drivers/pci/hotplug/cpcihp_zt5550.c b/drivers/pci/hotplug/cpcihp_zt5550.c
--- a/drivers/pci/hotplug/cpcihp_zt5550.c	2004-10-19 15:22:40 -07:00
+++ b/drivers/pci/hotplug/cpcihp_zt5550.c	2004-10-19 15:22:40 -07:00
@@ -283,7 +283,7 @@
 	if(!r)
 		return -EBUSY;
 
-	return pci_module_init(&zt5550_hc_driver);
+	return pci_register_driver(&zt5550_hc_driver);
 }
 
 static void __exit
diff -Nru a/drivers/pci/hotplug/cpqphp_core.c b/drivers/pci/hotplug/cpqphp_core.c
--- a/drivers/pci/hotplug/cpqphp_core.c	2004-10-19 15:22:40 -07:00
+++ b/drivers/pci/hotplug/cpqphp_core.c	2004-10-19 15:22:40 -07:00
@@ -1487,8 +1487,8 @@
 	cpqhp_debug = debug;
 
 	info (DRIVER_DESC " version: " DRIVER_VERSION "\n");
-	result = pci_module_init(&cpqhpc_driver);
-	dbg("pci_module_init = %d\n", result);
+	result = pci_register_driver(&cpqhpc_driver);
+	dbg("pci_register_driver = %d\n", result);
 	return result;
 }
 
diff -Nru a/drivers/pci/hotplug/ibmphp_ebda.c b/drivers/pci/hotplug/ibmphp_ebda.c
--- a/drivers/pci/hotplug/ibmphp_ebda.c	2004-10-19 15:22:40 -07:00
+++ b/drivers/pci/hotplug/ibmphp_ebda.c	2004-10-19 15:22:40 -07:00
@@ -1246,7 +1246,7 @@
 	list_for_each (tmp, &ebda_hpc_head) {
 		ctrl = list_entry (tmp, struct controller, ebda_hpc_list);
 		if (ctrl->ctlr_type == 1) {
-			rc = pci_module_init (&ibmphp_driver);
+			rc = pci_register_driver(&ibmphp_driver);
 			break;
 		}
 	}
diff -Nru a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
--- a/drivers/pci/hotplug/pciehp_core.c	2004-10-19 15:22:40 -07:00
+++ b/drivers/pci/hotplug/pciehp_core.c	2004-10-19 15:22:40 -07:00
@@ -602,8 +602,8 @@
 
 	retval = pciehprm_init(PCI);
 	if (!retval) {
-		retval = pci_module_init(&pcie_driver);
-		dbg("pci_module_init = %d\n", retval);
+		retval = pci_register_driver(&pcie_driver);
+		dbg("pci_register_driver = %d\n", retval);
 		info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
 	}
 
diff -Nru a/drivers/pci/hotplug/shpchp_core.c b/drivers/pci/hotplug/shpchp_core.c
--- a/drivers/pci/hotplug/shpchp_core.c	2004-10-19 15:22:40 -07:00
+++ b/drivers/pci/hotplug/shpchp_core.c	2004-10-19 15:22:40 -07:00
@@ -599,8 +599,8 @@
 
 	retval = shpchprm_init(PCI);
 	if (!retval) {
-		retval = pci_module_init(&shpc_driver);
-		dbg("%s: pci_module_init = %d\n", __FUNCTION__, retval);
+		retval = pci_register_driver(&shpc_driver);
+		dbg("%s: pci_register_driver = %d\n", __FUNCTION__, retval);
 		info(DRIVER_DESC " version: " DRIVER_VERSION "\n");
 	}
 

