Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129624AbRCLJCg>; Mon, 12 Mar 2001 04:02:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129669AbRCLJCQ>; Mon, 12 Mar 2001 04:02:16 -0500
Received: from ns.caldera.de ([212.34.180.1]:43782 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S129624AbRCLJCI>;
	Mon, 12 Mar 2001 04:02:08 -0500
Date: Mon, 12 Mar 2001 10:01:11 +0100
From: Marcus Meissner <Marcus.Meissner@caldera.de>
To: linux-kernel@vger.kernel.org
Subject: PATCH: CS4281: missing pci_enable_dervice
Message-ID: <20010312100111.A16107@caldera.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

My Laptop has a CS4281 soundchip. It requires the following patch to start
working (enable pci device).

Ciao, Marcus

--- linux/drivers/sound/cs4281/cs4281m.c.marcus	Mon Mar 12 09:55:35 2001
+++ linux/drivers/sound/cs4281/cs4281m.c	Mon Mar 12 09:55:57 2001
@@ -4289,6 +4289,9 @@
 	CS_DBGOUT(CS_FUNCTION | CS_INIT, 2,
 		  printk(KERN_INFO "cs4281: probe()+\n"));
 
+	if (pci_enable_device(pcidev))
+		return -1;
+
 	if (!RSRCISMEMORYREGION(pcidev, 0) ||
 	    !RSRCISMEMORYREGION(pcidev, 1)) {
 		CS_DBGOUT(CS_ERROR, 1, printk(KERN_ERR


