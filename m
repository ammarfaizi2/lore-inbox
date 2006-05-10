Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965027AbWEJR2l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965027AbWEJR2l (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 13:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965029AbWEJR2l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 13:28:41 -0400
Received: from homer.mvista.com ([63.81.120.158]:35618 "EHLO
	dwalker1.mvista.com") by vger.kernel.org with ESMTP id S965027AbWEJR2k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 13:28:40 -0400
Date: Wed, 10 May 2006 10:28:29 -0700
Message-Id: <200605101728.k4AHSTIM004411@dwalker1.mvista.com>
From: Daniel Walker <dwalker@mvista.com>
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [PATCH -mm] BusLogic gcc 4.1 warning fixes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This at least makes the used away of the failure .
---


I just commented out BusLogic_AbortCommand because the code that uses it is 
commented out the same way .. It could just be removed .

Fixes the following warnings,

drivers/scsi/BusLogic.c: In function 'BusLogic_init':
drivers/scsi/BusLogic.c:2302: warning: ignoring return value of 'scsi_add_host', declared with attribute warn_unused_result
drivers/scsi/BusLogic.c: At top level:
drivers/scsi/BusLogic.c:2963: warning: 'BusLogic_AbortCommand' defined but not used

Signed-Off-By: Daniel Walker <dwalker@mvista.com>

Index: linux-2.6.16/drivers/scsi/BusLogic.c
===================================================================
--- linux-2.6.16.orig/drivers/scsi/BusLogic.c
+++ linux-2.6.16/drivers/scsi/BusLogic.c
@@ -2299,7 +2299,8 @@ static int __init BusLogic_init(void)
 				scsi_host_put(Host);
 			} else {
 				BusLogic_InitializeHostStructure(HostAdapter, Host);
-				scsi_add_host(Host, HostAdapter->PCI_Device ? &HostAdapter->PCI_Device->dev : NULL);
+				if (scsi_add_host(Host, HostAdapter->PCI_Device ? &HostAdapter->PCI_Device->dev : NULL))
+					printk(KERN_WARNING "BusLogic: scsi_add_host() failed!\n");
 				scsi_scan_host(Host);
 				BusLogicHostAdapterCount++;
 			}
@@ -2955,6 +2956,7 @@ static int BusLogic_QueueCommand(struct 
 }
 
 
+#if 0
 /*
   BusLogic_AbortCommand aborts Command if possible.
 */
@@ -3025,6 +3027,7 @@ static int BusLogic_AbortCommand(struct 
 	return SUCCESS;
 }
 
+#endif
 /*
   BusLogic_ResetHostAdapter resets Host Adapter if possible, marking all
   currently executing SCSI Commands as having been Reset.
