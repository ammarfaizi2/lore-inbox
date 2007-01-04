Return-Path: <linux-kernel-owner+w=401wt.eu-S1030267AbXADX3J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030267AbXADX3J (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 18:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030270AbXADX3J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 18:29:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:56912 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030267AbXADX3I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 18:29:08 -0500
Message-ID: <459D8DBB.10507@redhat.com>
Date: Thu, 04 Jan 2007 17:28:59 -0600
From: Eric Sandeen <sandeen@redhat.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, Mitchell Blank Jr <mitch@sfgoth.com>,
       Al Viro <viro@ftp.linux.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Al Viro <viro@zeniv.linux.org.uk>
Subject: Re: [UPDATED PATCH] fix memory corruption from misinterpreted bad_inode_ops
 return values
References: <20070104105430.1de994a7.akpm@osdl.org> <Pine.LNX.4.64.0701041104021.3661@woody.osdl.org> <20070104191451.GW17561@ftp.linux.org.uk> <Pine.LNX.4.64.0701041127350.3661@woody.osdl.org> <20070104202412.GY17561@ftp.linux.org.uk> <20070104215206.GZ17561@ftp.linux.org.uk> <20070104223856.GA79126@gaz.sfgoth.com> <Pine.LNX.4.64.0701041428510.3661@woody.osdl.org> <20070104150651.5bafddfc.akpm@osdl.org> <Pine.LNX.4.64.0701041514470.3661@woody.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0701041514470.3661@woody.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> On Thu, 4 Jan 2007, Andrew Morton wrote:
>   
>> That's what I currently have queued.  It increases bad_inode.o text from 
>> 200-odd bytes to 700-odd :(
>>     
> Then I think we're ok. We do care about bytes, but we care more about 
> bytes that actually ever hit the icache or dcache, and this will 
> effectively do neither.
>
>   
Oh good.  Resolution?  ;-)

Andrew, if you stick with what you've got, you might want this on top of it.

Mostly cosmetic, making placement of * for pointers consistently " *foo"
not "* foo," (was a mishmash before, from cut-n-paste), but also making 
.poll return POLLERR.

Thanks,
-Eric

Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Index: linux-2.6.19/fs/bad_inode.c
===================================================================
--- linux-2.6.19.orig/fs/bad_inode.c
+++ linux-2.6.19/fs/bad_inode.c
@@ -46,18 +46,17 @@ static ssize_t bad_file_aio_write(struct
 	return -EIO;
 }
 
-static int bad_file_readdir(struct file * filp, void * dirent,
-			filldir_t filldir)
+static int bad_file_readdir(struct file *filp, void *dirent, filldir_t filldir)
 {
 	return -EIO;
 }
 
 static unsigned int bad_file_poll(struct file *filp, poll_table *wait)
 {
-	return -EIO;
+	return POLLERR;
 }
 
-static int bad_file_ioctl (struct inode * inode, struct file * filp,
+static int bad_file_ioctl (struct inode *inode, struct file *filp,
 			unsigned int cmd, unsigned long arg)
 {
 	return -EIO;
@@ -75,12 +74,12 @@ static long bad_file_compat_ioctl(struct
 	return -EIO;
 }
 
-static int bad_file_mmap(struct file * file, struct vm_area_struct * vma)
+static int bad_file_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	return -EIO;
 }
 
-static int bad_file_open(struct inode * inode, struct file * filp)
+static int bad_file_open(struct inode *inode, struct file *filp)
 {
 	return -EIO;
 }
@@ -90,12 +89,12 @@ static int bad_file_flush(struct file *f
 	return -EIO;
 }
 
-static int bad_file_release(struct inode * inode, struct file * filp)
+static int bad_file_release(struct inode *inode, struct file *filp)
 {
 	return -EIO;
 }
 
-static int bad_file_fsync(struct file * file, struct dentry *dentry,
+static int bad_file_fsync(struct file *file, struct dentry *dentry,
 			int datasync)
 {
 	return -EIO;
@@ -140,7 +139,7 @@ static int bad_file_check_flags(int flag
 	return -EIO;
 }
 
-static int bad_file_dir_notify(struct file * file, unsigned long arg)
+static int bad_file_dir_notify(struct file *file, unsigned long arg)
 {
 	return -EIO;
 }
@@ -194,54 +193,54 @@ static const struct file_operations bad_
 	.splice_read	= bad_file_splice_read,
 };
 
-static int bad_inode_create (struct inode * dir, struct dentry * dentry,
+static int bad_inode_create (struct inode *dir, struct dentry *dentry,
 		int mode, struct nameidata *nd)
 {
 	return -EIO;
 }
 
-static struct dentry *bad_inode_lookup(struct inode * dir,
+static struct dentry *bad_inode_lookup(struct inode *dir,
 			struct dentry *dentry, struct nameidata *nd)
 {
 	return ERR_PTR(-EIO);
 }
 
-static int bad_inode_link (struct dentry * old_dentry, struct inode * dir,
+static int bad_inode_link (struct dentry *old_dentry, struct inode *dir,
 		struct dentry *dentry)
 {
 	return -EIO;
 }
 
-static int bad_inode_unlink(struct inode * dir, struct dentry *dentry)
+static int bad_inode_unlink(struct inode *dir, struct dentry *dentry)
 {
 	return -EIO;
 }
 
-static int bad_inode_symlink (struct inode * dir, struct dentry *dentry,
-		const char * symname)
+static int bad_inode_symlink (struct inode *dir, struct dentry *dentry,
+		const char *symname)
 {
 	return -EIO;
 }
 
-static int bad_inode_mkdir(struct inode * dir, struct dentry * dentry,
+static int bad_inode_mkdir(struct inode *dir, struct dentry *dentry,
 			int mode)
 {
 	return -EIO;
 }
 
-static int bad_inode_rmdir (struct inode * dir, struct dentry *dentry)
+static int bad_inode_rmdir (struct inode *dir, struct dentry *dentry)
 {
 	return -EIO;
 }
 
-static int bad_inode_mknod (struct inode * dir, struct dentry *dentry,
+static int bad_inode_mknod (struct inode *dir, struct dentry *dentry,
 			int mode, dev_t rdev)
 {
 	return -EIO;
 }
 
-static int bad_inode_rename (struct inode * old_dir, struct dentry *old_dentry,
-		struct inode * new_dir, struct dentry *new_dentry)
+static int bad_inode_rename (struct inode *old_dir, struct dentry *old_dentry,
+		struct inode *new_dir, struct dentry *new_dentry)
 {
 	return -EIO;
 }
@@ -337,7 +336,7 @@ static struct inode_operations bad_inode
  *	on it to fail from this point on.
  */
  
-void make_bad_inode(struct inode * inode) 
+void make_bad_inode(struct inode *inode) 
 {
 	remove_inode_hash(inode);
 
@@ -362,7 +361,7 @@ EXPORT_SYMBOL(make_bad_inode);
  *	Returns true if the inode in question has been marked as bad.
  */
  
-int is_bad_inode(struct inode * inode) 
+int is_bad_inode(struct inode *inode) 
 {
 	return (inode->i_op == &bad_inode_ops);	
 }


