Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262597AbVFWH6d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262597AbVFWH6d (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 03:58:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262280AbVFWHpu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 03:45:50 -0400
Received: from [24.22.56.4] ([24.22.56.4]:29414 "EHLO
	w-gerrit.beaverton.ibm.com") by vger.kernel.org with ESMTP
	id S262312AbVFWGTD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 02:19:03 -0400
Message-Id: <20050623061756.511988000@w-gerrit.beaverton.ibm.com>
References: <20050623061552.833852000@w-gerrit.beaverton.ibm.com>
Date: Wed, 22 Jun 2005 23:16:04 -0700
From: Gerrit Huizenga <gh@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Cc: ckrm-tech@lists.sourceforge.net, Chandra Seetharaman <sekharan@us.ibm.com>,
       Vivek Kashyap <kashyapv@us.ibm.com>, Gerrit Huizenga <gh@us.ibm.com>
Subject: [patch 12/38] CKRM e18: Check to see if my guarantee is set to DONTCARE
Content-Disposition: inline; filename=07a-numtasks_config
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
Signed-Off-By: Vivek Kashyap <kashyapv@us.ibm.com>
Signed-Off-By: Gerrit Huizenga <gh@us.ibm.com>

recalc and propagate was not checking for class's my_guarantee and
my_limit againt DONT_CARE. This was leading to different wierd
problems. This patch fixes it.

 ckrm_numtasks.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

Index: linux-2.6.12-ckrm1/kernel/ckrm/ckrm_numtasks.c
===================================================================
--- linux-2.6.12-ckrm1.orig/kernel/ckrm/ckrm_numtasks.c	2005-06-20 13:08:34.000000000 -0700
+++ linux-2.6.12-ckrm1/kernel/ckrm/ckrm_numtasks.c	2005-06-20 13:08:39.000000000 -0700
@@ -296,7 +296,8 @@ recalc_and_propagate(struct ckrm_numtask
 		struct ckrm_shares *self = &res->shares;
 
 		/* calculate cnt_guarantee and cnt_limit */
-		if (parres->cnt_guarantee == CKRM_SHARE_DONTCARE) {
+		if ((parres->cnt_guarantee == CKRM_SHARE_DONTCARE) ||
+				(self->my_guarantee == CKRM_SHARE_DONTCARE)) {
 			res->cnt_guarantee = CKRM_SHARE_DONTCARE;
 		} else if (par->total_guarantee) {
 			u64 temp = (u64) self->my_guarantee * parres->cnt_guarantee;
@@ -306,7 +307,8 @@ recalc_and_propagate(struct ckrm_numtask
 			res->cnt_guarantee = 0;
 		}
 
-		if (parres->cnt_limit == CKRM_SHARE_DONTCARE) {
+		if ((parres->cnt_limit == CKRM_SHARE_DONTCARE) ||
+				(self->my_limit == CKRM_SHARE_DONTCARE)) {
 			res->cnt_limit = CKRM_SHARE_DONTCARE;
 		} else if (par->max_limit) {
 			u64 temp = (u64) self->my_limit * parres->cnt_limit;
@@ -317,7 +319,8 @@ recalc_and_propagate(struct ckrm_numtask
 		}
 
 		/* Calculate unused units */
-		if (res->cnt_guarantee == CKRM_SHARE_DONTCARE) {
+		if ((res->cnt_guarantee == CKRM_SHARE_DONTCARE) ||
+				(self->my_guarantee == CKRM_SHARE_DONTCARE)) {
 			res->cnt_unused = CKRM_SHARE_DONTCARE;
 		} else if (self->total_guarantee) {
 			u64 temp = (u64) self->unused_guarantee * res->cnt_guarantee;

--
