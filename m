Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262175AbVEES3W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbVEES3W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 14:29:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262193AbVEES3W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 14:29:22 -0400
Received: from c-24-22-18-178.hsd1.or.comcast.net ([24.22.18.178]:41617 "EHLO
	w-gerrit.beaverton.ibm.com") by vger.kernel.org with ESMTP
	id S262175AbVEES3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 14:29:09 -0400
Message-Id: <20050505180933.111111000@us.ibm.com>
References: <20050505180731.010896000@us.ibm.com>
Date: Thu, 05 May 2005 11:07:45 -0700
To: linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Subject: [patch 14/21] CKRM: undo removal of check in numtasks_put_ref_local
From: gh@us.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--
Content-Disposition: inline; filename=07c2-numtasks-undo-delete


Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
Signed-Off-By: Gerrit Huizenga <gh@us.ibm.com>

Removed without realizing it. Putting it back.

 ckrm_numtasks.c |    3 +++
 1 files changed, 3 insertions(+)

Index: linux-2.6.12-rc3-ckrm5/kernel/ckrm/ckrm_numtasks.c
===================================================================
--- linux-2.6.12-rc3-ckrm5.orig/kernel/ckrm/ckrm_numtasks.c	2005-05-05 09:37:41.000000000 -0700
+++ linux-2.6.12-rc3-ckrm5/kernel/ckrm/ckrm_numtasks.c	2005-05-05 09:37:55.000000000 -0700
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

