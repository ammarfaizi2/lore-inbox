Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964809AbWFSRSF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964809AbWFSRSF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 13:18:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbWFSRSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 13:18:05 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:40835 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S964809AbWFSRSE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 13:18:04 -0400
Date: Mon, 19 Jun 2006 19:17:40 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Theodore Tso <tytso@thunk.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH 1/8] inode_diet: Replace inode.u.generic_ip with
 inode.i_private
In-Reply-To: <20060619153108.418349000@candygram.thunk.org>
Message-ID: <Pine.LNX.4.61.0606191913200.23792@yvahk01.tjqt.qr>
References: <20060619152003.830437000@candygram.thunk.org>
 <20060619153108.418349000@candygram.thunk.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>--- linux-2.6.17.orig/arch/s390/kernel/debug.c	2006-06-18 18:58:51.000000000 -0400
>+++ linux-2.6.17/arch/s390/kernel/debug.c	2006-06-18 18:58:55.000000000 -0400
>@@ -604,7 +604,7 @@
> 	debug_info_t *debug_info, *debug_info_snapshot;
> 
> 	down(&debug_lock);
>-	debug_info = (struct debug_info*)file->f_dentry->d_inode->u.generic_ip;
>+	debug_info = (struct debug_info*)file->f_dentry->d_inode->i_private;

All these casts can be removed at the same time,
since i_private is a void* anyway and therefore does not require casting.

>-	rhbeat->sp = (struct service_processor *)inode->u.generic_ip;
>+	rhbeat->sp = (struct service_processor *)inode->i_private;


>-	char *s=((struct autofs_symlink *)dentry->d_inode->u.generic_ip)->data;
>+	char *s=((struct autofs_symlink *)dentry->d_inode->i_private)->data;

>-	VERIFY_ENTRY((struct devfs_entry *)inode->u.generic_ip);
>-	return inode->u.generic_ip;
>+	VERIFY_ENTRY((struct devfs_entry *)inode->i_private);
>+	return inode->i_private;

> #define VXFS_INO(ip) \
>-	((struct vxfs_inode_info *)(ip)->u.generic_ip)
>+	((struct vxfs_inode_info *)(ip)->i_private)
Depends on use of VXFS_INO here.

>-	ip->u.generic_ip = (void *)vip;
>+	ip->i_private = (void *)vip;

>-	inode->u.generic_ip = (void *)f;
>+	inode->i_private = (void *)f;

>-	if (!(old_dir_f = (struct jffs_file *)old_dir->u.generic_ip)) {
>+	if (!(old_dir_f = (struct jffs_file *)old_dir->i_private)) {
Not sure.

>-	if (!(new_dir_f = (struct jffs_file *)new_dir->u.generic_ip)) {
>+	if (!(new_dir_f = (struct jffs_file *)new_dir->i_private)) {

>-	if (!(d = (struct jffs_file *)dir->u.generic_ip)) {
>+	if (!(d = (struct jffs_file *)dir->i_private)) {

>-	struct jffs_file *f = (struct jffs_file *)inode->u.generic_ip;
>+	struct jffs_file *f = (struct jffs_file *)inode->i_private;
> 	struct jffs_control *c = (struct jffs_control *)inode->i_sb->s_fs_info;

>-	dir_f = (struct jffs_file *)dir->u.generic_ip;
>+	dir_f = (struct jffs_file *)dir->i_private;

>-	dir_f = (struct jffs_file *) dir->u.generic_ip;
>+	dir_f = (struct jffs_file *) dir->i_private;

>-	dir_f = (struct jffs_file *)dir->u.generic_ip;
>+	dir_f = (struct jffs_file *)dir->i_private;

>-	dir_f = (struct jffs_file *)dir->u.generic_ip;
>+	dir_f = (struct jffs_file *)dir->i_private;

>-	dir_f = (struct jffs_file *)dir->u.generic_ip;
>+	dir_f = (struct jffs_file *)dir->i_private;

>-	if (!(f = (struct jffs_file *)inode->u.generic_ip)) {
>-		D(printk("jffs_file_write(): inode->u.generic_ip = 0x%p\n",
>-				inode->u.generic_ip));
>+	if (!(f = (struct jffs_file *)inode->i_private)) {
>+		D(printk("jffs_file_write(): inode->i_private = 0x%p\n",
>+				inode->i_private));

>-	inode->u.generic_ip = (void *)f;
>+	inode->i_private = (void *)f;

lots more.


Jan Engelhardt
-- 
