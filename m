Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422842AbWAMTS1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422842AbWAMTS1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 14:18:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422840AbWAMTS1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 14:18:27 -0500
Received: from mx2.mail.ru ([194.67.23.122]:39304 "EHLO mx2.mail.ru")
	by vger.kernel.org with ESMTP id S1422839AbWAMTSZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 14:18:25 -0500
Date: Fri, 13 Jan 2006 22:05:24 +0300
From: Evgeniy <dushistov@mail.ru>
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: [PATCH 2.6.15] ufs cleanup
Message-ID: <20060113190524.GA31715@rain.homenetwork>
Mail-Followup-To: Linus Torvalds <torvalds@osdl.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20060113005450.GA7971@mipter.zuzino.mipt.ru> <Pine.LNX.4.64.0601121700041.3535@g5.osdl.org> <20060113102136.GA7868@mipter.zuzino.mipt.ru> <Pine.LNX.4.64.0601130739540.3535@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0601130739540.3535@g5.osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 13, 2006 at 07:45:12AM -0800, Linus Torvalds wrote:
> Evgeniy - That is one ugly macro, can you (or Alexey, for that matter: 
> somebody who can test it) turn it into an inline function or something to 
> make it half-way readable? I realize that means changing the arguments too 
> (right now that horrid macro accesses "uspi" directly - uggghhh).

You mean something like this?

This patch converts ubh_get_usb_* to inline functions.

Signed-off-by: Evgeniy Dushistov <dushistov@mail.ru>

---


diff -uprN -X linux-2.6.15-vanilla/Documentation/dontdiff linux-2.6.15-vanilla/fs/ufs/balloc.c linux-2.6.15/fs/ufs/balloc.c
--- linux-2.6.15-vanilla/fs/ufs/balloc.c	2006-01-03 06:21:10.000000000 +0300
+++ linux-2.6.15/fs/ufs/balloc.c	2006-01-13 21:32:50.308214250 +0300
@@ -48,7 +48,7 @@ void ufs_free_fragments (struct inode * 
 	
 	sb = inode->i_sb;
 	uspi = UFS_SB(sb)->s_uspi;
-	usb1 = ubh_get_usb_first(USPI_UBH);
+	usb1 = ubh_get_usb_first(uspi);
 	
 	UFSD(("ENTER, fragment %u, count %u\n", fragment, count))
 	
@@ -142,7 +142,7 @@ void ufs_free_blocks (struct inode * ino
 	
 	sb = inode->i_sb;
 	uspi = UFS_SB(sb)->s_uspi;
-	usb1 = ubh_get_usb_first(USPI_UBH);
+	usb1 = ubh_get_usb_first(uspi);
 
 	UFSD(("ENTER, fragment %u, count %u\n", fragment, count))
 	
@@ -246,7 +246,7 @@ unsigned ufs_new_fragments (struct inode
 	
 	sb = inode->i_sb;
 	uspi = UFS_SB(sb)->s_uspi;
-	usb1 = ubh_get_usb_first(USPI_UBH);
+	usb1 = ubh_get_usb_first(uspi);
 	*err = -ENOSPC;
 
 	lock_super (sb);
@@ -406,7 +406,7 @@ ufs_add_fragments (struct inode * inode,
 	
 	sb = inode->i_sb;
 	uspi = UFS_SB(sb)->s_uspi;
-	usb1 = ubh_get_usb_first (USPI_UBH);
+	usb1 = ubh_get_usb_first (uspi);
 	count = newcount - oldcount;
 	
 	cgno = ufs_dtog(fragment);
@@ -489,7 +489,7 @@ static unsigned ufs_alloc_fragments (str
 
 	sb = inode->i_sb;
 	uspi = UFS_SB(sb)->s_uspi;
-	usb1 = ubh_get_usb_first(USPI_UBH);
+	usb1 = ubh_get_usb_first(uspi);
 	oldcg = cgno;
 	
 	/*
@@ -605,7 +605,7 @@ static unsigned ufs_alloccg_block (struc
 
 	sb = inode->i_sb;
 	uspi = UFS_SB(sb)->s_uspi;
-	usb1 = ubh_get_usb_first(USPI_UBH);
+	usb1 = ubh_get_usb_first(uspi);
 	ucg = ubh_get_ucg(UCPI_UBH);
 
 	if (goal == 0) {
@@ -662,7 +662,7 @@ static unsigned ufs_bitmap_search (struc
 	UFSD(("ENTER, cg %u, goal %u, count %u\n", ucpi->c_cgx, goal, count))
 
 	uspi = UFS_SB(sb)->s_uspi;
-	usb1 = ubh_get_usb_first (USPI_UBH);
+	usb1 = ubh_get_usb_first (uspi);
 	ucg = ubh_get_ucg(UCPI_UBH);
 
 	if (goal)
diff -uprN -X linux-2.6.15-vanilla/Documentation/dontdiff linux-2.6.15-vanilla/fs/ufs/ialloc.c linux-2.6.15/fs/ufs/ialloc.c
--- linux-2.6.15-vanilla/fs/ufs/ialloc.c	2006-01-03 06:21:10.000000000 +0300
+++ linux-2.6.15/fs/ufs/ialloc.c	2006-01-13 21:32:50.328215500 +0300
@@ -72,7 +72,7 @@ void ufs_free_inode (struct inode * inod
 
 	sb = inode->i_sb;
 	uspi = UFS_SB(sb)->s_uspi;
-	usb1 = ubh_get_usb_first(USPI_UBH);
+	usb1 = ubh_get_usb_first(uspi);
 	
 	ino = inode->i_ino;
 
@@ -167,7 +167,7 @@ struct inode * ufs_new_inode(struct inod
 	ufsi = UFS_I(inode);
 	sbi = UFS_SB(sb);
 	uspi = sbi->s_uspi;
-	usb1 = ubh_get_usb_first(USPI_UBH);
+	usb1 = ubh_get_usb_first(uspi);
 
 	lock_super (sb);
 
diff -uprN -X linux-2.6.15-vanilla/Documentation/dontdiff linux-2.6.15-vanilla/fs/ufs/super.c linux-2.6.15/fs/ufs/super.c
--- linux-2.6.15-vanilla/fs/ufs/super.c	2006-01-03 06:21:10.000000000 +0300
+++ linux-2.6.15/fs/ufs/super.c	2006-01-13 21:32:50.336216000 +0300
@@ -221,7 +221,7 @@ void ufs_error (struct super_block * sb,
 	va_list args;
 
 	uspi = UFS_SB(sb)->s_uspi;
-	usb1 = ubh_get_usb_first(USPI_UBH);
+	usb1 = ubh_get_usb_first(uspi);
 	
 	if (!(sb->s_flags & MS_RDONLY)) {
 		usb1->fs_clean = UFS_FSBAD;
@@ -253,7 +253,7 @@ void ufs_panic (struct super_block * sb,
 	va_list args;
 	
 	uspi = UFS_SB(sb)->s_uspi;
-	usb1 = ubh_get_usb_first(USPI_UBH);
+	usb1 = ubh_get_usb_first(uspi);
 	
 	if (!(sb->s_flags & MS_RDONLY)) {
 		usb1->fs_clean = UFS_FSBAD;
@@ -735,9 +735,9 @@ again:	
             goto failed;
 
 	
-	usb1 = ubh_get_usb_first(USPI_UBH);
-	usb2 = ubh_get_usb_second(USPI_UBH);
-	usb3 = ubh_get_usb_third(USPI_UBH);
+	usb1 = ubh_get_usb_first(uspi);
+	usb2 = ubh_get_usb_second(uspi);
+	usb3 = ubh_get_usb_third(uspi);
 	usb  = (struct ufs_super_block *)
 		((struct ufs_buffer_head *)uspi)->bh[0]->b_data ;
 
@@ -1006,8 +1006,8 @@ static void ufs_write_super (struct supe
 	UFSD(("ENTER\n"))
 	flags = UFS_SB(sb)->s_flags;
 	uspi = UFS_SB(sb)->s_uspi;
-	usb1 = ubh_get_usb_first(USPI_UBH);
-	usb3 = ubh_get_usb_third(USPI_UBH);
+	usb1 = ubh_get_usb_first(uspi);
+	usb3 = ubh_get_usb_third(uspi);
 
 	if (!(sb->s_flags & MS_RDONLY)) {
 		usb1->fs_time = cpu_to_fs32(sb, get_seconds());
@@ -1049,8 +1049,8 @@ static int ufs_remount (struct super_blo
 	
 	uspi = UFS_SB(sb)->s_uspi;
 	flags = UFS_SB(sb)->s_flags;
-	usb1 = ubh_get_usb_first(USPI_UBH);
-	usb3 = ubh_get_usb_third(USPI_UBH);
+	usb1 = ubh_get_usb_first(uspi);
+	usb3 = ubh_get_usb_third(uspi);
 	
 	/*
 	 * Allow the "check" option to be passed as a remount option.
@@ -1124,7 +1124,7 @@ static int ufs_statfs (struct super_bloc
 	lock_kernel();
 
 	uspi = UFS_SB(sb)->s_uspi;
-	usb1 = ubh_get_usb_first (USPI_UBH);
+	usb1 = ubh_get_usb_first (uspi);
 	usb  = (struct ufs_super_block *)
 		((struct ufs_buffer_head *)uspi)->bh[0]->b_data ;
 	
diff -uprN -X linux-2.6.15-vanilla/Documentation/dontdiff linux-2.6.15-vanilla/fs/ufs/util.h linux-2.6.15/fs/ufs/util.h
--- linux-2.6.15-vanilla/fs/ufs/util.h	2006-01-13 21:28:46.724991250 +0300
+++ linux-2.6.15/fs/ufs/util.h	2006-01-13 21:32:50.344216500 +0300
@@ -249,18 +249,30 @@ extern void _ubh_memcpyubh_(struct ufs_s
 
 
 /*
- * macros to get important structures from ufs_buffer_head
+ * inline functions to get important structures from ufs_sb_private_info
  */
-#define ubh_get_usb_first(ubh) \
-	((struct ufs_super_block_first *)((ubh)->bh[0]->b_data))
+static inline struct ufs_super_block_first *
+ubh_get_usb_first(struct ufs_sb_private_info *uspi)
+{
+	char *res=uspi->s_ubh.bh[0]->b_data;
+	return (struct ufs_super_block_first *)res;
+}
 
-#define ubh_get_usb_second(ubh) \
-	((struct ufs_super_block_second *)((ubh)->\
-					   bh[UFS_SECTOR_SIZE >> uspi->s_fshift]->b_data + (UFS_SECTOR_SIZE & ~uspi->s_fmask)))
-
-#define ubh_get_usb_third(ubh) \
-	((struct ufs_super_block_third *)((ubh)-> \
-	bh[UFS_SECTOR_SIZE*2 >> uspi->s_fshift]->b_data + (UFS_SECTOR_SIZE*2 & ~uspi->s_fmask)))
+static inline struct ufs_super_block_second *
+ubh_get_usb_second(struct ufs_sb_private_info *uspi)
+{
+	char *res=uspi->s_ubh.bh[UFS_SECTOR_SIZE >> uspi->s_fshift]->b_data + 
+		(UFS_SECTOR_SIZE & ~uspi->s_fmask);
+	return (struct ufs_super_block_second *)res;
+}
+
+static inline struct ufs_super_block_third *
+ubh_get_usb_third(struct ufs_sb_private_info *uspi)
+{
+	char *res=uspi->s_ubh.bh[UFS_SECTOR_SIZE*2 >> uspi->s_fshift]->b_data + 
+		(UFS_SECTOR_SIZE*2 & ~uspi->s_fmask);	
+	return (struct ufs_super_block_third *)res;
+}
 
 #define ubh_get_ucg(ubh) \
 	((struct ufs_cylinder_group *)((ubh)->bh[0]->b_data))

-- 
/Evgeniy

