Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267765AbUH1BUO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267765AbUH1BUO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 21:20:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268095AbUH1BUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 21:20:14 -0400
Received: from hera.cwi.nl ([192.16.191.8]:21985 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S267765AbUH1BUF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 21:20:05 -0400
Date: Sat, 28 Aug 2004 03:19:59 +0200
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andries.Brouwer@cwi.nl, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] remove unused ext2_panic
Message-ID: <20040828011959.GC16444@apps.cwi.nl>
References: <UTC200408271606.i7RG6tV27596.aeb@smtp.cwi.nl> <Pine.LNX.4.58.0408271104300.14196@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0408271104300.14196@ppc970.osdl.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 27, 2004 at 11:04:59AM -0700, Linus Torvalds wrote:

> Fixed (slightly differently) in current -BK.

Don't see it yet. Something else: ext2_panic is unused, it seems.

Andries

diff -uprN -X /linux/dontdiff a/fs/ext2/ext2.h b/fs/ext2/ext2.h
--- a/fs/ext2/ext2.h	2003-12-18 03:59:56.000000000 +0100
+++ b/fs/ext2/ext2.h	2004-08-28 03:19:30.000000000 +0200
@@ -131,9 +131,6 @@ extern int ext2_ioctl (struct inode *, s
 /* super.c */
 extern void ext2_error (struct super_block *, const char *, const char *, ...)
 	__attribute__ ((format (printf, 3, 4)));
-extern NORET_TYPE void ext2_panic (struct super_block *, const char *,
-				   const char *, ...)
-	__attribute__ ((NORET_AND format (printf, 3, 4)));
 extern void ext2_warning (struct super_block *, const char *, const char *, ...)
 	__attribute__ ((format (printf, 3, 4)));
 extern void ext2_update_dynamic_rev (struct super_block *sb);
diff -uprN -X /linux/dontdiff a/fs/ext2/super.c b/fs/ext2/super.c
--- a/fs/ext2/super.c	2004-05-28 20:53:22.000000000 +0200
+++ b/fs/ext2/super.c	2004-08-28 03:20:00.000000000 +0200
@@ -66,27 +66,6 @@ void ext2_error (struct super_block * sb
 	}
 }
 
-NORET_TYPE void ext2_panic (struct super_block * sb, const char * function,
-			    const char * fmt, ...)
-{
-	va_list args;
-	struct ext2_sb_info *sbi = EXT2_SB(sb);
-
-	if (!(sb->s_flags & MS_RDONLY)) {
-		sbi->s_mount_state |= EXT2_ERROR_FS;
-		sbi->s_es->s_state =
-			cpu_to_le16(le16_to_cpu(sbi->s_es->s_state) | EXT2_ERROR_FS);
-		mark_buffer_dirty(sbi->s_sbh);
-		sb->s_dirt = 1;
-	}
-	va_start (args, fmt);
-	vsprintf (error_buf, fmt, args);
-	va_end (args);
-	sb->s_flags |= MS_RDONLY;
-	panic ("EXT2-fs panic (device %s): %s: %s\n",
-	       sb->s_id, function, error_buf);
-}
-
 void ext2_warning (struct super_block * sb, const char * function,
 		   const char * fmt, ...)
 {
