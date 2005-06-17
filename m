Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261960AbVFQNSL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbVFQNSL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Jun 2005 09:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261964AbVFQNSL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Jun 2005 09:18:11 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:33942 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S261960AbVFQNSA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Jun 2005 09:18:00 -0400
Subject: [PATCH 0/1] VFS: memory leak in do_kern_mount()
From: Gerald Schaefer <geraldsc@de.ibm.com>
Reply-To: geraldsc@de.ibm.com
To: akpm@osdl.org
Cc: schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Fri, 17 Jun 2005 15:17:56 +0200
Message-Id: <1119014276.7006.57.camel@thinkpad>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 0/1] VFS: memory leak in do_kern_mount()
There is a memory leak during mount when CONFIG_SECURITY is enabled and mount
options are specified.

Signed-off-by: Gerald Schaefer <geraldsc@de.ibm.com>
---

diff -pruN linux-2.6-git/fs/super.c linux-2.6-git_xxx/fs/super.c
--- linux-2.6-git/fs/super.c    2005-06-16 20:00:26.000000000 +0200
+++ linux-2.6-git_xxx/fs/super.c        2005-06-17 14:18:06.000000000 +0200
@@ -835,6 +835,7 @@ do_kern_mount(const char *fstype, int fl
        mnt->mnt_parent = mnt;
        mnt->mnt_namespace = current->namespace;
        up_write(&sb->s_umount);
+       free_secdata(secdata);
        put_filesystem(type);
        return mnt;
 out_sb:


