Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751190AbWGKTGr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbWGKTGr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 15:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbWGKTGr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 15:06:47 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:16768 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1751190AbWGKTGq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 15:06:46 -0400
From: Pierre Ossman <drzeus@drzeus.cx>
Subject: [PATCH] [MMC] Fix incorrect register access
Date: Tue, 11 Jul 2006 21:06:48 +0200
Cc: Pierre Ossman <drzeus-list@drzeus.cx>
To: rmk+lkml@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060711190648.12674.48908.stgit@poseidon.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There was a writel() being used on a 16-bit register.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 drivers/mmc/sdhci.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/sdhci.c b/drivers/mmc/sdhci.c
index edf416b..fd34d84 100644
--- a/drivers/mmc/sdhci.c
+++ b/drivers/mmc/sdhci.c
@@ -565,7 +565,7 @@ static void sdhci_send_command(struct sd
 	if (cmd->data)
 		flags |= SDHCI_CMD_DATA;
 
-	writel(SDHCI_MAKE_CMD(cmd->opcode, flags),
+	writew(SDHCI_MAKE_CMD(cmd->opcode, flags),
 		host->ioaddr + SDHCI_COMMAND);
 }
 

