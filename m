Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262702AbUKLXoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262702AbUKLXoq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 18:44:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262703AbUKLXoW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:44:22 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:54422 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262702AbUKLXWv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:22:51 -0500
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI fixes for 2.6.10-rc1
User-Agent: Mutt/1.5.6i
In-Reply-To: <1100301716275@kroah.com>
Date: Fri, 12 Nov 2004 15:21:56 -0800
Message-Id: <11003017163000@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.2026.66.11, 2004/11/05 14:09:34-08:00, greg@kroah.com

PCI: remove kernel log message about drivers not calling pci_disable_device()

Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/pci/pci-driver.c |   15 ++++++---------
 1 files changed, 6 insertions(+), 9 deletions(-)


diff -Nru a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
--- a/drivers/pci/pci-driver.c	2004-11-12 15:13:35 -08:00
+++ b/drivers/pci/pci-driver.c	2004-11-12 15:13:35 -08:00
@@ -271,17 +271,14 @@
 		pci_dev->driver = NULL;
 	}
 
-#ifdef CONFIG_DEBUG_KERNEL
 	/*
-	 * If the driver decides to stop using the device, it should
-	 * call pci_disable_device().
+	 * We would love to complain here if pci_dev->is_enabled is set, that
+	 * the driver should have called pci_disable_device(), but the
+	 * unfortunate fact is there are too many odd BIOS and bridge setups
+	 * that don't like drivers doing that all of the time.  
+	 * Oh well, we can dream of sane hardware when we sleep, no matter how
+	 * horrible the crap we have to deal with is when we are awake...
 	 */
-	if (pci_dev->is_enabled) {
-		dev_warn(&pci_dev->dev, "Device was removed without properly "
-			 "calling pci_disable_device(). This may need fixing.\n");
-		/* WARN_ON(1); */
-	}
-#endif /* CONFIG_DEBUG_KERNEL */
 
 	pci_dev_put(pci_dev);
 	return 0;

