Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932796AbWAFSiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932796AbWAFSiH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 13:38:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932851AbWAFSiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 13:38:07 -0500
Received: from [85.8.13.51] ([85.8.13.51]:33985 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S932815AbWAFSiF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 13:38:05 -0500
From: Pierre Ossman <drzeus@drzeus.cx>
Subject: [PATCH] [MMC] Indicate that R1/R1b contains command opcode
Date: Fri, 06 Jan 2006 19:38:03 +0100
Cc: Pierre Ossman <drzeus-list@drzeus.cx>
To: rmk+lkml@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060106183802.10810.81449.stgit@poseidon.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some controllers actually check the first byte of the response (most don't).
This byte contains the command opcode for R1/R1b and all 1:s for other types.
The difference must be indicated to the controller so it knows which reply
to expect.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 include/linux/mmc/mmc.h |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/include/linux/mmc/mmc.h b/include/linux/mmc/mmc.h
index aef6042..b101f9e 100644
--- a/include/linux/mmc/mmc.h
+++ b/include/linux/mmc/mmc.h
@@ -27,14 +27,15 @@ struct mmc_command {
 #define MMC_RSP_MASK	(3 << 0)
 #define MMC_RSP_CRC	(1 << 3)		/* expect valid crc */
 #define MMC_RSP_BUSY	(1 << 4)		/* card may send busy */
+#define MMC_RSP_OPCODE	(1 << 5)		/* response contains opcode */
 
 /*
  * These are the response types, and correspond to valid bit
  * patterns of the above flags.  One additional valid pattern
  * is all zeros, which means we don't expect a response.
  */
-#define MMC_RSP_R1	(MMC_RSP_SHORT|MMC_RSP_CRC)
-#define MMC_RSP_R1B	(MMC_RSP_SHORT|MMC_RSP_CRC|MMC_RSP_BUSY)
+#define MMC_RSP_R1	(MMC_RSP_SHORT|MMC_RSP_CRC|MMC_RSP_OPCODE)
+#define MMC_RSP_R1B	(MMC_RSP_SHORT|MMC_RSP_CRC|MMC_RSP_OPCODE|MMC_RSP_BUSY)
 #define MMC_RSP_R2	(MMC_RSP_LONG|MMC_RSP_CRC)
 #define MMC_RSP_R3	(MMC_RSP_SHORT)
 #define MMC_RSP_R6	(MMC_RSP_SHORT|MMC_RSP_CRC)

