Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264400AbTFECIz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 22:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264372AbTFECDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 22:03:17 -0400
Received: from granite.he.net ([216.218.226.66]:56070 "EHLO granite.he.net")
	by vger.kernel.org with ESMTP id S264389AbTFECCA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 22:02:00 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10547787473026@kroah.com>
Subject: Re: [PATCH] PCI and PCI Hotplug changes and fixes for 2.5.70
In-Reply-To: <10547787472227@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 4 Jun 2003 19:05:47 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, pcihpd-discuss@lists.sourceforge.net
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1254.4.6, 2003/06/03 19:36:54-07:00, greg@kroah.com

[PATCH] IBM PCI hotplug: remove direct access of pci_devices variable.


 drivers/hotplug/ibmphp_core.c |   13 +++++--------
 1 files changed, 5 insertions(+), 8 deletions(-)


diff -Nru a/drivers/hotplug/ibmphp_core.c b/drivers/hotplug/ibmphp_core.c
--- a/drivers/hotplug/ibmphp_core.c	Wed Jun  4 18:12:01 2003
+++ b/drivers/hotplug/ibmphp_core.c	Wed Jun  4 18:12:01 2003
@@ -897,7 +897,6 @@
 	int rc;
 	u8 speed;
 	u8 cmd = 0x0;
-	const struct list_head *tmp;
 	struct pci_dev * dev;
 	int retval;
 
@@ -945,13 +944,11 @@
 				cmd = HPC_BUS_100PCIXMODE;
 				break;
 			case BUS_SPEED_133:
-				/* This is to take care of the bug in CIOBX chip*/
-				list_for_each (tmp, &pci_devices) {
-					dev = (struct pci_dev *) pci_dev_g (tmp);
-					if (dev) {
-						if ((dev->vendor == 0x1166) && (dev->device == 0x0101))
-							ibmphp_hpc_writeslot (slot_cur, HPC_BUS_100PCIXMODE);
-					}
+				/* This is to take care of the bug in CIOBX chip */
+				pci_for_each_dev(dev) {
+					if ((dev->vendor == PCI_VENDOR_ID_SERVERWORKS) &&
+					    (dev->device == 0x0101))
+						ibmphp_hpc_writeslot (slot_cur, HPC_BUS_100PCIXMODE);
 				}
 				cmd = HPC_BUS_133PCIXMODE;
 				break;

