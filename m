Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261818AbTCGWEm>; Fri, 7 Mar 2003 17:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261819AbTCGWEm>; Fri, 7 Mar 2003 17:04:42 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:44047
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S261818AbTCGWEl>; Fri, 7 Mar 2003 17:04:41 -0500
Subject: [patch] simple task_prio() fix
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com
Cc: Andrew Morton <akpm@digeo.com>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: 
Message-Id: <1047075285.12130.4.camel@phantasy.awol.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-3) 
Date: 07 Mar 2003 17:14:45 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus, while we are on the subject of the scheduler...

Trivial fix for task_prio() in the case MAX_RT_PRIO != MAX_USER_RT_PRIO
where all priorities are skewed by (MAX_RT_PRIO - MAX_USER_RT_PRIO). 
The fix makes sense, as the full priority range is unrelated to the
maximum user value.  Only the real maximum RT value matters.

The object code is the same for the 99% of the people who do not touch
the real-time priority defines.

Patch is against current BK - please, apply.

	Robert Love


 kernel/sched.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -urN linux-2.5.64-bk/kernel/sched.c linux/kernel/sched.c
--- linux-2.5.64-bk/kernel/sched.c	2003-03-07 17:01:34.727552472 -0500
+++ linux/kernel/sched.c	2003-03-07 17:07:56.244553072 -0500
@@ -1629,7 +1629,7 @@
  */
 int task_prio(task_t *p)
 {
-	return p->prio - MAX_USER_RT_PRIO;
+	return p->prio - MAX_RT_PRIO;
 }
 
 /**



