Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263248AbVCDVXv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263248AbVCDVXv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 16:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263223AbVCDVLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 16:11:21 -0500
Received: from mail.kroah.org ([69.55.234.183]:20386 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263171AbVCDUyk convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 15:54:40 -0500
Cc: alexn@dsv.su.se
Subject: [PATCH] PCI: fix hotplug double free
In-Reply-To: <11099696383198@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 4 Mar 2005 12:53:58 -0800
Message-Id: <11099696383203@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Greg K-H <greg@kroah.com>
To: linux-kernel@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1998.11.26, 2005/02/25 15:48:12-08:00, alexn@dsv.su.se

[PATCH] PCI: fix hotplug double free

With the brackets missed out func could be freed twice.

Found by Coverity tool

Signed-off-by: Alexander Nyberg <alexn@dsv.su.se>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


 drivers/pci/hotplug/pciehp_ctrl.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)


diff -Nru a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
--- a/drivers/pci/hotplug/pciehp_ctrl.c	2005-03-04 12:41:13 -08:00
+++ b/drivers/pci/hotplug/pciehp_ctrl.c	2005-03-04 12:41:13 -08:00
@@ -1354,10 +1354,11 @@
 				dbg("PCI Bridge Hot-Remove s:b:d:f(%02x:%02x:%02x:%02x)\n", 
 					ctrl->seg, func->bus, func->device, func->function);
 				bridge_slot_remove(func);
-			} else
+			} else {
 				dbg("PCI Function Hot-Remove s:b:d:f(%02x:%02x:%02x:%02x)\n", 
 					ctrl->seg, func->bus, func->device, func->function);
 				slot_remove(func);
+			}
 
 			func = pciehp_slot_find(ctrl->slot_bus, device, 0);
 		}

