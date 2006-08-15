Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030444AbWHOSYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030444AbWHOSYp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 14:24:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030445AbWHOSYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 14:24:14 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:16606 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1030444AbWHOSYI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 14:24:08 -0400
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>, <containers@lists.osdl.org>,
       Oleg Nesterov <oleg@tv-sign.ru>,
       "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 5/7] pid: Implement pid_nr
Date: Tue, 15 Aug 2006 12:23:10 -0600
Message-Id: <1155666193751-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.4.2.g3cd4f
In-Reply-To: <m1k65997xk.fsf@ebiederm.dsl.xmission.com>
References: <m1k65997xk.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As we stop storing pid_t's and move to storing struct pid *.  We
need a way to get the pid_t from the struct pid to report to user
space what we have stored.

Having a clean well defined way to do this is especially important
as we move to multiple pid spaces as may need to report a different
value to the caller depending on which pid space the caller is in.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 include/linux/pid.h |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/include/linux/pid.h b/include/linux/pid.h
index 4007114..9fd547f 100644
--- a/include/linux/pid.h
+++ b/include/linux/pid.h
@@ -93,6 +93,14 @@ extern struct pid *find_get_pid(int nr);
 extern struct pid *alloc_pid(void);
 extern void FASTCALL(free_pid(struct pid *pid));
 
+static inline pid_t pid_nr(struct pid *pid)
+{
+	pid_t nr = 0;
+	if (pid)
+		nr = pid->nr;
+	return nr;
+}
+
 #define pid_next(task, type)					\
 	((task)->pids[(type)].node.next)
 
-- 
1.4.2.rc3.g7e18e-dirty

