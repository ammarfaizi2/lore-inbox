Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262027AbTHTO5h (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 10:57:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262028AbTHTO5g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 10:57:36 -0400
Received: from mail.parknet.co.jp ([210.171.160.6]:14352 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262027AbTHTO5f
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 10:57:35 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Stephen Smalley <sds@epoch.ncsc.mil>, jmorris@redhat.com, chris@wirex.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Call security hook from pid*_revalidate
References: <20030819013834.1fa487dc.akpm@osdl.org>
	<1061327958.28439.62.camel@moss-spartans.epoch.ncsc.mil>
	<20030819142234.64433bad.akpm@osdl.org>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 20 Aug 2003 23:56:14 +0900
In-Reply-To: <20030819142234.64433bad.akpm@osdl.org>
Message-ID: <87wud8pecx.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> I'm not sure that the /proc/fd ownership patch is the correct solution to
> that bug yet; we'll see.

>  		dentry->d_inode->i_uid = task->euid;
>  		dentry->d_inode->i_gid = task->egid;
> +		security_task_to_inode(task, dentry->d_inode);
>  		return 1;
>  	}
>  	d_drop(dentry);
> @@ -899,6 +900,7 @@
>  			put_files_struct(files);
>  			dentry->d_inode->i_uid = task->euid;
>  			dentry->d_inode->i_gid = task->egid;
> +			security_task_to_inode(task, dentry->d_inode);
>  			return 1;
>  		}
>  		spin_unlock(&files->file_lock);

Umm.. Wasn't the following needed?

	inode->i_uid = 0;
	inode->i_gid = 0;
	if (ino == PROC_PID_INO || task_dumpable(task)) {
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
