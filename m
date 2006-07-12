Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932422AbWGLSYR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932422AbWGLSYR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jul 2006 14:24:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932328AbWGLSYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jul 2006 14:24:12 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:46493 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932330AbWGLSRU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jul 2006 14:17:20 -0400
Subject: [RFC][PATCH 08/27] increment sb writer count when nlink hits zero
To: viro@ftp.linux.org.uk
Cc: serue@us.ibm.com, linux-kernel@vger.kernel.org,
       Dave Hansen <haveblue@us.ibm.com>
From: Dave Hansen <haveblue@us.ibm.com>
Date: Wed, 12 Jul 2006 11:17:15 -0700
References: <20060712181709.5C1A4353@localhost.localdomain>
In-Reply-To: <20060712181709.5C1A4353@localhost.localdomain>
Message-Id: <20060712181715.624EC138@localhost.localdomain>
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
--- lxc/fs/libfs.c~C-inc-sb-writer-count-on-dec-nlink-to-zero	2006-07-12 11:09:23.000000000 -0700
+++ lxc-dave/fs/libfs.c	2006-07-12 11:09:25.000000000 -0700
@@ -276,6 +276,7 @@ void inode_drop_nlink(struct inode *inod
 	if (inode->i_nlink)
 		return;
 	inode->i_state |= I_WRITING_ON_SB;
+	atomic_inc(&inode->i_sb->s_mnt_writers);
 }
 
 int simple_unlink(struct inode *dir, struct dentry *dentry)
_
