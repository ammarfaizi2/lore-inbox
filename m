Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750738AbWJJNWN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738AbWJJNWN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 09:22:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbWJJNWN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 09:22:13 -0400
Received: from havoc.gtf.org ([69.61.125.42]:55445 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S1750738AbWJJNWM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 09:22:12 -0400
Date: Tue, 10 Oct 2006 09:22:06 -0400
From: Jeff Garzik <jeff@garzik.org>
To: wingel@nano-system.com, khali@linux-fr.org, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] i2c/buses/scx200_acb: handle PCI errors
Message-ID: <20061010132206.GA9191@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

 drivers/i2c/busses/scx200_acb.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/i2c/busses/scx200_acb.c b/drivers/i2c/busses/scx200_acb.c
index 32aab0d..714bae7 100644
--- a/drivers/i2c/busses/scx200_acb.c
+++ b/drivers/i2c/busses/scx200_acb.c
@@ -494,11 +494,12 @@ static __init int scx200_create_pci(cons
 	iface->pdev = pdev;
 	iface->bar = bar;
 
-	pci_enable_device_bars(iface->pdev, 1 << iface->bar);
+	rc = pci_enable_device_bars(iface->pdev, 1 << iface->bar);
+	if (rc)
+		goto errout_free;
 
 	rc = pci_request_region(iface->pdev, iface->bar, iface->adapter.name);
-
-	if (rc != 0) {
+	if (rc) {
 		printk(KERN_ERR NAME ": can't allocate PCI BAR %d\n",
 				iface->bar);
 		goto errout_free;
