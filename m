Return-Path: <linux-kernel-owner+w=401wt.eu-S932833AbWLNPy7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932833AbWLNPy7 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 10:54:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932835AbWLNPy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 10:54:59 -0500
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:60713 "EHLO
	ecfrec.frec.bull.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932833AbWLNPy6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 10:54:58 -0500
Message-ID: <458173D5.5050008@bull.net>
Date: Thu, 14 Dec 2006 16:55:01 +0100
From: Pierre Peiffer <pierre.peiffer@bull.net>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, suresh.b.siddha@intel.com
Subject: [PATCH 2.6.19-rt14][BUG] kernel/sched.c:4135: error: 'notick' undeclared
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 14/12/2006 17:02:31,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 14/12/2006 17:02:31,
	Serialize complete at 14/12/2006 17:02:31
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The kernel (sched.c) does not compile if CONFIG_HZ and CONFIG_SMP are set, and 
CONFIG_NO_HZ isn't.

Is this patch correct ?

---

Index: linux-2.6.19-rt14-test/kernel/sched.c
===================================================================
--- linux-2.6.19-rt14-test.orig/kernel/sched.c  2006-12-14 16:27:37.000000000 +0100
+++ linux-2.6.19-rt14-test/kernel/sched.c       2006-12-14 16:42:38.000000000 +0100
@@ -4131,7 +4131,7 @@ switch_tasks:
                 ++*switch_count;

                 prepare_task_switch(rq, next);
-#if defined(CONFIG_HZ) && defined(CONFIG_SMP)
+#if defined(CONFIG_NO_HZ) && defined(CONFIG_SMP)
                 if (prev == rq->idle && notick.load_balancer == -1) {
                         /*
                          * simple selection for now: Nominate the first cpu in


Thanks,

-- 
Pierre Peiffer
