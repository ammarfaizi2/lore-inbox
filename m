Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261487AbVEUKCa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261487AbVEUKCa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 06:02:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbVEUKCa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 06:02:30 -0400
Received: from smtp.gentoo.org ([134.68.220.30]:23021 "EHLO smtp.gentoo.org")
	by vger.kernel.org with ESMTP id S261487AbVEUKC0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 06:02:26 -0400
Subject: pm_message_t fix for radeon_pm.c
From: Henrik Brix Andersen <brix@gentoo.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Gentoo Linux
Date: Sat, 21 May 2005 12:02:24 +0200
Message-Id: <1116669744.14475.7.camel@sponge.fungus>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds a missing .event to pm_message_t handling in
drivers/video/aty/radeon_pm.c for linux-2.6.12-rc4.

--- linux-2.6.12-rc4/drivers/video/aty/radeon_pm.c	2005-05-21 11:31:32.000000000 +0200
+++ linux-2.6.12-rc4-radeon_pm/drivers/video/aty/radeon_pm.c	2005-05-21 11:34:51.000000000 +0200
@@ -2526,11 +2526,11 @@ int radeonfb_pci_suspend(struct pci_dev 
         struct radeonfb_info *rinfo = info->par;
 	int i;
 
-	if (state == pdev->dev.power.power_state)
+	if (state.event == pdev->dev.power.power_state.event)
 		return 0;
 
 	printk(KERN_DEBUG "radeonfb (%s): suspending to state: %d...\n",
-	       pci_name(pdev), state);
+	       pci_name(pdev), state.event);
 
 	/* For suspend-to-disk, we cheat here. We don't suspend anything and
 	 * let fbcon continue drawing until we are all set. That shouldn't

Sincerely,
Brix

Please CC: me on replies as I am not subscribed to LKML.
-- 
Henrik Brix Andersen <brix@gentoo.org>
Gentoo Linux

