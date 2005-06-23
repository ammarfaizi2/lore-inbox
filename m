Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262313AbVFWGmW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262313AbVFWGmW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 02:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262525AbVFWGi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 02:38:27 -0400
Received: from [24.22.56.4] ([24.22.56.4]:16358 "EHLO
	w-gerrit.beaverton.ibm.com") by vger.kernel.org with ESMTP
	id S262300AbVFWGSp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 02:18:45 -0400
Message-Id: <20050623061758.685906000@w-gerrit.beaverton.ibm.com>
References: <20050623061552.833852000@w-gerrit.beaverton.ibm.com>
Date: Wed, 22 Jun 2005 23:16:14 -0700
From: Gerrit Huizenga <gh@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: ckrm-tech@lists.sourceforge.net, Matt Helsley <matthltc@us.ibm.com>,
       Gerrit Huizenga <gh@us.ibm.com>
Subject: [patch 22/38] CKRM e18: Fix share calculation
Content-Disposition: inline; filename=ckrm-utils
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Increase the share by the new value if previous value was don't care or 
unchanged. Otherwise use the difference in values as the increase in share.

Signed-Off-By: Matt Helsley <matthltc@us.ibm.com>
Signed-Off-By: Gerrit Huizenga <gh@us.ibm.com>

Index: linux-2.6.12-ckrm1/kernel/ckrm/ckrmutils.c
===================================================================
--- linux-2.6.12-ckrm1.orig/kernel/ckrm/ckrmutils.c	2005-06-20 15:04:30.000000000 -0700
+++ linux-2.6.12-ckrm1/kernel/ckrm/ckrmutils.c	2005-06-20 15:04:46.000000000 -0700
@@ -100,7 +100,12 @@ set_shares(struct ckrm_shares *new, stru
 {
 	int rc = -EINVAL;
 	int cur_usage_guar = cur->total_guarantee - cur->unused_guarantee;
-	int increase_by = new->my_guarantee - cur->my_guarantee;
+	int increase_by;
+
+	if (cur->my_guarantee < 0) /* DONTCARE or UNCHANGED */
+		increase_by = new->my_guarantee;
+	else
+		increase_by = new->my_guarantee - cur->my_guarantee;
 
 	/* Check total_guarantee for correctness */
 	if (new->total_guarantee <= CKRM_SHARE_DONTCARE) {

--
