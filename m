Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161106AbVKDIy1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161106AbVKDIy1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Nov 2005 03:54:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161115AbVKDIy1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Nov 2005 03:54:27 -0500
Received: from [85.8.13.51] ([85.8.13.51]:14998 "EHLO smtp.drzeus.cx")
	by vger.kernel.org with ESMTP id S1161106AbVKDIy0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Nov 2005 03:54:26 -0500
From: Pierre Ossman <drzeus@drzeus.cx>
Subject: [PATCH] [MMC] Fix chip config in wbsd
Date: Fri, 04 Nov 2005 09:54:22 +0100
Cc: Pierre Ossman <drzeus-list@drzeus.cx>
To: rmk+lkml@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Message-Id: <20051104085410.3457.20238.stgit@poseidon.drzeus.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There is a broken if clause in the wbsd driver that can cause the
driver to try and configure the chip even though none is found. This
results in i/o on invalid ports.

Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
---

 drivers/mmc/wbsd.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/wbsd.c b/drivers/mmc/wbsd.c
--- a/drivers/mmc/wbsd.c
+++ b/drivers/mmc/wbsd.c
@@ -1852,9 +1852,9 @@ static int __devinit wbsd_init(struct de
 	/*
 	 * See if chip needs to be configured.
 	 */
-	if (pnp && (host->config != 0))
+	if (pnp)
 	{
-		if (!wbsd_chip_validate(host))
+		if ((host->config != 0) && !wbsd_chip_validate(host))
 		{
 			printk(KERN_WARNING DRIVER_NAME
 				": PnP active but chip not configured! "

