Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbWGKTHJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbWGKTHJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 15:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932091AbWGKTHJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 15:07:09 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:16768 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S932088AbWGKTHH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 15:07:07 -0400
From: Pierre Ossman <drzeus@drzeus.cx>
Subject: [PATCH] [MMC] Change SDHCI version error to a warning
Date: Tue, 11 Jul 2006 21:07:10 +0200
Cc: Pierre Ossman <drzeus-list@drzeus.cx>
To: rmk+lkml@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060711190710.12686.11805.stgit@poseidon.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

O2 Micro's controllers have a larger specification version value and are
therefore denied by the driver. When bypassing this check they seem to work
fine. This patch makes the code a bit more forgiving by changing the
warning to an error.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 drivers/mmc/sdhci.c |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
index fd34d84..9ec4200 100644
--- a/drivers/mmc/sdhci.c
+++ b/drivers/mmc/sdhci.c
@@ -1193,10 +1193,8 @@ static int __devinit sdhci_probe_slot(st
 	version = (version & SDHCI_SPEC_VER_MASK) >> SDHCI_SPEC_VER_SHIFT;
 	if (version != 0) {
 		printk(KERN_ERR "%s: Unknown controller version (%d). "
-			"Cowardly refusing to continue.\n", host->slot_descr,
+			"You may experience problems.\n", host->slot_descr,
 			version);
-		ret = -ENODEV;
-		goto unmap;
 	}
 
 	caps = readl(host->ioaddr + SDHCI_CAPABILITIES);

