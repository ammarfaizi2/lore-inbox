Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261842AbVCVUKI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261842AbVCVUKI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 15:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261801AbVCVUJ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 15:09:59 -0500
Received: from mail.dif.dk ([193.138.115.101]:55985 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261937AbVCVUIE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 15:08:04 -0500
Date: Tue, 22 Mar 2005 21:09:46 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: Steve French <smfrench@austin.rr.com>
Cc: Steven French <sfrench@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH][1/6] cifs: readdir.c cleanup - whitespace part 1
Message-ID: <Pine.LNX.4.62.0503222105050.2683@dragon.hyggekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This file cleans up function definitions in fs/cifs/readdir.c to all fit 
within 80col and also have return type and function name on a single line 
as well as indenting parameters that don't fit on the first line by a 
single tab. 
This is in keeping with the style I used in fs/cifs/file.c and which you 
merged previously. It is also the style I intend to make consistent 
throughout fs/cifs/ , so if you have a problem with this style now would 
be a good time to tell me :)


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

--- linux-2.6.12-rc1-mm1-orig/fs/cifs/readdir.c	2005-03-21 23:15:43.000000000 +0100
+++ linux-2.6.12-rc1-mm1/fs/cifs/readdir.c	2005-03-22 16:07:27.000000000 +0100
@@ -31,9 +31,8 @@
 #include "cifs_fs_sb.h"
 #include "cifsfs.h"
 
-
 /* BB fixme - add debug wrappers around this function to disable it fixme BB */
-/* static void dump_cifs_file_struct(struct file * file, char * label)
+/* static void dump_cifs_file_struct(struct file *file, char *label)
 {
 	struct cifsFileInfo * cf;
 
@@ -59,7 +58,7 @@
 /* Returns one if new inode created (which therefore needs to be hashed) */
 /* Might check in the future if inode number changed so we can rehash inode */
 static int construct_dentry(struct qstr *qstring, struct file *file,
-                 struct inode **ptmp_inode, struct dentry **pnew_dentry)
+	struct inode **ptmp_inode, struct dentry **pnew_dentry)
 {
 	struct dentry *tmp_dentry;
 	struct cifs_sb_info *cifs_sb;
@@ -106,7 +105,7 @@ static int construct_dentry(struct qstr 
 }
 
 static void fill_in_inode(struct inode *tmp_inode,
-	      FILE_DIRECTORY_INFO * pfindData, int *pobject_type)
+	FILE_DIRECTORY_INFO *pfindData, int *pobject_type)
 {
 	struct cifsInodeInfo *cifsInfo = CIFS_I(tmp_inode);
 	struct cifs_sb_info *cifs_sb = CIFS_SB(tmp_inode->i_sb);
@@ -195,7 +194,7 @@ static void fill_in_inode(struct inode *
 }
 
 static void unix_fill_in_inode(struct inode *tmp_inode,
-		   FILE_UNIX_INFO * pfindData, int *pobject_type)
+	FILE_UNIX_INFO *pfindData, int *pobject_type)
 {
 	struct cifsInodeInfo *cifsInfo = CIFS_I(tmp_inode);
 	__u32 type = le32_to_cpu(pfindData->Type);
@@ -273,8 +272,7 @@ static void unix_fill_in_inode(struct in
 	}
 }
 
-
-static int initiate_cifs_search(const int xid, struct file * file)
+static int initiate_cifs_search(const int xid, struct file *file)
 {
 	int rc = 0;
 	char * full_path;
@@ -336,7 +334,7 @@ static int initiate_cifs_search(const in
 }
 
 /* return length of unicode string in bytes */
-static int cifs_unicode_bytelen(char * str)
+static int cifs_unicode_bytelen(char *str)
 {
 	int len;
 	__le16 * ustr = (__le16 *)str;
@@ -349,7 +347,7 @@ static int cifs_unicode_bytelen(char * s
 	return len << 1;
 }
 
-static char * nxt_dir_entry(char * old_entry, char * end_of_smb)
+static char *nxt_dir_entry(char *old_entry, char *end_of_smb)
 {
 	char * new_entry;
 	FILE_DIRECTORY_INFO * pDirInfo = (FILE_DIRECTORY_INFO *)old_entry;
@@ -369,7 +367,7 @@ static char * nxt_dir_entry(char * old_e
 #define UNICODE_DOT cpu_to_le16(0x2e)
 
 /* return 0 if no match and 1 for . (current directory) and 2 for .. (parent) */
-static int cifs_entry_is_dot(char * current_entry, struct cifsFileInfo * cfile)
+static int cifs_entry_is_dot(char *current_entry, struct cifsFileInfo *cfile)
 {
 	int rc = 0;
 	char * filename = NULL;
@@ -441,8 +439,8 @@ static int cifs_entry_is_dot(char * curr
    assume that they are located in the findfirst return buffer.*/
 /* We start counting in the buffer with entry 2 and increment for every
    entry (do not increment for . or .. entry) */
-static int find_cifs_entry(const int xid, struct cifsTconInfo * pTcon, 
-		struct file * file, char ** ppCurrentEntry,int * num_to_ret) 
+static int find_cifs_entry(const int xid, struct cifsTconInfo *pTcon,
+	struct file *file, char **ppCurrentEntry, int *num_to_ret) 
 {
 	int rc = 0;
 	int pos_in_buf = 0;
@@ -534,9 +532,9 @@ static int find_cifs_entry(const int xid
 }
 
 /* inode num, inode type and filename returned */
-static int cifs_get_name_from_search_buf(struct qstr * pqst,char * current_entry,
-			__u16 level,unsigned int unicode,struct nls_table * nlt,
-			ino_t * pinum)
+static int cifs_get_name_from_search_buf(struct qstr *pqst,
+	char *current_entry, __u16 level, unsigned int unicode,
+	struct nls_table *nlt, ino_t *pinum)
 {
 	int rc = 0;
 	unsigned int len = 0;
@@ -595,10 +593,8 @@ static int cifs_get_name_from_search_buf
 	return rc;
 }
 
-
-static int
-cifs_filldir(char * pfindEntry, struct file *file, 
-			  filldir_t filldir, void *direntry,char * scratch_buf)
+static int cifs_filldir(char *pfindEntry, struct file *file,
+	filldir_t filldir, void *direntry, char *scratch_buf)
 {
 	int rc = 0;
 	struct qstr qstring;
@@ -662,7 +658,8 @@ cifs_filldir(char * pfindEntry, struct f
 	return rc;
 }
 
-static int cifs_save_resume_key(const char * current_entry,struct cifsFileInfo * cifsFile)
+static int cifs_save_resume_key(const char *current_entry,
+	struct cifsFileInfo *cifsFile)
 {
 	int rc = 0;
 	unsigned int len = 0;
@@ -848,4 +845,3 @@ rddir2_exit:
 	FreeXid(xid);
 	return rc;
 }
-


