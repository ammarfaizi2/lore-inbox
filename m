Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261320AbVFAWc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbVFAWc2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 18:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbVFAWc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 18:32:28 -0400
Received: from ms-smtp-02.texas.rr.com ([24.93.47.41]:32503 "EHLO
	ms-smtp-02-eri0.texas.rr.com") by vger.kernel.org with ESMTP
	id S261320AbVFAW0Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 18:26:16 -0400
Message-ID: <429E3574.8080207@austin.rr.com>
Date: Wed, 01 Jun 2005 17:23:48 -0500
From: Steve French <smfrench@austin.rr.com>
User-Agent: Mozilla Thunderbird  (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: torvalds@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: [GIT] cifs fixes
Content-Type: multipart/mixed;
 boundary="------------070809040500050400000601"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------070809040500050400000601
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Linus,

Please pull from:
     
rsync://rsync.kernel.org/pub/scm/linux/kernel/git/sfrench/cifs-2.6.git/HEAD


This will update the following files:
 cifs/README      |    4 +--
 cifs/cifsproto.h |    2 -
 cifs/cifssmb.c   |   56 
+++++++++++++++++++++++++++----------------------------
 cifs/dir.c       |    3 +-
 cifs/inode.c     |   24 ++++++++++++++---------
 cifs/misc.c      |    1
 6 files changed, 49 insertions(+), 41 deletions(-)

commit b1a45695bde0204597957e448923f09ce271ca80
tree 96e82946fffd1105741dc99c886d92753ddac0ee
parent b2aeb9d565be5ef00fb9f921c6d2459c74d90cdf
author Steve French <stevef@stevef95> Tue, 17 May 2005 16:07:23 -0500
committer Steve French <stevef@stevef95> Tue, 17 May 2005 16:07:23 -0500

    [CIFS] fix casts of unicode strings to match function definition

    Signed-off-by: Steve French (sfrench@us.ibm.com)

commit b2aeb9d565be5ef00fb9f921c6d2459c74d90cdf
tree e7adab50ce6a13ef5ceb0fbb3d1208ae63523dc9
parent 67594feb4b68074d8807f5566536e06db9130679
author Steve French <stevef@stevef95> Tue, 17 May 2005 13:16:18 -0500
committer Steve French <stevef@stevef95> Tue, 17 May 2005 13:16:18 -0500

    [CIFS] Fix oops in cifs_unlink.  Caused in some cases when renaming 
over existing,
    newly created, file.

    Samba bugzilla: 2697

    Signed-off-by: Steve French (sfrench@us.ibm.com)

commit 67594feb4b68074d8807f5566536e06db9130679
tree 7360879062daf210285ab0a72be22eb26c2565e3
parent ff0d2f90fdc4b564d47a7c26b16de81a16cfa28e
author Steve French <stevef@stevef95> Tue, 17 May 2005 13:04:49 -0500
committer Steve French <stevef@stevef95> Tue, 17 May 2005 13:04:49 -0500

    [CIFS] missing break needed to handle < when mount option "mapchars" 
specified

    Signed-off-by: Steve French (sfrench@us.ibm.com)

The diff also is attached

--------------070809040500050400000601
Content-Type: text/x-patch;
 name="cifs.134b.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cifs.134b.diff"

Index: fs/cifs/README
===================================================================
--- d414ab9a0f0995899c2e76c232714410f787b209/fs/cifs/README  (mode:100644)
+++ uncommitted/fs/cifs/README  (mode:100644)
@@ -371,7 +371,7 @@
 		on newly created files, directories, and devices (create, 
 		mkdir, mknod) which will result in the server setting the
 		uid and gid to the default (usually the server uid of the
-		usern who mounted the share).  Letting the server (rather than
+		user who mounted the share).  Letting the server (rather than
 		the client) set the uid and gid is the default. This
 		parameter has no effect if the CIFS Unix Extensions are not
 		negotiated.
@@ -384,7 +384,7 @@
 		client (e.g. when the application is doing large sequential
 		reads bigger than page size without rereading the same data) 
 		this can provide better performance than the default
-		behavior which caches reads (reaadahead) and writes 
+		behavior which caches reads (readahead) and writes 
 		(writebehind) through the local Linux client pagecache 
 		if oplock (caching token) is granted and held. Note that
 		direct allows write operations larger than page size
Index: fs/cifs/cifsproto.h
===================================================================
--- d414ab9a0f0995899c2e76c232714410f787b209/fs/cifs/cifsproto.h  (mode:100644)
+++ uncommitted/fs/cifs/cifsproto.h  (mode:100644)
@@ -228,7 +228,7 @@
 			const struct nls_table *nls_codepage, 
 			int remap_special_chars);
 #endif /* CONFIG_CIFS_EXPERIMENTAL */
-extern int cifs_convertUCSpath(char *target, const __u16 *source, int maxlen,
+extern int cifs_convertUCSpath(char *target, const __le16 *source, int maxlen,
 			const struct nls_table * codepage);
 extern int cifsConvertToUCS(__le16 * target, const char *source, int maxlen,
 			const struct nls_table * cp, int mapChars);
Index: fs/cifs/cifssmb.c
===================================================================
--- d414ab9a0f0995899c2e76c232714410f787b209/fs/cifs/cifssmb.c  (mode:100644)
+++ uncommitted/fs/cifs/cifssmb.c  (mode:100644)
@@ -567,7 +567,7 @@
 
 	if (pSMB->hdr.Flags2 & SMBFLG2_UNICODE) {
 		name_len =
-		    cifsConvertToUCS((__u16 *) pSMB->fileName, fileName, 
+		    cifsConvertToUCS((__le16 *) pSMB->fileName, fileName, 
 				     PATH_MAX, nls_codepage, remap);
 		name_len++;	/* trailing null */
 		name_len *= 2;
@@ -665,7 +665,7 @@
 		return rc;
 
 	if (pSMB->hdr.Flags2 & SMBFLG2_UNICODE) {
-		name_len = cifsConvertToUCS((__u16 *) pSMB->DirName, name, 
+		name_len = cifsConvertToUCS((__le16 *) pSMB->DirName, name, 
 					    PATH_MAX, nls_codepage, remap);
 		name_len++;	/* trailing null */
 		name_len *= 2;
@@ -719,7 +719,7 @@
 	if (pSMB->hdr.Flags2 & SMBFLG2_UNICODE) {
 		count = 1;	/* account for one byte pad to word boundary */
 		name_len =
-		    cifsConvertToUCS((__u16 *) (pSMB->fileName + 1),
+		    cifsConvertToUCS((__le16 *) (pSMB->fileName + 1),
 				     fileName, PATH_MAX, nls_codepage, remap);
 		name_len++;	/* trailing null */
 		name_len *= 2;
@@ -1141,7 +1141,7 @@
 
 	if (pSMB->hdr.Flags2 & SMBFLG2_UNICODE) {
 		name_len =
-		    cifsConvertToUCS((__u16 *) pSMB->OldFileName, fromName, 
+		    cifsConvertToUCS((__le16 *) pSMB->OldFileName, fromName, 
 				     PATH_MAX, nls_codepage, remap);
 		name_len++;	/* trailing null */
 		name_len *= 2;
@@ -1149,7 +1149,7 @@
 	/* protocol requires ASCII signature byte on Unicode string */
 		pSMB->OldFileName[name_len + 1] = 0x00;
 		name_len2 =
-		    cifsConvertToUCS((__u16 *) &pSMB->OldFileName[name_len + 2],
+		    cifsConvertToUCS((__le16 *) &pSMB->OldFileName[name_len + 2],
 				     toName, PATH_MAX, nls_codepage, remap);
 		name_len2 += 1 /* trailing null */  + 1 /* Signature word */ ;
 		name_len2 *= 2;	/* convert to bytes */
@@ -1236,10 +1236,10 @@
 	/* unicode only call */
 	if(target_name == NULL) {
 		sprintf(dummy_string,"cifs%x",pSMB->hdr.Mid);
-	        len_of_str = cifsConvertToUCS((__u16 *)rename_info->target_name,
+	        len_of_str = cifsConvertToUCS((__le16 *)rename_info->target_name,
 					dummy_string, 24, nls_codepage, remap);
 	} else {
-		len_of_str = cifsConvertToUCS((__u16 *)rename_info->target_name,
+		len_of_str = cifsConvertToUCS((__le16 *)rename_info->target_name,
 					target_name, PATH_MAX, nls_codepage, remap);
 	}
 	rename_info->target_name_len = cpu_to_le32(2 * len_of_str);
@@ -1296,7 +1296,7 @@
 	pSMB->Flags = cpu_to_le16(flags & COPY_TREE);
 
 	if (pSMB->hdr.Flags2 & SMBFLG2_UNICODE) {
-		name_len = cifsConvertToUCS((__u16 *) pSMB->OldFileName, 
+		name_len = cifsConvertToUCS((__le16 *) pSMB->OldFileName, 
 					    fromName, PATH_MAX, nls_codepage,
 					    remap);
 		name_len++;     /* trailing null */
@@ -1304,7 +1304,7 @@
 		pSMB->OldFileName[name_len] = 0x04;     /* pad */
 		/* protocol requires ASCII signature byte on Unicode string */
 		pSMB->OldFileName[name_len + 1] = 0x00;
-		name_len2 = cifsConvertToUCS((__u16 *)&pSMB->OldFileName[name_len + 2], 
+		name_len2 = cifsConvertToUCS((__le16 *)&pSMB->OldFileName[name_len + 2], 
 				toName, PATH_MAX, nls_codepage, remap);
 		name_len2 += 1 /* trailing null */  + 1 /* Signature word */ ;
 		name_len2 *= 2; /* convert to bytes */
@@ -1453,7 +1453,7 @@
 		return rc;
 
 	if (pSMB->hdr.Flags2 & SMBFLG2_UNICODE) {
-		name_len = cifsConvertToUCS((__u16 *) pSMB->FileName, toName,
+		name_len = cifsConvertToUCS((__le16 *) pSMB->FileName, toName,
 					    PATH_MAX, nls_codepage, remap);
 		name_len++;	/* trailing null */
 		name_len *= 2;
@@ -1476,7 +1476,7 @@
 	data_offset = (char *) (&pSMB->hdr.Protocol) + offset;
 	if (pSMB->hdr.Flags2 & SMBFLG2_UNICODE) {
 		name_len_target =
-		    cifsConvertToUCS((__u16 *) data_offset, fromName, PATH_MAX,
+		    cifsConvertToUCS((__le16 *) data_offset, fromName, PATH_MAX,
 				     nls_codepage, remap);
 		name_len_target++;	/* trailing null */
 		name_len_target *= 2;
@@ -1546,14 +1546,14 @@
 
 	if (pSMB->hdr.Flags2 & SMBFLG2_UNICODE) {
 		name_len =
-		    cifsConvertToUCS((__u16 *) pSMB->OldFileName, fromName,
+		    cifsConvertToUCS((__le16 *) pSMB->OldFileName, fromName,
 				     PATH_MAX, nls_codepage, remap);
 		name_len++;	/* trailing null */
 		name_len *= 2;
 		pSMB->OldFileName[name_len] = 0;	/* pad */
 		pSMB->OldFileName[name_len + 1] = 0x04; 
 		name_len2 =
-		    cifsConvertToUCS((__u16 *)&pSMB->OldFileName[name_len + 2], 
+		    cifsConvertToUCS((__le16 *)&pSMB->OldFileName[name_len + 2], 
 				     toName, PATH_MAX, nls_codepage, remap);
 		name_len2 += 1 /* trailing null */  + 1 /* Signature word */ ;
 		name_len2 *= 2;	/* convert to bytes */
@@ -1939,7 +1939,7 @@
                                                                                                                                              
 	if (pSMB->hdr.Flags2 & SMBFLG2_UNICODE) {
 		name_len =
-			cifsConvertToUCS((__u16 *) pSMB->FileName, searchName, 
+			cifsConvertToUCS((__le16 *) pSMB->FileName, searchName, 
 					 PATH_MAX, nls_codepage, remap);
 		name_len++;     /* trailing null */
 		name_len *= 2;
@@ -2024,7 +2024,7 @@
 		return rc;
 	if (pSMB->hdr.Flags2 & SMBFLG2_UNICODE) {
 		name_len =
-			cifsConvertToUCS((__u16 *) pSMB->FileName, fileName, 
+			cifsConvertToUCS((__le16 *) pSMB->FileName, fileName, 
 				      PATH_MAX, nls_codepage, remap);
 		name_len++;     /* trailing null */
 		name_len *= 2;
@@ -2188,7 +2188,7 @@
 
 	if (pSMB->hdr.Flags2 & SMBFLG2_UNICODE) {
 		name_len =
-		    cifsConvertToUCS((__u16 *) pSMB->FileName, searchName, 
+		    cifsConvertToUCS((__le16 *) pSMB->FileName, searchName, 
 				     PATH_MAX, nls_codepage, remap);
 		name_len++;	/* trailing null */
 		name_len *= 2;
@@ -2269,7 +2269,7 @@
 
 	if (pSMB->hdr.Flags2 & SMBFLG2_UNICODE) {
 		name_len =
-		    cifsConvertToUCS((__u16 *) pSMB->FileName, searchName,
+		    cifsConvertToUCS((__le16 *) pSMB->FileName, searchName,
 				  PATH_MAX, nls_codepage, remap);
 		name_len++;	/* trailing null */
 		name_len *= 2;
@@ -2350,7 +2350,7 @@
 
 	if (pSMB->hdr.Flags2 & SMBFLG2_UNICODE) {
 		name_len =
-		    cifsConvertToUCS((wchar_t *) pSMB->FileName, searchName, PATH_MAX
+		    cifsConvertToUCS((__le16 *) pSMB->FileName, searchName, PATH_MAX
 				  /* find define for this maxpathcomponent */
 				  , nls_codepage);
 		name_len++;	/* trailing null */
@@ -2435,7 +2435,7 @@
 
 	if (pSMB->hdr.Flags2 & SMBFLG2_UNICODE) {
 		name_len =
-		    cifsConvertToUCS((__u16 *) pSMB->FileName,searchName,
+		    cifsConvertToUCS((__le16 *) pSMB->FileName,searchName,
 				 PATH_MAX, nls_codepage, remap);
 		/* We can not add the asterik earlier in case
 		it got remapped to 0xF03A as if it were part of the
@@ -2726,7 +2726,7 @@
 
 	if (pSMB->hdr.Flags2 & SMBFLG2_UNICODE) {
 		name_len =
-			cifsConvertToUCS((__u16 *) pSMB->FileName, searchName,
+			cifsConvertToUCS((__le16 *) pSMB->FileName, searchName,
 				PATH_MAX,nls_codepage, remap);
 		name_len++;     /* trailing null */
 		name_len *= 2;
@@ -2837,7 +2837,7 @@
 	if (ses->capabilities & CAP_UNICODE) {
 		pSMB->hdr.Flags2 |= SMBFLG2_UNICODE;
 		name_len =
-		    cifsConvertToUCS((__u16 *) pSMB->RequestFileName,
+		    cifsConvertToUCS((__le16 *) pSMB->RequestFileName,
 				     searchName, PATH_MAX, nls_codepage, remap);
 		name_len++;	/* trailing null */
 		name_len *= 2;
@@ -3369,7 +3369,7 @@
 
 	if (pSMB->hdr.Flags2 & SMBFLG2_UNICODE) {
 		name_len =
-		    cifsConvertToUCS((__u16 *) pSMB->FileName, fileName,
+		    cifsConvertToUCS((__le16 *) pSMB->FileName, fileName,
 				     PATH_MAX, nls_codepage, remap);
 		name_len++;	/* trailing null */
 		name_len *= 2;
@@ -3627,7 +3627,7 @@
 
 	if (pSMB->hdr.Flags2 & SMBFLG2_UNICODE) {
 		name_len =
-		    cifsConvertToUCS((__u16 *) pSMB->FileName, fileName,
+		    cifsConvertToUCS((__le16 *) pSMB->FileName, fileName,
 				     PATH_MAX, nls_codepage, remap);
 		name_len++;	/* trailing null */
 		name_len *= 2;
@@ -3708,7 +3708,7 @@
 
 	if (pSMB->hdr.Flags2 & SMBFLG2_UNICODE) {
 		name_len =
-			ConvertToUCS((wchar_t *) pSMB->fileName, fileName, 
+			ConvertToUCS((__le16 *) pSMB->fileName, fileName, 
 				PATH_MAX, nls_codepage);
 		name_len++;     /* trailing null */
 		name_len *= 2;
@@ -3759,7 +3759,7 @@
 
 	if (pSMB->hdr.Flags2 & SMBFLG2_UNICODE) {
 		name_len =
-		    cifsConvertToUCS((__u16 *) pSMB->FileName, fileName, 
+		    cifsConvertToUCS((__le16 *) pSMB->FileName, fileName, 
 				     PATH_MAX, nls_codepage, remap);
 		name_len++;	/* trailing null */
 		name_len *= 2;
@@ -3904,7 +3904,7 @@
 
 	if (pSMB->hdr.Flags2 & SMBFLG2_UNICODE) {
 		name_len =
-		    cifsConvertToUCS((wchar_t *) pSMB->FileName, searchName, 
+		    cifsConvertToUCS((__le16 *) pSMB->FileName, searchName, 
 				     PATH_MAX, nls_codepage, remap);
 		name_len++;	/* trailing null */
 		name_len *= 2;
@@ -4047,7 +4047,7 @@
 
 	if (pSMB->hdr.Flags2 & SMBFLG2_UNICODE) {
 		name_len =
-		    cifsConvertToUCS((__u16 *) pSMB->FileName, searchName, 
+		    cifsConvertToUCS((__le16 *) pSMB->FileName, searchName, 
 				     PATH_MAX, nls_codepage, remap);
 		name_len++;	/* trailing null */
 		name_len *= 2;
@@ -4194,7 +4194,7 @@
 
 	if (pSMB->hdr.Flags2 & SMBFLG2_UNICODE) {
 		name_len =
-		    cifsConvertToUCS((__u16 *) pSMB->FileName, fileName, 
+		    cifsConvertToUCS((__le16 *) pSMB->FileName, fileName, 
 				     PATH_MAX, nls_codepage, remap);
 		name_len++;	/* trailing null */
 		name_len *= 2;
Index: fs/cifs/dir.c
===================================================================
--- d414ab9a0f0995899c2e76c232714410f787b209/fs/cifs/dir.c  (mode:100644)
+++ uncommitted/fs/cifs/dir.c  (mode:100644)
@@ -392,7 +392,8 @@
 		rc = 0;
 		d_add(direntry, NULL);
 	} else {
-		cERROR(1,("Error 0x%x or on cifs_get_inode_info in lookup",rc));
+		cERROR(1,("Error 0x%x on cifs_get_inode_info in lookup of %s",
+			   rc,full_path));
 		/* BB special case check for Access Denied - watch security 
 		exposure of returning dir info implicitly via different rc 
 		if file exists or not but no access BB */
Index: fs/cifs/inode.c
===================================================================
--- d414ab9a0f0995899c2e76c232714410f787b209/fs/cifs/inode.c  (mode:100644)
+++ uncommitted/fs/cifs/inode.c  (mode:100644)
@@ -422,7 +422,8 @@
 			cifs_sb->mnt_cifs_flags & CIFS_MOUNT_MAP_SPECIAL_CHR);
 
 	if (!rc) {
-		direntry->d_inode->i_nlink--;
+		if(direntry->d_inode)
+			direntry->d_inode->i_nlink--;
 	} else if (rc == -ENOENT) {
 		d_drop(direntry);
 	} else if (rc == -ETXTBSY) {
@@ -440,7 +441,8 @@
 					      cifs_sb->mnt_cifs_flags & 
 						CIFS_MOUNT_MAP_SPECIAL_CHR);
 			CIFSSMBClose(xid, pTcon, netfid);
-			direntry->d_inode->i_nlink--;
+			if(direntry->d_inode)
+				direntry->d_inode->i_nlink--;
 		}
 	} else if (rc == -EACCES) {
 		/* try only if r/o attribute set in local lookup data? */
@@ -494,7 +496,8 @@
 					    cifs_sb->mnt_cifs_flags & 
 						CIFS_MOUNT_MAP_SPECIAL_CHR);
 			if (!rc) {
-				direntry->d_inode->i_nlink--;
+				if(direntry->d_inode)
+					direntry->d_inode->i_nlink--;
 			} else if (rc == -ETXTBSY) {
 				int oplock = FALSE;
 				__u16 netfid;
@@ -514,17 +517,20 @@
 						cifs_sb->mnt_cifs_flags &
 						    CIFS_MOUNT_MAP_SPECIAL_CHR);
 					CIFSSMBClose(xid, pTcon, netfid);
-		                        direntry->d_inode->i_nlink--;
+					if(direntry->d_inode)
+			                        direntry->d_inode->i_nlink--;
 				}
 			/* BB if rc = -ETXTBUSY goto the rename logic BB */
 			}
 		}
 	}
-	cifsInode = CIFS_I(direntry->d_inode);
-	cifsInode->time = 0;	/* will force revalidate to get info when
-				   needed */
-	direntry->d_inode->i_ctime = inode->i_ctime = inode->i_mtime =
-		current_fs_time(inode->i_sb);
+	if(direntry->d_inode) {
+		cifsInode = CIFS_I(direntry->d_inode);
+		cifsInode->time = 0;	/* will force revalidate to get info
+					   when needed */
+		direntry->d_inode->i_ctime = current_fs_time(inode->i_sb);
+	}
+	inode->i_ctime = inode->i_mtime = current_fs_time(inode->i_sb);
 	cifsInode = CIFS_I(inode);
 	cifsInode->time = 0;	/* force revalidate of dir as well */
 
Index: fs/cifs/misc.c
===================================================================
--- d414ab9a0f0995899c2e76c232714410f787b209/fs/cifs/misc.c  (mode:100644)
+++ uncommitted/fs/cifs/misc.c  (mode:100644)
@@ -571,6 +571,7 @@
 				break;
 			case UNI_LESSTHAN:
 				target[j] = '<';
+				break;
 			default: 
 				len = cp->uni2char(src_char, &target[j], 
 						NLS_MAX_CHARSET_SIZE);

--------------070809040500050400000601--
