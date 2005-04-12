Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262505AbVDMFI7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262505AbVDMFI7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 01:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262541AbVDLSkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 14:40:14 -0400
Received: from fire.osdl.org ([65.172.181.4]:2507 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262245AbVDLKd6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:33:58 -0400
Message-Id: <200504121033.j3CAXRwP005881@shell0.pdx.osdl.net>
Subject: [patch 180/198] IB/mthca: add SYNC_TPT firmware command
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, mst@mellanox.co.il,
       roland@topspin.com
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:33:21 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Michael S. Tsirkin <mst@mellanox.co.il>

Add code for SYNC_TPT firmware command, which will be used by FMR
implementation.

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <roland@topspin.com>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/drivers/infiniband/hw/mthca/mthca_cmd.c |    5 +++++
 25-akpm/drivers/infiniband/hw/mthca/mthca_cmd.h |    1 +
 2 files changed, 6 insertions(+)

diff -puN drivers/infiniband/hw/mthca/mthca_cmd.c~ib-mthca-add-sync_tpt-firmware-command drivers/infiniband/hw/mthca/mthca_cmd.c
--- 25/drivers/infiniband/hw/mthca/mthca_cmd.c~ib-mthca-add-sync_tpt-firmware-command	2005-04-12 03:21:46.273102320 -0700
+++ 25-akpm/drivers/infiniband/hw/mthca/mthca_cmd.c	2005-04-12 03:21:46.279101408 -0700
@@ -1404,6 +1404,11 @@ int mthca_WRITE_MTT(struct mthca_dev *de
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
diff -puN drivers/infiniband/hw/mthca/mthca_cmd.h~ib-mthca-add-sync_tpt-firmware-command drivers/infiniband/hw/mthca/mthca_cmd.h
--- 25/drivers/infiniband/hw/mthca/mthca_cmd.h~ib-mthca-add-sync_tpt-firmware-command	2005-04-12 03:21:46.275102016 -0700
+++ 25-akpm/drivers/infiniband/hw/mthca/mthca_cmd.h	2005-04-12 03:21:46.279101408 -0700
@@ -276,6 +276,7 @@ int mthca_HW2SW_MPT(struct mthca_dev *de
 		    int mpt_index, u8 *status);
 int mthca_WRITE_MTT(struct mthca_dev *dev, u64 *mtt_entry,
 		    int num_mtt, u8 *status);
+int mthca_SYNC_TPT(struct mthca_dev *dev, u8 *status);
 int mthca_MAP_EQ(struct mthca_dev *dev, u64 event_mask, int unmap,
 		 int eq_num, u8 *status);
 int mthca_SW2HW_EQ(struct mthca_dev *dev, void *eq_context,
_
