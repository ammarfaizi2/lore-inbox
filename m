Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262523AbVBCUAi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262523AbVBCUAi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 15:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263336AbVBCUAg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 15:00:36 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:18825 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S263018AbVBCTs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 14:48:59 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH] InfiniBand: remove unbalance refcnt decrement
X-Message-Flag: Warning: May contain useful information
References: <52y8e65hhb.fsf@topspin.com>
From: Roland Dreier <roland@topspin.com>
Date: Thu, 03 Feb 2005 11:48:52 -0800
In-Reply-To: <52y8e65hhb.fsf@topspin.com> (Roland Dreier's message of "Wed,
 02 Feb 2005 21:40:16 -0800")
Message-ID: <526519ifvf.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 03 Feb 2005 19:48:52.0511 (UTC) FILETIME=[6341A2F0:01C50A29]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Michael S. Tsirkin <mst@mellanox.co.il>

Fix unbalanced QP reference count decrement (introduced with QP lock
optimization patch)

Signed-off-by: Michael S. Tsirkin <mst@mellanox.co.il>
Signed-off-by: Roland Dreier <roland@topspin.com>

--- linux-bk.orig/drivers/infiniband/hw/mthca/mthca_cq.c	2005-01-28 11:11:03.000000000 -0800
+++ linux-bk/drivers/infiniband/hw/mthca/mthca_cq.c	2005-02-03 11:47:39.300426349 -0800
@@ -422,8 +422,6 @@
 				*freed = 0;
 			}
 			spin_unlock(&(*cur_qp)->lock);
-			if (atomic_dec_and_test(&(*cur_qp)->refcount))
-				wake_up(&(*cur_qp)->wait);
 		}
 
 		spin_lock(&dev->qp_table.lock);
