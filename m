Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271703AbTHMIvu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 04:51:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271707AbTHMIvu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 04:51:50 -0400
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:14865 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id S271703AbTHMIvm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 04:51:42 -0400
Date: Wed, 13 Aug 2003 05:47:47 -0300
From: Gerardo Exequiel Pozzi <vmlinuz386@yahoo.com.ar>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] 2.4.22-rc2 fix warnings deprecated in fs/ntfs
Message-Id: <20030813054747.1dde3a87.vmlinuz386@yahoo.com.ar>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i486-slackware-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcelo,

I created a patch that fix these warnings in gcc 3.2, please apply it.


fs/ntfs/dir.c
fs/ntfs/inode.c
fs/ntfs/super.c


inode.c: In function `ntfs_alloc_mft_record':
inode.c:1720: warning: concatenation of string literals with
__FUNCTION__ is dep recated
inode.c:2002: warning: concatenation of string literals with
__FUNCTION__ is deprecated
inode.c:2010: warning: concatenation of string literals with
__FUNCTION__ is deprecated
inode.c:2030: warning: concatenation of string literals with
__FUNCTION__ is deprecated
inode.c:2052: warning: concatenation of string literals with
__FUNCTION__ is deprecated
inode.c:2072: warning: concatenation of string literals with
__FUNCTION__ is deprecated
inode.c:2094: warning: concatenation of string literals with
__FUNCTION__ is deprecated
inode.c:2117: warning: concatenation of string literals with
__FUNCTION__ is deprecated
inode.c: In function `ntfs_alloc_inode':
inode.c:2259: warning: concatenation of string literals with
__FUNCTION__ is deprecated

dir.c: In function `ntfs_getdir_unsorted':
dir.c:805: warning: concatenation of string literals with __FUNCTION__
is deprecated
dir.c:811: warning: concatenation of string literals with __FUNCTION__
is deprecated
dir.c:855: warning: concatenation of string literals with __FUNCTION__
is deprecated
dir.c:909: warning: concatenation of string literals with __FUNCTION__
is deprecated
dir.c:941: warning: concatenation of string literals with __FUNCTION__
is deprecated
dir.c:972: warning: concatenation of string literals with __FUNCTION__
is deprecated

super.c: In function `ntfs_allocate_clusters':
super.c:975: warning: concatenation of string literals with __FUNCTION__
is deprecated
super.c:1235: warning: concatenation of string literals with
__FUNCTION__ is deprecated
super.c:1253: warning: concatenation of string literals with
__FUNCTION__ is deprecated
super.c:1301: warning: concatenation of string literals with
__FUNCTION__ is deprecated



diff -ru linux-2.4.21-vanilla/fs/ntfs/dir.c linux-2.4.21/fs/ntfs/dir.c
--- linux-2.4.21-vanilla/fs/ntfs/dir.c	2001-11-03 21:35:46.000000000 -0300
+++ linux-2.4.21/fs/ntfs/dir.c	2003-08-13 05:08:34.000000000 -0300
@@ -802,13 +802,13 @@
 	u8 ibs_bits;
 
 	if (!ino) {
-		ntfs_error(__FUNCTION__ "(): No inode! Returning -EINVAL.\n");
+		ntfs_error("%s(): No inode! Returning -EINVAL.\n",__FUNCTION__);
 		return -EINVAL;
 	}
 	vol = ino->vol;
 	if (!vol) {
-		ntfs_error(__FUNCTION__ "(): Inode 0x%lx has no volume. "
-				"Returning -EINVAL.\n", ino->i_number);
+		ntfs_error("%s(): Inode 0x%lx has no volume. Returning "
+			    "-EINVAL.\n", __FUNCTION__, ino->i_number);
 		return -EINVAL;
 	}
 	ntfs_debug(DEBUG_DIR3, __FUNCTION__ "(): Unsorted 1: Entering
for "@@ -850,9 +850,9 @@
 		if (err || io.size != ibs)
 			goto read_err_ret;
 		if (!ntfs_check_index_record(ino, buf)) {
-			ntfs_error(__FUNCTION__ "(): Index block 0x%x is not "
-					"an index record. Returning "
-					"-ENOTDIR.\n", *p_high - 1);
+			ntfs_error("%s(): Index block 0x%x is not an index "
+					"record. Returning -ENOTDIR.\n",
+					__FUNCTION__, *p_high - 1);
 			ntfs_free(buf);
 			return -ENOTDIR;
 		}
@@ -905,8 +905,8 @@
 	}
 	max_size = attr->size;
 	if (max_size > 0x7fff >> 3) {
-		ntfs_error(__FUNCTION__ "(): Directory too large. Visible "
-				"length is truncated.\n");
+		ntfs_error("%s(): Directory too large. Visible "
+				"length is truncated.\n", __FUNCTION__);
 		max_size = 0x7fff >> 3;
 	}
 	buf = ntfs_malloc(max_size);
@@ -934,12 +934,12 @@
 	max_size <<= 3;
 	while (1) {
 		if (++*p_high >= 0x7fff) {
-			ntfs_error(__FUNCTION__ "(): Unsorted 10: Directory "
+			ntfs_error("%s(): Unsorted 10: Directory "
 					"inode 0x%lx overflowed the maximum "
 					"number of index allocation buffers "
 					"the driver can cope with. Pretending "
 					"to be at end of directory.\n",
-					ino->i_number);
+					__FUNCTION__, ino->i_number);
 			goto fake_eod;
 		}
 		if (*p_high > max_size || (s64)*p_high << ibs_bits >
@@ -969,8 +969,8 @@
 read_err_ret:
 	if (!err)
 		err = -EIO;
-	ntfs_error(__FUNCTION__ "(): Read failed. Returning error code %i.\n",
-			err);
+	ntfs_error("%s(): Read failed. Returning error code %i.\n",
+			__FUNCTION__, err);
 	ntfs_free(buf);
 	return err;
 }
diff -ru linux-2.4.21-vanilla/fs/ntfs/inode.c
linux-2.4.21/fs/ntfs/inode.c--- linux-2.4.21-vanilla/fs/ntfs/inode.c
2001-12-21 14:42:03.000000000 -0300+++ linux-2.4.21/fs/ntfs/inode.c	2003-08-13 04:57:27.000000000
-0300@@ -1713,11 +1713,12 @@
 					if (count > 0) {
 rl2_dealloc_err_out:				if (ntfs_deallocate_clusters(
 							vol, rl2, r2len))
-							ntfs_error(__FUNCTION__
-							"(): Cluster "
+							ntfs_error("%s(): "
+							"Cluster "
 							"deallocation in error "
 							"code path failed! You "
-							"should run chkdsk.\n");
+							"should run chkdsk.\n",
+							__FUNCTION__);
 					}
 					ntfs_vfree(rl2);
 					if (!err)
@@ -1998,16 +1999,16 @@
 	free_page((unsigned long)buf);
 	ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Syncing inode
$MFT.\n"); 	if (ntfs_update_inode(vol->mft_ino))
-		ntfs_error(__FUNCTION__ "(): Failed to sync inode $MFT. "
-				"Continuing anyway.\n");
+		ntfs_error("%s(): Failed to sync inode $MFT. "
+				"Continuing anyway.\n",__FUNCTION__);
 	if (!err) {
 		ntfs_debug(DEBUG_FILE3, __FUNCTION__ "(): Done. Allocated mft "
 				"record number *result = 0x%lx.\n", *result);
 		return 0;
 	}
 	if (err != -ENOSPC)
-		ntfs_error(__FUNCTION__ "(): Failed to allocate an mft "
-				"record. Returning error code %i.\n", -err);
+		ntfs_error("%s(): Failed to allocate an mft record. Returning "
+				"error code %i.\n", __FUNCTION__, -err);
 	else
 		ntfs_debug(DEBUG_FILE3, __FUNCTION__ "(): Failed to allocate "
 				"an mft record due to lack of free space.\n");
@@ -2026,8 +2027,8 @@
 			"undo_partial_data_alloc_err_ret.\n");
 	/* Deallocate the clusters. */
 	if (ntfs_deallocate_clusters(vol, rl2, r2len))
-		ntfs_error(__FUNCTION__ "(): Error deallocating clusters in "
-				"error code path. You should run chkdsk.\n");
+		ntfs_error("%s(): Error deallocating clusters in error code "
+			"path. You should run chkdsk.\n", __FUNCTION__);
 	ntfs_vfree(rl2);
 	/* Revert the run list back to what it was before. */
 	r2len = data->d.r.len;
@@ -2047,9 +2048,9 @@
 			ntfs_vfree(data->d.r.runlist);
 			data->d.r.runlist = rl2;
 		} else
-			ntfs_error(__FUNCTION__ "(): Error reallocating "
+			ntfs_error("%s(): Error reallocating "
 					"memory in error code path. This "
-					"should be harmless.\n");
+					"should be harmless.\n", __FUNCTION__);
 	}	
 undo_mftbmp_alloc_err_ret:
 	ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): At "
@@ -2068,8 +2069,8 @@
 	if (err || io.size != 1) {
 		if (!err)
 			err = -EIO;
-		ntfs_error(__FUNCTION__ "(): Error deallocating mft record in "
-				"error code path. You should run chkdsk.\n");
+		ntfs_error("%s(): Error deallocating mft record in error code "
+			"path. You should run chkdsk.\n", __FUNCTION__);
 	}
 shrink_mftbmp_err_ret:
 	ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): At
shrink_mftbmp_err_ret.\n");@@ -2090,8 +2091,8 @@
 	/* Deallocate the allocated cluster. */
 	bmp->allocated -= (__s64)vol->cluster_size;
 	if (ntfs_deallocate_cluster_run(vol, lcn, (ntfs_cluster_t)1))
-		ntfs_error(__FUNCTION__ "(): Error deallocating cluster in "
-				"error code path. You should run chkdsk.\n");
+		ntfs_error("%s(): Error deallocating cluster in error code "
+			"path. You should run chkdsk.\n", __FUNCTION__);
 	switch (have_allocated_mftbmp & 3) {
 	case 1:
 		/* Delete the last lcn from the last run of mftbmp. */
@@ -2111,10 +2112,10 @@
 				ntfs_vfree(rl);
 				bmp->d.r.runlist = rl = rlt;
 			} else
-				ntfs_error(__FUNCTION__ "(): Error "
+				ntfs_error("%s(): Error "
 						"reallocating memory in error "
 						"code path. This should be "
-						"harmless.\n");
+						"harmless.\n", __FUNCTION__);
 		}
 		bmp->d.r.runlist[bmp->d.r.len].lcn = (ntfs_cluster_t)-1;
 		bmp->d.r.runlist[bmp->d.r.len].len = (ntfs_cluster_t)0;
@@ -2256,7 +2257,7 @@
 	err = ntfs_alloc_mft_record(vol, &(result->i_number));
 	if (err) {
 		if (err == -ENOSPC)
-			ntfs_error(__FUNCTION__ "(): No free inodes.\n");
+			ntfs_error("%s(): No free inodes.\n", __FUNCTION__);
 		return err;
 	}
 	/* Get the sequence number. */
diff -ru linux-2.4.21-vanilla/fs/ntfs/super.c
linux-2.4.21/fs/ntfs/super.c--- linux-2.4.21-vanilla/fs/ntfs/super.c
2001-09-08 16:24:40.000000000 -0300+++ linux-2.4.21/fs/ntfs/super.c	2003-08-13 05:15:25.000000000
-0300@@ -969,10 +969,10 @@
 			err = ntfs_readwrite_attr(vol->bitmap, data,
 					last_read_pos, &io);
 			if (err) {
-				ntfs_error(__FUNCTION__ "(): Bitmap writeback "
-						"failed in read next buffer "
-						"code path with error code "
-						"%i.\n", -err);
+				ntfs_error("%s(): Bitmap writeback failed "
+						"in read next buffer code "
+						"path with error code %i.\n",
+						__FUNCTION__, -err);
 				goto err_ret;
 			}
 		}
@@ -1230,9 +1230,9 @@
 		err = ntfs_readwrite_attr(vol->bitmap, data, last_read_pos,
 				&io);
 		if (err) {
-			ntfs_error(__FUNCTION__ "(): Bitmap writeback failed "
-					"in done code path with error code "
-					"%i.\n", -err);
+			ntfs_error("%s(): Bitmap writeback failed in done "
+					"code path with error code %i.\n",
+					__FUNCTION__, -err);
 			goto err_ret;
 		}
 		ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Wrote 0x%Lx
bytes.\n",@@ -1249,8 +1249,8 @@
 				-err);
 	ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Syncing $Bitmap
inode.\n"); 	if (ntfs_update_inode(vol->bitmap))
-		ntfs_error(__FUNCTION__ "(): Failed to sync inode $Bitmap. "
-				"Continuing anyway.\n");
+		ntfs_error("%s(): Failed to sync inode $Bitmap. "
+				"Continuing anyway.\n", __FUNCTION__);
 	ntfs_debug(DEBUG_OTHER, __FUNCTION__ "(): Returning with code
%i.\n", 			err);
 	return err;
@@ -1296,9 +1296,9 @@
 		__err = ntfs_readwrite_attr(vol->bitmap, data, last_read_pos,
 				&io);
 		if (__err)
-			ntfs_error(__FUNCTION__ "(): Bitmap writeback failed "
-					"in error code path with error code "
-					"%i.\n", -__err);
+			ntfs_error("%s(): Bitmap writeback failed in error "
+					"code path with error code %i.\n",
+					__FUNCTION__, -__err);
 		need_writeback = 0;
 	}
 err_ret:



ciao,
 djgera


-- 
Gerardo Exequiel Pozzi ( djgera )
http://www.vmlinuz.com.ar http://www.djgera.com.ar
KeyID: 0x1B8C330D
Key fingerprint = 0CAA D5D4 CD85 4434 A219  76ED 39AB 221B 1B8C 330D
