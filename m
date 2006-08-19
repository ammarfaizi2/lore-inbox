Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751456AbWHSP2E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751456AbWHSP2E (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Aug 2006 11:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751469AbWHSP2E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Aug 2006 11:28:04 -0400
Received: from filfla-vlan276.msk.corbina.net ([213.234.233.49]:33951 "EHLO
	screens.ru") by vger.kernel.org with ESMTP id S1751456AbWHSP2D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Aug 2006 11:28:03 -0400
Date: Sat, 19 Aug 2006 23:52:03 +0400
From: Oleg Nesterov <oleg@tv-sign.ru>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] reparent_to_init: use has_rt_policy()
Message-ID: <20060819195203.GA11034@oleg>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove open-coded has_rt_policy(), no changes in kernel/exit.o

Signed-off-by: Oleg Nesterov <oleg@tv-sign.ru>

--- 2.6.18-rc4/kernel/exit.c~5_r_t_i	2006-07-16 01:53:08.000000000 +0400
+++ 2.6.18-rc4/kernel/exit.c	2006-08-19 23:47:01.000000000 +0400
@@ -292,9 +292,7 @@ static void reparent_to_init(void)
 	/* Set the exit signal to SIGCHLD so we signal init on exit */
 	current->exit_signal = SIGCHLD;
 
-	if ((current->policy == SCHED_NORMAL ||
-			current->policy == SCHED_BATCH)
-				&& (task_nice(current) < 0))
+	if (!has_rt_policy(current) && (task_nice(current) < 0))
 		set_user_nice(current, 0);
 	/* cpus_allowed? */
 	/* rt_priority? */

