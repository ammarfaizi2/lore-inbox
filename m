Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262719AbUKMCRo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262719AbUKMCRo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 21:17:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262729AbUKLXbc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:31:32 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:15235 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262679AbUKLXWj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:22:39 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.10-rc1
User-Agent: Mutt/1.5.6i
In-Reply-To: <11003017171675@kroah.com>
Date: Fri, 12 Nov 2004 15:21:57 -0800
Message-Id: <1100301717571@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2026.66.23, 2004/11/11 15:40:24-08:00, greg@kroah.com

PCI Hotplug: fix up remaining MODULE_PARAM usage in pci hotplug drivers

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/hotplug/cpcihp_generic.c |   14 +++++++-------
 drivers/pci/hotplug/fakephp.c        |    2 +-
 drivers/pci/hotplug/ibmphp_core.c    |    2 +-
 3 files changed, 9 insertions(+), 9 deletions(-)


diff -Nru a/drivers/pci/hotplug/cpcihp_generic.c b/drivers/pci/hotplug/cpcihp_generic.c
--- a/drivers/pci/hotplug/cpcihp_generic.c	2004-11-12 15:12:04 -08:00
+++ b/drivers/pci/hotplug/cpcihp_generic.c	2004-11-12 15:12:04 -08:00
@@ -63,7 +63,7 @@
 
 /* local variables */
 static int debug;
-static char* bridge;
+static char bridge[256];
 static u8 bridge_busnr;
 static u8 bridge_slot;
 static struct pci_bus *bus;
@@ -209,15 +209,15 @@
 MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
-MODULE_PARM(debug, "i");
+module_param(debug, bool, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(debug, "Debugging mode enabled or not");
-MODULE_PARM(bridge, "s");
+module_param_string(bridge, bridge, 256, 0);
 MODULE_PARM_DESC(bridge, "Hotswap bus bridge device, <bus>:<slot> (bus and slot are in hexadecimal)");
-MODULE_PARM(first_slot, "b");
+module_param(first_slot, byte, 0);
 MODULE_PARM_DESC(first_slot, "Hotswap bus first slot number");
-MODULE_PARM(last_slot, "b");
+module_param(last_slot, byte, 0);
 MODULE_PARM_DESC(last_slot, "Hotswap bus last slot number");
-MODULE_PARM(port, "h");
+module_param(port, ushort, 0);
 MODULE_PARM_DESC(port, "#ENUM signal I/O port");
-MODULE_PARM(enum_bit, "i");
+module_param(enum_bit, int, 0);
 MODULE_PARM_DESC(enum_bit, "#ENUM signal bit (0-7)");
diff -Nru a/drivers/pci/hotplug/fakephp.c b/drivers/pci/hotplug/fakephp.c
--- a/drivers/pci/hotplug/fakephp.c	2004-11-12 15:12:04 -08:00
+++ b/drivers/pci/hotplug/fakephp.c	2004-11-12 15:12:04 -08:00
@@ -227,6 +227,6 @@
 MODULE_AUTHOR(DRIVER_AUTHOR);
 MODULE_DESCRIPTION(DRIVER_DESC);
 MODULE_LICENSE("GPL");
-MODULE_PARM(debug, "i");
+module_param(debug, bool, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC(debug, "Debugging mode enabled or not");
 
diff -Nru a/drivers/pci/hotplug/ibmphp_core.c b/drivers/pci/hotplug/ibmphp_core.c
--- a/drivers/pci/hotplug/ibmphp_core.c	2004-11-12 15:12:04 -08:00
+++ b/drivers/pci/hotplug/ibmphp_core.c	2004-11-12 15:12:04 -08:00
@@ -51,7 +51,7 @@
 int ibmphp_debug;
 
 static int debug;
-MODULE_PARM (debug, "i");
+module_param(debug, bool, S_IRUGO | S_IWUSR);
 MODULE_PARM_DESC (debug, "Debugging mode enabled or not");
 MODULE_LICENSE ("GPL");
 MODULE_DESCRIPTION (DRIVER_DESC);

