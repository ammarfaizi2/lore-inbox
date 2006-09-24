Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932139AbWIXW45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932139AbWIXW45 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 18:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932151AbWIXW45
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 18:56:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:50379 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932139AbWIXW45 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 18:56:57 -0400
X-Authenticated: #704063
Subject: [Patch] Remove unnecessary check in
	drivers/pci/hotplug/pciehp_ctrl.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Mon, 25 Sep 2006 00:56:53 +0200
Message-Id: <1159138613.9062.17.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

this was spotted by coverity (cid #819). We dereference p_slot
earlier in the function, and i found no way it could become NULL
anywhere.

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.18-git3/drivers/pci/hotplug/pciehp_ctrl.c.orig	2006-09-24 22:19:11.000000000 +0200
+++ linux-2.6.18-git3/drivers/pci/hotplug/pciehp_ctrl.c	2006-09-24 22:25:10.000000000 +0200
@@ -790,8 +790,7 @@ int pciehp_enable_slot(struct slot *p_sl
 		p_slot->hpc_ops->get_latch_status(p_slot, &getstatus);
 	}
 
-	if (p_slot)
-		update_slot_info(p_slot);
+	update_slot_info(p_slot);
 
 	return rc;
 }


