Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264949AbUGBVkf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264949AbUGBVkf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jul 2004 17:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265000AbUGBVkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jul 2004 17:40:33 -0400
Received: from mail.kroah.org ([65.200.24.183]:30354 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264949AbUGBVka convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jul 2004 17:40:30 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] More PCI fixes for 2.6.7
User-Agent: Mutt/1.5.6i
In-Reply-To: <1088804352811@kroah.com>
Date: Fri, 2 Jul 2004 14:39:12 -0700
Message-Id: <1088804352158@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1788, 2004/07/02 13:35:57-07:00, linas@austin.ibm.com

[PATCH] PCI Hotplug: RPAPHP structure size/performance

Please review and apply the following patch if you find it agreeable.

This patch does not make any functional changes, but does improve
both performance and memory usage by rearranging structure elements.

The need for these changes became appearent during a code review of
the disassembly involving this structure. The memory footprint of this
structure is made smaller by grouping the byte fields next to each other.
The access of the list_head can be simplified by making it the first element
of the structure, thus avoiding a needless add-immediate without negatively
impacting any of the other accesses.

Signed-off-by: Linas Vepstas <linas@linas.org>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/hotplug/rpaphp.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)


diff -Nru a/drivers/pci/hotplug/rpaphp.h b/drivers/pci/hotplug/rpaphp.h
--- a/drivers/pci/hotplug/rpaphp.h	2004-07-02 14:24:19 -07:00
+++ b/drivers/pci/hotplug/rpaphp.h	2004-07-02 14:24:19 -07:00
@@ -85,6 +85,7 @@
  * struct slot - slot information for each *physical* slot
  */
 struct slot {
+	struct list_head rpaphp_slot_list;
 	int state;
 	u32 index;
 	u32 type;
@@ -92,6 +93,7 @@
 	char *name;
 	char *location;
 	u8 removable;
+	u8 dev_type;		/* VIO or PCI */
 	struct device_node *dn;	/* slot's device_node in OFDT */
 				/* dn has phb info */
 	struct pci_dev *bridge;	/* slot's pci_dev in pci_devices */
@@ -99,9 +101,7 @@
 		struct list_head pci_funcs; /* pci_devs in PCI slot */ 
 		struct vio_dev *vio_dev; /* vio_dev in VIO slot */
 	} dev;
-	u8 dev_type;		/* VIO or PCI */
 	struct hotplug_slot *hotplug_slot;
-	struct list_head rpaphp_slot_list;
 };
 
 extern struct hotplug_slot_ops rpaphp_hotplug_slot_ops;

