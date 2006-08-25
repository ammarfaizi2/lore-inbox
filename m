Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422739AbWHYS3N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422739AbWHYS3N (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Aug 2006 14:29:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422698AbWHYSZ0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Aug 2006 14:25:26 -0400
Received: from mx.pathscale.com ([64.160.42.68]:43394 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1422760AbWHYSZT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Aug 2006 14:25:19 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 13 of 23] IB/ipath - account for attached QPs correctly
X-Mercurial-Node: f35895850ced971a7b9cb3c82f7254fde8e0f5fa
Message-Id: <f35895850ced971a7b9c.1156530278@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1156530265@eng-12.pathscale.com>
Date: Fri, 25 Aug 2006 11:24:38 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff --git a/drivers/infiniband/hw/ipath/ipath_verbs_mcast.c b/drivers/infiniband/hw/ipath/ipath_verbs_mcast.c
--- a/drivers/infiniband/hw/ipath/ipath_verbs_mcast.c	Fri Aug 25 11:19:45 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs_mcast.c	Fri Aug 25 11:19:45 2006 -0700
@@ -217,6 +217,8 @@ static int ipath_mcast_add(struct ipath_
 	dev->n_mcast_grps_allocated++;
 	spin_unlock(&dev->n_mcast_grps_lock);
 
+	mcast->n_attached++;
+
 	list_add_tail_rcu(&mqp->list, &mcast->qp_list);
 
 	atomic_inc(&mcast->refcount);
