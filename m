Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262736AbVCCXuW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262736AbVCCXuW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 18:50:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262738AbVCCXts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 18:49:48 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:56054 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262736AbVCCXWS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 18:22:18 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][13/26] IB/mthca: tweak firmware command debug messages
In-Reply-To: <2005331520.KR3jHRDWtXI3rzl6@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Thu, 3 Mar 2005 15:20:27 -0800
Message-Id: <2005331520.wYWJriF1rMlIY4lJ@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 03 Mar 2005 23:20:27.0800 (UTC) FILETIME=[95CE0180:01C52047]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Slightly improve debugging output for UNMAP_ICM and MODIFY_QP firmware commands.

Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_cmd.c	2005-01-25 20:48:02.000000000 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_cmd.c	2005-03-03 14:12:58.283270213 -0800
@@ -1305,6 +1305,9 @@
 
 int mthca_UNMAP_ICM(struct mthca_dev *dev, u64 virt, u32 page_count, u8 *status)
 {
+	mthca_dbg(dev, "Unmapping %d pages at %llx from ICM.\n",
+		  page_count, (unsigned long long) virt);
+
 	return mthca_cmd(dev, virt, page_count, 0, CMD_UNMAP_ICM, CMD_TIME_CLASS_B, status);
 }
 
@@ -1538,10 +1541,10 @@
 		if (0) {
 			int i;
 			mthca_dbg(dev, "Dumping QP context:\n");
-			printk(" %08x\n", be32_to_cpup(qp_context));
+			printk("  opt param mask: %08x\n", be32_to_cpup(qp_context));
 			for (i = 0; i < 0x100 / 4; ++i) {
 				if (i % 8 == 0)
-					printk("[%02x] ", i * 4);
+					printk("  [%02x] ", i * 4);
 				printk(" %08x", be32_to_cpu(((u32 *) qp_context)[i + 2]));
 				if ((i + 1) % 8 == 0)
 					printk("\n");

