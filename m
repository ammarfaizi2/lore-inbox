Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262364AbVAQR7p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262364AbVAQR7p (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 12:59:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261274AbVAQR7p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 12:59:45 -0500
Received: from mail.parknet.co.jp ([210.171.160.6]:15881 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP id S262820AbVAQRtd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 12:49:33 -0500
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 10/13] FAT: Lindent fs/vfat/namei.c
References: <87pt04oszi.fsf@devron.myhome.or.jp>
	<87llasosxu.fsf@devron.myhome.or.jp>
	<87hdlgoswe.fsf_-_@devron.myhome.or.jp>
	<87d5w4osuv.fsf_-_@devron.myhome.or.jp>
	<878y6sostl.fsf_-_@devron.myhome.or.jp>
	<874qhgosrf.fsf_-_@devron.myhome.or.jp>
	<87zmz8ne5p.fsf_-_@devron.myhome.or.jp>
	<877jmcne0o.fsf_-_@devron.myhome.or.jp>
	<873bx0ndze.fsf_-_@devron.myhome.or.jp>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 18 Jan 2005 02:49:21 +0900
In-Reply-To: <873bx0ndze.fsf_-_@devron.myhome.or.jp> (OGAWA Hirofumi's
 message of "Tue, 18 Jan 2005 02:48:37 +0900")
Message-ID: <87y8eslzdq.fsf_-_@devron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/21.3.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Signed-off-by: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
---

 fs/vfat/namei.c |  225 ++++++++++++++++++++++++++++----------------------------
 1 files changed, 113 insertions(+), 112 deletions(-)

diff -puN fs/vfat/namei.c~fat_lindent-vfat fs/vfat/namei.c
--- linux-2.6.10/fs/vfat/namei.c~fat_lindent-vfat	2005-01-10 01:57:31.000000000 +0900
+++ linux-2.6.10-hirofumi/fs/vfat/namei.c	2005-01-10 01:57:44.000000000 +0900
@@ -12,7 +12,7 @@
  *  Short name translation 1999, 2001 by Wolfram Pienkoss <wp@bszh.de>
  *
  *  Support Multibyte character and cleanup by
- *  				OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
+ *				OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
  */
 
 #include <linux/module.h>
@@ -25,33 +25,6 @@
 #include <linux/buffer_head.h>
 #include <linux/namei.h>
 
-static int vfat_hashi(struct dentry *parent, struct qstr *qstr);
-static int vfat_hash(struct dentry *parent, struct qstr *qstr);
-static int vfat_cmpi(struct dentry *dentry, struct qstr *a, struct qstr *b);
-static int vfat_cmp(struct dentry *dentry, struct qstr *a, struct qstr *b);
-static int vfat_revalidate(struct dentry *dentry, struct nameidata *nd);
-
-static struct dentry_operations vfat_dentry_ops[4] = {
-	{
-		.d_hash		= vfat_hashi,
-		.d_compare	= vfat_cmpi,
-	},
-	{
-		.d_revalidate	= vfat_revalidate,
-		.d_hash		= vfat_hashi,
-		.d_compare	= vfat_cmpi,
-	},
-	{
-		.d_hash		= vfat_hash,
-		.d_compare	= vfat_cmp,
-	},
-	{
-		.d_revalidate	= vfat_revalidate,
-		.d_hash		= vfat_hash,
-		.d_compare	= vfat_cmp,
-	}
-};
-
 static int vfat_revalidate(struct dentry *dentry, struct nameidata *nd)
 {
 	int ret = 1;
@@ -78,9 +51,8 @@ static unsigned int vfat_striptail_len(s
 {
 	unsigned int len = qstr->len;
 
-	while (len && qstr->name[len-1] == '.')
+	while (len && qstr->name[len - 1] == '.')
 		len--;
-
 	return len;
 }
 
@@ -93,7 +65,6 @@ static unsigned int vfat_striptail_len(s
 static int vfat_hash(struct dentry *dentry, struct qstr *qstr)
 {
 	qstr->hash = full_name_hash(qstr->name, vfat_striptail_len(qstr));
-
 	return 0;
 }
 
@@ -156,6 +127,27 @@ static int vfat_cmp(struct dentry *dentr
 	return 1;
 }
 
+static struct dentry_operations vfat_dentry_ops[4] = {
+	{
+		.d_hash		= vfat_hashi,
+		.d_compare	= vfat_cmpi,
+	},
+	{
+		.d_revalidate	= vfat_revalidate,
+		.d_hash		= vfat_hashi,
+		.d_compare	= vfat_cmpi,
+	},
+	{
+		.d_hash		= vfat_hash,
+		.d_compare	= vfat_cmp,
+	},
+	{
+		.d_revalidate	= vfat_revalidate,
+		.d_hash		= vfat_hash,
+		.d_compare	= vfat_cmp,
+	}
+};
+
 /* Characters that are undesirable in an MS-DOS file name */
 
 static inline wchar_t vfat_bad_char(wchar_t w)
@@ -183,7 +175,7 @@ static wchar_t vfat_skip_char(wchar_t w)
 static inline int vfat_is_used_badchars(const wchar_t *s, int len)
 {
 	int i;
-	
+
 	for (i = 0; i < len; i++)
 		if (vfat_bad_char(s[i]))
 			return -EINVAL;
@@ -231,7 +223,7 @@ static int vfat_find_form(struct inode *
 	return 0;
 }
 
-/* 
+/*
  * 1) Valid characters for the 8.3 format alias are any combination of
  * letters, uppercase alphabets, digits, any of the
  * following special characters:
@@ -241,11 +233,11 @@ static int vfat_find_form(struct inode *
  * WinNT's Extension:
  * File name and extension name is contain uppercase/lowercase
  * only. And it is expressed by CASE_LOWER_BASE and CASE_LOWER_EXT.
- *     
+ *
  * 2) File name is 8.3 format, but it contain the uppercase and
  * lowercase char, muliti bytes char, etc. In this case numtail is not
  * added, but Longfilename is stored.
- * 
+ *
  * 3) When the one except for the above, or the following special
  * character are contained:
  *        .   [ ] ; , + =
@@ -263,8 +255,8 @@ struct shortname_info {
 } while (0)
 
 static inline int to_shortname_char(struct nls_table *nls,
-				    unsigned char *buf, int buf_size, wchar_t *src,
-				    struct shortname_info *info)
+				    unsigned char *buf, int buf_size,
+				    wchar_t *src, struct shortname_info *info)
 {
 	int len;
 
@@ -277,7 +269,7 @@ static inline int to_shortname_char(stru
 		buf[0] = '_';
 		return 1;
 	}
-	
+
 	len = nls->uni2char(*src, buf, buf_size);
 	if (len <= 0) {
 		info->valid = 0;
@@ -302,7 +294,7 @@ static inline int to_shortname_char(stru
 		info->lower = 0;
 		info->upper = 0;
 	}
-	
+
 	return len;
 }
 
@@ -332,7 +324,7 @@ static int vfat_create_shortname(struct 
 	/* Now, we need to create a shortname from the long name */
 	ext_start = end = &uname[ulen];
 	while (--ext_start >= uname) {
-		if (*ext_start == 0x002E) { /* is `.' */
+		if (*ext_start == 0x002E) {	/* is `.' */
 			if (ext_start == end - 1) {
 				sz = ulen;
 				ext_start = NULL;
@@ -361,7 +353,7 @@ static int vfat_create_shortname(struct 
 			ext_start++;
 		} else {
 			sz = ulen;
-			ext_start=NULL;
+			ext_start = NULL;
 		}
 	}
 
@@ -377,7 +369,7 @@ static int vfat_create_shortname(struct 
 			numtail2_baselen = baselen;
 		if (baselen < 6 && (baselen + chl) > 6)
 			numtail_baselen = baselen;
-		for (chi = 0; chi < chl; chi++){
+		for (chi = 0; chi < chl; chi++) {
 			*p++ = charbuf[chi];
 			baselen++;
 			if (baselen >= 8)
@@ -452,7 +444,7 @@ static int vfat_create_shortname(struct 
 			BUG();
 		}
 	}
-	
+
 	if (MSDOS_SB(dir->i_sb)->options.numtail == 0)
 		if (vfat_find_form(dir, name_res) < 0)
 			return 0;
@@ -465,25 +457,25 @@ static int vfat_create_shortname(struct 
 	 * values for part of the base.
 	 */
 
-	if (baselen>6) {
+	if (baselen > 6) {
 		baselen = numtail_baselen;
 		name_res[7] = ' ';
 	}
 	name_res[baselen] = '~';
 	for (i = 1; i < 10; i++) {
-		name_res[baselen+1] = i + '0';
+		name_res[baselen + 1] = i + '0';
 		if (vfat_find_form(dir, name_res) < 0)
 			return 0;
 	}
 
 	i = jiffies & 0xffff;
 	sz = (jiffies >> 16) & 0x7;
-	if (baselen>2) {
+	if (baselen > 2) {
 		baselen = numtail2_baselen;
 		name_res[7] = ' ';
 	}
-	name_res[baselen+4] = '~';
-	name_res[baselen+5] = '1' + sz;
+	name_res[baselen + 4] = '~';
+	name_res[baselen + 5] = '1' + sz;
 	while (1) {
 		sprintf(buf, "%04X", i);
 		memcpy(&name_res[baselen], buf, 4);
@@ -516,13 +508,14 @@ xlate_to_uni(const unsigned char *name, 
 		 * We stripped '.'s before and set len appropriately,
 		 * but utf8_mbstowcs doesn't care about len
 		 */
-		*outlen -= (name_len-len);
+		*outlen -= (name_len - len);
 
 		op = &outname[*outlen * sizeof(wchar_t)];
 	} else {
 		if (nls) {
 			for (i = 0, ip = name, op = outname, *outlen = 0;
-			     i < len && *outlen <= 260; *outlen += 1)
+			     i < len && *outlen <= 260;
+			     *outlen += 1)
 			{
 				if (escape && (*ip == ':')) {
 					if (i > len - 5)
@@ -550,7 +543,7 @@ xlate_to_uni(const unsigned char *name, 
 					ip += 5;
 					i += 5;
 				} else {
-					if ((charlen = nls->char2uni(ip, len-i, (wchar_t *)op)) < 0)
+					if ((charlen = nls->char2uni(ip, len - i, (wchar_t *)op)) < 0)
 						return -EINVAL;
 					ip += charlen;
 					i += charlen;
@@ -559,7 +552,8 @@ xlate_to_uni(const unsigned char *name, 
 			}
 		} else {
 			for (i = 0, ip = name, op = outname, *outlen = 0;
-			     i < len && *outlen <= 260; i++, *outlen += 1)
+			     i < len && *outlen <= 260;
+			     i++, *outlen += 1)
 			{
 				*op++ = *ip++;
 				*op++ = 0;
@@ -607,7 +601,8 @@ static int vfat_build_slots(struct inode
 	if (res)
 		return res;
 
-	if(!(page = __get_free_page(GFP_KERNEL)))
+	page = __get_free_page(GFP_KERNEL);
+	if (!page)
 		return -ENOMEM;
 
 	uname = (wchar_t *)page;
@@ -632,9 +627,8 @@ static int vfat_build_slots(struct inode
 
 	/* build the entry of long file name */
 	*slots = usize / 13;
-	for (cksum = i = 0; i < 11; i++) {
+	for (cksum = i = 0; i < 11; i++)
 		cksum = (((cksum&1)<<7)|((cksum&0xfe)>>1)) + msdos_name[i];
-	}
 
 	for (ps = ds, slot = *slots; slot > 0; slot--, ps++) {
 		ps->id = slot;
@@ -648,7 +642,7 @@ static int vfat_build_slots(struct inode
 		fatwchar_to16(ps->name11_12, uname + offset + 11, 2);
 	}
 	ds[0].id |= 0x40;
-	de = (struct msdos_dir_entry *) ps;
+	de = (struct msdos_dir_entry *)ps;
 
 shortname:
 	/* build the entry of 8.3 alias name */
@@ -668,7 +662,7 @@ out_free:
 	return res;
 }
 
-static int vfat_add_entry(struct inode *dir,struct qstr* qname,
+static int vfat_add_entry(struct inode *dir, struct qstr *qname,
 			  int is_dir, struct vfat_slot_info *sinfo_out,
 			  struct buffer_head **bh, struct msdos_dir_entry **de)
 {
@@ -684,8 +678,7 @@ static int vfat_add_entry(struct inode *
 	if (len == 0)
 		return -ENOENT;
 
-	dir_slots =
-	       kmalloc(sizeof(struct msdos_dir_slot) * MSDOS_SLOTS, GFP_KERNEL);
+	dir_slots = kmalloc(sizeof(*dir_slots) * MSDOS_SLOTS, GFP_KERNEL);
 	if (dir_slots == NULL)
 		return -ENOMEM;
 
@@ -695,7 +688,8 @@ static int vfat_add_entry(struct inode *
 		goto cleanup;
 
 	/* build the empty directory entry of number of slots */
-	offset = fat_add_entries(dir, slots, &dummy_bh, &dummy_de, &dummy_i_pos);
+	offset =
+	    fat_add_entries(dir, slots, &dummy_bh, &dummy_de, &dummy_i_pos);
 	if (offset < 0) {
 		res = offset;
 		goto cleanup;
@@ -735,9 +729,9 @@ cleanup:
 	return res;
 }
 
-static int vfat_find(struct inode *dir,struct qstr* qname,
-	struct vfat_slot_info *sinfo, struct buffer_head **last_bh,
-	struct msdos_dir_entry **last_de)
+static int vfat_find(struct inode *dir, struct qstr *qname,
+		     struct vfat_slot_info *sinfo, struct buffer_head **last_bh,
+		     struct msdos_dir_entry **last_de)
 {
 	struct super_block *sb = dir->i_sb;
 	loff_t offset;
@@ -751,17 +745,17 @@ static int vfat_find(struct inode *dir,s
 	res = fat_search_long(dir, qname->name, len,
 			      (MSDOS_SB(sb)->options.name_check != 's'),
 			      &offset, &sinfo->longname_offset);
-	if (res>0) {
-		sinfo->long_slots = res-1;
-		if (fat_get_entry(dir,&offset,last_bh,last_de,&sinfo->i_pos)>=0)
+	if (res > 0) {
+		sinfo->long_slots = res - 1;
+		if (fat_get_entry(dir, &offset, last_bh, last_de, &sinfo->i_pos) >= 0)
 			return 0;
 		res = -EIO;
-	} 
+	}
 	return res ? res : -ENOENT;
 }
 
 static struct dentry *vfat_lookup(struct inode *dir, struct dentry *dentry,
-		struct nameidata *nd)
+				  struct nameidata *nd)
 {
 	int res;
 	struct vfat_slot_info sinfo;
@@ -770,13 +764,13 @@ static struct dentry *vfat_lookup(struct
 	struct buffer_head *bh = NULL;
 	struct msdos_dir_entry *de;
 	int table;
-	
+
 	lock_kernel();
 	table = (MSDOS_SB(dir->i_sb)->options.name_check == 's') ? 2 : 0;
 	dentry->d_op = &vfat_dentry_ops[table];
 
 	inode = NULL;
-	res = vfat_find(dir,&dentry->d_name,&sinfo,&bh,&de);
+	res = vfat_find(dir, &dentry->d_name, &sinfo, &bh, &de);
 	if (res < 0) {
 		table++;
 		goto error;
@@ -789,14 +783,14 @@ static struct dentry *vfat_lookup(struct
 	}
 	alias = d_find_alias(inode);
 	if (alias) {
-		if (d_invalidate(alias)==0)
+		if (d_invalidate(alias) == 0)
 			dput(alias);
 		else {
 			iput(inode);
 			unlock_kernel();
 			return alias;
 		}
-		
+
 	}
 error:
 	unlock_kernel();
@@ -810,8 +804,8 @@ error:
 	return dentry;
 }
 
-static int vfat_create(struct inode *dir, struct dentry* dentry, int mode,
-		struct nameidata *nd)
+static int vfat_create(struct inode *dir, struct dentry *dentry, int mode,
+		       struct nameidata *nd)
 {
 	struct super_block *sb = dir->i_sb;
 	struct inode *inode = NULL;
@@ -834,14 +828,15 @@ static int vfat_create(struct inode *dir
 	inode->i_version++;
 	dir->i_version++;
 	dentry->d_time = dentry->d_parent->d_inode->i_version;
-	d_instantiate(dentry,inode);
+	d_instantiate(dentry, inode);
 out:
 	unlock_kernel();
 	return res;
 }
 
-static void vfat_remove_entry(struct inode *dir,struct vfat_slot_info *sinfo,
-     struct buffer_head *bh, struct msdos_dir_entry *de)
+static void vfat_remove_entry(struct inode *dir, struct vfat_slot_info *sinfo,
+			      struct buffer_head *bh,
+			      struct msdos_dir_entry *de)
 {
 	loff_t offset, i_pos;
 	int i;
@@ -853,7 +848,8 @@ static void vfat_remove_entry(struct ino
 	de->name[0] = DELETED_FLAG;
 	mark_buffer_dirty(bh);
 	/* remove the longname */
-	offset = sinfo->longname_offset; de = NULL;
+	offset = sinfo->longname_offset;
+	de = NULL;
 	for (i = sinfo->long_slots; i > 0; --i) {
 		if (fat_get_entry(dir, &offset, &bh, &de, &i_pos) < 0)
 			continue;
@@ -864,28 +860,30 @@ static void vfat_remove_entry(struct ino
 	brelse(bh);
 }
 
-static int vfat_rmdir(struct inode *dir, struct dentry* dentry)
+static int vfat_rmdir(struct inode *dir, struct dentry *dentry)
 {
-	int res;
+	struct inode *inode = dentry->d_inode;
 	struct vfat_slot_info sinfo;
 	struct buffer_head *bh = NULL;
 	struct msdos_dir_entry *de;
+	int res;
 
 	lock_kernel();
-	res = fat_dir_empty(dentry->d_inode);
+	res = fat_dir_empty(inode);
 	if (res)
 		goto out;
 
-	res = vfat_find(dir,&dentry->d_name,&sinfo, &bh, &de);
+	res = vfat_find(dir, &dentry->d_name, &sinfo, &bh, &de);
 	if (res < 0)
 		goto out;
+
 	res = 0;
-	dentry->d_inode->i_nlink = 0;
-	dentry->d_inode->i_mtime = dentry->d_inode->i_atime = CURRENT_TIME_SEC;
-	fat_detach(dentry->d_inode);
-	mark_inode_dirty(dentry->d_inode);
+	inode->i_nlink = 0;
+	inode->i_mtime = inode->i_atime = CURRENT_TIME_SEC;
+	fat_detach(inode);
+	mark_inode_dirty(inode);
 	/* releases bh */
-	vfat_remove_entry(dir,&sinfo,bh,de);
+	vfat_remove_entry(dir, &sinfo, bh, de);
 	dir->i_nlink--;
 out:
 	unlock_kernel();
@@ -894,28 +892,29 @@ out:
 
 static int vfat_unlink(struct inode *dir, struct dentry *dentry)
 {
-	int res;
+	struct inode *inode = dentry->d_inode;
 	struct vfat_slot_info sinfo;
 	struct buffer_head *bh = NULL;
 	struct msdos_dir_entry *de;
+	int res;
 
 	lock_kernel();
-	res = vfat_find(dir,&dentry->d_name,&sinfo,&bh,&de);
+	res = vfat_find(dir, &dentry->d_name, &sinfo, &bh, &de);
 	if (res < 0)
 		goto out;
-	dentry->d_inode->i_nlink = 0;
-	dentry->d_inode->i_mtime = dentry->d_inode->i_atime = CURRENT_TIME_SEC;
-	fat_detach(dentry->d_inode);
-	mark_inode_dirty(dentry->d_inode);
+	inode->i_nlink = 0;
+	inode->i_mtime = inode->i_atime = CURRENT_TIME_SEC;
+	fat_detach(inode);
+	mark_inode_dirty(inode);
 	/* releases bh */
-	vfat_remove_entry(dir,&sinfo,bh,de);
+	vfat_remove_entry(dir, &sinfo, bh, de);
 out:
 	unlock_kernel();
 
 	return res;
 }
 
-static int vfat_mkdir(struct inode *dir,struct dentry* dentry,int mode)
+static int vfat_mkdir(struct inode *dir, struct dentry *dentry, int mode)
 {
 	struct super_block *sb = dir->i_sb;
 	struct inode *inode = NULL;
@@ -936,12 +935,12 @@ static int vfat_mkdir(struct inode *dir,
 	inode->i_version++;
 	dir->i_version++;
 	dir->i_nlink++;
-	inode->i_nlink = 2; /* no need to mark them dirty */
+	inode->i_nlink = 2;	/* no need to mark them dirty */
 	res = fat_new_dir(inode, dir, 1);
 	if (res < 0)
 		goto mkdir_failed;
 	dentry->d_time = dentry->d_parent->d_inode->i_version;
-	d_instantiate(dentry,inode);
+	d_instantiate(dentry, inode);
 out_brelse:
 	brelse(bh);
 out:
@@ -954,27 +953,28 @@ mkdir_failed:
 	fat_detach(inode);
 	mark_inode_dirty(inode);
 	/* releases bh */
-	vfat_remove_entry(dir,&sinfo,bh,de);
+	vfat_remove_entry(dir, &sinfo, bh, de);
 	iput(inode);
 	dir->i_nlink--;
 	goto out;
 }
- 
+
 static int vfat_rename(struct inode *old_dir, struct dentry *old_dentry,
-		struct inode *new_dir, struct dentry *new_dentry)
+		       struct inode *new_dir, struct dentry *new_dentry)
 {
-	struct buffer_head *old_bh,*new_bh,*dotdot_bh;
-	struct msdos_dir_entry *old_de,*new_de,*dotdot_de;
+	struct buffer_head *old_bh, *new_bh, *dotdot_bh;
+	struct msdos_dir_entry *old_de, *new_de, *dotdot_de;
 	loff_t dotdot_i_pos;
 	struct inode *old_inode, *new_inode;
 	int res, is_dir;
-	struct vfat_slot_info old_sinfo,sinfo;
+	struct vfat_slot_info old_sinfo, sinfo;
 
 	old_bh = new_bh = dotdot_bh = NULL;
 	old_inode = old_dentry->d_inode;
 	new_inode = new_dentry->d_inode;
 	lock_kernel();
-	res = vfat_find(old_dir,&old_dentry->d_name,&old_sinfo,&old_bh,&old_de);
+	res = vfat_find(old_dir, &old_dentry->d_name, &old_sinfo, &old_bh,
+			&old_de);
 	if (res < 0)
 		goto rename_done;
 
@@ -989,7 +989,7 @@ static int vfat_rename(struct inode *old
 	}
 
 	if (new_dentry->d_inode) {
-		res = vfat_find(new_dir,&new_dentry->d_name,&sinfo,&new_bh,
+		res = vfat_find(new_dir, &new_dentry->d_name, &sinfo, &new_bh,
 				&new_de);
 		if (res < 0 || MSDOS_I(new_inode)->i_pos != sinfo.i_pos) {
 			/* WTF??? Cry and fail. */
@@ -1004,16 +1004,17 @@ static int vfat_rename(struct inode *old
 		}
 		fat_detach(new_inode);
 	} else {
-		res = vfat_add_entry(new_dir,&new_dentry->d_name,is_dir,&sinfo,
-					&new_bh,&new_de);
-		if (res < 0) goto rename_done;
+		res = vfat_add_entry(new_dir, &new_dentry->d_name, is_dir,
+				     &sinfo, &new_bh, &new_de);
+		if (res < 0)
+			goto rename_done;
 	}
 
 	new_dir->i_version++;
 
 	/* releases old_bh */
-	vfat_remove_entry(old_dir,&old_sinfo,old_bh,old_de);
-	old_bh=NULL;
+	vfat_remove_entry(old_dir, &old_sinfo, old_bh, old_de);
+	old_bh = NULL;
 	fat_detach(old_inode);
 	fat_attach(old_inode, sinfo.i_pos);
 	mark_inode_dirty(old_inode);
@@ -1046,7 +1047,6 @@ rename_done:
 	brelse(new_bh);
 	unlock_kernel();
 	return res;
-
 }
 
 static struct inode_operations vfat_dir_inode_operations = {
@@ -1076,7 +1076,8 @@ static int vfat_fill_super(struct super_
 }
 
 static struct super_block *vfat_get_sb(struct file_system_type *fs_type,
-	int flags, const char *dev_name, void *data)
+				       int flags, const char *dev_name,
+				       void *data)
 {
 	return get_sb_bdev(fs_type, flags, dev_name, data, vfat_fill_super);
 }
_
