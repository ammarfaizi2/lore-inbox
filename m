Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261481AbTHSV1T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 17:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbTHSV1T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 17:27:19 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:10710 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S261557AbTHSVT2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 17:19:28 -0400
Subject: [PATCH] Call security hook from pid*_revalidate
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Andrew Morton <akpm@osdl.org>, James Morris <jmorris@redhat.com>,
       Chris Wright <chris@wirex.com>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20030819013834.1fa487dc.akpm@osdl.org>
References: <20030819013834.1fa487dc.akpm@osdl.org>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1061327958.28439.62.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 19 Aug 2003 17:19:18 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-08-19 at 04:38, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test3/2.6.0-test3-mm3/

This patch against 2.6.0-test3-mm3 adds calls to the
security_task_to_inode hook to the pid*_revalidate functions to ensure
that the inode security field is also updated appropriately for
/proc/pid inodes.  This corresponds with the uid/gid update performed by
the proc-pid-setuid-ownership-fix.patch that is already in -mm3.

 fs/proc/base.c |    2 ++
 1 files changed, 2 insertions(+)

diff -X /home/sds/dontdiff -ru linux-2.6.0-test3-mm3/fs/proc/base.c linux-2.6.0-test3-mm3-t2i/fs/proc/base.c
--- linux-2.6.0-test3-mm3/fs/proc/base.c	2003-08-19 14:41:23.000000000 -0400
+++ linux-2.6.0-test3-mm3-t2i/fs/proc/base.c	2003-08-19 14:45:49.000000000 -0400
@@ -875,6 +875,7 @@
 
 		dentry->d_inode->i_uid = task->euid;
 		dentry->d_inode->i_gid = task->egid;
+		security_task_to_inode(task, dentry->d_inode);
 		return 1;
 	}
 	d_drop(dentry);
@@ -899,6 +900,7 @@
 			put_files_struct(files);
 			dentry->d_inode->i_uid = task->euid;
 			dentry->d_inode->i_gid = task->egid;
+			security_task_to_inode(task, dentry->d_inode);
 			return 1;
 		}
 		spin_unlock(&files->file_lock);





-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

