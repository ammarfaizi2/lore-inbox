Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262830AbVAQRyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262830AbVAQRyM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 12:54:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262828AbVAQRv5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 12:51:57 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:13321 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262364AbVAQRst
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 12:48:49 -0500
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 9/13] FAT: Lindent fs/msdos/namei.c
References: <87pt04oszi.fsf@devron.myhome.or.jp>
	<87llasosxu.fsf@devron.myhome.or.jp>
	<87hdlgoswe.fsf_-_@devron.myhome.or.jp>
	<87d5w4osuv.fsf_-_@devron.myhome.or.jp>
	<878y6sostl.fsf_-_@devron.myhome.or.jp>
	<874qhgosrf.fsf_-_@devron.myhome.or.jp>
	<87zmz8ne5p.fsf_-_@devron.myhome.or.jp>
	<877jmcne0o.fsf_-_@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 18 Jan 2005 02:48:37 +0900
In-Reply-To: <877jmcne0o.fsf_-_@devron.myhome.or.jp> (OGAWA Hirofumi's
 message of "Tue, 18 Jan 2005 02:47:51 +0900")
Message-ID: <873bx0ndze.fsf_-_@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/msdos/namei.c |  179 ++++++++++++++++++++++++++++++++-----------------------
 1 files changed, 105 insertions(+), 74 deletions(-)

diff -puN fs/msdos/namei.c~fat_lindent-msdos fs/msdos/namei.c
--- linux-2.6.10/fs/msdos/namei.c~fat_lindent-msdos	2005-01-08 09:08:19.000000000 +0900
+++ linux-2.6.10-hirofumi/fs/msdos/namei.c	2005-01-08 09:08:19.000000000 +0900
@@ -12,25 +12,28 @@
 #include <linux/msdos_fs.h>
 #include <linux/smp_lock.h>
 
-
 /* MS-DOS "device special files" */
 static const unsigned char *reserved_names[] = {
-	"CON     ","PRN     ","NUL     ","AUX     ",
-	"LPT1    ","LPT2    ","LPT3    ","LPT4    ",
-	"COM1    ","COM2    ","COM3    ","COM4    ",
+	"CON     ", "PRN     ", "NUL     ", "AUX     ",
+	"LPT1    ", "LPT2    ", "LPT3    ", "LPT4    ",
+	"COM1    ", "COM2    ", "COM3    ", "COM4    ",
 	NULL
 };
 
 /* Characters that are undesirable in an MS-DOS file name */
 static unsigned char bad_chars[] = "*?<>|\"";
 static unsigned char bad_if_strict_pc[] = "+=,; ";
-static unsigned char bad_if_strict_atari[] = " "; /* GEMDOS is less restrictive */
-#define	bad_if_strict(opts) ((opts)->atari ? bad_if_strict_atari : bad_if_strict_pc)
+/* GEMDOS is less restrictive */
+static unsigned char bad_if_strict_atari[] = " ";
+
+#define bad_if_strict(opts) \
+	((opts)->atari ? bad_if_strict_atari : bad_if_strict_pc)
 
 /***** Formats an MS-DOS file name. Rejects invalid names. */
 static int msdos_format_name(const unsigned char *name, int len,
-	unsigned char *res, struct fat_mount_options *opts)
-	/* name is the proposed name, len is its length, res is
+			     unsigned char *res, struct fat_mount_options *opts)
+	/*
+	 * name is the proposed name, len is its length, res is
 	 * the resulting name, opts->name_check is either (r)elaxed,
 	 * (n)ormal or (s)trict, opts->dotsOK allows dots at the
 	 * beginning of name (for hidden files)
@@ -41,52 +44,66 @@ static int msdos_format_name(const unsig
 	unsigned char c;
 	int space;
 
-	if (name[0] == '.') {  /* dotfile because . and .. already done */
+	if (name[0] == '.') {	/* dotfile because . and .. already done */
 		if (opts->dotsOK) {
 			/* Get rid of dot - test for it elsewhere */
-			name++; len--;
-		}
-		else if (!opts->atari) return -EINVAL;
+			name++;
+			len--;
+		} else if (!opts->atari)
+			return -EINVAL;
 	}
-	/* disallow names that _really_ start with a dot for MS-DOS, GEMDOS does
-	 * not care */
+	/*
+	 * disallow names that _really_ start with a dot for MS-DOS,
+	 * GEMDOS does not care
+	 */
 	space = !opts->atari;
 	c = 0;
-	for (walk = res; len && walk-res < 8; walk++) {
-	    	c = *name++;
+	for (walk = res; len && walk - res < 8; walk++) {
+		c = *name++;
 		len--;
-		if (opts->name_check != 'r' && strchr(bad_chars,c))
+		if (opts->name_check != 'r' && strchr(bad_chars, c))
 			return -EINVAL;
-		if (opts->name_check == 's' && strchr(bad_if_strict(opts),c))
+		if (opts->name_check == 's' && strchr(bad_if_strict(opts), c))
 			return -EINVAL;
-  		if (c >= 'A' && c <= 'Z' && opts->name_check == 's')
+		if (c >= 'A' && c <= 'Z' && opts->name_check == 's')
 			return -EINVAL;
-		if (c < ' ' || c == ':' || c == '\\') return -EINVAL;
-/*  0xE5 is legal as a first character, but we must substitute 0x05     */
-/*  because 0xE5 marks deleted files.  Yes, DOS really does this.       */
-/*  It seems that Microsoft hacked DOS to support non-US characters     */
-/*  after the 0xE5 character was already in use to mark deleted files.  */
-		if((res==walk) && (c==0xE5)) c=0x05;
-		if (c == '.') break;
+		if (c < ' ' || c == ':' || c == '\\')
+			return -EINVAL;
+	/*
+	 * 0xE5 is legal as a first character, but we must substitute
+	 * 0x05 because 0xE5 marks deleted files.  Yes, DOS really
+	 * does this.
+	 * It seems that Microsoft hacked DOS to support non-US
+	 * characters after the 0xE5 character was already in use to
+	 * mark deleted files.
+	 */
+		if ((res == walk) && (c == 0xE5))
+			c = 0x05;
+		if (c == '.')
+			break;
 		space = (c == ' ');
-		*walk = (!opts->nocase && c >= 'a' && c <= 'z') ? c-32 : c;
+		*walk = (!opts->nocase && c >= 'a' && c <= 'z') ? c - 32 : c;
 	}
-	if (space) return -EINVAL;
+	if (space)
+		return -EINVAL;
 	if (opts->name_check == 's' && len && c != '.') {
 		c = *name++;
 		len--;
-		if (c != '.') return -EINVAL;
+		if (c != '.')
+			return -EINVAL;
 	}
-	while (c != '.' && len--) c = *name++;
+	while (c != '.' && len--)
+		c = *name++;
 	if (c == '.') {
-		while (walk-res < 8) *walk++ = ' ';
-		while (len > 0 && walk-res < MSDOS_NAME) {
+		while (walk - res < 8)
+			*walk++ = ' ';
+		while (len > 0 && walk - res < MSDOS_NAME) {
 			c = *name++;
 			len--;
-			if (opts->name_check != 'r' && strchr(bad_chars,c))
+			if (opts->name_check != 'r' && strchr(bad_chars, c))
 				return -EINVAL;
 			if (opts->name_check == 's' &&
-			    strchr(bad_if_strict(opts),c))
+			    strchr(bad_if_strict(opts), c))
 				return -EINVAL;
 			if (c < ' ' || c == ':' || c == '\\')
 				return -EINVAL;
@@ -98,16 +115,23 @@ static int msdos_format_name(const unsig
 			if (c >= 'A' && c <= 'Z' && opts->name_check == 's')
 				return -EINVAL;
 			space = c == ' ';
-			*walk++ = (!opts->nocase && c >= 'a' && c <= 'z') ? c-32 : c;
+			if (!opts->nocase && c >= 'a' && c <= 'z')
+				*walk++ = c - 32;
+			else
+				*walk++ = c;
 		}
-		if (space) return -EINVAL;
-		if (opts->name_check == 's' && len) return -EINVAL;
+		if (space)
+			return -EINVAL;
+		if (opts->name_check == 's' && len)
+			return -EINVAL;
 	}
-	while (walk-res < MSDOS_NAME) *walk++ = ' ';
+	while (walk - res < MSDOS_NAME)
+		*walk++ = ' ';
 	if (!opts->atari)
 		/* GEMDOS is less stupid and has no reserved names */
 		for (reserved = reserved_names; *reserved; reserved++)
-			if (!strncmp(res,*reserved,8)) return -EINVAL;
+			if (!strncmp(res, *reserved, 8))
+				return -EINVAL;
 	return 0;
 }
 
@@ -121,12 +145,13 @@ static int msdos_find(struct inode *dir,
 	int res;
 
 	dotsOK = MSDOS_SB(dir->i_sb)->options.dotsOK;
-	res = msdos_format_name(name,len, msdos_name,&MSDOS_SB(dir->i_sb)->options);
+	res = msdos_format_name(name, len, msdos_name,
+				&MSDOS_SB(dir->i_sb)->options);
 	if (res < 0)
 		return -ENOENT;
 	res = fat_scan(dir, msdos_name, bh, de, i_pos);
 	if (!res && dotsOK) {
-		if (name[0]=='.') {
+		if (name[0] == '.') {
 			if (!((*de)->attr & ATTR_HIDDEN))
 				res = -ENOENT;
 		} else {
@@ -145,10 +170,10 @@ static int msdos_find(struct inode *dir,
  */
 static int msdos_hash(struct dentry *dentry, struct qstr *qstr)
 {
-	struct fat_mount_options *options = & (MSDOS_SB(dentry->d_sb)->options);
+	struct fat_mount_options *options = &MSDOS_SB(dentry->d_sb)->options;
 	unsigned char msdos_name[MSDOS_NAME];
 	int error;
-	
+
 	error = msdos_format_name(qstr->name, qstr->len, msdos_name, options);
 	if (!error)
 		qstr->hash = full_name_hash(msdos_name, MSDOS_NAME);
@@ -161,7 +186,7 @@ static int msdos_hash(struct dentry *den
  */
 static int msdos_cmp(struct dentry *dentry, struct qstr *a, struct qstr *b)
 {
-	struct fat_mount_options *options = & (MSDOS_SB(dentry->d_sb)->options);
+	struct fat_mount_options *options = &MSDOS_SB(dentry->d_sb)->options;
 	unsigned char a_msdos_name[MSDOS_NAME], b_msdos_name[MSDOS_NAME];
 	int error;
 
@@ -182,7 +207,6 @@ old_compare:
 	goto out;
 }
 
-
 static struct dentry_operations msdos_dentry_operations = {
 	.d_hash		= msdos_hash,
 	.d_compare	= msdos_cmp,
@@ -194,7 +218,7 @@ static struct dentry_operations msdos_de
 
 /***** Get inode using directory and name */
 static struct dentry *msdos_lookup(struct inode *dir, struct dentry *dentry,
-		struct nameidata *nd)
+				   struct nameidata *nd)
 {
 	struct super_block *sb = dir->i_sb;
 	struct inode *inode = NULL;
@@ -202,7 +226,7 @@ static struct dentry *msdos_lookup(struc
 	struct buffer_head *bh = NULL;
 	loff_t i_pos;
 	int res;
-	
+
 	dentry->d_op = &msdos_dentry_operations;
 
 	lock_kernel();
@@ -260,7 +284,7 @@ static int msdos_add_entry(struct inode 
 
 /***** Create a file */
 static int msdos_create(struct inode *dir, struct dentry *dentry, int mode,
-		struct nameidata *nd)
+			struct nameidata *nd)
 {
 	struct super_block *sb = dir->i_sb;
 	struct buffer_head *bh;
@@ -271,19 +295,19 @@ static int msdos_create(struct inode *di
 	unsigned char msdos_name[MSDOS_NAME];
 
 	lock_kernel();
-	res = msdos_format_name(dentry->d_name.name,dentry->d_name.len,
+	res = msdos_format_name(dentry->d_name.name, dentry->d_name.len,
 				msdos_name, &MSDOS_SB(sb)->options);
 	if (res < 0) {
 		unlock_kernel();
 		return res;
 	}
-	is_hid = (dentry->d_name.name[0]=='.') && (msdos_name[0]!='.');
+	is_hid = (dentry->d_name.name[0] == '.') && (msdos_name[0] != '.');
 	/* Have to do it due to foo vs. .foo conflicts */
 	if (fat_scan(dir, msdos_name, &bh, &de, &i_pos) >= 0) {
 		brelse(bh);
 		unlock_kernel();
 		return -EINVAL;
- 	}
+	}
 	inode = NULL;
 	res = msdos_add_entry(dir, msdos_name, &bh, &de, &i_pos, 0, is_hid);
 	if (res) {
@@ -349,18 +373,18 @@ static int msdos_mkdir(struct inode *dir
 	struct buffer_head *bh;
 	struct msdos_dir_entry *de;
 	struct inode *inode;
-	int res,is_hid;
+	int res, is_hid;
 	unsigned char msdos_name[MSDOS_NAME];
 	loff_t i_pos;
 
 	lock_kernel();
-	res = msdos_format_name(dentry->d_name.name,dentry->d_name.len,
+	res = msdos_format_name(dentry->d_name.name, dentry->d_name.len,
 				msdos_name, &MSDOS_SB(sb)->options);
 	if (res < 0) {
 		unlock_kernel();
 		return res;
 	}
-	is_hid = (dentry->d_name.name[0]=='.') && (msdos_name[0]!='.');
+	is_hid = (dentry->d_name.name[0] == '.') && (msdos_name[0] != '.');
 	/* foo vs .foo situation */
 	if (fat_scan(dir, msdos_name, &bh, &de, &i_pos) >= 0)
 		goto out_exist;
@@ -376,7 +400,7 @@ static int msdos_mkdir(struct inode *dir
 	res = 0;
 
 	dir->i_nlink++;
-	inode->i_nlink = 2; /* no need to mark them dirty */
+	inode->i_nlink = 2;	/* no need to mark them dirty */
 
 	res = fat_new_dir(inode, dir, 0);
 	if (res)
@@ -440,14 +464,16 @@ unlink_done:
 }
 
 static int do_msdos_rename(struct inode *old_dir, unsigned char *old_name,
-    struct dentry *old_dentry,
-    struct inode *new_dir, unsigned char *new_name, struct dentry *new_dentry,
-    struct buffer_head *old_bh,
-    struct msdos_dir_entry *old_de, loff_t old_i_pos, int is_hid)
-{
-	struct buffer_head *new_bh=NULL,*dotdot_bh=NULL;
-	struct msdos_dir_entry *new_de,*dotdot_de;
-	struct inode *old_inode,*new_inode;
+			   struct dentry *old_dentry,
+			   struct inode *new_dir, unsigned char *new_name,
+			   struct dentry *new_dentry,
+			   struct buffer_head *old_bh,
+			   struct msdos_dir_entry *old_de, loff_t old_i_pos,
+			   int is_hid)
+{
+	struct buffer_head *new_bh = NULL, *dotdot_bh = NULL;
+	struct msdos_dir_entry *new_de, *dotdot_de;
+	struct inode *old_inode, *new_inode;
 	loff_t new_i_pos, dotdot_i_pos;
 	int error;
 	int is_dir;
@@ -456,8 +482,8 @@ static int do_msdos_rename(struct inode 
 	new_inode = new_dentry->d_inode;
 	is_dir = S_ISDIR(old_inode->i_mode);
 
-	if (fat_scan(new_dir, new_name, &new_bh, &new_de, &new_i_pos) >= 0
-	    && !new_inode)
+	if (fat_scan(new_dir, new_name, &new_bh, &new_de, &new_i_pos) >= 0 &&
+	    !new_inode)
 		goto degenerate_case;
 	if (is_dir) {
 		if (new_inode) {
@@ -502,7 +528,8 @@ static int do_msdos_rename(struct inode 
 	}
 	if (dotdot_bh) {
 		dotdot_de->start = cpu_to_le16(MSDOS_I(new_dir)->i_logstart);
-		dotdot_de->starthi = cpu_to_le16((MSDOS_I(new_dir)->i_logstart) >> 16);
+		dotdot_de->starthi =
+			cpu_to_le16((MSDOS_I(new_dir)->i_logstart) >> 16);
 		mark_buffer_dirty(dotdot_bh);
 		old_dir->i_nlink--;
 		mark_inode_dirty(old_dir);
@@ -522,7 +549,7 @@ out:
 
 degenerate_case:
 	error = -EINVAL;
-	if (new_de!=old_de)
+	if (new_de != old_de)
 		goto out;
 	if (is_hid)
 		MSDOS_I(old_inode)->i_attrs |= ATTR_HIDDEN;
@@ -537,7 +564,7 @@ degenerate_case:
 
 /***** Rename, a wrapper for rename_same_dir & rename_diff_dir */
 static int msdos_rename(struct inode *old_dir, struct dentry *old_dentry,
-		struct inode *new_dir, struct dentry *new_dentry)
+			struct inode *new_dir, struct dentry *new_dentry)
 {
 	struct buffer_head *old_bh;
 	struct msdos_dir_entry *old_de;
@@ -547,18 +574,21 @@ static int msdos_rename(struct inode *ol
 
 	lock_kernel();
 	error = msdos_format_name(old_dentry->d_name.name,
-				  old_dentry->d_name.len,old_msdos_name,
+				  old_dentry->d_name.len, old_msdos_name,
 				  &MSDOS_SB(old_dir->i_sb)->options);
 	if (error < 0)
 		goto rename_done;
 	error = msdos_format_name(new_dentry->d_name.name,
-				  new_dentry->d_name.len,new_msdos_name,
+				  new_dentry->d_name.len, new_msdos_name,
 				  &MSDOS_SB(new_dir->i_sb)->options);
 	if (error < 0)
 		goto rename_done;
 
-	is_hid  = (new_dentry->d_name.name[0]=='.') && (new_msdos_name[0]!='.');
-	old_hid = (old_dentry->d_name.name[0]=='.') && (old_msdos_name[0]!='.');
+	is_hid =
+	     (new_dentry->d_name.name[0] == '.') && (new_msdos_name[0] != '.');
+	old_hid =
+	     (old_dentry->d_name.name[0] == '.') && (old_msdos_name[0] != '.');
+
 	error = fat_scan(old_dir, old_msdos_name, &old_bh, &old_de, &old_i_pos);
 	if (error < 0)
 		goto rename_done;
@@ -583,7 +613,7 @@ static struct inode_operations msdos_dir
 	.setattr	= fat_notify_change,
 };
 
-static int msdos_fill_super(struct super_block *sb,void *data, int silent)
+static int msdos_fill_super(struct super_block *sb, void *data, int silent)
 {
 	int res;
 
@@ -596,7 +626,8 @@ static int msdos_fill_super(struct super
 }
 
 static struct super_block *msdos_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+					int flags, const char *dev_name,
+					void *data)
 {
 	return get_sb_bdev(fs_type, flags, dev_name, data, msdos_fill_super);
 }
_
