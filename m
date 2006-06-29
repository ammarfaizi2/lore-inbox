Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932905AbWF2Vxx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932905AbWF2Vxx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 17:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932901AbWF2VxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 17:53:04 -0400
Received: from mx.pathscale.com ([64.160.42.68]:37519 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932905AbWF2VoK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:44:10 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 26 of 39] IB/ipath - check for valid LID and multicast LIDs
X-Mercurial-Node: eef7f80215004f4cf8549c7bd99be8484482b3bb
Message-Id: <eef7f80215004f4cf854.1151617277@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1151617251@eng-12.pathscale.com>
Date: Thu, 29 Jun 2006 14:41:17 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: akpm@osdl.org, rdreier@cisco.com, mst@mellanox.co.il
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Ralph Campbell <ralph.campbell@qlogic.com>
Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r 4c581c37bb95 -r eef7f8021500 drivers/infiniband/hw/ipath/ipath_sysfs.c
--- a/drivers/infiniband/hw/ipath/ipath_sysfs.c	Thu Jun 29 14:33:26 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_sysfs.c	Thu Jun 29 14:33:26 2006 -0700
@@ -280,7 +280,7 @@ static ssize_t store_lid(struct device *
 	if (ret < 0)
 		goto invalid;
 
-	if (lid == 0 || lid >= 0xc000) {
+	if (lid == 0 || lid >= IPS_MULTICAST_LID_BASE) {
 		ret = -EINVAL;
 		goto invalid;
 	}
@@ -314,7 +314,7 @@ static ssize_t store_mlid(struct device 
 	int ret;
 
 	ret = ipath_parse_ushort(buf, &mlid);
-	if (ret < 0)
+	if (ret < 0 || mlid < IPS_MULTICAST_LID_BASE)
 		goto invalid;
 
 	unit = dd->ipath_unit;
