Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263455AbTDDG1S (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 01:27:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263456AbTDDG1S (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 01:27:18 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:16061 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S263455AbTDDG1D (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 01:27:03 -0500
Date: Fri, 4 Apr 2003 01:38:29 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
To: akpm@digeo.com
Cc: linux-kernel@vger.kernel.org
Subject: Patch for show_task
Message-ID: <20030404013829.A30163@devserv.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, bkbits says you changed the line above to be p->thread_info.
Unfortunately, there's another.

--- linux-2.5.66/kernel/sched.c	2003-03-24 14:01:16.000000000 -0800
+++ linux-2.5.66-sparc/kernel/sched.c	2003-04-03 22:33:29.000000000 -0800
@@ -2197,7 +2197,7 @@
 		unsigned long * n = (unsigned long *) (p->thread_info+1);
 		while (!*n)
 			n++;
-		free = (unsigned long) n - (unsigned long)(p+1);
+		free = (unsigned long) n - (unsigned long) (p->thread_info+1);
 	}
 	printk("%5lu %5d %6d ", free, p->pid, p->parent->pid);
 	if ((relative = eldest_child(p)))

-- Pete
