Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932645AbWEXIUs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932645AbWEXIUs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 04:20:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932661AbWEXIUr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 04:20:47 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:60325 "EHLO
	mail.drzeus.cx") by vger.kernel.org with ESMTP id S932645AbWEXIUr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 04:20:47 -0400
From: Pierre Ossman <drzeus@drzeus.cx>
Subject: [PATCH] [MMC] Fix premature use of md->disk
Date: Wed, 24 May 2006 10:20:45 +0200
Cc: Pierre Ossman <drzeus-list@drzeus.cx>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, rmk+lkml@arm.linux.org.uk
Message-Id: <20060524082045.7334.22221.stgit@poseidon.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

md->disk was being used in a debug message before it was allocated.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 drivers/mmc/mmc_block.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/mmc_block.c b/drivers/mmc/mmc_block.c
index e39cc05..587458b 100644
--- a/drivers/mmc/mmc_block.c
+++ b/drivers/mmc/mmc_block.c
@@ -353,7 +353,7 @@ static struct mmc_blk_data *mmc_blk_allo
 			 */
 			printk(KERN_ERR "%s: unable to select block size for "
 				"writing (rb%u wb%u rp%u wp%u)\n",
-				md->disk->disk_name,
+				mmc_card_id(card),
 				1 << card->csd.read_blkbits,
 				1 << card->csd.write_blkbits,
 				card->csd.read_partial,

