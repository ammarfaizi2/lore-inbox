Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261521AbULYPgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbULYPgx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 10:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261524AbULYPgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 10:36:52 -0500
Received: from coderock.org ([193.77.147.115]:16348 "EHLO trashy.coderock.org")
	by vger.kernel.org with ESMTP id S261521AbULYPfJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 10:35:09 -0500
Subject: [patch 1/2] inux-2.6.9/fs/proc/base.c: array size
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, domen@coderock.org, wharms@bfs.de
From: domen@coderock.org
Date: Sat, 25 Dec 2004 16:35:12 +0100
Message-Id: <20041225153503.10FF41EA0F@trashy.coderock.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Sorry about duplicate, had mail problems]

Hi list,
i was looking for arrays (and possible overflows) when i noticed that
proc_pid_wchan() uses a 128-Byte array for something that can change its size
via define.

Fix possible overflow: rewrite arraysize with correct constant

re,
walter

signed-off-by: walter harms <wharms@bfs.de>
Signed-off-by: Domen Puncer <domen@coderock.org>
---


 kj-domen/fs/proc/base.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN fs/proc/base.c~array_size-fs_proc_base.c.bak fs/proc/base.c
--- kj/fs/proc/base.c~array_size-fs_proc_base.c.bak	2004-12-25 01:36:07.000000000 +0100
+++ kj-domen/fs/proc/base.c	2004-12-25 01:36:07.000000000 +0100
@@ -401,7 +401,7 @@ static int proc_pid_wchan(struct task_st
 	char *modname;
 	const char *sym_name;
 	unsigned long wchan, size, offset;
-	char namebuf[128];
+	char namebuf[KSYM_NAME_LEN+1];
 
 	wchan = get_wchan(task);
 
diff -L fs/proc/base.c.bak -puN /dev/null /dev/null
_
