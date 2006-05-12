Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932297AbWELXpJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbWELXpJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 19:45:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbWELXoh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 19:44:37 -0400
Received: from mx.pathscale.com ([64.160.42.68]:51113 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932189AbWELXod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 19:44:33 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 5 of 53] ipath - forbid creation of AHs with illegal ports
X-Mercurial-Node: db56c0ab6a648f56348a6492bbc7fe651617d73f
Message-Id: <db56c0ab6a648f56348a.1147477370@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1147477365@eng-12.pathscale.com>
Date: Fri, 12 May 2006 16:42:50 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't allow an AH to be created with an illegal port.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 300f0aa6f034 -r db56c0ab6a64 drivers/infiniband/hw/ipath/ipath_verbs.c
--- a/drivers/infiniband/hw/ipath/ipath_verbs.c	Fri May 12 15:55:27 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs.c	Fri May 12 15:55:27 2006 -0700
@@ -810,6 +810,12 @@ static struct ib_ah *ipath_create_ah(str
 	if (ah_attr->dlid >= IPS_MULTICAST_LID_BASE &&
 	    ah_attr->dlid != IPS_PERMISSIVE_LID &&
 	    !(ah_attr->ah_flags & IB_AH_GRH)) {
+		ret = ERR_PTR(-EINVAL);
+		goto bail;
+	}
+
+	if (ah_attr->port_num != 1 ||
+	    ah_attr->port_num > pd->device->phys_port_cnt) {
 		ret = ERR_PTR(-EINVAL);
 		goto bail;
 	}
