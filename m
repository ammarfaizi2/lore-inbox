Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262766AbVF3AsI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262766AbVF3AsI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 20:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262765AbVF3AsH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 20:48:07 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:43282 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262761AbVF3Arz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 20:47:55 -0400
Date: Thu, 30 Jun 2005 02:47:53 +0200
From: Adrian Bunk <bunk@stusta.de>
To: drzeus-wbsd@drzeus.cx, wbsd-devel@list.drzeus.cx
Cc: linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/mmc/wbsd.c: possible cleanups
Message-ID: <20050630004753.GB27478@stusta.de>
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

 drivers/mmc/wbsd.c |   29 +++++++----------------------
 drivers/mmc/wbsd.h |    7 -------
 2 files changed, 7 insertions(+), 29 deletions(-)

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
--- linux-2.6.12-mm2-full/drivers/mmc/wbsd.c.old	2005-06-30 02:31:01.000000000 +0200
+++ linux-2.6.12-mm2-full/drivers/mmc/wbsd.c	2005-06-30 02:31:51.000000000 +0200
@@ -54,28 +54,6 @@
 #define DBGF(x...)	do { } while (0)
 #endif
 
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
  * Device resources
  */
@@ -92,6 +70,13 @@
 
 #endif /* CONFIG_PNP */
 
+static const int config_ports[] = { 0x2E, 0x4E };
+static const int unlock_codes[] = { 0x83, 0x87 };
+
+static const int valid_ids[] = {
+	0x7112,
+	};
+
 #ifdef CONFIG_PNP
 static unsigned int nopnp = 0;
 #else
