Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262874AbUCPAEx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 19:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262873AbUCPADj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 19:03:39 -0500
Received: from mail.kroah.org ([65.200.24.183]:3503 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262874AbUCPAB6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:01:58 -0500
Subject: Re: [PATCH] Driver Core update for 2.6.4
In-Reply-To: <10793951481021@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 15 Mar 2004 15:59:08 -0800
Message-Id: <10793951483511@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1608.84.10, 2004/03/11 13:22:16-08:00, greg@kroah.com

PCI Hotplug: use the new decl_subsys_name() macro instead of rolling our own.


 drivers/pci/hotplug/pci_hotplug_core.c |   14 +-------------
 1 files changed, 1 insertion(+), 13 deletions(-)


diff -Nru a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
--- a/drivers/pci/hotplug/pci_hotplug_core.c	Mon Mar 15 15:29:01 2004
+++ b/drivers/pci/hotplug/pci_hotplug_core.c	Mon Mar 15 15:29:01 2004
@@ -104,19 +104,7 @@
 	.release = &hotplug_slot_release,
 };
 
-/* 
- * We create a struct subsystem on our own and not use decl_subsys so
- * we can have a sane name "slots" in sysfs, yet still keep a good
- * global variable name "pci_hotplug_slots_subsys.
- * If the decl_subsys() #define ever changes, this declaration will
- * need to be update to make sure everything is initialized properly.
- */
-struct subsystem pci_hotplug_slots_subsys = {
-	.kset = {
-		.kobj = { .name = "slots" },
-		.ktype = &hotplug_slot_ktype,
-	}
-};
+decl_subsys_name(pci_hotplug_slots, slots, &hotplug_slot_ktype, NULL);
 
 /* these strings match up with the values in pci_bus_speed */
 static char *pci_bus_speed_strings[] = {

