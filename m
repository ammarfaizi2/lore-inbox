Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262924AbVDAVlJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262924AbVDAVlJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Apr 2005 16:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262923AbVDAVAI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Apr 2005 16:00:08 -0500
Received: from webmail.topspin.com ([12.162.17.3]:35887 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S262908AbVDAUvS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Apr 2005 15:51:18 -0500
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH][18/27] IB/mthca: add SYNC_TPT firmware command
In-Reply-To: <2005411249.S2hhmQaEpM8vK71i@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Fri, 1 Apr 2005 12:49:53 -0800
Message-Id: <2005411249.Wiedh3QohPRJi9Sp@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 01 Apr 2005 20:49:53.0575 (UTC) FILETIME=[5AF76B70:01C536FC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael S. Tsirkin <mst@mellanox.co.il>

Add code for SYNC_TPT firmware command, which will be used by FMR implementation.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <roland@topspin.com>


--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_cmd.c	2005-04-01 12:38:25.574409178 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_cmd.c	2005-04-01 12:38:27.495992056 -0800
@@ -1404,6 +1404,11 @@
 	return err;
 }
 
+int mthca_SYNC_TPT(struct mthca_dev *dev, u8 *status)
+{
+	return mthca_cmd(dev, 0, 0, 0, CMD_SYNC_TPT, CMD_TIME_CLASS_B, status);
+}
+
 int mthca_MAP_EQ(struct mthca_dev *dev, u64 event_mask, int unmap,
 		 int eq_num, u8 *status)
 {
--- linux-export.orig/drivers/infiniband/hw/mthca/mthca_cmd.h	2005-04-01 12:38:25.578408310 -0800
+++ linux-export/drivers/infiniband/hw/mthca/mthca_cmd.h	2005-04-01 12:38:27.500990971 -0800
@@ -276,6 +276,7 @@
 		    int mpt_index, u8 *status);
 int mthca_WRITE_MTT(struct mthca_dev *dev, u64 *mtt_entry,
 		    int num_mtt, u8 *status);
+int mthca_SYNC_TPT(struct mthca_dev *dev, u8 *status);
 int mthca_MAP_EQ(struct mthca_dev *dev, u64 event_mask, int unmap,
 		 int eq_num, u8 *status);
 int mthca_SW2HW_EQ(struct mthca_dev *dev, void *eq_context,

