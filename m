Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262351AbVAUMmc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262351AbVAUMmc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 07:42:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262352AbVAUMmc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 07:42:32 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:20233 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S262351AbVAUMmU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 07:42:20 -0500
Date: Fri, 21 Jan 2005 13:42:18 +0100
From: Adrian Bunk <bunk@stusta.de>
To: chas@cmf.nrl.navy.mil
Cc: linux-atm-general@lists.sourceforge.net, jgarzik@pobox.com,
       linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/atm/nicstar*: small cleanup
Message-ID: <20050121124218.GL3209@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes two needlessly global functions in nicstarmac.c static.

Since after this change nicstarmac.h contained only one typedef I've 
moved this typedef to nicstarmac.c and completely removed the header.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

---

 drivers/atm/nicstar.c    |    1 -
 drivers/atm/nicstarmac.c |    6 ++++--
 drivers/atm/nicstarmac.h |   13 -------------
 3 files changed, 4 insertions(+), 16 deletions(-)

--- linux-2.6.11-rc1-mm2-full/drivers/atm/nicstarmac.h	2005-01-20 07:44:04.000000000 +0100
+++ /dev/null	2004-11-25 03:16:25.000000000 +0100
@@ -1,13 +0,0 @@
-/******************************************************************************
- *
- * nicstarmac.h
- *
- * Header file for nicstarmac.c
- *
- ******************************************************************************/
-
-
-typedef void __iomem *virt_addr_t;
-
-void nicstar_init_eprom( virt_addr_t base );
-void nicstar_read_eprom( virt_addr_t, u_int8_t, u_int8_t *, u_int32_t);
--- linux-2.6.11-rc1-mm2-full/drivers/atm/nicstarmac.c.old	2005-01-21 13:23:05.000000000 +0100
+++ linux-2.6.11-rc1-mm2-full/drivers/atm/nicstarmac.c	2005-01-21 13:23:37.000000000 +0100
@@ -7,6 +7,8 @@
  * Read this ForeRunner's MAC address from eprom/eeprom
  */
 
+typedef void __iomem *virt_addr_t;
+
 #define CYCLE_DELAY 5
 
 /* This was the original definition
@@ -213,7 +215,7 @@
 }
 
 
-void
+static void
 nicstar_init_eprom( virt_addr_t base )
 {
     u_int32_t val;
@@ -246,7 +248,7 @@
  * above.
  */ 
 
-void
+static void
 nicstar_read_eprom(
     virt_addr_t	base,
     u_int8_t	prom_offset,
--- linux-2.6.11-rc1-mm2-full/drivers/atm/nicstar.c.old	2005-01-21 13:26:41.000000000 +0100
+++ linux-2.6.11-rc1-mm2-full/drivers/atm/nicstar.c	2005-01-21 13:26:50.000000000 +0100
@@ -54,7 +54,6 @@
 #include <asm/uaccess.h>
 #include <asm/atomic.h>
 #include "nicstar.h"
-#include "nicstarmac.h"
 #ifdef CONFIG_ATM_NICSTAR_USE_SUNI
 #include "suni.h"
 #endif /* CONFIG_ATM_NICSTAR_USE_SUNI */

