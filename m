Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932495AbWARARf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbWARARf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 19:17:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932519AbWARARe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 19:17:34 -0500
Received: from wproxy.gmail.com ([64.233.184.204]:21112 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932495AbWARARd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 19:17:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=S1V5KQPToa2e2XQGWhPHiKIjr7qAszWahEmnqeft93Uf/T2bIQ2fZFRwyAn2JLUYka2KNzUSayerII/8SbmznUI2/qF+T+Cksb/faq6pPCpEei5hqEe7ukIprQmOYYSOxRuygtDeKg91vXj6oJ/LxOLfbAgYtgwaohJaR8ZTFW8=
Date: Wed, 18 Jan 2006 03:34:53 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] Extract inode_inc_count(), inode_dec_count()
Message-ID: <20060118003453.GB24835@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/linux/fs.h |   12 ++++++++++++
 1 file changed, 12 insertions(+)

--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1112,6 +1112,18 @@ static inline void mark_inode_dirty_sync
 	__mark_inode_dirty(inode, I_DIRTY_SYNC);
 }
 
+static inline void inode_inc_count(struct inode *inode)
+{
+	inode->i_nlink++;
+	mark_inode_dirty(inode);
+}
+
+static inline void inode_dec_count(struct inode *inode)
+{
+	inode->i_nlink--;
+	mark_inode_dirty(inode);
+}
+
 extern void touch_atime(struct vfsmount *mnt, struct dentry *dentry);
 static inline void file_accessed(struct file *file)
 {

