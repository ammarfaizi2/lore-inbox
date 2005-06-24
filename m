Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263136AbVFXEW2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263136AbVFXEW2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Jun 2005 00:22:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263116AbVFXEMT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Jun 2005 00:12:19 -0400
Received: from webmail.topspin.com ([12.162.17.3]:33605 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S263100AbVFXEEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Jun 2005 00:04:25 -0400
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
Subject: [PATCH 11/14] IB/mthca: Fix memory leak on error path
In-Reply-To: <2005623214.fUJVvXKwjz2o8abB@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Thu, 23 Jun 2005 21:04:20 -0700
Message-Id: <2005623214.gjur4MFr788QnYf6@topspin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: akpm@osdl.org
Content-Transfer-Encoding: 7BIT
From: Roland Dreier <roland@topspin.com>
X-OriginalArrivalTime: 24 Jun 2005 04:04:21.0136 (UTC) FILETIME=[CCBAD100:01C57871]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Free page_list buffer on error path of mthca_reg_phys_mr().

Signed-off-by: Roland Dreier <roland@topspin.com>

---

 linux.git/drivers/infiniband/hw/mthca/mthca_provider.c |    1 +
 1 files changed, 1 insertion(+)



--- linux.git.orig/drivers/infiniband/hw/mthca/mthca_provider.c	2005-06-23 13:03:06.413728929 -0700
+++ linux.git/drivers/infiniband/hw/mthca/mthca_provider.c	2005-06-23 13:03:07.987388350 -0700
@@ -559,6 +559,7 @@ static struct ib_mr *mthca_reg_phys_mr(s
 				  convert_access(acc), mr);
 
 	if (err) {
+		kfree(page_list);
 		kfree(mr);
 		return ERR_PTR(err);
 	}

