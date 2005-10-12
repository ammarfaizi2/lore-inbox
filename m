Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751441AbVJLLYE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbVJLLYE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 07:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbVJLLYE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 07:24:04 -0400
Received: from xproxy.gmail.com ([66.249.82.203]:31280 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751441AbVJLLYC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 07:24:02 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=nk5kY8YCFIORbEmavP2z8Ww9EbsZtLr9oxm0/QoOx6k82T3cUjLe46EHGEJww+0c/PhEdRtliylcqbDmGC9f583V+BKvSgCM2whV0VGET4N2VsXzP9dCxIKFMJqpQQ+rsiFvg7paCM7lbJiFyhbNvCghxCoICi0LEOeqKeZVSsE=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Subject: [PATCH] hpfs: Whitespace and Codingstyle cleanup for dir.c
Date: Wed, 12 Oct 2005 13:26:52 +0200
User-Agent: KMail/1.8.2
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510121326.52216.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Whitespace and CodingStyle cleanup for fs/hpfs/dir.c

While reading through fs/hpfs/dir.c I ran across lots of cases of multiple
statements on a single line that made some bits of the file quite confusing
to read. This patch cleans that up and also make sure labels are placed at
column 1, removes trailing whitespace and a few other minor CodingStyle nits.

There are some very long lines in this file that would be a lot more readable 
(IMHO) if broken up to fit within 80 cols. This patch does not do that, but
if wanted I can submit an aditional patch on top of this one to do that.


Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
---

 fs/hpfs/dir.c |   65 +++++++++++++++++++++++++++++++++-------------------------
 1 files changed, 38 insertions(+), 27 deletions(-)

--- linux-2.6.14-rc4-orig/fs/hpfs/dir.c	2005-08-29 01:41:01.000000000 +0200
+++ linux-2.6.14-rc4/fs/hpfs/dir.c	2005-10-12 13:18:33.000000000 +0200
@@ -31,19 +31,23 @@ static loff_t hpfs_dir_lseek(struct file
 	lock_kernel();
 
 	/*printk("dir lseek\n");*/
-	if (new_off == 0 || new_off == 1 || new_off == 11 || new_off == 12 || new_off == 13) goto ok;
+	if (new_off == 0 || new_off == 1 || new_off == 11 || new_off == 12 || new_off == 13)
+		goto ok;
 	down(&i->i_sem);
-	pos = ((loff_t) hpfs_de_as_down_as_possible(s, hpfs_inode->i_dno) << 4) + 1;
+	pos = ((loff_t)hpfs_de_as_down_as_possible(s, hpfs_inode->i_dno) << 4) + 1;
 	while (pos != new_off) {
-		if (map_pos_dirent(i, &pos, &qbh)) hpfs_brelse4(&qbh);
-		else goto fail;
-		if (pos == 12) goto fail;
+		if (map_pos_dirent(i, &pos, &qbh))
+			hpfs_brelse4(&qbh);
+		else
+			goto fail;
+		if (pos == 12)
+			goto fail;
 	}
 	up(&i->i_sem);
-ok:
+ ok:
 	unlock_kernel();
 	return filp->f_pos = new_off;
-fail:
+ fail:
 	up(&i->i_sem);
 	/*printk("illegal lseek: %016llx\n", new_off);*/
 	unlock_kernel();
@@ -78,6 +82,7 @@ static int hpfs_readdir(struct file *fil
 		struct buffer_head *bh;
 		struct fnode *fno;
 		int e = 0;
+
 		if (!(fno = hpfs_map_fnode(inode->i_sb, inode->i_ino, &bh))) {
 			ret = -EIOERROR;
 			goto out;
@@ -105,7 +110,7 @@ static int hpfs_readdir(struct file *fil
 		ret = -ENOENT;
 		goto out;
 	}
-	
+
 	while (1) {
 		again:
 		/* This won't work when cycle is longer than number of dirents
@@ -119,7 +124,7 @@ static int hpfs_readdir(struct file *fil
 		if (filp->f_pos == 12)
 			goto out;
 		if (filp->f_pos == 3 || filp->f_pos == 4 || filp->f_pos == 5) {
-			printk("HPFS: warning: pos==%d\n",(int)filp->f_pos);
+			printk("HPFS: warning: pos==%d\n", (int)filp->f_pos);
 			goto out;
 		}
 		if (filp->f_pos == 0) {
@@ -144,8 +149,10 @@ static int hpfs_readdir(struct file *fil
 		}
 		if (de->first || de->last) {
 			if (hpfs_sb(inode->i_sb)->sb_chk) {
-				if (de->first && !de->last && (de->namelen != 2 || de ->name[0] != 1 || de->name[1] != 1)) hpfs_error(inode->i_sb, "hpfs_readdir: bad ^A^A entry; pos = %08x", old_pos);
-				if (de->last && (de->namelen != 1 || de ->name[0] != 255)) hpfs_error(inode->i_sb, "hpfs_readdir: bad \\377 entry; pos = %08x", old_pos);
+				if (de->first && !de->last && (de->namelen != 2 || de ->name[0] != 1 || de->name[1] != 1))
+					hpfs_error(inode->i_sb, "hpfs_readdir: bad ^A^A entry; pos = %08x", old_pos);
+				if (de->last && (de->namelen != 1 || de ->name[0] != 255))
+					hpfs_error(inode->i_sb, "hpfs_readdir: bad \\377 entry; pos = %08x", old_pos);
 			}
 			hpfs_brelse4(&qbh);
 			goto again;
@@ -153,14 +160,16 @@ static int hpfs_readdir(struct file *fil
 		tempname = hpfs_translate_name(inode->i_sb, de->name, de->namelen, lc, de->not_8x3);
 		if (filldir(dirent, tempname, de->namelen, old_pos, de->fnode, DT_UNKNOWN) < 0) {
 			filp->f_pos = old_pos;
-			if (tempname != (char *)de->name) kfree(tempname);
+			if (tempname != (char *)de->name)
+				kfree(tempname);
 			hpfs_brelse4(&qbh);
 			goto out;
 		}
-		if (tempname != (char *)de->name) kfree(tempname);
+		if (tempname != (char *)de->name)
+			kfree(tempname);
 		hpfs_brelse4(&qbh);
 	}
-out:
+ out:
 	unlock_kernel();
 	return ret;
 }
@@ -204,13 +213,14 @@ struct dentry *hpfs_lookup(struct inode 
 	 * '.' and '..' will never be passed here.
 	 */
 
-	de = map_dirent(dir, hpfs_i(dir)->i_dno, (char *) name, len, NULL, &qbh);
+	de = map_dirent(dir, hpfs_i(dir)->i_dno, (char *)name, len, NULL, &qbh);
 
 	/*
 	 * This is not really a bailout, just means file not found.
 	 */
 
-	if (!de) goto end;
+	if (!de)
+		goto end;
 
 	/*
 	 * Get inode number, what we're after.
@@ -243,14 +253,16 @@ struct dentry *hpfs_lookup(struct inode 
 		unlock_new_inode(result);
 	}
 	hpfs_result = hpfs_i(result);
-	if (!de->directory) hpfs_result->i_parent_dir = dir->i_ino;
+	if (!de->directory)
+		hpfs_result->i_parent_dir = dir->i_ino;
 
 	hpfs_decide_conv(result, (char *)name, len);
 
-	if (de->has_acl || de->has_xtd_perm) if (!(dir->i_sb->s_flags & MS_RDONLY)) {
-		hpfs_error(result->i_sb, "ACLs or XPERM found. This is probably HPFS386. This driver doesn't support it now. Send me some info on these structures");
-		goto bail1;
-	}
+	if (de->has_acl || de->has_xtd_perm)
+		if (!(dir->i_sb->s_flags & MS_RDONLY)) {
+			hpfs_error(result->i_sb, "ACLs or XPERM found. This is probably HPFS386. This driver doesn't support it now. Send me some info on these structures");
+			goto bail1;
+		}
 
 	/*
 	 * Fill in the info from the directory if this is a newly created
@@ -290,8 +302,8 @@ struct dentry *hpfs_lookup(struct inode 
 	 * Made it.
 	 */
 
-	end:
-	end_add:
+ end:
+ end_add:
 	hpfs_set_dentry_operations(dentry);
 	unlock_kernel();
 	d_add(dentry, result);
@@ -300,11 +312,10 @@ struct dentry *hpfs_lookup(struct inode 
 	/*
 	 * Didn't.
 	 */
-	bail1:
-	
+ bail1:
 	hpfs_brelse4(&qbh);
-	
-	/*bail:*/
+
+ /*bail:*/
 
 	unlock_kernel();
 	return ERR_PTR(-ENOENT);
