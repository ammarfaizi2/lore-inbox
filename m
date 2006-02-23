Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751470AbWBWQAJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751470AbWBWQAJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 11:00:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751498AbWBWQAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 11:00:09 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:60054 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751470AbWBWQAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 11:00:07 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH 04/23] proc: Remove unnecessary and misleading assignments
 from proc_pid_make_inode.
References: <m1oe0yhy1w.fsf@ebiederm.dsl.xmission.com>
	<m1k6bmhxze.fsf@ebiederm.dsl.xmission.com>
	<m1fymahxwr.fsf_-_@ebiederm.dsl.xmission.com>
	<m1bqwyhxua.fsf_-_@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 23 Feb 2006 08:58:55 -0700
In-Reply-To: <m1bqwyhxua.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Thu, 23 Feb 2006 08:57:33 -0700")
Message-ID: <m17j7mhxs0.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The removed fields are already set by proc_alloc_inode.  
Initializing them in proc_pid_make_inode implies they need
to be set.  At least ei->pde was not set on all paths making
it look like proc_pid_make_inode was buggy.  So just remove 
the redundant assignments.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 fs/proc/base.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

2b0fa5317e60458090cfa528e9421ecd3de38f6b
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 24a3526..56ca519 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1310,7 +1310,6 @@ static struct inode *proc_pid_make_inode
 
 	/* Common stuff */
 	ei = PROC_I(inode);
-	ei->task = NULL;
 	inode->i_mtime = inode->i_atime = inode->i_ctime = CURRENT_TIME;
 	inode->i_ino = fake_ino(task->pid, ino);
 
@@ -1335,7 +1334,6 @@ out:
 	return inode;
 
 out_unlock:
-	ei->pde = NULL;
 	iput(inode);
 	return NULL;
 }
-- 
1.2.2.g709a

