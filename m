Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932304AbWELX5O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932304AbWELX5O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 19:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932300AbWELX5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 19:57:13 -0400
Received: from mx.pathscale.com ([64.160.42.68]:62377 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932284AbWELXoe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 19:44:34 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 40 of 53] ipath - remember to drop spinlock
X-Mercurial-Node: 160a111381ae9f6f5df2c2f0c30844b04c9ea2ca
Message-Id: <160a111381ae9f6f5df2.1147477405@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1147477365@eng-12.pathscale.com>
Date: Fri, 12 May 2006 16:43:25 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 5b565c24d62a -r 160a111381ae drivers/infiniband/hw/ipath/ipath_rc.c
--- a/drivers/infiniband/hw/ipath/ipath_rc.c	Fri May 12 15:55:28 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_rc.c	Fri May 12 15:55:29 2006 -0700
@@ -1505,8 +1505,10 @@ void ipath_rc_rcv(struct ipath_ibdev *de
 			ok = ipath_rkey_ok(dev, &qp->s_rdma_sge,
 					   qp->s_rdma_len, vaddr, rkey,
 					   IB_ACCESS_REMOTE_READ);
-			if (unlikely(!ok))
+			if (unlikely(!ok)) {
+				spin_unlock_irq(&qp->s_lock);
 				goto nack_acc;
+			}
 			/*
 			 * Update the next expected PSN.  We add 1 later
 			 * below, so only add the remainder here.
