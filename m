Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964935AbVHOUN0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964935AbVHOUN0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 16:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964936AbVHOUN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 16:13:26 -0400
Received: from waste.org ([216.27.176.166]:10902 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S964935AbVHOUNZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 16:13:25 -0400
Date: Mon, 15 Aug 2005 13:13:11 -0700
From: Matt Mackall <mpm@selenic.com>
To: Andrew Morton <akpm@osdl.org>
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org, michael.kerrisk@gmx.net,
       chrisw@osdl.org, Michael Kerrisk <mtk-manpages@gmx.net>
Subject: [PATCH] Fix nice range for RLIMIT NICE
Message-ID: <20050815201311.GA12284@waste.org>
References: <32710.1122563064@www32.gmx.net> <20050729061318.GD7425@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050729061318.GD7425@waste.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Looks like I let this one slip through the cracks:

Make RLIMIT_NICE ranges consistent with getpriority(2)

As suggested by Michael Kerrisk <mtk-manpages@gmx.net>, make
RLIMIT_NICE consistent with getpriority before it becomes available in
released glibc.

Signed-off-by: Matt Mackall <mpm@selenic.com>
Acked-by: Ingo Molnar <mingo@elte.hu>
Acked-by: Chris Wright <chrisw@osdl.org>

Index: lhg/kernel/sched.c
===================================================================
--- lhg.orig/kernel/sched.c	2005-08-15 13:03:05.000000000 -0700
+++ lhg/kernel/sched.c	2005-08-15 13:09:21.000000000 -0700
@@ -3378,8 +3378,8 @@ EXPORT_SYMBOL(set_user_nice);
  */
 int can_nice(const task_t *p, const int nice)
 {
-	/* convert nice value [19,-20] to rlimit style value [0,39] */
-	int nice_rlim = 19 - nice;
+	/* convert nice value [19,-20] to rlimit style value [1,40] */
+	int nice_rlim = 20 - nice;
 	return (nice_rlim <= p->signal->rlim[RLIMIT_NICE].rlim_cur ||
 		capable(CAP_SYS_NICE));
 }


-- 
Mathematics is the supreme nostalgia of our time.
