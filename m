Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262049AbTEFWwo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 18:52:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbTEFWwo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 18:52:44 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:55467 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S262028AbTEFWwk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 18:52:40 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10522624132993@kroah.com>
Subject: Re: [PATCH] PCI hotplug changes for 2.5.69
In-Reply-To: <10522624131723@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Tue, 6 May 2003 16:06:53 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1084, 2003/05/06 15:35:45-07:00, greg@kroah.com

[PATCH] PCI Hotplug: fix up the acpi driver to work properly again.


 drivers/hotplug/acpiphp_glue.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletion(-)


diff -Nru a/drivers/hotplug/acpiphp_glue.c b/drivers/hotplug/acpiphp_glue.c
--- a/drivers/hotplug/acpiphp_glue.c	Tue May  6 15:55:50 2003
+++ b/drivers/hotplug/acpiphp_glue.c	Tue May  6 15:55:50 2003
@@ -806,6 +806,7 @@
 	struct list_head *l;
 	struct acpiphp_func *func;
 	int retval = 0;
+	int num;
 
 	if (slot->flags & SLOT_ENABLED)
 		goto err_exit;
@@ -825,7 +826,10 @@
 		goto err_exit;
 
 	/* returned `dev' is the *first function* only! */
-	dev = pci_scan_slot(slot->bridge->pci_bus, PCI_DEVFN(slot->device, 0));
+	num = pci_scan_slot(slot->bridge->pci_bus, PCI_DEVFN(slot->device, 0));
+	if (num)
+		pci_bus_add_devices(slot->bridge->pci_bus);
+	dev = pci_find_slot(slot->bridge->bus, PCI_DEVFN(slot->device, 0));
 
 	if (!dev) {
 		err("No new device found\n");

