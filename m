Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbWHFXj6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWHFXj6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 19:39:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750771AbWHFXj6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 19:39:58 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:5254 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1750769AbWHFXj5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 19:39:57 -0400
From: Pierre Ossman <drzeus@drzeus.cx>
Subject: [PATCH] [MMC] Another stray 'io' reference
Date: Mon, 07 Aug 2006 01:40:04 +0200
Cc: Pierre Ossman <drzeus-list@drzeus.cx>
To: rmk+lkml@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Message-Id: <20060806234001.11770.63270.stgit@poseidon.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Another misuse of the global 'io' variable instead of the local 'base'.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 drivers/mmc/wbsd.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/mmc/wbsd.c b/drivers/mmc/wbsd.c
index ce86887..c351c6d 100644
--- a/drivers/mmc/wbsd.c
+++ b/drivers/mmc/wbsd.c
@@ -1773,7 +1773,7 @@ static int __devinit wbsd_init(struct de
 	/*
 	 * Request resources.
 	 */
-	ret = wbsd_request_resources(host, io, irq, dma);
+	ret = wbsd_request_resources(host, base, irq, dma);
 	if (ret) {
 		wbsd_release_resources(host);
 		wbsd_free_mmc(dev);
@@ -1861,6 +1861,7 @@ static void __devexit wbsd_shutdown(stru
 
 static int __devinit wbsd_probe(struct platform_device *dev)
 {
+	/* Use the module parameters for resources */
 	return wbsd_init(&dev->dev, io, irq, dma, 0);
 }
 

