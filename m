Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261630AbULJPPw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261630AbULJPPw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 10:15:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261635AbULJPPv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 10:15:51 -0500
Received: from [61.48.53.158] ([61.48.53.158]:29667 "EHLO freya.yggdrasil.com")
	by vger.kernel.org with ESMTP id S261630AbULJPPp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 10:15:45 -0500
Date: Fri, 10 Dec 2004 23:11:46 +0800
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200412101511.iBAFBkR02052@freya.yggdrasil.com>
To: nanhai.zou@intel.com
Subject: Re: [Patch]Memory leak in sysfs
Cc: greg@kroah.com, linux-kernel@vger.kernel.org, maneesh@in.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zou, Nanhai wrote:
>Some stress testes show there is a memory leak in the latest kernel.
>I found the memory leak is in sysfs.
>Here is a patch against 2.6.10-rc2-mm4 to fix that.
>
>Signed-off-by: Zou Nan hai <Nanhai.Zou@intel.com>
>
>["sysfs-memleak-fix.patch" (application/octet-stream)]
>
>diff -Nraup a/fs/sysfs/dir.c b/fs/sysfs/dir.c
>--- a/fs/sysfs/dir.c    2004-12-06 13:04:56.000000000 +0800
>+++ b/fs/sysfs/dir.c    2004-12-07 16:49:36.000000000 +0800
>@@ -349,6 +349,7 @@ static int sysfs_dir_close(struct inode 
> 
>        down(&dentry->d_inode->i_sem);
>        list_del_init(&cursor->s_sibling);
>+       sysfs_put(cursor);
>        up(&dentry->d_inode->i_sem);
> 
>        return 0;


	This is will be fixed when the patch that I posted
at http://marc.theaimsgroup.com/?l=linux-kernel&m=110204311025022&w=2
is applied (that patch calls release_sysfs_dirent, since there
is no need for the reference counting of sysfs_put in this case).
I believe that Greg had already indicated he was going to forward
that patch to Linus (without the BUG_ON statement in my patch, which
is fine with me).

                    __     ______________ 
Adam J. Richter        \ /
adam@yggdrasil.com      | g g d r a s i l
