Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750828AbWHAX4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750828AbWHAX4v (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 19:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbWHAXxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 19:53:33 -0400
Received: from e33.co.us.ibm.com ([32.97.110.151]:7358 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750755AbWHAXw7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 19:52:59 -0400
Subject: [PATCH 10/28] increment sb writer count when nlink hits zero
To: linux-kernel@vger.kernel.org
Cc: viro@ftp.linux.org.uk, herbert@13thfloor.at, hch@infradead.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Tue, 01 Aug 2006 16:52:47 -0700
References: <20060801235240.82ADCA42@localhost.localdomain>
In-Reply-To: <20060801235240.82ADCA42@localhost.localdomain>
Message-Id: <20060801235247.982CED24@localhost.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When a file is unlinked, there will soon be a write to the
filesystem.  Note this, and disallow remounts to r/o during
the time when this write is pending.

Signed-off-by: Dave Hansen <haveblue@us.ibm.com>
---

 lxc-dave/fs/libfs.c |    1 +
 1 files changed, 1 insertion(+)

diff -puN fs/libfs.c~C-inc-sb-writer-count-on-dec-nlink-to-zero fs/libfs.c
--- lxc/fs/libfs.c~C-inc-sb-writer-count-on-dec-nlink-to-zero	2006-08-01 16:35:20.000000000 -0700
+++ lxc-dave/fs/libfs.c	2006-08-01 16:35:21.000000000 -0700
@@ -273,6 +273,7 @@ out:
 void __inode_set_awaiting_final_iput(struct inode *inode)
 {
 	inode->i_state |= I_AWAITING_FINAL_IPUT;
+	atomic_inc(&inode->i_sb->s_mnt_writers);
 }
 
 int simple_unlink(struct inode *dir, struct dentry *dentry)
_
