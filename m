Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262685AbUKLXZ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262685AbUKLXZ5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 18:25:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262691AbUKLXY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:24:59 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:40419 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262685AbUKLXWm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:22:42 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.10-rc1
User-Agent: Mutt/1.5.6i
In-Reply-To: <11003017173408@kroah.com>
Date: Fri, 12 Nov 2004 15:21:57 -0800
Message-Id: <11003017171675@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2026.66.22, 2004/11/10 17:38:03-08:00, hannal@us.ibm.com

[PATCH] ibmphp_core.c: replace pci_get_device with pci_dev_present

This can be converted to pci_dev_present as the dev returned is never used.
Compile tested.

Signed-off-by: Hanna Linder <hannal@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/hotplug/ibmphp_core.c |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)


diff -Nru a/drivers/pci/hotplug/ibmphp_core.c b/drivers/pci/hotplug/ibmphp_core.c
--- a/drivers/pci/hotplug/ibmphp_core.c	2004-11-12 15:12:11 -08:00
+++ b/drivers/pci/hotplug/ibmphp_core.c	2004-11-12 15:12:11 -08:00
@@ -838,8 +838,11 @@
 	int rc;
 	u8 speed;
 	u8 cmd = 0x0;
-	struct pci_dev *dev = NULL;
 	int retval;
+	static struct pci_device_id ciobx[] = {
+		{ PCI_DEVICE(PCI_VENDOR_ID_SERVERWORKS, 0x0101) },
+	        { },
+	};	
 
 	debug ("%s - entry slot # %d\n", __FUNCTION__, slot_cur->number);
 	if (SET_BUS_STATUS (slot_cur->ctrl) && is_bus_empty (slot_cur)) {
@@ -886,8 +889,7 @@
 				break;
 			case BUS_SPEED_133:
 				/* This is to take care of the bug in CIOBX chip */
-				while ((dev = pci_get_device(PCI_VENDOR_ID_SERVERWORKS,
-							      0x0101, dev)) != NULL)
+				if (pci_dev_present(ciobx))
 					ibmphp_hpc_writeslot (slot_cur, HPC_BUS_100PCIXMODE);
 				cmd = HPC_BUS_133PCIXMODE;
 				break;

