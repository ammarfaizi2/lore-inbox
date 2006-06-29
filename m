Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932975AbWF2WDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932975AbWF2WDP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 18:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932989AbWF2WCw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 18:02:52 -0400
Received: from mx.pathscale.com ([64.160.42.68]:33679 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932812AbWF2VoJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:44:09 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 11 of 39] IB/ipath - return an error for unknown multicast GID
X-Mercurial-Node: 1e1f3da0e78d32f2a733b0f36a83fb7772b852df
Message-Id: <1e1f3da0e78d32f2a733.1151617262@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1151617251@eng-12.pathscale.com>
Date: Thu, 29 Jun 2006 14:41:02 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: akpm@osdl.org, rdreier@cisco.com, mst@mellanox.co.il
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Robert Walsh <robert.walsh@qlogic.com>
Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r 160e5cf91761 -r 1e1f3da0e78d drivers/infiniband/hw/ipath/ipath_verbs_mcast.c
--- a/drivers/infiniband/hw/ipath/ipath_verbs_mcast.c	Thu Jun 29 14:33:25 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs_mcast.c	Thu Jun 29 14:33:25 2006 -0700
@@ -273,7 +273,7 @@ int ipath_multicast_detach(struct ib_qp 
 	while (1) {
 		if (n == NULL) {
 			spin_unlock_irqrestore(&mcast_lock, flags);
-			ret = 0;
+			ret = -EINVAL;
 			goto bail;
 		}
 
