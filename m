Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932342AbWAJTcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932342AbWAJTcc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 14:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932495AbWAJTb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 14:31:57 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:2237 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S932411AbWAJTbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 14:31:48 -0500
X-IronPort-AV: i="3.99,351,1131350400"; 
   d="scan'208"; a="389971902:sNHT98935916"
Subject: [git patch review 3/7] IB/mthca: kzalloc conversions
From: Roland Dreier <rolandd@cisco.com>
Date: Tue, 10 Jan 2006 19:31:23 +0000
To: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Mailer: IB-patch-reviewer
Content-Transfer-Encoding: 8bit
Message-ID: <1136921483290-3d1a8ae2f0b61cbf@cisco.com>
In-Reply-To: <1136921483290-79d0774f48f3f587@cisco.com>
X-OriginalArrivalTime: 10 Jan 2006 19:31:24.0823 (UTC) FILETIME=[71A5E270:01C6161C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert kmalloc()/memset(,0,) pairs to kzalloc().

Signed-off-by: Roland Dreier <rolandd@cisco.com>

---

 drivers/infiniband/hw/mthca/mthca_provider.c |   12 ++++--------
 1 files changed, 4 insertions(+), 8 deletions(-)

105e50a5e8f184af31daffce4d7bfd7771fe213f
diff --git a/drivers/infiniband/hw/mthca/mthca_provider.c b/drivers/infiniband/hw/mthca/mthca_provider.c
index 30b67c2..0ae27fa 100644
--- a/drivers/infiniband/hw/mthca/mthca_provider.c
+++ b/drivers/infiniband/hw/mthca/mthca_provider.c
@@ -55,7 +55,7 @@ static int mthca_query_device(struct ib_
 
 	u8 status;
 
-	in_mad  = kmalloc(sizeof *in_mad, GFP_KERNEL);
+	in_mad  = kzalloc(sizeof *in_mad, GFP_KERNEL);
 	out_mad = kmalloc(sizeof *out_mad, GFP_KERNEL);
 	if (!in_mad || !out_mad)
 		goto out;
@@ -64,7 +64,6 @@ static int mthca_query_device(struct ib_
 
 	props->fw_ver              = mdev->fw_ver;
 
-	memset(in_mad, 0, sizeof *in_mad);
 	in_mad->base_version       = 1;
 	in_mad->mgmt_class     	   = IB_MGMT_CLASS_SUBN_LID_ROUTED;
 	in_mad->class_version  	   = 1;
@@ -128,14 +127,13 @@ static int mthca_query_port(struct ib_de
 	int err = -ENOMEM;
 	u8 status;
 
-	in_mad  = kmalloc(sizeof *in_mad, GFP_KERNEL);
+	in_mad  = kzalloc(sizeof *in_mad, GFP_KERNEL);
 	out_mad = kmalloc(sizeof *out_mad, GFP_KERNEL);
 	if (!in_mad || !out_mad)
 		goto out;
 
 	memset(props, 0, sizeof *props);
 
-	memset(in_mad, 0, sizeof *in_mad);
 	in_mad->base_version       = 1;
 	in_mad->mgmt_class     	   = IB_MGMT_CLASS_SUBN_LID_ROUTED;
 	in_mad->class_version  	   = 1;
@@ -220,12 +218,11 @@ static int mthca_query_pkey(struct ib_de
 	int err = -ENOMEM;
 	u8 status;
 
-	in_mad  = kmalloc(sizeof *in_mad, GFP_KERNEL);
+	in_mad  = kzalloc(sizeof *in_mad, GFP_KERNEL);
 	out_mad = kmalloc(sizeof *out_mad, GFP_KERNEL);
 	if (!in_mad || !out_mad)
 		goto out;
 
-	memset(in_mad, 0, sizeof *in_mad);
 	in_mad->base_version       = 1;
 	in_mad->mgmt_class     	   = IB_MGMT_CLASS_SUBN_LID_ROUTED;
 	in_mad->class_version  	   = 1;
@@ -259,12 +256,11 @@ static int mthca_query_gid(struct ib_dev
 	int err = -ENOMEM;
 	u8 status;
 
-	in_mad  = kmalloc(sizeof *in_mad, GFP_KERNEL);
+	in_mad  = kzalloc(sizeof *in_mad, GFP_KERNEL);
 	out_mad = kmalloc(sizeof *out_mad, GFP_KERNEL);
 	if (!in_mad || !out_mad)
 		goto out;
 
-	memset(in_mad, 0, sizeof *in_mad);
 	in_mad->base_version       = 1;
 	in_mad->mgmt_class     	   = IB_MGMT_CLASS_SUBN_LID_ROUTED;
 	in_mad->class_version  	   = 1;
-- 
1.0.7
