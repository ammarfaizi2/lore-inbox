Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262810AbVDAXuH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262810AbVDAXuH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 18:50:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262809AbVDAXti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 18:49:38 -0500
Received: from mail.kroah.org ([69.55.234.183]:28124 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262810AbVDAXsK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 18:48:10 -0500
Cc: gregkh@suse.de
Subject: PCI Hotplug: enforce the rule that a hotplug slot needs a release function.
In-Reply-To: <111239927248@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 1 Apr 2005 15:47:53 -0800
Message-Id: <11123992732278@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <gregkh@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2181.16.17, 2005/03/21 22:55:26-08:00, gregkh@suse.de

PCI Hotplug: enforce the rule that a hotplug slot needs a release function.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/pci/hotplug/pci_hotplug_core.c |    5 +++++
 1 files changed, 5 insertions(+)


diff -Nru a/drivers/pci/hotplug/pci_hotplug_core.c b/drivers/pci/hotplug/pci_hotplug_core.c
--- a/drivers/pci/hotplug/pci_hotplug_core.c	2005-04-01 15:34:15 -08:00
+++ b/drivers/pci/hotplug/pci_hotplug_core.c	2005-04-01 15:34:15 -08:00
@@ -567,6 +567,11 @@
 		return -ENODEV;
 	if ((slot->info == NULL) || (slot->ops == NULL))
 		return -EINVAL;
+	if (slot->release == NULL) {
+		dbg("Why are you trying to register a hotplug slot"
+		    "without a proper release function?\n");
+		return -EINVAL;
+	}
 
 	kobject_set_name(&slot->kobj, "%s", slot->name);
 	kobj_set_kset_s(slot, pci_hotplug_slots_subsys);

