Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263377AbVCJXQy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263377AbVCJXQy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 18:16:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263425AbVCJXQ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 18:16:27 -0500
Received: from mail.kroah.org ([69.55.234.183]:17882 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263378AbVCJXKK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 18:10:10 -0500
Date: Thu, 10 Mar 2005 15:09:14 -0800
From: Greg KH <greg@kroah.com>
To: gregkh@suse.de, linux-pci@atrey.karlin.mff.cuni.cz, alexn@dsv.su.se,
       dely.l.sy@intel.com
Cc: linux-kernel@vger.kernel.org, stable@kernel.org
Subject: [08/11] PCI-E: fix hotplug double free
Message-ID: <20050310230914.GI22112@kroah.com>
References: <20050310230519.GA22112@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050310230519.GA22112@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


-stable review patch.  If anyone has any objections, please let us know.

------------------



[PATCH] PCI: fix hotplug double free

With the brackets missed out func could be freed twice.

Found by Coverity tool

Signed-off-by: Alexander Nyberg <alexn@dsv.su.se>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>



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

