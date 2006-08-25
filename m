Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422771AbWHYSZr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422771AbWHYSZr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 14:25:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422777AbWHYSZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 14:25:39 -0400
Received: from mx.pathscale.com ([64.160.42.68]:44674 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1422771AbWHYSZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 14:25:19 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 17 of 23] IB/ipath - validate path_mig_state properly
X-Mercurial-Node: 98402de144a44d8589372c01aea52aba8dc0f1b7
Message-Id: <98402de144a44d858937.1156530282@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1156530265@eng-12.pathscale.com>
Date: Fri, 25 Aug 2006 11:24:42 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff --git a/drivers/infiniband/hw/ipath/ipath_qp.c b/drivers/infiniband/hw/ipath/ipath_qp.c
--- a/drivers/infiniband/hw/ipath/ipath_qp.c	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_qp.c	Fri Aug 25 11:19:45 2006 -0700
@@ -491,7 +491,8 @@ int ipath_modify_qp(struct ib_qp *ibqp, 
 			goto inval;
  
 	if (attr_mask & IB_QP_PATH_MIG_STATE)
-		if (attr->path_mig_state != IB_MIG_MIGRATED)
+		if (attr->path_mig_state != IB_MIG_MIGRATED &&
+		    attr->path_mig_state != IB_MIG_REARM)
 			goto inval;
  
 	switch (new_state) {
