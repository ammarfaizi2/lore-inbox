Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751413AbWCLW4B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbWCLW4B (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 17:56:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751421AbWCLW4B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 17:56:01 -0500
Received: from nproxy.gmail.com ([64.233.182.202]:1884 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751413AbWCLW4A (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 17:56:00 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=IwJ7VRzd1Z+XupRfxdMI90vmwxuPH0u0gKx2MDnpMgvsuxMAsADU4CIqhLjB63IdpA/iYPkdIu7DeNXf/Vn6lHFJP3p04vqSeAQ5Vd8X6iolqhqyR1K5G7Gj9d9hj0PHU8z40y1cqEFMi5gU4T3jUJcbQHHnHZfC0GTFwrAXziQ=
Date: Mon, 13 Mar 2006 01:55:50 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Laurent Riffard <laurent.riffard@free.fr>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Maneesh Soni <maneesh@in.ibm.com>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: 2.6.16-rc6-mm1: BUG at fs/sysfs/inode.c:180
Message-ID: <20060312225550.GA7790@mipter.zuzino.mipt.ru>
References: <20060312031036.3a382581.akpm@osdl.org> <44146C31.3010905@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44146C31.3010905@free.fr>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 12, 2006 at 07:45:05PM +0100, Laurent Riffard wrote:
> This kernel hangs on boot while trying to activate logical
> volumes from initrd:
>
> ------------[ cut here ]------------
> kernel BUG at fs/sysfs/inode.c:180!
> invalid opcode: 0000 [#1]
> last sysfs file: /block/ram0/dev
> Modules linked in: dm_mirror dm_mod
> CPU:    0
> EIP:    0060:[<c0172e71>]    Not tainted VLI
> EFLAGS: 00010246   (2.6.16-rc6-mm1 #123)
> EIP is at sysfs_get_name+0xd/0x46
> eax: c15a49c8   ebx: dfe2b988   ecx: dff254d8   edx: c15a49cc
> esi: dfe87b05   edi: dfe2b988   ebp: dfe67d28   esp: dfe67d28
> ds: 007b   es: 007b   ss: 0068
> Process vgchange (pid: 242, threadinfo=dfe67000 task=dfe175d0)
> Stack: <0>dfe67d44 c01738c3 dffdc4b4 c15a49c8 dfe2b988 ffffffef dfe2b98d dfe67d60
>        c0173dcd dff2a804 dfe2b984 dfe2b984 00000001 fffffffe dfe67d74 c0173f3b
>        dfe67d6c c15a84d4 dfe2b984 dfe67d90 c01a33fd c03242d0 00000004 dfe2b8f8
> Call Trace:
>  [<c0103a31>] show_stack_log_lvl+0x8b/0x95
>  [<c0103b69>] show_registers+0x12e/0x194
>  [<c0103e62>] die+0x14e/0x1db
>  [<c01040ba>] do_trap+0x7c/0x96
>  [<c0104319>] do_invalid_op+0x89/0x93
>  [<c01034db>] error_code+0x4f/0x54
>  [<c01738c3>] sysfs_dirent_exist+0x1c/0x65
>  [<c0173dcd>] create_dir+0x55/0x17d
>  [<c0173f3b>] sysfs_create_dir+0x46/0x61
>  [<c01a33fd>] kobject_add+0xa4/0x14c
>  [<c017267e>] register_disk+0x4b/0xe9
>  [<c019c28c>] add_disk+0x2e/0x3d
>  [<e08198a5>] create_aux+0x27e/0x2d7 [dm_mod]
>  [<e081991d>] dm_create+0xe/0x10 [dm_mod]
>  [<e081c317>] dev_create+0x4a/0x239 [dm_mod]
>  [<e081c18c>] ctl_ioctl+0x203/0x238 [dm_mod]
>  [<c0156648>] do_ioctl+0x3c/0x4f
>  [<c0156851>] vfs_ioctl+0x1f6/0x20d
>  [<c0156892>] sys_ioctl+0x2a/0x44
>  [<c01029bb>] sysenter_past_esp+0x54/0x75
> Code: 0b 30 01 72 85 28 c0 ff 06 31 db eb 07 89 f8 e8 d1 8d fe ff 83 c4 10 89 d8 5b 5e 5f c9 c3 55 85 c0 89 e5 74 06 83 78 14 00 75 08 <0f> 0b b4 00 73 d3 28 c0 8b 50 18 83 fa 08 74 22 7f 0a 83 fa 02
>  BUG: vgchange/242, lock held at task exit time!
>  [dff25548] {inode_init_once}
> .. held by:          vgchange:  242 [dfe175d0, 102]
> ... acquired at:               create_dir+0x1d/0x17d
>
>
> There was no such problems with 2.6.16-rc5-mm3, I didn't change my
> kernel config.

Does reverting this patch make it work?

BTW, sysfs_dirent_exist() should return 0 or 1.
----------------------------------------------------------------
The following patch checks for existing sysfs_dirent before
preparing new one while creating sysfs directories and files.

Signed-off-by: Maneesh Soni <maneesh@in.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 fs/sysfs/dir.c     |   30 +++++++++++++++++++++++++++++-
 fs/sysfs/file.c    |    6 ++++--
 fs/sysfs/symlink.c |    5 +++--
 fs/sysfs/sysfs.h   |    1 +
 4 files changed, 37 insertions(+), 5 deletions(-)

--- gregkh-2.6.orig/fs/sysfs/dir.c
+++ gregkh-2.6/fs/sysfs/dir.c
@@ -51,6 +51,30 @@ static struct sysfs_dirent * sysfs_new_d
 	return sd;
 }
 
+/**
+ *
+ * Return -EEXIST if there is already a sysfs element with the same name for
+ * the same parent.
+ *
+ * called with parent inode's i_mutex held
+ */
+int sysfs_dirent_exist(struct sysfs_dirent *parent_sd,
+			  const unsigned char *new)
+{
+	struct sysfs_dirent * sd;
+
+	list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
+		const unsigned char * existing = sysfs_get_name(sd);
+		if (strcmp(existing, new))
+			continue;
+		else
+			return -EEXIST;
+	}
+
+	return 0;
+}
+
+
 int sysfs_make_dirent(struct sysfs_dirent * parent_sd, struct dentry * dentry,
 			void * element, umode_t mode, int type)
 {
@@ -117,7 +141,11 @@ static int create_dir(struct kobject * k
 	mutex_lock(&p->d_inode->i_mutex);
 	*d = lookup_one_len(n, p, strlen(n));
 	if (!IS_ERR(*d)) {
-		error = sysfs_make_dirent(p->d_fsdata, *d, k, mode, SYSFS_DIR);
+ 		if (sysfs_dirent_exist(p->d_fsdata, n))
+  			error = -EEXIST;
+  		else
+			error = sysfs_make_dirent(p->d_fsdata, *d, k, mode,
+								SYSFS_DIR);
 		if (!error) {
 			error = sysfs_create(*d, mode, init_dir);
 			if (!error) {
--- gregkh-2.6.orig/fs/sysfs/file.c
+++ gregkh-2.6/fs/sysfs/file.c
@@ -436,10 +436,12 @@ int sysfs_add_file(struct dentry * dir, 
 {
 	struct sysfs_dirent * parent_sd = dir->d_fsdata;
 	umode_t mode = (attr->mode & S_IALLUGO) | S_IFREG;
-	int error = 0;
+	int error = -EEXIST;
 
 	mutex_lock(&dir->d_inode->i_mutex);
-	error = sysfs_make_dirent(parent_sd, NULL, (void *) attr, mode, type);
+	if (!sysfs_dirent_exist(parent_sd, attr->name))
+		error = sysfs_make_dirent(parent_sd, NULL, (void *)attr,
+					  mode, type);
 	mutex_unlock(&dir->d_inode->i_mutex);
 
 	return error;
--- gregkh-2.6.orig/fs/sysfs/symlink.c
+++ gregkh-2.6/fs/sysfs/symlink.c
@@ -82,12 +82,13 @@ exit1:
 int sysfs_create_link(struct kobject * kobj, struct kobject * target, const char * name)
 {
 	struct dentry * dentry = kobj->dentry;
-	int error = 0;
+	int error = -EEXIST;
 
 	BUG_ON(!kobj || !kobj->dentry || !name);
 
 	mutex_lock(&dentry->d_inode->i_mutex);
-	error = sysfs_add_link(dentry, name, target);
+	if (!sysfs_dirent_exist(dentry->d_fsdata, name))
+		error = sysfs_add_link(dentry, name, target);
 	mutex_unlock(&dentry->d_inode->i_mutex);
 	return error;
 }
--- gregkh-2.6.orig/fs/sysfs/sysfs.h
+++ gregkh-2.6/fs/sysfs/sysfs.h
@@ -5,6 +5,7 @@ extern kmem_cache_t *sysfs_dir_cachep;
 extern struct inode * sysfs_new_inode(mode_t mode, struct sysfs_dirent *);
 extern int sysfs_create(struct dentry *, int mode, int (*init)(struct inode *));
 
+extern int sysfs_dirent_exist(struct sysfs_dirent *, const unsigned char *);
 extern int sysfs_make_dirent(struct sysfs_dirent *, struct dentry *, void *,
 				umode_t, int);
 

