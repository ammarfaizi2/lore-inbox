Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261554AbVCFXtc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261554AbVCFXtc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 18:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261598AbVCFXsl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 18:48:41 -0500
Received: from coderock.org ([193.77.147.115]:176 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261574AbVCFWhL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 17:37:11 -0500
Subject: [patch 11/14] message/mptbase: replace schedule_timeout() with ssleep()
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, nacc@us.ibm.com
From: domen@coderock.org
Date: Sun, 06 Mar 2005 23:36:50 +0100
Message-Id: <20050306223650.7D5C01F1F0@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Use ssleep() instead of schedule_timeout() to guarantee
the task delays as expected. The original code does use TASK_INTERRUPTIBLE, but
does not check for signals or early return from schedule_timeout() so ssleep()
seems more appropriate.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/drivers/message/fusion/mptbase.c |    3 +--
 1 files changed, 1 insertion(+), 2 deletions(-)

diff -puN drivers/message/fusion/mptbase.c~ssleep-drivers_message_fusion_mptbase drivers/message/fusion/mptbase.c
--- kj/drivers/message/fusion/mptbase.c~ssleep-drivers_message_fusion_mptbase	2005-03-05 16:11:15.000000000 +0100
+++ kj-domen/drivers/message/fusion/mptbase.c	2005-03-05 16:11:15.000000000 +0100
@@ -3137,8 +3137,7 @@ mpt_diag_reset(MPT_ADAPTER *ioc, int ign
 
 				/* wait 1 sec */
 				if (sleepFlag == CAN_SLEEP) {
-					set_current_state(TASK_INTERRUPTIBLE);
-					schedule_timeout(1000 * HZ / 1000);
+					ssleep(1);
 				} else {
 					mdelay (1000);
 				}
_
