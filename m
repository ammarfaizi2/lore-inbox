Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312853AbSDYBqD>; Wed, 24 Apr 2002 21:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312855AbSDYBqC>; Wed, 24 Apr 2002 21:46:02 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:27270 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S312853AbSDYBqC>;
	Wed, 24 Apr 2002 21:46:02 -0400
Date: Thu, 25 Apr 2002 11:43:25 +1000
From: Anton Blanchard <anton@samba.org>
To: linux-kernel@vger.kernel.org
Cc: torvalds@transmeta.com
Subject: [PATCH] gcc 3.1 breaks wchan
Message-ID: <20020425014325.GA22384@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I noticed on a ppc64 kernel compiled with gcc 3.1 that context_switch
was left out of line. It ended up outside of the
scheduling_functions_start_here/end_here placeholders which breaks
wchan.

This is one place where we require the code to be inline, so we should use
extern.

Anton


--- linux-2.5/kernel/sched.c	Tue Apr 23 16:00:33 2002
+++ linux-2.5_work/kernel/sched.c	Thu Apr 25 11:38:45 2002
@@ -405,7 +405,8 @@
 }
 #endif
 
-static inline void context_switch(task_t *prev, task_t *next)
+/* This must end up inline or our wchan handling will break, so use extern */
+extern inline void context_switch(task_t *prev, task_t *next)
 {
 	struct mm_struct *mm = next->mm;
 	struct mm_struct *oldmm = prev->active_mm;
