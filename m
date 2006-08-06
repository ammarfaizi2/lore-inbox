Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbWHFUWV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWHFUWV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 16:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750705AbWHFUWV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 16:22:21 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:64389 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1750704AbWHFUWV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 16:22:21 -0400
From: Pierre Ossman <drzeus@drzeus.cx>
Subject: [PATCH] [MMC] Fix base address configuration in wbsd
Date: Sun, 06 Aug 2006 22:22:23 +0200
Cc: Pierre Ossman <drzeus-list@drzeus.cx>
To: rmk+lkml@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060806202223.13663.66134.stgit@poseidon.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There were some confusion about base I/O variables in the wbsd driver.
Seems like things have been working on shear luck so far. The global 'io'
variable (used when manually configuring the resources) was used instead of
the local 'base' variable.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 drivers/mmc/wbsd.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mmc/wbsd.c b/drivers/mmc/wbsd.c
index 8a30ef3..ce86887 100644
--- a/drivers/mmc/wbsd.c
+++ b/drivers/mmc/wbsd.c
@@ -41,7 +41,7 @@ #include <asm/scatterlist.h>
 #include "wbsd.h"
 
 #define DRIVER_NAME "wbsd"
-#define DRIVER_VERSION "1.5"
+#define DRIVER_VERSION "1.6"
 
 #define DBG(x...) \
 	pr_debug(DRIVER_NAME ": " x)
@@ -1439,13 +1439,13 @@ static int __devinit wbsd_scan(struct wb
 
 static int __devinit wbsd_request_region(struct wbsd_host *host, int base)
 {
-	if (io & 0x7)
+	if (base & 0x7)
 		return -EINVAL;
 
 	if (!request_region(base, 8, DRIVER_NAME))
 		return -EIO;
 
-	host->base = io;
+	host->base = base;
 
 	return 0;
 }

