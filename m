Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265420AbUBIX6v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 18:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265431AbUBIX4N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 18:56:13 -0500
Received: from mail.kroah.org ([65.200.24.183]:61628 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265433AbUBIXWj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 18:22:39 -0500
Subject: Re: [PATCH] PCI Update for 2.6.3-rc1
In-Reply-To: <107636893939@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 9 Feb 2004 15:22:20 -0800
Message-Id: <1076368940408@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1500.11.12, 2004/02/03 16:48:38-08:00, eike-hotplug@sf-tec.de

[PATCH] PCI: avoid two returns directly after each other in pcidriver.c

This avoids a return direct before the final return of a function. Better
only modify the return code and fall through to the final return.


 drivers/pci/pci-driver.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -Nru a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
--- a/drivers/pci/pci-driver.c	Mon Feb  9 14:59:00 2004
+++ b/drivers/pci/pci-driver.c	Mon Feb  9 14:59:00 2004
@@ -241,7 +241,7 @@
 		error = drv->probe(pci_dev, id);
 	if (error >= 0) {
 		pci_dev->driver = drv;
-		return 0;
+		error = 0;
 	}
 	return error;
 }

