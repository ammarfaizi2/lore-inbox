Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751117AbWIZKkd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751117AbWIZKkd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 06:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751116AbWIZKkc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 06:40:32 -0400
Received: from mail.gmx.net ([213.165.64.20]:52357 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751114AbWIZKkc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 06:40:32 -0400
X-Authenticated: #704063
Subject: [Patch] Possible dereference in
	drivers/infiniband/hw/amso1100/c2_cm.c
From: Eric Sesterhenn <snakebyte@gmx.de>
To: linux-kernel@vger.kernel.org
Cc: tom@opengridcomputing.com
Content-Type: text/plain
Date: Tue, 26 Sep 2006 12:40:28 +0200
Message-Id: <1159267228.5491.2.camel@alice>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,

another dereference spotted by the coverity checker (cid #1395)
In case we cant alloc the vq_req, we goto bail1, where we
call vq_req_free(c2dev, vq_req); which then dereferences vq_req().

Signed-off-by: Eric Sesterhenn <snakebyte@gmx.de>

--- linux-2.6.18-git5/drivers/infiniband/hw/amso1100/c2_cm.c.orig	2006-09-26 12:36:56.000000000 +0200
+++ linux-2.6.18-git5/drivers/infiniband/hw/amso1100/c2_cm.c	2006-09-26 12:37:19.000000000 +0200
@@ -302,7 +302,7 @@ int c2_llp_accept(struct iw_cm_id *cm_id
 	vq_req = vq_req_alloc(c2dev);
 	if (!vq_req) {
 		err = -ENOMEM;
-		goto bail1;
+		goto bail0;
 	}
 	vq_req->qp = qp;
 	vq_req->cm_id = cm_id;


