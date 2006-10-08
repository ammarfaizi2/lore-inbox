Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932104AbWJHXQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbWJHXQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 19:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932112AbWJHXQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 19:16:51 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:56849 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932108AbWJHXQk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 19:16:40 -0400
Date: Mon, 9 Oct 2006 01:16:35 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Tom Tucker <tom@opengridcomputing.com>
Cc: Steve Wise <swise@opengridcomputing.com>,
       Roland Dreier <rolandd@cisco.com>, openib-general@openib.org,
       linux-kernel@vger.kernel.org
Subject: [2.6 patch] drivers/infiniband/hw/amso1100/c2_rnic.c: fix a NULL dereference
Message-ID: <20061008231635.GR6755@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a NULL dereference spotted by the Coverity checker.

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6/drivers/infiniband/hw/amso1100/c2_rnic.c.old	2006-10-09 00:39:32.000000000 +0200
+++ linux-2.6/drivers/infiniband/hw/amso1100/c2_rnic.c	2006-10-09 00:40:30.000000000 +0200
@@ -150,8 +150,8 @@
 	    (struct c2wr_rnic_query_rep *) (unsigned long) (vq_req->reply_msg);
 	if (!reply)
 		err = -ENOMEM;
-
-	err = c2_errno(reply);
+	else
+		err = c2_errno(reply);
 	if (err)
 		goto bail2;
 

