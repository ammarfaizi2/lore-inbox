Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932226AbVLDOA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbVLDOA0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Dec 2005 09:00:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932221AbVLDOA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Dec 2005 09:00:26 -0500
Received: from [85.8.13.51] ([85.8.13.51]:10665 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S932228AbVLDOAZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Dec 2005 09:00:25 -0500
From: Pierre Ossman <drzeus@drzeus.cx>
Subject: [PATCH] [MMC] Proper check of SCR error code
Date: Sun, 04 Dec 2005 15:00:19 +0100
Cc: Pierre Ossman <drzeus-list@drzeus.cx>
To: rmk+lkml@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Message-Id: <20051204140019.21469.97634.stgit@poseidon.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The routine reading the SCR wasn't paying proper attention to the error
codes returned from the driver.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 drivers/mmc/mmc.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index d336a1d..b586a83 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -932,8 +932,9 @@ static void mmc_read_scrs(struct mmc_hos
 
 		sg_init_one(&sg, (u8*)card->raw_scr, 8);
 
-		err = mmc_wait_for_req(host, &mrq);
-		if (err != MMC_ERR_NONE) {
+		mmc_wait_for_req(host, &mrq);
+
+		if (cmd.error != MMC_ERR_NONE || data.error != MMC_ERR_NONE) {
 			mmc_card_set_dead(card);
 			continue;
 		}

