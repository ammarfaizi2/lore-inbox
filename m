Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317613AbSFIOWQ>; Sun, 9 Jun 2002 10:22:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317614AbSFIOWP>; Sun, 9 Jun 2002 10:22:15 -0400
Received: from p50887457.dip.t-dialin.net ([80.136.116.87]:4305 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317613AbSFIOWP>; Sun, 9 Jun 2002 10:22:15 -0400
Date: Sun, 9 Jun 2002 08:22:06 -0600 (MDT)
From: Lightweight patch manager <patch@luckynet.dynu.com>
X-X-Sender: patch@hawkeye.luckynet.adm
To: Robert Love <rml@tech9.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@elte.hu>
Subject: [PATCH][2.5] make kernel scheduler use list_move_tail (1 occ)
Message-ID: <Pine.LNX.4.44.0206090820100.25737-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This makes the kernel scheduler use list_move_tail instead of more code

--- linus-2.5/kernel/sched.c	Sun Jun  9 04:17:27 2002
+++ thunder-2.5/kernel/sched.c	Sun Jun  9 06:58:51 2002
@@ -1360,8 +1360,7 @@
 	 * then just requeue the task to the end of the runqueue:
 	 */
 	if (likely(current->prio == MAX_PRIO-1 || rt_task(current))) {
-		list_del(&current->run_list);
-		list_add_tail(&current->run_list, array->queue + current->prio);
+		list_move_tail(&current->run_list, array->queue + current->prio);
 	} else {
 		list_del(&current->run_list);
 		if (list_empty(array->queue + current->prio))

-- 
Lightweight patch manager using pine. If you have any objections, tell me.

