Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269205AbUI2Xgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269205AbUI2Xgr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 19:36:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269196AbUI2Xgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 19:36:46 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:44929 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S269205AbUI2Xe2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 19:34:28 -0400
Date: Wed, 29 Sep 2004 16:35:31 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: linux-kernel@vger.kernel.org
cc: kernel-janitors@lists.osdl.org, hannal@us.ibm.com, greg@kroah.com
Subject: [PATCH 2.6.9-rc2-mm4 ibmphp_core.c][6/8] replace pci_get_device with pci_dev_present
Message-ID: <25390000.1096500931@w-hlinder.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This can be converted to pci_dev_present as the dev returned is never used.
Compile tested.

Hanna Linder
IBM Linux Technology Center

Signed-off-by: Hanna Linder <hannal@us.ibm.com>

diff -Nrup linux-2.6.9-rc2-mm4cln/drivers/pci/hotplug/ibmphp_core.c linux-2.6.9-rc2-mm4patch2/drivers/pci/hotplug/ibmphp_core.c
--- linux-2.6.9-rc2-mm4cln/drivers/pci/hotplug/ibmphp_core.c	2004-09-28 14:58:50.000000000 -0700
+++ linux-2.6.9-rc2-mm4patch2/drivers/pci/hotplug/ibmphp_core.c	2004-09-29 15:39:39.385406240 -0700
@@ -838,8 +838,11 @@ static int set_bus (struct slot * slot_c
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
@@ -886,8 +889,7 @@ static int set_bus (struct slot * slot_c
 				break;
 			case BUS_SPEED_133:
 				/* This is to take care of the bug in CIOBX chip */
-				while ((dev = pci_get_device(PCI_VENDOR_ID_SERVERWORKS,
-							      0x0101, dev)) != NULL)
+				if(pci_dev_present(ciobx))
 					ibmphp_hpc_writeslot (slot_cur, HPC_BUS_100PCIXMODE);
 				cmd = HPC_BUS_133PCIXMODE;
 				break;

