Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932904AbWF2VxO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932904AbWF2VxO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 17:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932947AbWF2VxJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 17:53:09 -0400
Received: from mx.pathscale.com ([64.160.42.68]:37007 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932904AbWF2VoJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:44:09 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 24 of 39] IB/ipath - don't confuse the max message size with
	the MTU
X-Mercurial-Node: e952aedb0e94b4f8ccc1ec0ab803d426dd79d8db
Message-Id: <e952aedb0e94b4f8ccc1.1151617275@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1151617251@eng-12.pathscale.com>
Date: Thu, 29 Jun 2006 14:41:15 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: akpm@osdl.org, rdreier@cisco.com, mst@mellanox.co.il
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Ralph Campbell <ralph.campbell@qlogic.com>
Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r 8e39364c2402 -r e952aedb0e94 drivers/infiniband/hw/ipath/ipath_verbs.c
--- a/drivers/infiniband/hw/ipath/ipath_verbs.c	Thu Jun 29 14:33:26 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.c	Thu Jun 29 14:33:26 2006 -0700
@@ -695,7 +695,7 @@ static int ipath_query_port(struct ib_de
 		ipath_layer_get_lastibcstat(dev->dd) & 0xf];
 	props->port_cap_flags = dev->port_cap_flags;
 	props->gid_tbl_len = 1;
-	props->max_msg_sz = 4096;
+	props->max_msg_sz = 0x80000000;
 	props->pkey_tbl_len = ipath_layer_get_npkeys(dev->dd);
 	props->bad_pkey_cntr = ipath_layer_get_cr_errpkey(dev->dd) -
 		dev->z_pkey_violations;
