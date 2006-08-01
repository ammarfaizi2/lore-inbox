Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932116AbWHAPxQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbWHAPxQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Aug 2006 11:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751618AbWHAPxQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Aug 2006 11:53:16 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:47390 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751221AbWHAPxP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Aug 2006 11:53:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=mbs2oiserNOcjPsN6Hb81t8LOLQtbC5ArYiY+vencrdxBDz+ff7YBhR6p/AOVF9tQeWlgK9HkZs+vCwbqjAhpj0dyKI5S3yFyidhlS25lmqYuJU4t6JQUK7gN+GkihXZcpMbUxwLDG03ijB+1/VK5vXFOAjdi/SkXgXvS7WPMfo=
Date: Tue, 1 Aug 2006 19:53:05 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fs.h: ifdef security fields
Message-ID: <20060801155305.GA6872@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chop 4 bytes from struct inode et al here.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/inode.c         |    2 ++
 include/linux/fs.h |    7 ++++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

--- a/fs/inode.c
+++ b/fs/inode.c
@@ -133,7 +133,9 @@ #endif
 		inode->i_bdev = NULL;
 		inode->i_cdev = NULL;
 		inode->i_rdev = 0;
+#ifdef CONFIG_SECURITY
 		inode->i_security = NULL;
+#endif
 		inode->dirtied_when = 0;
 		if (security_inode_alloc(inode)) {
 			if (inode->i_sb->s_op->destroy_inode)
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -552,7 +552,9 @@ struct inode {
 	unsigned int		i_flags;
 
 	atomic_t		i_writecount;
+#ifdef CONFIG_SECURITY
 	void			*i_security;
+#endif
 	union {
 		void		*generic_ip;
 	} u;
@@ -688,8 +690,9 @@ struct file {
 	struct file_ra_state	f_ra;
 
 	unsigned long		f_version;
+#ifdef CONFIG_SECURITY_SELINUX
 	void			*f_security;
-
+#endif
 	/* needed for tty driver, and maybe others */
 	void			*private_data;
 
@@ -877,7 +880,9 @@ struct super_block {
 	int			s_syncing;
 	int			s_need_sync_fs;
 	atomic_t		s_active;
+#ifdef CONFIG_SECURITY_SELINUX
 	void                    *s_security;
+#endif
 	struct xattr_handler	**s_xattr;
 
 	struct list_head	s_inodes;	/* all inodes */

