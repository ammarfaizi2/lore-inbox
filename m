Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270778AbUJUSdl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270778AbUJUSdl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 14:33:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270774AbUJUSaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 14:30:52 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:25321 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S270785AbUJUSZn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 14:25:43 -0400
Date: Thu, 21 Oct 2004 11:25:45 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: lkml <linux-kernel@vger.kernel.org>,
       kernel-janitors <kernel-janitors@lists.osdl.org>
cc: greg@kroah.com, hannal@us.ibm.com, dri-devel@lists.sourceforge.net
Subject: [PATCH 2.6] drm_drv.h: replace pci_find_device
Message-ID: <258330000.1098383145@w-hlinder.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


As pci_find_device is going away I've replaced it with pci_get_device.
for_each_pci_dev is a macro wrapper around pci_get_device.
If someone with this hardware could test it I would appreciate it.

Thanks.

Hanna Linder
IBM Linux Technology Center

Signed-off-by: Hanna Linder <hannal@us.ibm.com>

---
diff -Nrup linux-2.6.9cln/drivers/char/drm/drm_drv.h linux-2.6.9patch2/drivers/char/drm/drm_drv.h
--- linux-2.6.9cln/drivers/char/drm/drm_drv.h	2004-10-18 16:35:52.000000000 -0700
+++ linux-2.6.9patch2/drivers/char/drm/drm_drv.h	2004-10-20 14:51:17.000000000 -0700
@@ -556,9 +556,8 @@ static int __init drm_init( void )
 
 	DRM(mem_init)();
 
-	while ((pdev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pdev)) != NULL) {
+	for_each_pci_dev(pdev) 
 		DRM(probe)(pdev);
-	}
 	return 0;
 }
 

