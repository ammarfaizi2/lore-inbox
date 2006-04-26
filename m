Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932333AbWDZBtN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932333AbWDZBtN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 21:49:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932334AbWDZBtN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 21:49:13 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.193]:12273 "EHLO
	tyo201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S932333AbWDZBtM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 21:49:12 -0400
To: ext2-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [UPDATE][13/21]e2fsprogs modify format strings
Message-Id: <20060426104903sho@rifu.tnes.nec.co.jp>
Mime-Version: 1.0
X-Mailer: WeMail32[2.51] ID:1K0086
From: sho@tnes.nec.co.jp
Date: Wed, 26 Apr 2006 10:49:03 +0900
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Summary of this patch:
  [13/21] modify format strings in print
          - change the format strings "%d" and "%ld" to "%u" and "%lu"
            respectively.

Signed-off-by: Takashi Sato sho@tnes.nec.co.jp
---
diff -upNr e2fsprogs-1.39/debugfs/htree.c e2fsprogs-1.39.tmp/debugfs/htree.c
--- e2fsprogs-1.39/debugfs/htree.c	2006-04-12 11:21:58.000000000 +0900
+++ e2fsprogs-1.39.tmp/debugfs/htree.c	2006-04-12 11:38:34.000000000 +0900
@@ -114,7 +114,7 @@ static void htree_dump_int_node(ext2_fil
 
 	for (i=0; i < limit.count; i++) {
 		hash = i ? ext2fs_le32_to_cpu(ent[i].hash) : 0;
-		fprintf(pager, "Entry #%d: Hash 0x%08x%s, block %d\n", i,
+		fprintf(pager, "Entry #%d: Hash 0x%08x%s, block %u\n", i,
 			hash, (hash & 1) ? " (**)" : "",
 			ext2fs_le32_to_cpu(ent[i].block));
 		}
diff -upNr e2fsprogs-1.39/e2fsck/unix.c e2fsprogs-1.39.tmp/e2fsck/unix.c
--- e2fsprogs-1.39/e2fsck/unix.c	2006-04-12 11:21:58.000000000 +0900
+++ e2fsprogs-1.39.tmp/e2fsck/unix.c	2006-04-12 11:46:23.000000000 +0900
@@ -118,49 +118,49 @@ static void show_stats(e2fsck_t	ctx)
 	frag_percent = (frag_percent + 5) / 10;
 	
 	if (!verbose) {
-		printf(_("%s: %d/%d files (%0d.%d%% non-contiguous), %u/%u blocks\n"),
+		printf(_("%s: %u/%u files (%0d.%d%% non-contiguous), %u/%u blocks\n"),
 		       ctx->device_name, inodes_used, inodes,
 		       frag_percent / 10, frag_percent % 10,
 		       blocks_used, blocks);
 		return;
 	}
-	printf (P_("\n%8d inode used (%d%%)\n", "\n%8d inodes used (%d%%)\n",
-		   inodes_used), inodes_used, 100 * inodes_used / inodes);
+	printf (P_("\n%8d inode used (%u%%)\n", "\n%8d inodes used (%u%%)\n",
+		   inodes_used), inodes_used, 100 * (__u64)inodes_used / inodes);
 	printf (P_("%8d non-contiguous inode (%0d.%d%%)\n",
 		   "%8d non-contiguous inodes (%0d.%d%%)\n",
 		   ctx->fs_fragmented),
 		ctx->fs_fragmented, frag_percent / 10, frag_percent % 10);
-	printf (_("         # of inodes with ind/dind/tind blocks: %d/%d/%d\n"),
+	printf (_("         # of inodes with ind/dind/tind blocks: %u/%u/%u\n"),
 		ctx->fs_ind_count, ctx->fs_dind_count, ctx->fs_tind_count);
 	printf (P_("%8u block used (%d%%)\n", "%8u blocks used (%d%%)\n",
 		   blocks_used),
 		blocks_used, (int) ((long long) 100 * blocks_used / blocks));
 	printf (P_("%8d bad block\n", "%8d bad blocks\n",
 		   ctx->fs_badblocks_count), ctx->fs_badblocks_count);
-	printf (P_("%8d large file\n", "%8d large files\n",
+	printf (P_("%8u large file\n", "%8u large files\n",
 		   ctx->large_files), ctx->large_files);
-	printf (P_("\n%8d regular file\n", "\n%8d regular files\n",
+	printf (P_("\n%8u regular file\n", "\n%8u regular files\n",
 		   ctx->fs_regular_count), ctx->fs_regular_count);
-	printf (P_("%8d directory\n", "%8d directories\n",
+	printf (P_("%8u directory\n", "%8u directories\n",
 		   ctx->fs_directory_count), ctx->fs_directory_count);
-	printf (P_("%8d character device file\n",
-		   "%8d character device files\n", ctx->fs_chardev_count),
+	printf (P_("%8u character device file\n",
+		   "%8u character device files\n", ctx->fs_chardev_count),
 		ctx->fs_chardev_count);
-	printf (P_("%8d block device file\n", "%8d block device files\n",
+	printf (P_("%8u block device file\n", "%8u block device files\n",
 		   ctx->fs_blockdev_count), ctx->fs_blockdev_count);
-	printf (P_("%8d fifo\n", "%8d fifos\n", ctx->fs_fifo_count),
+	printf (P_("%8u fifo\n", "%8u fifos\n", ctx->fs_fifo_count),
 		ctx->fs_fifo_count);
-	printf (P_("%8d link\n", "%8d links\n",
+	printf (P_("%8u link\n", "%8u links\n",
 		   ctx->fs_links_count - dir_links),
 		ctx->fs_links_count - dir_links);
-	printf (P_("%8d symbolic link", "%8d symbolic links",
+	printf (P_("%8u symbolic link", "%8u symbolic links",
 		   ctx->fs_symlinks_count), ctx->fs_symlinks_count);
-	printf (P_(" (%d fast symbolic link)\n", " (%d fast symbolic links)\n",
+	printf (P_(" (%u fast symbolic link)\n", " (%u fast symbolic links)\n",
 		   ctx->fs_fast_symlinks_count), ctx->fs_fast_symlinks_count);
-	printf (P_("%8d socket\n", "%8d sockets\n", ctx->fs_sockets_count),
+	printf (P_("%8u socket\n", "%8u sockets\n", ctx->fs_sockets_count),
 		ctx->fs_sockets_count);
 	printf ("--------\n");
-	printf (P_("%8d file\n", "%8d files\n",
+	printf (P_("%8u file\n", "%8u files\n",
 		   ctx->fs_total_count - dir_links),
 		ctx->fs_total_count - dir_links);
 }
@@ -300,7 +300,7 @@ static void check_if_skip(e2fsck_t ctx)
 		fputs(_(", check forced.\n"), stdout);
 		return;
 	}
-	printf(_("%s: clean, %d/%d files, %u/%u blocks"), ctx->device_name,
+	printf(_("%s: clean, %u/%u files, %u/%u blocks"), ctx->device_name,
 	       fs->super->s_inodes_count - fs->super->s_free_inodes_count,
 	       fs->super->s_inodes_count,
 	       fs->super->s_blocks_count - fs->super->s_free_blocks_count,
diff -upNr e2fsprogs-1.39/misc/mke2fs.c e2fsprogs-1.39.tmp/misc/mke2fs.c
--- e2fsprogs-1.39/misc/mke2fs.c	2006-04-12 11:21:58.000000000 +0900
+++ e2fsprogs-1.39.tmp/misc/mke2fs.c	2006-04-12 11:49:33.000000000 +0900
@@ -644,8 +644,8 @@ static void show_stats(ext2_filsys fs)
 	       100.0 * s->s_r_blocks_count / s->s_blocks_count);
 	printf(_("First data block=%u\n"), s->s_first_data_block);
 	if (s->s_reserved_gdt_blocks)
-		printf(_("Maximum filesystem blocks=%lu\n"),
-		       (s->s_reserved_gdt_blocks + fs->desc_blocks) *
+		printf(_("Maximum filesystem blocks=%llu\n"),
+		       ((__u64)s->s_reserved_gdt_blocks + fs->desc_blocks) *
 		       (fs->blocksize / sizeof(struct ext2_group_desc)) *
 		       s->s_blocks_per_group);
 	if (fs->group_desc_count > 1)
