Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261359AbTCYCDX>; Mon, 24 Mar 2003 21:03:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261358AbTCYCDT>; Mon, 24 Mar 2003 21:03:19 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:22545
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S261357AbTCYCDQ>; Mon, 24 Mar 2003 21:03:16 -0500
Subject: [patch] trivial task_prio() fix
From: Robert Love <rml@tech9.net>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@elte.hu>
Content-Type: text/plain
Organization: 
Message-Id: <1048558471.1486.171.camel@phantasy.awol.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 24 Mar 2003 21:14:31 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trivial fix for task_prio() in the case MAX_RT_PRIO !=
MAX_USER_RT_PRIO.  In this case, all priorities are skewed by
(MAX_RT_PRIO - MAX_USER_RT_PRIO).

The fix is to subtract the full MAX_RT_PRIO from p->prio, not just
MAX_USER_RT_PRIO.  This makes sense, as the full priority range is
unrelated to the maximum user value.  Only the real maximum RT value
matters.

The object code is the same for the 99% of the people who do not touch
the real-time priority defines.

This has been in Andrew's tree for awhile, with no issue.  I have also
posted here to no complaint.  Patch is against 2.5.66, please apply.

	Robert Love


 kernel/sched.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -urN linux-2.5.66/kernel/sched.c linux/kernel/sched.c
--- linux-2.5.66/kernel/sched.c	2003-03-24 17:01:16.000000000 -0500
+++ linux/kernel/sched.c	2003-03-24 21:09:55.196360600 -0500
@@ -1680,7 +1680,7 @@
  */
 int task_prio(task_t *p)
 {
-	return p->prio - MAX_USER_RT_PRIO;
+	return p->prio - MAX_RT_PRIO;
 }
 
 /**



