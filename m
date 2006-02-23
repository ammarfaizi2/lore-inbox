Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751484AbWBWP5N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484AbWBWP5N (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 10:57:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbWBWP5N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 10:57:13 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:56982 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751484AbWBWP5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 10:57:13 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH 02/23] proc: Fix the .. inode number on /proc/<pid>/fd
References: <m1oe0yhy1w.fsf@ebiederm.dsl.xmission.com>
	<m1k6bmhxze.fsf@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 23 Feb 2006 08:56:04 -0700
In-Reply-To: <m1k6bmhxze.fsf@ebiederm.dsl.xmission.com> (Eric W. Biederman's
 message of "Thu, 23 Feb 2006 08:54:29 -0700")
Message-ID: <m1fymahxwr.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 fs/proc/base.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

c901696b26aa347532930dc5ab12ecb54e473722
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 20feb75..4cbbd2d 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1149,7 +1149,8 @@ static struct inode_operations proc_pid_
 
 static int proc_readfd(struct file * filp, void * dirent, filldir_t filldir)
 {
-	struct inode *inode = filp->f_dentry->d_inode;
+	struct dentry *dentry = filp->f_dentry;
+	struct inode *inode = dentry->d_inode;
 	struct task_struct *p = proc_task(inode);
 	unsigned int fd, tid, ino;
 	int retval;
@@ -1170,7 +1171,7 @@ static int proc_readfd(struct file * fil
 				goto out;
 			filp->f_pos++;
 		case 1:
-			ino = fake_ino(tid, PROC_TID_INO);
+			ino = parent_ino(dentry);
 			if (filldir(dirent, "..", 2, 1, ino, DT_DIR) < 0)
 				goto out;
 			filp->f_pos++;
-- 
1.2.2.g709a

