Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267548AbUIXDnm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267548AbUIXDnm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 23:43:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266880AbUIXDls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 23:41:48 -0400
Received: from baikonur.stro.at ([213.239.196.228]:59343 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S266878AbUIWUdZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 16:33:25 -0400
Subject: [patch 1/3]  message/mptbase: replace 	schedule_timeout() with msleep_interruptible()
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, nacc@us.ibm.com
From: janitor@sternwelten.at
Date: Thu, 23 Sep 2004 22:33:21 +0200
Message-ID: <E1CAaHK-0001n2-2Q@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




Any comments would be appreciated. I was recently informed that
i2o_core.c was removed from the kernel, so one of my patches was
obsoleted. Hence, the total number has dropped to 3.

Description: Use msleep_interruptible() instead of schedule_timeout()
to guarantee the task delays as expected.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.9-rc2-bk7-max/drivers/message/fusion/mptbase.c |   42 +++++----------
 1 files changed, 14 insertions(+), 28 deletions(-)

diff -puN drivers/message/fusion/mptbase.c~msleep_interruptible-drivers_message_fusion_mptbase drivers/message/fusion/mptbase.c
--- linux-2.6.9-rc2-bk7/drivers/message/fusion/mptbase.c~msleep_interruptible-drivers_message_fusion_mptbase	2004-09-21 21:17:12.000000000 +0200
+++ linux-2.6.9-rc2-bk7-max/drivers/message/fusion/mptbase.c	2004-09-21 21:17:12.000000000 +0200
@@ -2229,8 +2229,7 @@ MakeIocReady(MPT_ADAPTER *ioc, int force
 		}
 
 		if (sleepFlag == CAN_SLEEP) {
-			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(1 * HZ / 1000);
+			msleep_interruptible(1);
 		} else {
 			mdelay (1);	/* 1 msec delay */
 		}
@@ -2599,8 +2598,7 @@ SendIocInit(MPT_ADAPTER *ioc, int sleepF
 	state = mpt_GetIocState(ioc, 1);
 	while (state != MPI_IOC_STATE_OPERATIONAL && --cntdn) {
 		if (sleepFlag == CAN_SLEEP) {
-			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(1 * HZ / 1000);
+			msleep_interruptible(1);
 		} else {
 			mdelay(1);
 		}
@@ -2867,8 +2865,7 @@ mpt_downloadboot(MPT_ADAPTER *ioc, int s
 
 	/* wait 1 msec */
 	if (sleepFlag == CAN_SLEEP) {
-		set_current_state(TASK_INTERRUPTIBLE);
-		schedule_timeout(1 * HZ / 1000);
+		msleep_interruptible(1);
 	} else {
 		mdelay (1);
 	}
@@ -2885,8 +2882,7 @@ mpt_downloadboot(MPT_ADAPTER *ioc, int s
 		}
 		/* wait 1 sec */
 		if (sleepFlag == CAN_SLEEP) {
-			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(1000 * HZ / 1000);
+			msleep_interruptible (1000);
 		} else {
 			mdelay (1000);
 		}
@@ -2986,8 +2982,7 @@ mpt_downloadboot(MPT_ADAPTER *ioc, int s
 			return 0;
 		}
 		if (sleepFlag == CAN_SLEEP) {
-			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(10 * HZ / 1000);
+			msleep_interruptible (10);
 		} else {
 			mdelay (10);
 		}
@@ -3038,8 +3033,7 @@ KickStart(MPT_ADAPTER *ioc, int force, i
 		SendIocReset(ioc, MPI_FUNCTION_IOC_MESSAGE_UNIT_RESET, sleepFlag);
 
 		if (sleepFlag == CAN_SLEEP) {
-			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(1000 * HZ / 1000);
+			msleep_interruptible (1000);
 		} else {
 			mdelay (1000);
 		}
@@ -3061,8 +3055,7 @@ KickStart(MPT_ADAPTER *ioc, int force, i
 			return hard_reset_done;
 		}
 		if (sleepFlag == CAN_SLEEP) {
-			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(10 * HZ / 1000);
+			msleep_interruptible (10);
 		} else {
 			mdelay (10);
 		}
@@ -3133,8 +3126,7 @@ mpt_diag_reset(MPT_ADAPTER *ioc, int ign
 
 			/* wait 100 msec */
 			if (sleepFlag == CAN_SLEEP) {
-				set_current_state(TASK_INTERRUPTIBLE);
-				schedule_timeout(100 * HZ / 1000);
+				msleep_interruptible (100);
 			} else {
 				mdelay (100);
 			}
@@ -3213,8 +3205,7 @@ mpt_diag_reset(MPT_ADAPTER *ioc, int ign
 
 				/* wait 1 sec */
 				if (sleepFlag == CAN_SLEEP) {
-					set_current_state(TASK_INTERRUPTIBLE);
-					schedule_timeout(1000 * HZ / 1000);
+					msleep_interruptible (1000);
 				} else {
 					mdelay (1000);
 				}
@@ -3241,8 +3232,7 @@ mpt_diag_reset(MPT_ADAPTER *ioc, int ign
 
 				/* wait 1 sec */
 				if (sleepFlag == CAN_SLEEP) {
-					set_current_state(TASK_INTERRUPTIBLE);
-					schedule_timeout(1000 * HZ / 1000);
+					msleep_interruptible(1000);
 				} else {
 					mdelay (1000);
 				}
@@ -3276,8 +3266,7 @@ mpt_diag_reset(MPT_ADAPTER *ioc, int ign
 
 		/* wait 100 msec */
 		if (sleepFlag == CAN_SLEEP) {
-			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(100 * HZ / 1000);
+			msleep_interruptible (100);
 		} else {
 			mdelay (100);
 		}
@@ -3371,8 +3360,7 @@ SendIocReset(MPT_ADAPTER *ioc, u8 reset_
 		}
 
 		if (sleepFlag == CAN_SLEEP) {
-			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(1 * HZ / 1000);
+			msleep_interruptible(1);
 		} else {
 			mdelay (1);	/* 1 msec delay */
 		}
@@ -3808,8 +3796,7 @@ WaitForDoorbellAck(MPT_ADAPTER *ioc, int
 			intstat = CHIPREG_READ32(&ioc->chip->IntStatus);
 			if (! (intstat & MPI_HIS_IOP_DOORBELL_STATUS))
 				break;
-			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(1 * HZ / 1000);
+			msleep_interruptible (1);
 			count++;
 		}
 	} else {
@@ -3858,8 +3845,7 @@ WaitForDoorbellInt(MPT_ADAPTER *ioc, int
 			intstat = CHIPREG_READ32(&ioc->chip->IntStatus);
 			if (intstat & MPI_HIS_DOORBELL_INTERRUPT)
 				break;
-			set_current_state(TASK_INTERRUPTIBLE);
-			schedule_timeout(1 * HZ / 1000);
+			msleep_interruptible(1);
 			count++;
 		}
 	} else {
_
