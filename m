Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030642AbWFOPRR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030642AbWFOPRR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jun 2006 11:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030646AbWFOPRR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jun 2006 11:17:17 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:4012 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1030642AbWFOPRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jun 2006 11:17:17 -0400
Subject: PATCH: Fix 32bitism in SDHCI
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: sdhci-devel@list.drzeus.cx, linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 15 Jun 2006 16:33:25 +0100
Message-Id: <1150385605.3490.85.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The data field is ulong, pointers fit in ulongs. Casting them to int is
bad for 64bit systems.

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.17-rc6/drivers/mmc/sdhci.c linux-2.6.17-rc6/drivers/mmc/sdhci.c
--- linux.vanilla-2.6.17-rc6/drivers/mmc/sdhci.c	2006-06-06 14:01:11.000000000 +0100
+++ linux-2.6.17-rc6/drivers/mmc/sdhci.c	2006-06-15 11:59:57.580510280 +0100
@@ -1073,7 +1073,7 @@
 	tasklet_init(&host->finish_tasklet,
 		sdhci_tasklet_finish, (unsigned long)host);
 
-	setup_timer(&host->timer, sdhci_timeout_timer, (int)host);
+	setup_timer(&host->timer, sdhci_timeout_timer, (unsigned long)host);
 
 	ret = request_irq(host->irq, sdhci_irq, SA_SHIRQ,
 		host->slot_descr, host);

