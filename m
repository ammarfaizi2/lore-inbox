Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265127AbUIVMYQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265127AbUIVMYQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 08:24:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264984AbUIVMXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 08:23:45 -0400
Received: from ppsw-6.csi.cam.ac.uk ([131.111.8.136]:26314 "EHLO
	ppsw-6.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id S264903AbUIVMQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 08:16:51 -0400
Date: Wed, 22 Sep 2004 13:16:44 +0100 (BST)
From: Anton Altaparmakov <aia21@cam.ac.uk>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
cc: linux-kernel@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net
Subject: [PATCH 5/7] Re: [2.6-BK-URL] NTFS 2.1.18 release
In-Reply-To: <Pine.LNX.4.60.0409221316040.505@hermes-1.csi.cam.ac.uk>
Message-ID: <Pine.LNX.4.60.0409221316230.505@hermes-1.csi.cam.ac.uk>
References: <Pine.LNX.4.60.0409221308540.505@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409221314250.505@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409221315251.505@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409221315460.505@hermes-1.csi.cam.ac.uk>
 <Pine.LNX.4.60.0409221316040.505@hermes-1.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cam-ScannerInfo: http://www.cam.ac.uk/cs/email/scanner/
X-Cam-AntiVirus: No virus found
X-Cam-SpamDetails: Not scanned
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is patch 5/7 in the series.  It contains the following ChangeSet:

<aia21@cantab.net> (04/09/21 1.1942)
   NTFS: Rename {{re,}init,get,put}_attr_search_ctx() to
         ntfs_attr_{{re,}init,get,put}_search_ctx() as well as the type
         attr_search_context to ntfs_attr_search_ctx.
   
   Signed-off-by: Anton Altaparmakov <aia21@cantab.net>

Best regards,

	Anton
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Unix Support, Computing Service, University of Cambridge, CB2 3QH, UK
Linux NTFS maintainer / IRC: #ntfs on irc.freenode.net
WWW: http://linux-ntfs.sf.net/, http://www-stu.christs.cam.ac.uk/~aia21/

===================================================================

diff -Nru a/fs/ntfs/ChangeLog b/fs/ntfs/ChangeLog
--- a/fs/ntfs/ChangeLog	2004-09-22 13:02:47 +01:00
+++ b/fs/ntfs/ChangeLog	2004-09-22 13:02:47 +01:00
@@ -35,6 +35,9 @@
 	- Rename {find,lookup}_attr() to ntfs_attr_{find,lookup}() as well as
 	  find_external_attr() to ntfs_external_attr_find() to cleanup the
 	  namespace a bit and to be more consistent with libntfs.
+	- Rename {{re,}init,get,put}_attr_search_ctx() to
+	  ntfs_attr_{{re,}init,get,put}_search_ctx() as well as the type
+	  attr_search_context to ntfs_attr_search_ctx.
 
 2.1.17 - Fix bugs in mount time error code paths and other updates.
 
diff -Nru a/fs/ntfs/aops.c b/fs/ntfs/aops.c
--- a/fs/ntfs/aops.c	2004-09-22 13:02:48 +01:00
+++ b/fs/ntfs/aops.c	2004-09-22 13:02:48 +01:00
@@ -348,7 +348,7 @@
 	s64 attr_pos;
 	ntfs_inode *ni, *base_ni;
 	u8 *kaddr;
-	attr_search_context *ctx;
+	ntfs_attr_search_ctx *ctx;
 	MFT_RECORD *mrec;
 	u32 attr_len;
 	int err = 0;
@@ -397,7 +397,7 @@
 		err = PTR_ERR(mrec);
 		goto err_out;
 	}
-	ctx = get_attr_search_ctx(base_ni, mrec);
+	ctx = ntfs_attr_get_search_ctx(base_ni, mrec);
 	if (unlikely(!ctx)) {
 		err = -ENOMEM;
 		goto unm_err_out;
@@ -433,7 +433,7 @@
 
 	SetPageUptodate(page);
 put_unm_err_out:
-	put_attr_search_ctx(ctx);
+	ntfs_attr_put_search_ctx(ctx);
 unm_err_out:
 	unmap_mft_record(base_ni);
 err_out:
@@ -1030,7 +1030,7 @@
 	struct inode *vi;
 	ntfs_inode *ni, *base_ni;
 	char *kaddr;
-	attr_search_context *ctx;
+	ntfs_attr_search_ctx *ctx;
 	MFT_RECORD *m;
 	u32 attr_len, bytes;
 	int err;
@@ -1117,7 +1117,7 @@
 		ctx = NULL;
 		goto err_out;
 	}
-	ctx = get_attr_search_ctx(base_ni, m);
+	ctx = ntfs_attr_get_search_ctx(base_ni, m);
 	if (unlikely(!ctx)) {
 		err = -ENOMEM;
 		goto err_out;
@@ -1201,7 +1201,7 @@
 	/* Mark the mft record dirty, so it gets written back. */
 	mark_mft_record_dirty(ctx->ntfs_ino);
 
-	put_attr_search_ctx(ctx);
+	ntfs_attr_put_search_ctx(ctx);
 	unmap_mft_record(base_ni);
 	return 0;
 err_out:
@@ -1221,7 +1221,7 @@
 	}
 	unlock_page(page);
 	if (ctx)
-		put_attr_search_ctx(ctx);
+		ntfs_attr_put_search_ctx(ctx);
 	if (m)
 		unmap_mft_record(base_ni);
 	return err;
@@ -1683,9 +1683,9 @@
 	 * We thus defer the uptodate bringing of the page region outside the
 	 * region written to to ntfs_commit_write(). The reason for doing this
 	 * is that we save one round of:
-	 *	map_mft_record(), get_attr_search_ctx(), ntfs_attr_lookup(),
-	 *	kmap_atomic(), kunmap_atomic(), put_attr_search_ctx(),
-	 *	unmap_mft_record().
+	 *	map_mft_record(), ntfs_attr_get_search_ctx(),
+	 *	ntfs_attr_lookup(), kmap_atomic(), kunmap_atomic(),
+	 *	ntfs_attr_put_search_ctx(), unmap_mft_record().
 	 * Which is obviously a very worthwhile save.
 	 *
 	 * Thus we just return success now...
@@ -1804,7 +1804,7 @@
 	struct inode *vi;
 	ntfs_inode *ni, *base_ni;
 	char *kaddr, *kattr;
-	attr_search_context *ctx;
+	ntfs_attr_search_ctx *ctx;
 	MFT_RECORD *m;
 	u32 attr_len, bytes;
 	int err;
@@ -1891,7 +1891,7 @@
 		ctx = NULL;
 		goto err_out;
 	}
-	ctx = get_attr_search_ctx(base_ni, m);
+	ctx = ntfs_attr_get_search_ctx(base_ni, m);
 	if (unlikely(!ctx)) {
 		err = -ENOMEM;
 		goto err_out;
@@ -1966,7 +1966,7 @@
 	/* Mark the mft record dirty, so it gets written back. */
 	mark_mft_record_dirty(ctx->ntfs_ino);
 
-	put_attr_search_ctx(ctx);
+	ntfs_attr_put_search_ctx(ctx);
 	unmap_mft_record(base_ni);
 	ntfs_debug("Done.");
 	return 0;
@@ -1993,7 +1993,7 @@
 		SetPageError(page);
 	}
 	if (ctx)
-		put_attr_search_ctx(ctx);
+		ntfs_attr_put_search_ctx(ctx);
 	if (m)
 		unmap_mft_record(base_ni);
 	return err;
diff -Nru a/fs/ntfs/attrib.c b/fs/ntfs/attrib.c
--- a/fs/ntfs/attrib.c	2004-09-22 13:02:48 +01:00
+++ b/fs/ntfs/attrib.c	2004-09-22 13:02:48 +01:00
@@ -946,7 +946,7 @@
 int ntfs_map_runlist(ntfs_inode *ni, VCN vcn)
 {
 	ntfs_inode *base_ni;
-	attr_search_context *ctx;
+	ntfs_attr_search_ctx *ctx;
 	MFT_RECORD *mrec;
 	int err = 0;
 
@@ -961,14 +961,14 @@
 	mrec = map_mft_record(base_ni);
 	if (IS_ERR(mrec))
 		return PTR_ERR(mrec);
-	ctx = get_attr_search_ctx(base_ni, mrec);
+	ctx = ntfs_attr_get_search_ctx(base_ni, mrec);
 	if (!ctx) {
 		err = -ENOMEM;
 		goto err_out;
 	}
 	if (!ntfs_attr_lookup(ni->type, ni->name, ni->name_len, CASE_SENSITIVE,
 			vcn, NULL, 0, ctx)) {
-		put_attr_search_ctx(ctx);
+		ntfs_attr_put_search_ctx(ctx);
 		err = -ENOENT;
 		goto err_out;
 	}
@@ -987,7 +987,7 @@
 	}
 	up_write(&ni->runlist.lock);
 
-	put_attr_search_ctx(ctx);
+	ntfs_attr_put_search_ctx(ctx);
 err_out:
 	unmap_mft_record(base_ni);
 	return err;
@@ -1199,7 +1199,7 @@
  */
 BOOL ntfs_attr_find(const ATTR_TYPES type, const ntfschar *name,
 		const u32 name_len, const IGNORE_CASE_BOOL ic,
-		const u8 *val, const u32 val_len, attr_search_context *ctx)
+		const u8 *val, const u32 val_len, ntfs_attr_search_ctx *ctx)
 {
 	ATTR_RECORD *a;
 	ntfs_volume *vol;
@@ -1440,13 +1440,13 @@
  * in there and return it.
  *
  * On first search @ctx->ntfs_ino must be the base mft record and @ctx must
- * have been obtained from a call to get_attr_search_ctx().  On subsequent
+ * have been obtained from a call to ntfs_attr_get_search_ctx().  On subsequent
  * calls @ctx->ntfs_ino can be any extent inode, too (@ctx->base_ntfs_ino is
  * then the base inode).
  *
  * After finishing with the attribute/mft record you need to call
- * put_attr_search_ctx() to cleanup the search context (unmapping any mapped
- * inodes, etc).
+ * ntfs_attr_put_search_ctx() to cleanup the search context (unmapping any
+ * mapped inodes, etc).
  *
  * Return TRUE if the search was successful and FALSE if not.  When TRUE,
  * @ctx->attr is the found attribute and it is in mft record @ctx->mrec.  When
@@ -1459,7 +1459,7 @@
 static BOOL ntfs_external_attr_find(const ATTR_TYPES type,
 		const ntfschar *name, const u32 name_len,
 		const IGNORE_CASE_BOOL ic, const VCN lowest_vcn,
-		const u8 *val, const u32 val_len, attr_search_context *ctx)
+		const u8 *val, const u32 val_len, ntfs_attr_search_ctx *ctx)
 {
 	ntfs_inode *base_ni, *ni;
 	ntfs_volume *vol;
@@ -1692,7 +1692,7 @@
 	 *
 	 * FIXME: Do we really want to do this here? Think about it... (AIA)
 	 */
-	reinit_attr_search_ctx(ctx);
+	ntfs_attr_reinit_search_ctx(ctx);
 	ntfs_attr_find(type, name, name_len, ic, val, val_len, ctx);
 	ntfs_debug("Done, not found.");
 	return FALSE;
@@ -1711,14 +1711,14 @@
  *
  * Find an attribute in an ntfs inode. On first search @ctx->ntfs_ino must
  * be the base mft record and @ctx must have been obtained from a call to
- * get_attr_search_ctx().
+ * ntfs_attr_get_search_ctx().
  *
  * This function transparently handles attribute lists and @ctx is used to
  * continue searches where they were left off at.
  *
  * After finishing with the attribute/mft record you need to call
- * put_attr_search_ctx() to cleanup the search context (unmapping any mapped
- * inodes, etc).
+ * ntfs_attr_put_search_ctx() to cleanup the search context (unmapping any
+ * mapped inodes, etc).
  *
  * Return TRUE if the search was successful and FALSE if not. When TRUE,
  * @ctx->attr is the found attribute and it is in mft record @ctx->mrec. When
@@ -1729,7 +1729,7 @@
 BOOL ntfs_attr_lookup(const ATTR_TYPES type, const ntfschar *name,
 		const u32 name_len, const IGNORE_CASE_BOOL ic,
 		const VCN lowest_vcn, const u8 *val, const u32 val_len,
-		attr_search_context *ctx)
+		ntfs_attr_search_ctx *ctx)
 {
 	ntfs_inode *base_ni;
 
@@ -1748,14 +1748,14 @@
 }
 
 /**
- * init_attr_search_ctx - initialize an attribute search context
+ * ntfs_attr_init_search_ctx - initialize an attribute search context
  * @ctx:	attribute search context to initialize
  * @ni:		ntfs inode with which to initialize the search context
  * @mrec:	mft record with which to initialize the search context
  *
  * Initialize the attribute search context @ctx with @ni and @mrec.
  */
-static inline void init_attr_search_ctx(attr_search_context *ctx,
+static inline void ntfs_attr_init_search_ctx(ntfs_attr_search_ctx *ctx,
 		ntfs_inode *ni, MFT_RECORD *mrec)
 {
 	ctx->mrec = mrec;
@@ -1770,7 +1770,7 @@
 }
 
 /**
- * reinit_attr_search_ctx - reinitialize an attribute search context
+ * ntfs_attr_reinit_search_ctx - reinitialize an attribute search context
  * @ctx:	attribute search context to reinitialize
  *
  * Reinitialize the attribute search context @ctx, unmapping an associated
@@ -1779,7 +1779,7 @@
  * This is used when a search for a new attribute is being started to reset
  * the search context to the beginning.
  */
-void reinit_attr_search_ctx(attr_search_context *ctx)
+void ntfs_attr_reinit_search_ctx(ntfs_attr_search_ctx *ctx)
 {
 	if (likely(!ctx->base_ntfs_ino)) {
 		/* No attribute list. */
@@ -1791,40 +1791,39 @@
 	} /* Attribute list. */
 	if (ctx->ntfs_ino != ctx->base_ntfs_ino)
 		unmap_extent_mft_record(ctx->ntfs_ino);
-	init_attr_search_ctx(ctx, ctx->base_ntfs_ino, ctx->base_mrec);
+	ntfs_attr_init_search_ctx(ctx, ctx->base_ntfs_ino, ctx->base_mrec);
 	return;
 }
 
 /**
- * get_attr_search_ctx - allocate and initialize a new attribute search context
+ * ntfs_attr_get_search_ctx - allocate/initialize a new attribute search context
  * @ni:		ntfs inode with which to initialize the search context
  * @mrec:	mft record with which to initialize the search context
  *
  * Allocate a new attribute search context, initialize it with @ni and @mrec,
  * and return it. Return NULL if allocation failed.
  */
-attr_search_context *get_attr_search_ctx(ntfs_inode *ni, MFT_RECORD *mrec)
+ntfs_attr_search_ctx *ntfs_attr_get_search_ctx(ntfs_inode *ni, MFT_RECORD *mrec)
 {
-	attr_search_context *ctx;
+	ntfs_attr_search_ctx *ctx;
 
 	ctx = kmem_cache_alloc(ntfs_attr_ctx_cache, SLAB_NOFS);
 	if (ctx)
-		init_attr_search_ctx(ctx, ni, mrec);
+		ntfs_attr_init_search_ctx(ctx, ni, mrec);
 	return ctx;
 }
 
 /**
- * put_attr_search_ctx - release an attribute search context
+ * ntfs_attr_put_search_ctx - release an attribute search context
  * @ctx:	attribute search context to free
  *
  * Release the attribute search context @ctx, unmapping an associated extent
  * mft record if present.
  */
-void put_attr_search_ctx(attr_search_context *ctx)
+void ntfs_attr_put_search_ctx(ntfs_attr_search_ctx *ctx)
 {
 	if (ctx->base_ntfs_ino && ctx->ntfs_ino != ctx->base_ntfs_ino)
 		unmap_extent_mft_record(ctx->ntfs_ino);
 	kmem_cache_free(ntfs_attr_ctx_cache, ctx);
 	return;
 }
-
diff -Nru a/fs/ntfs/attrib.h b/fs/ntfs/attrib.h
--- a/fs/ntfs/attrib.h	2004-09-22 13:02:47 +01:00
+++ b/fs/ntfs/attrib.h	2004-09-22 13:02:47 +01:00
@@ -43,7 +43,7 @@
 } LCN_SPECIAL_VALUES;
 
 /**
- * attr_search_context - used in attribute search functions
+ * ntfs_attr_search_ctx - used in attribute search functions
  * @mrec:	buffer containing mft record to search
  * @attr:	attribute record in @mrec where to begin/continue search
  * @is_first:	if true ntfs_attr_lookup() begins search with @attr, else after
@@ -69,7 +69,7 @@
 	ntfs_inode *base_ntfs_ino;
 	MFT_RECORD *base_mrec;
 	ATTR_RECORD *base_attr;
-} attr_search_context;
+} ntfs_attr_search_ctx;
 
 extern runlist_element *decompress_mapping_pairs(const ntfs_volume *vol,
 		const ATTR_RECORD *attr, runlist_element *old_rl);
@@ -83,12 +83,12 @@
 
 extern BOOL ntfs_attr_find(const ATTR_TYPES type, const ntfschar *name,
 		const u32 name_len, const IGNORE_CASE_BOOL ic, const u8 *val,
-		const u32 val_len, attr_search_context *ctx);
+		const u32 val_len, ntfs_attr_search_ctx *ctx);
 
 BOOL ntfs_attr_lookup(const ATTR_TYPES type, const ntfschar *name,
 		const u32 name_len, const IGNORE_CASE_BOOL ic,
 		const VCN lowest_vcn, const u8 *val, const u32 val_len,
-		attr_search_context *ctx);
+		ntfs_attr_search_ctx *ctx);
 
 extern int load_attribute_list(ntfs_volume *vol, runlist *rl, u8 *al_start,
 		const s64 size, const s64 initialized_size);
@@ -100,9 +100,9 @@
 	return sle64_to_cpu(a->data.non_resident.data_size);
 }
 
-extern void reinit_attr_search_ctx(attr_search_context *ctx);
-extern attr_search_context *get_attr_search_ctx(ntfs_inode *ni,
+extern void ntfs_attr_reinit_search_ctx(ntfs_attr_search_ctx *ctx);
+extern ntfs_attr_search_ctx *ntfs_attr_get_search_ctx(ntfs_inode *ni,
 		MFT_RECORD *mrec);
-extern void put_attr_search_ctx(attr_search_context *ctx);
+extern void ntfs_attr_put_search_ctx(ntfs_attr_search_ctx *ctx);
 
 #endif /* _LINUX_NTFS_ATTRIB_H */
diff -Nru a/fs/ntfs/dir.c b/fs/ntfs/dir.c
--- a/fs/ntfs/dir.c	2004-09-22 13:02:47 +01:00
+++ b/fs/ntfs/dir.c	2004-09-22 13:02:47 +01:00
@@ -83,7 +83,7 @@
 	INDEX_ALLOCATION *ia;
 	u8 *index_end;
 	u64 mref;
-	attr_search_context *ctx;
+	ntfs_attr_search_ctx *ctx;
 	int err, rc;
 	VCN vcn, old_vcn;
 	struct address_space *ia_mapping;
@@ -100,7 +100,7 @@
 				-PTR_ERR(m));
 		return ERR_MREF(PTR_ERR(m));
 	}
-	ctx = get_attr_search_ctx(dir_ni, m);
+	ctx = ntfs_attr_get_search_ctx(dir_ni, m);
 	if (unlikely(!ctx)) {
 		err = -ENOMEM;
 		goto err_out;
@@ -179,7 +179,7 @@
 				*res = NULL;
 			}
 			mref = le64_to_cpu(ie->data.dir.indexed_file);
-			put_attr_search_ctx(ctx);
+			ntfs_attr_put_search_ctx(ctx);
 			unmap_mft_record(dir_ni);
 			return mref;
 		}
@@ -278,7 +278,7 @@
 	 */
 	if (!(ie->flags & INDEX_ENTRY_NODE)) {
 		if (name) {
-			put_attr_search_ctx(ctx);
+			ntfs_attr_put_search_ctx(ctx);
 			unmap_mft_record(dir_ni);
 			return name->mref;
 		}
@@ -301,7 +301,7 @@
 	 * We are done with the index root and the mft record. Release them,
 	 * otherwise we deadlock with ntfs_map_page().
 	 */
-	put_attr_search_ctx(ctx);
+	ntfs_attr_put_search_ctx(ctx);
 	unmap_mft_record(dir_ni);
 	m = NULL;
 	ctx = NULL;
@@ -582,7 +582,7 @@
 	ntfs_unmap_page(page);
 err_out:
 	if (ctx)
-		put_attr_search_ctx(ctx);
+		ntfs_attr_put_search_ctx(ctx);
 	if (m)
 		unmap_mft_record(dir_ni);
 	if (name) {
@@ -634,7 +634,7 @@
 	INDEX_ALLOCATION *ia;
 	u8 *index_end;
 	u64 mref;
-	attr_search_context *ctx;
+	ntfs_attr_search_ctx *ctx;
 	int err, rc;
 	IGNORE_CASE_BOOL ic;
 	VCN vcn, old_vcn;
@@ -649,7 +649,7 @@
 				-PTR_ERR(m));
 		return ERR_MREF(PTR_ERR(m));
 	}
-	ctx = get_attr_search_ctx(dir_ni, m);
+	ctx = ntfs_attr_get_search_ctx(dir_ni, m);
 	if (!ctx) {
 		err = -ENOMEM;
 		goto err_out;
@@ -710,7 +710,7 @@
 				vol->upcase, vol->upcase_len)) {
 found_it:
 			mref = le64_to_cpu(ie->data.dir.indexed_file);
-			put_attr_search_ctx(ctx);
+			ntfs_attr_put_search_ctx(ctx);
 			unmap_mft_record(dir_ni);
 			return mref;
 		}
@@ -776,7 +776,7 @@
 	 * We are done with the index root and the mft record. Release them,
 	 * otherwise we deadlock with ntfs_map_page().
 	 */
-	put_attr_search_ctx(ctx);
+	ntfs_attr_put_search_ctx(ctx);
 	unmap_mft_record(dir_ni);
 	m = NULL;
 	ctx = NULL;
@@ -979,7 +979,7 @@
 	ntfs_unmap_page(page);
 err_out:
 	if (ctx)
-		put_attr_search_ctx(ctx);
+		ntfs_attr_put_search_ctx(ctx);
 	if (m)
 		unmap_mft_record(dir_ni);
 	return ERR_MREF(err);
@@ -1125,7 +1125,7 @@
 	struct address_space *ia_mapping, *bmp_mapping;
 	struct page *bmp_page = NULL, *ia_page = NULL;
 	u8 *kaddr, *bmp, *index_end;
-	attr_search_context *ctx;
+	ntfs_attr_search_ctx *ctx;
 
 	fpos = filp->f_pos;
 	ntfs_debug("Entering for inode 0x%lx, fpos 0x%llx.",
@@ -1175,7 +1175,7 @@
 		m = NULL;
 		goto err_out;
 	}
-	ctx = get_attr_search_ctx(ndir, m);
+	ctx = ntfs_attr_get_search_ctx(ndir, m);
 	if (unlikely(!ctx)) {
 		err = -ENOMEM;
 		goto err_out;
@@ -1208,7 +1208,7 @@
 	/* Copy the index root value (it has been verified in read_inode). */
 	memcpy(ir, (u8*)ctx->attr +
 			le16_to_cpu(ctx->attr->data.resident.value_offset), rc);
-	put_attr_search_ctx(ctx);
+	ntfs_attr_put_search_ctx(ctx);
 	unmap_mft_record(ndir);
 	ctx = NULL;
 	m = NULL;
@@ -1460,7 +1460,7 @@
 	if (name)
 		kfree(name);
 	if (ctx)
-		put_attr_search_ctx(ctx);
+		ntfs_attr_put_search_ctx(ctx);
 	if (m)
 		unmap_mft_record(ndir);
 	if (!err)
diff -Nru a/fs/ntfs/index.c b/fs/ntfs/index.c
--- a/fs/ntfs/index.c	2004-09-22 13:02:48 +01:00
+++ b/fs/ntfs/index.c	2004-09-22 13:02:48 +01:00
@@ -65,7 +65,7 @@
 	if (ictx->entry) {
 		if (ictx->is_in_root) {
 			if (ictx->actx)
-				put_attr_search_ctx(ictx->actx);
+				ntfs_attr_put_search_ctx(ictx->actx);
 			if (ictx->base_ni)
 				unmap_mft_record(ictx->base_ni);
 		} else {
@@ -134,7 +134,7 @@
 	INDEX_ENTRY *ie;
 	INDEX_ALLOCATION *ia;
 	u8 *index_end;
-	attr_search_context *actx;
+	ntfs_attr_search_ctx *actx;
 	int rc, err = 0;
 	VCN vcn, old_vcn;
 	struct address_space *ia_mapping;
@@ -162,7 +162,7 @@
 				-PTR_ERR(m));
 		return PTR_ERR(m);
 	}
-	actx = get_attr_search_ctx(base_ni, m);
+	actx = ntfs_attr_get_search_ctx(base_ni, m);
 	if (unlikely(!actx)) {
 		err = -ENOMEM;
 		goto err_out;
@@ -269,7 +269,7 @@
 	 * We are done with the index root and the mft record.  Release them,
 	 * otherwise we deadlock with ntfs_map_page().
 	 */
-	put_attr_search_ctx(actx);
+	ntfs_attr_put_search_ctx(actx);
 	unmap_mft_record(base_ni);
 	m = NULL;
 	actx = NULL;
@@ -448,7 +448,7 @@
 	ntfs_unmap_page(page);
 err_out:
 	if (actx)
-		put_attr_search_ctx(actx);
+		ntfs_attr_put_search_ctx(actx);
 	if (m)
 		unmap_mft_record(base_ni);
 	return err;
diff -Nru a/fs/ntfs/index.h b/fs/ntfs/index.h
--- a/fs/ntfs/index.h	2004-09-22 13:02:48 +01:00
+++ b/fs/ntfs/index.h	2004-09-22 13:02:48 +01:00
@@ -78,7 +78,7 @@
 	u16 data_len;
 	BOOL is_in_root;
 	INDEX_ROOT *ir;
-	attr_search_context *actx;
+	ntfs_attr_search_ctx *actx;
 	ntfs_inode *base_ni;
 	INDEX_ALLOCATION *ia;
 	struct page *page;
diff -Nru a/fs/ntfs/inode.c b/fs/ntfs/inode.c
--- a/fs/ntfs/inode.c	2004-09-22 13:02:48 +01:00
+++ b/fs/ntfs/inode.c	2004-09-22 13:02:48 +01:00
@@ -430,12 +430,12 @@
  *	   0: file is not in $Extend directory
  *	-EIO: file is corrupt
  */
-static int ntfs_is_extended_system_file(attr_search_context *ctx)
+static int ntfs_is_extended_system_file(ntfs_attr_search_ctx *ctx)
 {
 	int nr_links;
 
 	/* Restart search. */
-	reinit_attr_search_ctx(ctx);
+	ntfs_attr_reinit_search_ctx(ctx);
 
 	/* Get number of hard links. */
 	nr_links = le16_to_cpu(ctx->mrec->link_count);
@@ -525,7 +525,7 @@
 	ntfs_inode *ni;
 	MFT_RECORD *m;
 	STANDARD_INFORMATION *si;
-	attr_search_context *ctx;
+	ntfs_attr_search_ctx *ctx;
 	int err = 0;
 
 	ntfs_debug("Entering for i_ino 0x%lx.", vi->i_ino);
@@ -557,7 +557,7 @@
 		err = PTR_ERR(m);
 		goto err_out;
 	}
-	ctx = get_attr_search_ctx(ni, m);
+	ctx = ntfs_attr_get_search_ctx(ni, m);
 	if (!ctx) {
 		err = -ENOMEM;
 		goto unm_err_out;
@@ -646,7 +646,7 @@
 	vi->i_atime = ntfs2utc(si->last_access_time);
 
 	/* Find the attribute list attribute if present. */
-	reinit_attr_search_ctx(ctx);
+	ntfs_attr_reinit_search_ctx(ctx);
 	if (ntfs_attr_lookup(AT_ATTRIBUTE_LIST, NULL, 0, 0, 0, NULL, 0, ctx)) {
 		if (vi->i_ino == FILE_MFT)
 			goto skip_attr_list_load;
@@ -733,7 +733,7 @@
 		char *ir_end, *index_end;
 
 		/* It is a directory, find index root attribute. */
-		reinit_attr_search_ctx(ctx);
+		ntfs_attr_reinit_search_ctx(ctx);
 		if (!ntfs_attr_lookup(AT_INDEX_ROOT, I30, 4, CASE_SENSITIVE, 0,
 				NULL, 0, ctx)) {
 			// FIXME: File is corrupt! Hot-fix with empty index
@@ -841,7 +841,7 @@
 			vi->i_size = ni->initialized_size =
 					ni->allocated_size = 0;
 			/* We are done with the mft record, so we release it. */
-			put_attr_search_ctx(ctx);
+			ntfs_attr_put_search_ctx(ctx);
 			unmap_mft_record(ni);
 			m = NULL;
 			ctx = NULL;
@@ -849,7 +849,7 @@
 		} /* LARGE_INDEX: Index allocation present. Setup state. */
 		NInoSetIndexAllocPresent(ni);
 		/* Find index allocation attribute. */
-		reinit_attr_search_ctx(ctx);
+		ntfs_attr_reinit_search_ctx(ctx);
 		if (!ntfs_attr_lookup(AT_INDEX_ALLOCATION, I30, 4,
 				CASE_SENSITIVE, 0, NULL, 0, ctx)) {
 			ntfs_error(vi->i_sb, "$INDEX_ALLOCATION attribute "
@@ -894,7 +894,7 @@
 		 * We are done with the mft record, so we release it. Otherwise
 		 * we would deadlock in ntfs_attr_iget().
 		 */
-		put_attr_search_ctx(ctx);
+		ntfs_attr_put_search_ctx(ctx);
 		unmap_mft_record(ni);
 		m = NULL;
 		ctx = NULL;
@@ -938,7 +938,7 @@
 		vi->i_mapping->a_ops = &ntfs_mst_aops;
 	} else {
 		/* It is a file. */
-		reinit_attr_search_ctx(ctx);
+		ntfs_attr_reinit_search_ctx(ctx);
 
 		/* Setup the data attribute, even if not present. */
 		ni->type = AT_DATA;
@@ -1059,7 +1059,7 @@
 		}
 no_data_attr_special_case:
 		/* We are done with the mft record, so we release it. */
-		put_attr_search_ctx(ctx);
+		ntfs_attr_put_search_ctx(ctx);
 		unmap_mft_record(ni);
 		m = NULL;
 		ctx = NULL;
@@ -1098,7 +1098,7 @@
 	if (!err)
 		err = -EIO;
 	if (ctx)
-		put_attr_search_ctx(ctx);
+		ntfs_attr_put_search_ctx(ctx);
 	if (m)
 		unmap_mft_record(ni);
 err_out:
@@ -1133,7 +1133,7 @@
 	ntfs_volume *vol = NTFS_SB(vi->i_sb);
 	ntfs_inode *ni, *base_ni;
 	MFT_RECORD *m;
-	attr_search_context *ctx;
+	ntfs_attr_search_ctx *ctx;
 	int err = 0;
 
 	ntfs_debug("Entering for i_ino 0x%lx.", vi->i_ino);
@@ -1162,7 +1162,7 @@
 		err = PTR_ERR(m);
 		goto err_out;
 	}
-	ctx = get_attr_search_ctx(base_ni, m);
+	ctx = ntfs_attr_get_search_ctx(base_ni, m);
 	if (!ctx) {
 		err = -ENOMEM;
 		goto unm_err_out;
@@ -1333,7 +1333,7 @@
 	ni->ext.base_ntfs_ino = base_ni;
 	ni->nr_extents = -1;
 
-	put_attr_search_ctx(ctx);
+	ntfs_attr_put_search_ctx(ctx);
 	unmap_mft_record(base_ni);
 
 	ntfs_debug("Done.");
@@ -1343,7 +1343,7 @@
 	if (!err)
 		err = -EIO;
 	if (ctx)
-		put_attr_search_ctx(ctx);
+		ntfs_attr_put_search_ctx(ctx);
 	unmap_mft_record(base_ni);
 err_out:
 	ntfs_error(vi->i_sb, "Failed with error code %i while reading "
@@ -1392,7 +1392,7 @@
 	ntfs_inode *ni, *base_ni, *bni;
 	struct inode *bvi;
 	MFT_RECORD *m;
-	attr_search_context *ctx;
+	ntfs_attr_search_ctx *ctx;
 	INDEX_ROOT *ir;
 	u8 *ir_end, *index_end;
 	int err = 0;
@@ -1419,7 +1419,7 @@
 		err = PTR_ERR(m);
 		goto err_out;
 	}
-	ctx = get_attr_search_ctx(base_ni, m);
+	ctx = ntfs_attr_get_search_ctx(base_ni, m);
 	if (!ctx) {
 		err = -ENOMEM;
 		goto unm_err_out;
@@ -1497,7 +1497,7 @@
 		/* No index allocation. */
 		vi->i_size = ni->initialized_size = ni->allocated_size = 0;
 		/* We are done with the mft record, so we release it. */
-		put_attr_search_ctx(ctx);
+		ntfs_attr_put_search_ctx(ctx);
 		unmap_mft_record(base_ni);
 		m = NULL;
 		ctx = NULL;
@@ -1505,7 +1505,7 @@
 	} /* LARGE_INDEX:  Index allocation present.  Setup state. */
 	NInoSetIndexAllocPresent(ni);
 	/* Find index allocation attribute. */
-	reinit_attr_search_ctx(ctx);
+	ntfs_attr_reinit_search_ctx(ctx);
 	if (!ntfs_attr_lookup(AT_INDEX_ALLOCATION, ni->name, ni->name_len,
 			CASE_SENSITIVE, 0, NULL, 0, ctx)) {
 		ntfs_error(vi->i_sb, "$INDEX_ALLOCATION attribute is not "
@@ -1546,7 +1546,7 @@
 	 * We are done with the mft record, so we release it.  Otherwise
 	 * we would deadlock in ntfs_attr_iget().
 	 */
-	put_attr_search_ctx(ctx);
+	ntfs_attr_put_search_ctx(ctx);
 	unmap_mft_record(base_ni);
 	m = NULL;
 	ctx = NULL;
@@ -1597,7 +1597,7 @@
 	if (!err)
 		err = -EIO;
 	if (ctx)
-		put_attr_search_ctx(ctx);
+		ntfs_attr_put_search_ctx(ctx);
 	if (m)
 		unmap_mft_record(base_ni);
 err_out:
@@ -1644,7 +1644,7 @@
 	ntfs_inode *ni;
 	MFT_RECORD *m = NULL;
 	ATTR_RECORD *attr;
-	attr_search_context *ctx;
+	ntfs_attr_search_ctx *ctx;
 	unsigned int i, nr_blocks;
 	int err;
 
@@ -1719,7 +1719,7 @@
 	/* Provides readpage() and sync_page() for map_mft_record(). */
 	vi->i_mapping->a_ops = &ntfs_mft_aops;
 
-	ctx = get_attr_search_ctx(ni, m);
+	ctx = ntfs_attr_get_search_ctx(ni, m);
 	if (!ctx) {
 		err = -ENOMEM;
 		goto err_out;
@@ -1855,7 +1855,7 @@
 		}
 	}
 
-	reinit_attr_search_ctx(ctx);
+	ntfs_attr_reinit_search_ctx(ctx);
 
 	/* Now load all attribute extents. */
 	attr = NULL;
@@ -1955,7 +1955,7 @@
 						"saw this message to "
 						"linux-ntfs-dev@lists."
 						"sourceforge.net");
-				put_attr_search_ctx(ctx);
+				ntfs_attr_put_search_ctx(ctx);
 				/* Revert to the safe super operations. */
 				ntfs_free(m);
 				return -1;
@@ -2005,7 +2005,7 @@
 				(unsigned long long)last_vcn - 1);
 		goto put_err_out;
 	}
-	put_attr_search_ctx(ctx);
+	ntfs_attr_put_search_ctx(ctx);
 	ntfs_debug("Done.");
 	ntfs_free(m);
 	return 0;
@@ -2014,7 +2014,7 @@
 	ntfs_error(sb, "Couldn't find first extent of $DATA attribute in "
 			"attribute list. $MFT is corrupt. Run chkdsk.");
 put_err_out:
-	put_attr_search_ctx(ctx);
+	ntfs_attr_put_search_ctx(ctx);
 err_out:
 	ntfs_error(sb, "Failed. Marking inode as bad.");
 	make_bad_inode(vi);
@@ -2317,7 +2317,7 @@
 {
 	s64 nt;
 	ntfs_inode *ni = NTFS_I(vi);
-	attr_search_context *ctx;
+	ntfs_attr_search_ctx *ctx;
 	MFT_RECORD *m;
 	STANDARD_INFORMATION *si;
 	int err = 0;
@@ -2342,14 +2342,14 @@
 		goto err_out;
 	}
 	/* Update the access times in the standard information attribute. */
-	ctx = get_attr_search_ctx(ni, m);
+	ctx = ntfs_attr_get_search_ctx(ni, m);
 	if (unlikely(!ctx)) {
 		err = -ENOMEM;
 		goto unm_err_out;
 	}
 	if (unlikely(!ntfs_attr_lookup(AT_STANDARD_INFORMATION, NULL, 0,
 			CASE_SENSITIVE, 0, NULL, 0, ctx))) {
-		put_attr_search_ctx(ctx);
+		ntfs_attr_put_search_ctx(ctx);
 		err = -ENOENT;
 		goto unm_err_out;
 	}
@@ -2395,7 +2395,7 @@
 	 */
 	if (modified && !NInoTestSetDirty(ctx->ntfs_ino))
 		__set_page_dirty_nobuffers(ctx->ntfs_ino->page);
-	put_attr_search_ctx(ctx);
+	ntfs_attr_put_search_ctx(ctx);
 	/* Now the access times are updated, write the base mft record. */
 	if (NInoDirty(ni))
 		err = write_mft_record(ni, m, sync);
diff -Nru a/fs/ntfs/namei.c b/fs/ntfs/namei.c
--- a/fs/ntfs/namei.c	2004-09-22 13:02:48 +01:00
+++ b/fs/ntfs/namei.c	2004-09-22 13:02:48 +01:00
@@ -171,7 +171,7 @@
    {
 	struct dentry *real_dent, *new_dent;
 	MFT_RECORD *m;
-	attr_search_context *ctx;
+	ntfs_attr_search_ctx *ctx;
 	ntfs_inode *ni = NTFS_I(dent_inode);
 	int err;
 	struct qstr nls_name;
@@ -196,7 +196,7 @@
 			ctx = NULL;
 			goto err_out;
 		}
-		ctx = get_attr_search_ctx(ni, m);
+		ctx = ntfs_attr_get_search_ctx(ni, m);
 		if (!ctx) {
 			err = -ENOMEM;
 			goto err_out;
@@ -233,7 +233,7 @@
 				(ntfschar*)&fn->file_name, fn->file_name_length,
 				(unsigned char**)&nls_name.name, 0);
 
-		put_attr_search_ctx(ctx);
+		ntfs_attr_put_search_ctx(ctx);
 		unmap_mft_record(ni);
 	}
 	m = NULL;
@@ -329,7 +329,7 @@
 	err = -EIO;
 err_out:
 	if (ctx)
-		put_attr_search_ctx(ctx);
+		ntfs_attr_put_search_ctx(ctx);
 	if (m)
 		unmap_mft_record(ni);
 	iput(dent_inode);
@@ -366,7 +366,7 @@
 	struct inode *vi = child_dent->d_inode;
 	ntfs_inode *ni = NTFS_I(vi);
 	MFT_RECORD *mrec;
-	attr_search_context *ctx;
+	ntfs_attr_search_ctx *ctx;
 	ATTR_RECORD *attr;
 	FILE_NAME_ATTR *fn;
 	struct inode *parent_vi;
@@ -379,7 +379,7 @@
 	if (IS_ERR(mrec))
 		return (struct dentry *)mrec;
 	/* Find the first file name attribute in the mft record. */
-	ctx = get_attr_search_ctx(ni, mrec);
+	ctx = ntfs_attr_get_search_ctx(ni, mrec);
 	if (unlikely(!ctx)) {
 		unmap_mft_record(ni);
 		return ERR_PTR(-ENOMEM);
@@ -387,7 +387,7 @@
 try_next:
 	if (unlikely(!ntfs_attr_lookup(AT_FILE_NAME, NULL, 0, CASE_SENSITIVE,
 			0, NULL, 0, ctx))) {
-		put_attr_search_ctx(ctx);
+		ntfs_attr_put_search_ctx(ctx);
 		unmap_mft_record(ni);
 		ntfs_error(vi->i_sb, "Inode 0x%lx does not have a file name "
 				"attribute. Run chkdsk.", vi->i_ino);
@@ -404,7 +404,7 @@
 	/* Get the inode number of the parent directory. */
 	parent_ino = MREF_LE(fn->parent_directory);
 	/* Release the search context and the mft record of the child. */
-	put_attr_search_ctx(ctx);
+	ntfs_attr_put_search_ctx(ctx);
 	unmap_mft_record(ni);
 	/* Get the inode of the parent directory. */
 	parent_vi = ntfs_iget(vi->i_sb, parent_ino);
diff -Nru a/fs/ntfs/super.c b/fs/ntfs/super.c
--- a/fs/ntfs/super.c	2004-09-22 13:02:47 +01:00
+++ b/fs/ntfs/super.c	2004-09-22 13:02:48 +01:00
@@ -318,7 +318,7 @@
 	ntfs_inode *ni = NTFS_I(vol->vol_ino);
 	MFT_RECORD *m;
 	VOLUME_INFORMATION *vi;
-	attr_search_context *ctx;
+	ntfs_attr_search_ctx *ctx;
 	int err;
 
 	ntfs_debug("Entering, old flags = 0x%x, new flags = 0x%x.",
@@ -331,7 +331,7 @@
 		err = PTR_ERR(m);
 		goto err_out;
 	}
-	ctx = get_attr_search_ctx(ni, m);
+	ctx = ntfs_attr_get_search_ctx(ni, m);
 	if (!ctx) {
 		err = -ENOMEM;
 		goto put_unm_err_out;
@@ -346,14 +346,14 @@
 	vol->vol_flags = vi->flags = flags;
 	flush_dcache_mft_record_page(ctx->ntfs_ino);
 	mark_mft_record_dirty(ctx->ntfs_ino);
-	put_attr_search_ctx(ctx);
+	ntfs_attr_put_search_ctx(ctx);
 	unmap_mft_record(ni);
 done:
 	ntfs_debug("Done.");
 	return 0;
 put_unm_err_out:
 	if (ctx)
-		put_attr_search_ctx(ctx);
+		ntfs_attr_put_search_ctx(ctx);
 	unmap_mft_record(ni);
 err_out:
 	ntfs_error(vol->sb, "Failed with error code %i.", -err);
@@ -1345,7 +1345,7 @@
 	struct super_block *sb = vol->sb;
 	MFT_RECORD *m;
 	VOLUME_INFORMATION *vi;
-	attr_search_context *ctx;
+	ntfs_attr_search_ctx *ctx;
 
 	ntfs_debug("Entering.");
 #ifdef NTFS_RW
@@ -1429,14 +1429,14 @@
 		iput(vol->vol_ino);
 		goto volume_failed;
 	}
-	if (!(ctx = get_attr_search_ctx(NTFS_I(vol->vol_ino), m))) {
+	if (!(ctx = ntfs_attr_get_search_ctx(NTFS_I(vol->vol_ino), m))) {
 		ntfs_error(sb, "Failed to get attribute search context.");
 		goto get_ctx_vol_failed;
 	}
 	if (!ntfs_attr_lookup(AT_VOLUME_INFORMATION, NULL, 0, 0, 0, NULL, 0,
 			ctx) || ctx->attr->non_resident || ctx->attr->flags) {
 err_put_vol:
-		put_attr_search_ctx(ctx);
+		ntfs_attr_put_search_ctx(ctx);
 get_ctx_vol_failed:
 		unmap_mft_record(NTFS_I(vol->vol_ino));
 		goto iput_volume_failed;
@@ -1452,7 +1452,7 @@
 	vol->vol_flags = vi->flags;
 	vol->major_ver = vi->major_ver;
 	vol->minor_ver = vi->minor_ver;
-	put_attr_search_ctx(ctx);
+	ntfs_attr_put_search_ctx(ctx);
 	unmap_mft_record(NTFS_I(vol->vol_ino));
 	printk(KERN_INFO "NTFS volume version %i.%i.\n", vol->major_ver,
 			vol->minor_ver);
@@ -2629,7 +2629,7 @@
 		goto ictx_err_out;
 	}
 	ntfs_attr_ctx_cache = kmem_cache_create(ntfs_attr_ctx_cache_name,
-			sizeof(attr_search_context), 0 /* offset */,
+			sizeof(ntfs_attr_search_ctx), 0 /* offset */,
 			SLAB_HWCACHE_ALIGN, NULL /* ctor */, NULL /* dtor */);
 	if (!ntfs_attr_ctx_cache) {
 		printk(KERN_CRIT "NTFS: Failed to create %s!\n",
