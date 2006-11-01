Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946306AbWKABtY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946306AbWKABtY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 20:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946364AbWKABtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 20:49:24 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:52648 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1946295AbWKABtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 20:49:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=DbIc92EO6yMiX8Qs2jvFMUmssDG3xYkWIVyh4nT8VKMkAkcc6TtBXrEUnD0vGJR8WvDrQ3/dQVYxHtJ1iN7ps1rd5CD4oKPiysgMBR6PfI551i/oCm+P9DR1+N8ZeZ5zuXxFJBm2S5/bh/HoKTwM0xXO82OT3B/qdircnpaYub4=
Date: Wed, 1 Nov 2006 04:47:44 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH] fs/*: trivial vsnprintf() conversion
Message-ID: <20061101014744.GA5014@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It would very lame to get buffer overflow via one of the following.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/adfs/super.c    |    2 +-
 fs/affs/amigaffs.c |    4 ++--
 fs/jfs/super.c     |    2 +-
 fs/ocfs2/super.c   |    4 ++--
 fs/udf/super.c     |    4 ++--
 fs/ufs/super.c     |    6 +++---
 6 files changed, 11 insertions(+), 11 deletions(-)

--- a/fs/adfs/super.c
+++ b/fs/adfs/super.c
@@ -36,7 +36,7 @@ void __adfs_error(struct super_block *sb
 	va_list args;
 
 	va_start(args, fmt);
-	vsprintf(error_buf, fmt, args);
+	vsnprintf(error_buf, sizeof(error_buf), fmt, args);
 	va_end(args);
 
 	printk(KERN_CRIT "ADFS-fs error (device %s)%s%s: %s\n",
--- a/fs/affs/amigaffs.c
+++ b/fs/affs/amigaffs.c
@@ -445,7 +445,7 @@ affs_error(struct super_block *sb, const
 	va_list	 args;
 
 	va_start(args,fmt);
-	vsprintf(ErrorBuffer,fmt,args);
+	vsnprintf(ErrorBuffer,sizeof(ErrorBuffer),fmt,args);
 	va_end(args);
 
 	printk(KERN_CRIT "AFFS error (device %s): %s(): %s\n", sb->s_id,
@@ -461,7 +461,7 @@ affs_warning(struct super_block *sb, con
 	va_list	 args;
 
 	va_start(args,fmt);
-	vsprintf(ErrorBuffer,fmt,args);
+	vsnprintf(ErrorBuffer,sizeof(ErrorBuffer),fmt,args);
 	va_end(args);
 
 	printk(KERN_WARNING "AFFS warning (device %s): %s(): %s\n", sb->s_id,
--- a/fs/jfs/super.c
+++ b/fs/jfs/super.c
@@ -93,7 +93,7 @@ void jfs_error(struct super_block *sb, c
 	va_list args;
 
 	va_start(args, function);
-	vsprintf(error_buf, function, args);
+	vsnprintf(error_buf, sizeof(error_buf), function, args);
 	va_end(args);
 
 	printk(KERN_ERR "ERROR: (device %s): %s\n", sb->s_id, error_buf);
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -1674,7 +1674,7 @@ void __ocfs2_error(struct super_block *s
 	va_list args;
 
 	va_start(args, fmt);
-	vsprintf(error_buf, fmt, args);
+	vsnprintf(error_buf, sizeof(error_buf), fmt, args);
 	va_end(args);
 
 	/* Not using mlog here because we want to show the actual
@@ -1695,7 +1695,7 @@ void __ocfs2_abort(struct super_block* s
 	va_list args;
 
 	va_start(args, fmt);
-	vsprintf(error_buf, fmt, args);
+	vsnprintf(error_buf, sizeof(error_buf), fmt, args);
 	va_end(args);
 
 	printk(KERN_CRIT "OCFS2: abort (device %s): %s: %s\n",
--- a/fs/udf/super.c
+++ b/fs/udf/super.c
@@ -1709,7 +1709,7 @@ void udf_error(struct super_block *sb, c
 		sb->s_dirt = 1;
 	}
 	va_start(args, fmt);
-	vsprintf(error_buf, fmt, args);
+	vsnprintf(error_buf, sizeof(error_buf), fmt, args);
 	va_end(args);
 	printk (KERN_CRIT "UDF-fs error (device %s): %s: %s\n",
 		sb->s_id, function, error_buf);
@@ -1721,7 +1721,7 @@ void udf_warning(struct super_block *sb,
 	va_list args;
 
 	va_start (args, fmt);
-	vsprintf(error_buf, fmt, args);
+	vsnprintf(error_buf, sizeof(error_buf), fmt, args);
 	va_end(args);
 	printk(KERN_WARNING "UDF-fs warning (device %s): %s: %s\n",
 		sb->s_id, function, error_buf);
--- a/fs/ufs/super.c
+++ b/fs/ufs/super.c
@@ -224,7 +224,7 @@ void ufs_error (struct super_block * sb,
 		sb->s_flags |= MS_RDONLY;
 	}
 	va_start (args, fmt);
-	vsprintf (error_buf, fmt, args);
+	vsnprintf (error_buf, sizeof(error_buf), fmt, args);
 	va_end (args);
 	switch (UFS_SB(sb)->s_mount_opt & UFS_MOUNT_ONERROR) {
 	case UFS_MOUNT_ONERROR_PANIC:
@@ -255,7 +255,7 @@ void ufs_panic (struct super_block * sb,
 		sb->s_dirt = 1;
 	}
 	va_start (args, fmt);
-	vsprintf (error_buf, fmt, args);
+	vsnprintf (error_buf, sizeof(error_buf), fmt, args);
 	va_end (args);
 	sb->s_flags |= MS_RDONLY;
 	printk (KERN_CRIT "UFS-fs panic (device %s): %s: %s\n",
@@ -268,7 +268,7 @@ void ufs_warning (struct super_block * s
 	va_list args;
 
 	va_start (args, fmt);
-	vsprintf (error_buf, fmt, args);
+	vsnprintf (error_buf, sizeof(error_buf), fmt, args);
 	va_end (args);
 	printk (KERN_WARNING "UFS-fs warning (device %s): %s: %s\n",
 		sb->s_id, function, error_buf);

