Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751356AbWBPRnE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbWBPRnE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 12:43:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbWBPRnE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 12:43:04 -0500
Received: from gateway-1237.mvista.com ([63.81.120.158]:51960 "EHLO
	dhcp153.mvista.com") by vger.kernel.org with ESMTP id S1751356AbWBPRnC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 12:43:02 -0500
Date: Thu, 16 Feb 2006 09:42:54 -0800
Message-Id: <200602161742.k1GHgs2m029392@dhcp153.mvista.com>
From: Daniel Walker <dwalker@mvista.com>
To: mingo@elte.hu
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] FUTEX: one more return .
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-Off-By: Daniel Walker <dwalker@mvista.com>


Continue the theme of returns .

Index: linux-2.6.15/kernel/futex.c
===================================================================
--- linux-2.6.15.orig/kernel/futex.c
+++ linux-2.6.15/kernel/futex.c
@@ -973,8 +973,10 @@ void exit_robust_list(struct task_struct
 	 */
 	if (get_user(pending, &head->list_op_pending))
 		return;
-	if (pending)
-		handle_futex_death((void *)pending + futex_offset, curr);
+	if (pending) {
+		if (handle_futex_death((void *)pending + futex_offset, curr))
+			return;
+	}
 
 	while (entry != &head->list) {
 		/*
