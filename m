Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030409AbWHACzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030409AbWHACzi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 22:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030410AbWHACzi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 22:55:38 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:59711 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030409AbWHACzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 22:55:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=DI6m9u8N5YpEcM5Kb6a6obHZYEsxpGNFg/YVohJI6jrppLjNlq9AU17pwwcPIxsALj2NWg08ufHmc4P5b7YSGz8g/XpNw5mKK6edkYofpmvk6e/30y1V24IeXT/4iJ7UA1R+9Sd/jEgfPyA3YEsXzNkSzTBXfF6uTF/0AnX51qg=
Date: Tue, 1 Aug 2006 06:55:29 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] task_struct: ifdef btrace_seq
Message-ID: <20060801025529.GD7006@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Debugging aid.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/linux/sched.h |    2 ++
 kernel/fork.c         |    2 ++
 2 files changed, 4 insertions(+)

--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -784,7 +784,9 @@ #endif
 	struct prio_array *array;
 
 	unsigned short ioprio;
+#ifdef CONFIG_BLK_DEV_IO_TRACE
 	unsigned int btrace_seq;
+#endif
 
 	unsigned long sleep_avg;
 	unsigned long long timestamp, last_ran;
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -177,7 +177,9 @@ static struct task_struct *dup_task_stru
 	/* One for us, one for whoever does the "release_task()" (usually parent) */
 	atomic_set(&tsk->usage,2);
 	atomic_set(&tsk->fs_excl, 0);
+#ifdef CONFIG_BLK_DEV_IO_TRACE
 	tsk->btrace_seq = 0;
+#endif
 	tsk->splice_pipe = NULL;
 	return tsk;
 }

