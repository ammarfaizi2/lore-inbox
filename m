Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262191AbVEETQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262191AbVEETQw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 15:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262188AbVEETQl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 15:16:41 -0400
Received: from c-24-22-18-178.hsd1.or.comcast.net ([24.22.18.178]:49041 "EHLO
	w-gerrit.beaverton.ibm.com") by vger.kernel.org with ESMTP
	id S262191AbVEES3R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 14:29:17 -0400
Message-Id: <20050505180932.333979000@us.ibm.com>
References: <20050505180731.010896000@us.ibm.com>
Date: Thu, 05 May 2005 11:07:43 -0700
To: linux-kernel@vger.kernel.org, ckrm-tech@lists.sourceforge.net
Subject: [patch 12/21] CKRM: Check to see if my guarantee is set to DONTCARE
From: gh@us.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--
Content-Disposition: inline; filename=07a-numtasks_config


Signed-Off-By: Chandra Seetharaman <sekharan@us.ibm.com>
Signed-Off-By: Vivek Kashyap <kashyapv@us.ibm.com>
Signed-Off-By: Gerrit Huizenga <gh@us.ibm.com>

recalc and propagate was not checking for class's my_guarantee and
my_limit againt DONT_CARE. This was leading to different wierd
problems. This patch fixes it.

 ckrm_numtasks.c |    9 ++++++---
 1 files changed, 6 insertions(+), 3 deletions(-)

Index: linux-2.6.12-rc3-ckrm5/kernel/ckrm/ckrm_numtasks.c
===================================================================
--- linux-2.6.12-rc3-ckrm5.orig/kernel/ckrm/ckrm_numtasks.c	2005-05-05 09:35:11.000000000 -0700
+++ linux-2.6.12-rc3-ckrm5/kernel/ckrm/ckrm_numtasks.c	2005-05-05 09:36:29.000000000 -0700
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

