Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030519AbVKCXND@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030519AbVKCXND (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 18:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030522AbVKCXLh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 18:11:37 -0500
Received: from ams-iport-1.cisco.com ([144.254.224.140]:22347 "EHLO
	ams-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1030519AbVKCXLO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 18:11:14 -0500
Subject: [git patch review 5/7] [IB] mthca: fix format of FW version
From: Roland Dreier <rolandd@cisco.com>
Date: Thu, 03 Nov 2005 23:10:59 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1131059459423-9ff5e95fb47caab0@cisco.com>
In-Reply-To: <1131059459423-c39565dcb8db8aaa@cisco.com>
X-OriginalArrivalTime: 03 Nov 2005 23:11:00.0620 (UTC) FILETIME=[DAF1F4C0:01C5E0CB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mellanox has decided that the components of the firmware version are
really meant to be displayed in decimal, e.g. 0x000400070190 is
version 4.7.400.  Change the format we use from "%x.%x.%x" to
"%d.%d.%d" to match this convention.

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/hw/mthca/mthca_main.c     |    2 +-
 drivers/infiniband/hw/mthca/mthca_provider.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

applies-to: 389cecdfb0769cdddd0e901c1d60b9549b0a6322
87cfe32375e0b69b999b59bf8287f501df3e43f7
diff --git a/drivers/infiniband/hw/mthca/mthca_main.c b/drivers/infiniband/hw/mthca/mthca_main.c
index 883d1e5..45c6328 100644
--- a/drivers/infiniband/hw/mthca/mthca_main.c
+++ b/drivers/infiniband/hw/mthca/mthca_main.c
@@ -1057,7 +1057,7 @@ static int __devinit mthca_init_one(stru
 		goto err_cmd;
 
 	if (mdev->fw_ver < mthca_hca_table[id->driver_data].latest_fw) {
-		mthca_warn(mdev, "HCA FW version %x.%x.%x is old (%x.%x.%x is current).\n",
+		mthca_warn(mdev, "HCA FW version %d.%d.%d is old (%d.%d.%d is current).\n",
 			   (int) (mdev->fw_ver >> 32), (int) (mdev->fw_ver >> 16) & 0xffff,
 			   (int) (mdev->fw_ver & 0xffff),
 			   (int) (mthca_hca_table[id->driver_data].latest_fw >> 32),
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index 1b9477e..6b01666 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -1028,7 +1028,7 @@ static ssize_t show_rev(struct class_dev
 static ssize_t show_fw_ver(struct class_device *cdev, char *buf)
 {
 	struct mthca_dev *dev = container_of(cdev, struct mthca_dev, ib_dev.class_dev);
-	return sprintf(buf, "%x.%x.%x\n", (int) (dev->fw_ver >> 32),
+	return sprintf(buf, "%d.%d.%d\n", (int) (dev->fw_ver >> 32),
 		       (int) (dev->fw_ver >> 16) & 0xffff,
 		       (int) dev->fw_ver & 0xffff);
 }
---
0.99.9
