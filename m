Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267951AbUHEUjL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267951AbUHEUjL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 16:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267947AbUHEUjK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 16:39:10 -0400
Received: from mail5.speakeasy.net ([216.254.0.205]:36826 "EHLO
	mail5.speakeasy.net") by vger.kernel.org with ESMTP id S267957AbUHEUhu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 16:37:50 -0400
Date: Thu, 5 Aug 2004 13:37:45 -0700
Message-Id: <200408052037.i75KbjZu023287@magilla.sf.frob.com>
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix /proc printing of TASK_DEAD state
X-Fcc: ~/Mail/linus
X-Zippy-Says: These PRESERVES should be FORCE-FED to PENTAGON OFFICIALS!!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just stumbled across this patch that's been sitting in my tree for ages.
I thought I'd sent this in before.  It's a trivial fix for the printing of
task state in /proc and sysrq dumps and such, so that TASK_DEAD shows up
correctly.  This state is pretty much only ever there to be seen when there
are exit/reaping bugs, but it's not like that hasn't come up.


Thanks,
Roland

Signed-off-by: Roland McGrath <roland@redhat.com>

Index: linux-2.6/fs/proc/array.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/fs/proc/array.c,v
retrieving revision 1.62
diff -u -b -p -r1.62 array.c
--- linux-2.6/fs/proc/array.c 25 May 2004 15:37:14 -0000 1.62
+++ linux-2.6/fs/proc/array.c 5 Aug 2004 20:36:53 -0000
@@ -137,6 +137,7 @@ static inline const char * get_task_stat
 					   TASK_INTERRUPTIBLE |
 					   TASK_UNINTERRUPTIBLE |
 					   TASK_ZOMBIE |
+					   TASK_DEAD |
 					   TASK_STOPPED);
 	const char **p = &task_state_array[0];
 
