Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262696AbUKLXby@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262696AbUKLXby (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 18:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262728AbUKLXbN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:31:13 -0500
Received: from e5.ny.us.ibm.com ([32.97.182.105]:35811 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262678AbUKLXWj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:22:39 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.10-rc1
User-Agent: Mutt/1.5.6i
In-Reply-To: <11003017191521@kroah.com>
Date: Fri, 12 Nov 2004 15:21:59 -0800
Message-Id: <11003017191459@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2091.1.11, 2004/11/12 14:07:33-08:00, hannal@us.ibm.com

[PATCH] drm_drv.h: replace pci_find_device

As pci_find_device is going away I've replaced it with pci_get_device.
for_each_pci_dev is a macro wrapper around pci_get_device.


Signed-off-by: Hanna Linder <hannal@us.ibm.com>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/char/drm/drm_drv.h |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)


diff -Nru a/drivers/char/drm/drm_drv.h b/drivers/char/drm/drm_drv.h
--- a/drivers/char/drm/drm_drv.h	2004-11-12 15:10:42 -08:00
+++ b/drivers/char/drm/drm_drv.h	2004-11-12 15:10:42 -08:00
@@ -556,9 +556,8 @@
 
 	DRM(mem_init)();
 
-	while ((pdev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, pdev)) != NULL) {
+	for_each_pci_dev(pdev) 
 		DRM(probe)(pdev);
-	}
 	return 0;
 }
 

