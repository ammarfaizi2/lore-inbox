Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261690AbVEAPuN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261690AbVEAPuN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 11:50:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261691AbVEAPuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 11:50:13 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:54280 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S261682AbVEAPnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 11:43:20 -0400
Date: Sun, 1 May 2005 17:43:18 +0200
From: Adrian Bunk <bunk@stusta.de>
To: drzeus-wbsd@drzeus.cx
Cc: wbsd-devel@list.drzeus.cx, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/mmc/wbsd.c: possible cleanups
Message-ID: <20050501154318.GU3592@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch contains the following possible cleanups:
- make some needlessly global code static
- remove the unneeded global function DBG_REG

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

This patch was already sent on:
- 19 Apr 2005

 drivers/mmc/wbsd.c |   30 ++++++++----------------------
 drivers/mmc/wbsd.h |    7 -------
 2 files changed, 8 insertions(+), 29 deletions(-)

--- linux-2.6.12-rc2-mm3-full/drivers/mmc/wbsd.h.old	2005-04-19 02:56:24.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/mmc/wbsd.h	2005-04-19 02:57:17.000000000 +0200
@@ -8,13 +8,6 @@
  * published by the Free Software Foundation.
  */
 
-const int config_ports[] = { 0x2E, 0x4E };
-const int unlock_codes[] = { 0x83, 0x87 };
-
-const int valid_ids[] = {
-	0x7112,
-	};
-
 #define LOCK_CODE		0xAA
 
 #define WBSD_CONF_SWRST		0x02
--- linux-2.6.12-rc2-mm3-full/drivers/mmc/wbsd.c.old	2005-04-19 02:55:39.000000000 +0200
+++ linux-2.6.12-rc2-mm3-full/drivers/mmc/wbsd.c	2005-04-19 02:57:06.000000000 +0200
@@ -52,32 +52,18 @@
 #define DBGF(x...)	do { } while (0)
 #endif
 
+static const int config_ports[] = { 0x2E, 0x4E };
+static const int unlock_codes[] = { 0x83, 0x87 };
+
+static const int valid_ids[] = {
+	0x7112,
+	};
+
+
 static unsigned int io = 0x248;
 static unsigned int irq = 6;
 static int dma = 2;
 
-#ifdef CONFIG_MMC_DEBUG
-void DBG_REG(int reg, u8 value)
-{
-	int i;
-	
-	printk(KERN_DEBUG "wbsd: Register %d: 0x%02X %3d '%c' ",
-		reg, (int)value, (int)value, (value < 0x20)?'.':value);
-	
-	for (i = 7;i >= 0;i--)
-	{
-		if (value & (1 << i))
-			printk("x");
-		else
-			printk(".");
-	}
-	
-	printk("\n");
-}
-#else
-#define DBG_REG(r, v) do {}  while (0)
-#endif
-
 /*
  * Basic functions
  */

