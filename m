Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750929AbWC0W6k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbWC0W6k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Mar 2006 17:58:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbWC0W6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Mar 2006 17:58:40 -0500
Received: from sj-iport-5.cisco.com ([171.68.10.87]:40265 "EHLO
	sj-iport-5.cisco.com") by vger.kernel.org with ESMTP
	id S1750929AbWC0W6j (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Mar 2006 17:58:39 -0500
X-IronPort-AV: i="4.03,136,1141632000"; 
   d="scan'208"; a="264544999:sNHT30605564"
To: Sean Hefty <mshefty@ichips.intel.com>
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org
Subject: Re: [openib-general] InfiniBand 2.6.17 merge plans
X-Message-Flag: Warning: May contain useful information
References: <ada7j6f8xwi.fsf@cisco.com> <442848EF.4000407@ichips.intel.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 27 Mar 2006 14:58:36 -0800
In-Reply-To: <442848EF.4000407@ichips.intel.com> (Sean Hefty's message of "Mon, 27 Mar 2006 12:19:59 -0800")
Message-ID: <adar74n5wbn.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 27 Mar 2006 22:58:36.0882 (UTC) FILETIME=[FB208B20:01C651F1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

BTW, what do you think of changing rdma_wq to be a GPL export, to give
a hint that this is an internal symbol not really for general use?

In other words:

diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
index 6ebd1d1..cdf4888 100644
--- a/drivers/infiniband/core/addr.c
+++ b/drivers/infiniband/core/addr.c
@@ -56,7 +56,7 @@ static DEFINE_MUTEX(lock);
 static LIST_HEAD(req_list);
 static DECLARE_WORK(work, process_req, NULL);
 struct workqueue_struct *rdma_wq;
-EXPORT_SYMBOL(rdma_wq);
+EXPORT_SYMBOL_GPL(rdma_wq);
 
 static int copy_addr(struct rdma_dev_addr *dev_addr, struct net_device *dev,
 		     unsigned char *dst_dev_addr)
