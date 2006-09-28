Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbWI1QEU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbWI1QEU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 12:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932509AbWI1QCe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 12:02:34 -0400
Received: from mx.pathscale.com ([64.160.42.68]:4790 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751927AbWI1QBY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 12:01:24 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 24 of 28] IB/mthca - Fix compiler warnings with gcc4 on
	possible unitialized variables
X-Mercurial-Node: 9fa624c592af68f7a851e5c1becd81218b0a2b91
Message-Id: <9fa624c592af68f7a851.1159459220@eng-12.pathscale.com>
In-Reply-To: <patchbomb.1159459196@eng-12.pathscale.com>
Date: Thu, 28 Sep 2006 09:00:20 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: rdreier@cisco.com
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It's possible (from the compiler perspective) that f0 is unitialized
in two functions (shows up with gcc4.0.2 on fc4, for example).  Initialize
to zero to fix warning.

Signed-off-by: Bryan O'Sullivan <bryan.osullivan@qlogic.com>

diff -r 6a9a67c2b35a -r 9fa624c592af drivers/infiniband/hw/mthca/mthca_qp.c
--- a/drivers/infiniband/hw/mthca/mthca_qp.c	Thu Sep 28 08:57:13 2006 -0700
+++ b/drivers/infiniband/hw/mthca/mthca_qp.c	Thu Sep 28 08:57:13 2006 -0700
@@ -1527,7 +1527,7 @@ int mthca_tavor_post_send(struct ib_qp *
 	int i;
 	int size;
 	int size0 = 0;
-	u32 f0;
+	u32 f0 = 0;
 	int ind;
 	u8 op0 = 0;
 
@@ -1870,7 +1870,7 @@ int mthca_arbel_post_send(struct ib_qp *
 	int i;
 	int size;
 	int size0 = 0;
-	u32 f0;
+	u32 f0 = 0;
 	int ind;
 	u8 op0 = 0;
 
