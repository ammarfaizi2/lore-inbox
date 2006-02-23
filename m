Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751489AbWBWP6l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489AbWBWP6l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 10:58:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751490AbWBWP6l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 10:58:41 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:58006 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751489AbWBWP6k (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 10:58:40 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: <linux-kernel@vger.kernel.org>
Subject: [PATCH 03/23] proc: Remove useless BKL in proc_pid_readlink.
References: <m1oe0yhy1w.fsf@ebiederm.dsl.xmission.com>
	<m1k6bmhxze.fsf@ebiederm.dsl.xmission.com>
	<m1fymahxwr.fsf_-_@ebiederm.dsl.xmission.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 23 Feb 2006 08:57:33 -0700
In-Reply-To: <m1fymahxwr.fsf_-_@ebiederm.dsl.xmission.com> (Eric W.
 Biederman's message of "Thu, 23 Feb 2006 08:56:04 -0700")
Message-ID: <m1bqwyhxua.fsf_-_@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


We already call everything except do_proc_readlink
outside of the BKL in proc_pid_followlink, and there
appears to be nothing in do_proc_readlink that needs
any special protection.

So remove this leftover from one of the BKL cleanup
efforts.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>


---

 fs/proc/base.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

da9fe7b5227340bea1f4bd1e246af4a921ce765a
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 4cbbd2d..24a3526 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1120,7 +1120,6 @@ static int proc_pid_readlink(struct dent
 	struct dentry *de;
 	struct vfsmount *mnt = NULL;
 
-	lock_kernel();
 
 	if (current->fsuid != inode->i_uid && !capable(CAP_DAC_OVERRIDE))
 		goto out;
@@ -1136,7 +1135,6 @@ static int proc_pid_readlink(struct dent
 	dput(de);
 	mntput(mnt);
 out:
-	unlock_kernel();
 	return error;
 }
 
-- 
1.2.2.g709a

