Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264479AbUDZKsh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264479AbUDZKsh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 06:48:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264307AbUDZK3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 06:29:39 -0400
Received: from ns.suse.de ([195.135.220.2]:56277 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264479AbUDZK2v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 06:28:51 -0400
Subject: [PATCH 3/11] rpcsvc-pages
From: Andreas Gruenbacher <agruen@suse.de>
To: Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: SUSE Labs, SUSE LINUX AG
Message-Id: <1082975179.3295.73.camel@winden.suse.de>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Mon, 26 Apr 2004 12:28:47 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a page to an rpc reply from the allocated pool

  Andreas Gruenbacher <agruen@suse.de>, SUSE Labs

Index: linux-2.6.6-rc2/include/linux/sunrpc/svc.h
===================================================================
--- linux-2.6.6-rc2.orig/include/linux/sunrpc/svc.h
+++ linux-2.6.6-rc2/include/linux/sunrpc/svc.h
@@ -177,6 +177,17 @@ xdr_ressize_check(struct svc_rqst *rqstp
 	return vec->iov_len <= PAGE_SIZE;
 }
 
+static inline struct page *
+svc_take_res_page(struct svc_rqst *rqstp)
+{
+	if (rqstp->rq_arghi <= rqstp->rq_argused)
+		return NULL;
+	rqstp->rq_arghi--;
+	rqstp->rq_respages[rqstp->rq_resused] =
+		rqstp->rq_argpages[rqstp->rq_arghi];
+	return rqstp->rq_respages[rqstp->rq_resused++];
+}
+
 static inline int svc_take_page(struct svc_rqst *rqstp)
 {
 	if (rqstp->rq_arghi <= rqstp->rq_argused)


