Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751258AbVK1IyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258AbVK1IyN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 03:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbVK1IyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 03:54:13 -0500
Received: from [85.8.13.51] ([85.8.13.51]:16549 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1751258AbVK1IyM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 03:54:12 -0500
From: Pierre Ossman <drzeus@drzeus.cx>
Subject: [PATCH] [MMC] Fix protocol errors
Date: Mon, 28 Nov 2005 09:54:04 +0100
Cc: Pierre Ossman <drzeus-list@drzeus.cx>
To: rmk+lkml@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Message-Id: <20051128085404.4852.40271.stgit@poseidon.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A review against MMC/SD specifications found some errors in the current
implementation.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 drivers/mmc/mmc.c            |    2 +-
 include/linux/mmc/protocol.h |    4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/mmc.c b/drivers/mmc/mmc.c
index fa6835f..8c47100 100644
--- a/drivers/mmc/mmc.c
+++ b/drivers/mmc/mmc.c
@@ -816,7 +816,7 @@ static void mmc_discover_cards(struct mm
 
 			cmd.opcode = SD_SEND_RELATIVE_ADDR;
 			cmd.arg = 0;
-			cmd.flags = MMC_RSP_R1;
+			cmd.flags = MMC_RSP_R6;
 
 			err = mmc_wait_for_cmd(host, &cmd, CMD_RETRIES);
 			if (err != MMC_ERR_NONE)
diff --git a/include/linux/mmc/protocol.h b/include/linux/mmc/protocol.h
index 06355fa..c359a8e 100644
--- a/include/linux/mmc/protocol.h
+++ b/include/linux/mmc/protocol.h
@@ -63,7 +63,7 @@
   /* class 5 */
 #define MMC_ERASE_GROUP_START    35   /* ac   [31:0] data addr   R1  */
 #define MMC_ERASE_GROUP_END      36   /* ac   [31:0] data addr   R1  */
-#define MMC_ERASE                37   /* ac                      R1b */
+#define MMC_ERASE                38   /* ac                      R1b */
 
   /* class 9 */
 #define MMC_FAST_IO              39   /* ac   <Complex>          R4  */
@@ -74,7 +74,7 @@
 
   /* class 8 */
 #define MMC_APP_CMD              55   /* ac   [31:16] RCA        R1  */
-#define MMC_GEN_CMD              56   /* adtc [0] RD/WR          R1b */
+#define MMC_GEN_CMD              56   /* adtc [0] RD/WR          R1  */
 
 /* SD commands                           type  argument     response */
   /* class 8 */

