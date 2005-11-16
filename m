Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965210AbVKPDWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965210AbVKPDWy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 22:22:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965211AbVKPDWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 22:22:54 -0500
Received: from peabody.ximian.com ([130.57.169.10]:7128 "EHLO
	peabody.ximian.com") by vger.kernel.org with ESMTP id S965210AbVKPDWp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 22:22:45 -0500
Subject: [RFC][PATCH 5/6] PCI PM: kzalloc() cleanup
From: Adam Belay <abelay@novell.com>
To: Linux-pm mailing list <linux-pm@lists.osdl.org>, Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Tue, 15 Nov 2005 22:31:31 -0500
Message-Id: <1132111891.9809.57.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use kzalloc() instead of kmalloc() and memset().


--- a/drivers/pci/pm.c	2005-11-08 17:10:37.000000000 -0500
+++ b/drivers/pci/pm.c	2005-11-08 17:11:33.000000000 -0500
@@ -300,12 +300,10 @@
 		return -EIO;
 	}
 
-	dev->pm = pm_data = kmalloc(sizeof(struct pci_dev_pm), GFP_KERNEL);
+	dev->pm = pm_data = kzalloc(sizeof(struct pci_dev_pm), GFP_KERNEL);
 	if (!pm_data)
 		return -ENOMEM;
 
-	memset(pm_data, 0, sizeof(struct pci_dev_pm));
-
 	pm_data->pm_offset = pm;
 
 	/* determine supported device states */


