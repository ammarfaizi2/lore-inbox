Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262368AbUCCEeT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 23:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262367AbUCCEeH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 23:34:07 -0500
Received: from mail.kroah.org ([65.200.24.183]:40578 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262372AbUCCEWF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 23:22:05 -0500
Subject: Re: [PATCH] PCI Hotplug fixes for 2.6.4-rc1
In-Reply-To: <10782877051959@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 2 Mar 2004 20:21:45 -0800
Message-Id: <1078287705197@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1622, 2004/03/01 16:18:12-08:00, greg@kroah.com

PCI Hotplug: fix stupid directory name of "pci_hotplug_slots" to be just "slots"


 drivers/pci/hotplug/pci_hotplug_core.c |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)


diff -Nru a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
--- a/drivers/pci/hotplug/pci_hotplug_core.c	Tue Mar  2 19:42:42 2004
+++ b/drivers/pci/hotplug/pci_hotplug_core.c	Tue Mar  2 19:42:42 2004
@@ -104,8 +104,19 @@
 	.release = &hotplug_slot_release,
 };
 
-decl_subsys(pci_hotplug_slots, &hotplug_slot_ktype, NULL);
-
+/* 
+ * We create a struct subsystem on our own and not use decl_subsys so
+ * we can have a sane name "slots" in sysfs, yet still keep a good
+ * global variable name "pci_hotplug_slots_subsys.
+ * If the decl_subsys() #define ever changes, this declaration will
+ * need to be update to make sure everything is initialized properly.
+ */
+struct subsystem pci_hotplug_slots_subsys = {
+	.kset = {
+		.kobj = { .name = "slots" },
+		.ktype = &hotplug_slot_ktype,
+	}
+};
 
 /* these strings match up with the values in pci_bus_speed */
 static char *pci_bus_speed_strings[] = {

