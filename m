Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263022AbUKTFOQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263022AbUKTFOQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Nov 2004 00:14:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263043AbUKTCin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 21:38:43 -0500
Received: from baikonur.stro.at ([213.239.196.228]:64408 "EHLO
	baikonur.stro.at") by vger.kernel.org with ESMTP id S263022AbUKTC3e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 21:29:34 -0500
Subject: [patch 3/8]  kernel/sched.c: fix subtle TASK_RUNNING compare
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, janitor@sternwelten.at, domen@coderock.org
From: janitor@sternwelten.at
Date: Sat, 20 Nov 2004 03:29:33 +0100
Message-ID: <E1CVL0H-0000SH-EN@sputnik>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi.

This test was depending on TASK_RUNNING being defined as 0.

Signed-off-by: Domen Puncer <domen@coderock.org>

Signed-off-by: Maximilian Attems <janitor@sternwelten.at>
---

 linux-2.6.10-rc2-bk4-max/kernel/sched.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

diff -puN kernel/sched.c~fix-test-kernel_sched kernel/sched.c
--- linux-2.6.10-rc2-bk4/kernel/sched.c~fix-test-kernel_sched	2004-11-20 03:04:46.000000000 +0100
+++ linux-2.6.10-rc2-bk4-max/kernel/sched.c	2004-11-20 03:04:46.000000000 +0100
@@ -2576,7 +2576,8 @@ need_resched_nonpreemptible:
 	 * to picking the next task.
 	 */
 	switch_count = &prev->nivcsw;
-	if (prev->state && !(preempt_count() & PREEMPT_ACTIVE)) {
+	if (prev->state != TASK_RUNNING &&
+			!(preempt_count() & PREEMPT_ACTIVE)) {
 		switch_count = &prev->nvcsw;
 		if (unlikely((prev->state & TASK_INTERRUPTIBLE) &&
 				unlikely(signal_pending(prev))))
_
