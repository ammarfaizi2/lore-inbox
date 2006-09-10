Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965207AbWIJEBy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965207AbWIJEBy (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 00:01:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965210AbWIJEBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 00:01:54 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:62627 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965207AbWIJEBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 00:01:53 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, Jan Engelhardt <jengelh@linux01.gwdg.de>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 1/4] proc: Properly compute TGID_OFFSET
Date: Sat,  9 Sep 2006 22:01:02 -0600
Message-Id: <11578608653509-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.2.g3cd4f
In-Reply-To: <m1venwfk43.fsf@ebiederm.dsl.xmission.com>
References: <m1venwfk43.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The value doesn't change but this ensures I will have the proper
value when other files are added to proc_base_stuff.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 fs/proc/base.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index 04e29f9..c4fcd64 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1961,7 +1961,7 @@ retry:
 	return task;
 }
 
-#define TGID_OFFSET (FIRST_PROCESS_ENTRY + (1 /* /proc/self */))
+#define TGID_OFFSET (FIRST_PROCESS_ENTRY + (ARRAY_SIZE(proc_base_stuff) - 1))
 
 static int proc_pid_fill_cache(struct file *filp, void *dirent, filldir_t filldir,
 	struct task_struct *task, int tgid)
-- 
1.4.2.rc3.g7e18e-dirty

