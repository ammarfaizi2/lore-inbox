Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261827AbVDERni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbVDERni (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 13:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbVDERnh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 13:43:37 -0400
Received: from webmail.topspin.com ([12.162.17.3]:63199 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S261827AbVDERO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 13:14:27 -0400
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       mshefty@ichips.intel.com, halr@voltaire.com, openib-general@openib.org
Subject: Re: [-mm patch] drivers/infiniband/hw/mthca/mthca_main.c: remove an
 unused label
X-Message-Flag: Warning: May contain useful information
References: <20050405000524.592fc125.akpm@osdl.org>
	<20050405142449.GF6885@stusta.de>
From: Roland Dreier <roland@topspin.com>
Date: Tue, 05 Apr 2005 09:53:21 -0700
In-Reply-To: <20050405142449.GF6885@stusta.de> (Adrian Bunk's message of
 "Tue, 5 Apr 2005 16:24:49 +0200")
Message-ID: <52psx9cghq.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 05 Apr 2005 16:53:21.0759 (UTC) FILETIME=[F9A326F0:01C539FF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    >   CC      drivers/infiniband/hw/mthca/mthca_main.o
    > drivers/infiniband/hw/mthca/mthca_main.c: In function `mthca_init_icm':
    > drivers/infiniband/hw/mthca/mthca_main.c:479: warning: label 
    > `err_unmap_eqp' defined but not used

Thanks, good catch.  I screwed up the error path in that function a
little while merging patches.  Here's the correct fix.


Correct unwinding in error path of mthca_init_icm().

Signed-off-by: Roland Dreier <roland@topspin.com>

--- linux-2.6.12-rc2-mm1.orig/drivers/infiniband/hw/mthca/mthca_main.c	2005-04-05 09:49:02.944473724 -0700
+++ linux-2.6.12-rc2-mm1/drivers/infiniband/hw/mthca/mthca_main.c	2005-04-05 09:49:15.679708865 -0700
@@ -437,7 +437,7 @@
 	if (!mdev->qp_table.rdb_table) {
 		mthca_err(mdev, "Failed to map RDB context memory, aborting\n");
 		err = -ENOMEM;
-		goto err_unmap_rdb;
+		goto err_unmap_eqp;
 	}
 
        mdev->cq_table.table = mthca_alloc_icm_table(mdev, init_hca->cqc_base,
