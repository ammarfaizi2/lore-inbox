Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932275AbWELXpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932275AbWELXpH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 May 2006 19:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932282AbWELXou
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 May 2006 19:44:50 -0400
Received: from mx.pathscale.com ([64.160.42.68]:63657 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932290AbWELXoe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 May 2006 19:44:34 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 45 of 53] ipath - fix memory leak when create of QP fails
X-Mercurial-Node: b41e576e5202131efbdcd4402eff38cc0c8f67e8
Message-Id: <b41e576e5202131efbdc.1147477410@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1147477365@eng-12.pathscale.com>
Date: Fri, 12 May 2006 16:43:30 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>

diff -r 28d938eb0463 -r b41e576e5202 drivers/infiniband/hw/ipath/ipath_init_chip.c
--- a/drivers/infiniband/hw/ipath/ipath_init_chip.c	Fri May 12 15:55:29 2006 -0700
+++ b/drivers/infiniband/hw/ipath/ipath_init_chip.c	Fri May 12 15:55:29 2006 -0700
@@ -114,6 +114,7 @@ static int create_port0_egr(struct ipath
 				      "eager TID %u\n", e);
 			while (e != 0)
 				dev_kfree_skb(skbs[--e]);
+			vfree(skbs);
 			ret = -ENOMEM;
 			goto bail;
 		}
