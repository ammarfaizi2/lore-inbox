Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964795AbVKGHFH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964795AbVKGHFH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 02:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964797AbVKGHFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 02:05:06 -0500
Received: from [85.8.13.51] ([85.8.13.51]:49815 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S964795AbVKGHFF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 02:05:05 -0500
From: Pierre Ossman <drzeus@drzeus.cx>
Subject: [PATCH] [MMC] Use __devexit_p in wbsd
Date: Mon, 07 Nov 2005 08:04:59 +0100
Cc: Pierre Ossman <drzeus-list@drzeus.cx>
To: rmk+lkml@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Message-Id: <20051107070458.6640.83631.stgit@poseidon.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

wbsd_*_remove() is declared as __devexit but __devexit_p isn't used
when taking their addresses.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 drivers/mmc/wbsd.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/wbsd.c b/drivers/mmc/wbsd.c
--- a/drivers/mmc/wbsd.c
+++ b/drivers/mmc/wbsd.c
@@ -2110,7 +2110,7 @@ static struct device_driver wbsd_driver 
 	.name		= DRIVER_NAME,
 	.bus		= &platform_bus_type,
 	.probe		= wbsd_probe,
-	.remove		= wbsd_remove,
+	.remove		= __devexit_p(wbsd_remove),
 
 	.suspend	= wbsd_platform_suspend,
 	.resume		= wbsd_platform_resume,
@@ -2122,7 +2122,7 @@ static struct pnp_driver wbsd_pnp_driver
 	.name		= DRIVER_NAME,
 	.id_table	= pnp_dev_table,
 	.probe		= wbsd_pnp_probe,
-	.remove		= wbsd_pnp_remove,
+	.remove		= __devexit_p(wbsd_pnp_remove),
 
 	.suspend	= wbsd_pnp_suspend,
 	.resume		= wbsd_pnp_resume,

