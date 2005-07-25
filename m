Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261524AbVGYUkO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261524AbVGYUkO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 16:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261560AbVGYUkO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 16:40:14 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:2176 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S261524AbVGYUkL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 16:40:11 -0400
Subject: Re: [PATCH] fix (again) MAX_USER_RT_PRIO and MAX_RT_PRIO (was:
	MAX_USER_RT_PRIO and MAX_RT_PRIO are wrong!)
From: Lee Revell <rlrevell@joe-job.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Dean Nelson <dcn@SGI.com>
In-Reply-To: <1122323319.4895.3.camel@localhost.localdomain>
References: <1122323319.4895.3.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 25 Jul 2005 16:40:09 -0400
Message-Id: <1122324010.1472.44.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-07-25 at 16:28 -0400, Steven Rostedt wrote:
> Ingo,
> 
> I've CC you just because you are the schedule maintainer.  You already
> accepted this patch into your RT tree.
> 

Please make sure to pick up this patch from Andreas Steinmetz too,
otherwise the rlimits are broken:

--- linux.orig/kernel/sched.c   2005-07-22 19:45:05.000000000 +0200
+++ linux/kernel/sched.c        2005-07-22 19:45:42.000000000 +0200
@@ -3528,7 +3528,8 @@
         */
        if (!capable(CAP_SYS_NICE)) {
                /* can't change policy */
-               if (policy != p->policy)
+               if (policy != p->policy &&
+                       !p->signal->rlim[RLIMIT_RTPRIO].rlim_cur)
                        return -EPERM;
                /* can't increase priority */
                if (policy != SCHED_NORMAL &&

Lee

