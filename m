Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267030AbTBTXcX>; Thu, 20 Feb 2003 18:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267035AbTBTXcX>; Thu, 20 Feb 2003 18:32:23 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:28429
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S267030AbTBTXcV>; Thu, 20 Feb 2003 18:32:21 -0500
Subject: [patch] task_prio() fix
From: Robert Love <rml@tech9.net>
To: mingo@elte.hu
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com
Content-Type: text/plain
Organization: 
Message-Id: <1045784559.781.26.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-1) 
Date: 20 Feb 2003 18:42:40 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like task_prio() should do:

        int task_prio(task_t *p)
        {
        	return p->prio - MAX_RT_PRIO;
        }

Instead of subtracting MAX_USER_RT_PRIO, since the maximum _user_ value
has nothing to do with the maximum that may be stored.  The effect is if
MAX_RT_PRIO != MAX_USER_RT_PRIO, then all priorities are skewed by
(MAX_RT_PRIO - MAX_USER_RT_PRIO).

Ingo, this looks trivial to me... but I swear it _used_ to work and this
function has always been like this.  Comments?

Patch is against 2.5.62.

	Robert Love


 kernel/sched.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)


diff -urN linux-2.5.62/kernel/sched.c linux/kernel/sched.c
--- linux-2.5.62/kernel/sched.c	2003-02-20 18:30:08.232619488 -0500
+++ linux/kernel/sched.c	2003-02-20 18:30:15.585501680 -0500
@@ -1552,7 +1552,7 @@
  */
 int task_prio(task_t *p)
 {
-	return p->prio - MAX_USER_RT_PRIO;
+	return p->prio - MAX_RT_PRIO;
 }
 
 /**



