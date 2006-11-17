Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424819AbWKQAld@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424819AbWKQAld (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Nov 2006 19:41:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424821AbWKQAld
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Nov 2006 19:41:33 -0500
Received: from mx1.suse.de ([195.135.220.2]:55680 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1424819AbWKQAlc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Nov 2006 19:41:32 -0500
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 2/3] debugfs: check return value correctly
Date: Thu, 16 Nov 2006 16:41:37 -0800
Message-Id: <11637241024111-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.3.5
In-Reply-To: <11637240981960-git-send-email-greg@kroah.com>
References: <20061117000740.GB687@kroah.com> <11637240981960-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Akinobu Mita <akinobu.mita@gmail.com>

The return value is stored in "*dentry", not in "dentry".

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 fs/debugfs/inode.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index e77676d..a736d44 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -147,13 +147,13 @@ static int debugfs_create_by_name(const
 	*dentry = NULL;
 	mutex_lock(&parent->d_inode->i_mutex);
 	*dentry = lookup_one_len(name, parent, strlen(name));
-	if (!IS_ERR(dentry)) {
+	if (!IS_ERR(*dentry)) {
 		if ((mode & S_IFMT) == S_IFDIR)
 			error = debugfs_mkdir(parent->d_inode, *dentry, mode);
 		else 
 			error = debugfs_create(parent->d_inode, *dentry, mode);
 	} else
-		error = PTR_ERR(dentry);
+		error = PTR_ERR(*dentry);
 	mutex_unlock(&parent->d_inode->i_mutex);
 
 	return error;
-- 
1.4.3.5

