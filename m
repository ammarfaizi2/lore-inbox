Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262243AbVFWHxf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262243AbVFWHxf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 03:53:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262336AbVFWHxP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 03:53:15 -0400
Received: from [24.22.56.4] ([24.22.56.4]:10726 "EHLO
	w-gerrit.beaverton.ibm.com") by vger.kernel.org with ESMTP
	id S262249AbVFWGSk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 02:18:40 -0400
Message-Id: <20050623061756.914124000@w-gerrit.beaverton.ibm.com>
References: <20050623061552.833852000@w-gerrit.beaverton.ibm.com>
Date: Wed, 22 Jun 2005 23:16:06 -0700
From: Gerrit Huizenga <gh@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: ckrm-tech@lists.sourceforge.net, Chandra Seetharaman <sekharan@us.ibm.com>,
       Gerrit Huizenga <gh@us.ibm.com>
Subject: [patch 14/38] CKRM e18: undo removal of check in numtasks_put_ref_local
Content-Disposition: inline; filename=07c2-numtasks-undo-delete
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
Signed-Off-By: Gerrit Huizenga <gh@us.ibm.com>

Removed without realizing it. Putting it back.

 ckrm_numtasks.c |    3 +++
 1 files changed, 3 insertions(+)

Index: linux-2.6.12-ckrm1/kernel/ckrm/ckrm_numtasks.c
===================================================================
--- linux-2.6.12-ckrm1.orig/kernel/ckrm/ckrm_numtasks.c	2005-06-20 13:08:40.000000000 -0700
+++ linux-2.6.12-ckrm1/kernel/ckrm/ckrm_numtasks.c	2005-06-20 13:08:41.000000000 -0700
@@ -165,6 +165,9 @@ static void numtasks_put_ref_local(struc
 	res = ckrm_get_res_class(core, resid, struct ckrm_numtasks);
 	if (res == NULL)
 		return;
+
+	if (atomic_read(&res->cnt_cur_alloc) == 0)
+		return;
 	atomic_dec(&res->cnt_cur_alloc);
 	if (atomic_read(&res->cnt_borrowed) > 0) {
 		atomic_dec(&res->cnt_borrowed);

--
