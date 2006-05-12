Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932196AbWELXpM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932196AbWELXpM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 19:45:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932195AbWELXoo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 19:44:44 -0400
Received: from mx.pathscale.com ([64.160.42.68]:55721 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932208AbWELXod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 19:44:33 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 17 of 53] ipath - fail properly if GID missing
X-Mercurial-Node: c5f3731224bb1211ab13cbdff6f656e745cc71cc
Message-Id: <c5f3731224bb1211ab13.1147477382@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1147477365@eng-12.pathscale.com>
Date: Fri, 12 May 2006 16:43:02 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Return -EINVAL if we can't find a multicast GID.

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 176d1f0c26a3 -r c5f3731224bb drivers/infiniband/hw/ipath/ipath_verbs_mcast.c
--- a/drivers/infiniband/hw/ipath/ipath_verbs_mcast.c	Fri May 12 15:55:28 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_verbs_mcast.c	Fri May 12 15:55:28 2006 -0700
@@ -272,7 +272,7 @@ int ipath_multicast_detach(struct ib_qp 
 	while (1) {
 		if (n == NULL) {
 			spin_unlock_irqrestore(&mcast_lock, flags);
-			ret = 0;
+			ret = -EINVAL;
 			goto bail;
 		}
 
