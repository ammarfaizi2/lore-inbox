Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267928AbUIHQCj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267928AbUIHQCj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 12:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268655AbUIHQCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 12:02:39 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:11446 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S267928AbUIHQAb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 12:00:31 -0400
Subject: [PATCH] fix schedstats null deref in sched_exec
From: Nathan Lynch <nathanl@austin.ibm.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
In-Reply-To: <413F01C7.3060008@yahoo.com.au>
References: <413EFFFB.5050902@yahoo.com.au> <413F0070.2020104@yahoo.com.au>
	 <413F01C7.3060008@yahoo.com.au>
Content-Type: text/plain
Message-Id: <1094658900.14438.6.camel@booger>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 08 Sep 2004 10:55:00 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oops, I meant to send this one with my original patchset.

In sched_exec, schedstat_inc will dereference a null pointer if no
domain is found with the SD_BALANCE_EXEC flag set.  This was exposed
during testing of the previous patches where cpus are temporarily
attached to a dummy domain without SD_BALANCE_EXEC set.

Signed-off-by: Nathan Lynch <nathanl@austin.ibm.com>


---


diff -puN kernel/sched.c~sched_exec-schedstats-fix kernel/sched.c
--- 2.6.9-rc1-bk12/kernel/sched.c~sched_exec-schedstats-fix	2004-09-06 02:14:05.000000000 -0500
+++ 2.6.9-rc1-bk12-nathanl/kernel/sched.c	2004-09-06 19:00:12.000000000 -0500
@@ -1727,8 +1727,8 @@ void sched_exec(void)
 		if (tmp->flags & SD_BALANCE_EXEC)
 			sd = tmp;
 
-	schedstat_inc(sd, sbe_attempts);
 	if (sd) {
+		schedstat_inc(sd, sbe_attempts);
 		new_cpu = find_idlest_cpu(current, this_cpu, sd);
 		if (new_cpu != this_cpu) {
 			schedstat_inc(sd, sbe_pushed);

_


