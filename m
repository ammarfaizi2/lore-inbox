Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317117AbSIAPXX>; Sun, 1 Sep 2002 11:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317181AbSIAPXX>; Sun, 1 Sep 2002 11:23:23 -0400
Received: from louise.pinerecords.com ([212.71.160.16]:15114 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id <S317117AbSIAPXX>; Sun, 1 Sep 2002 11:23:23 -0400
Date: Sun, 1 Sep 2002 17:27:44 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org, davem@redhat.com
Subject: [PATCH] warnkill trivia 2/2 (correction)
Message-ID: <20020901152744.GF7325@louise.pinerecords.com>
References: <20020901105643.GH32122@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020901105643.GH32122@louise.pinerecords.com>
User-Agent: Mutt/1.4i
X-OS: GNU/Linux 2.4.20-pre1/sparc SMP
X-Uptime: 7 days, 4:02
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2.4.20-pre5: prevent sparc32's atomic_read() from possibly discarding
> const qualifiers from pointers passed as its argument.

Ok, the only reasonable way to deal with the last reiserfs vs.
sparc32 compilation warning is apparently to strip the const from
the wait_buffer_until_released() prototype, as it doesn't make any
sense there. Marcelo please disregard the atomic_read() patch and
apply the following instead:


diff -urN linux-2.4.20-pre5/fs/reiserfs/buffer2.c linux-2.4.20-pre5.n/fs/reiserfs/buffer2.c
--- linux-2.4.20-pre5/fs/reiserfs/buffer2.c	2002-09-01 17:19:26.000000000 +0200
+++ linux-2.4.20-pre5.n/fs/reiserfs/buffer2.c	2002-09-01 17:07:27.000000000 +0200
@@ -21,7 +21,7 @@
    hold we did free all buffers in tree balance structure
    (get_empty_nodes and get_nodes_for_preserving) or in path structure
    only (get_new_buffer) just before calling this */
-void wait_buffer_until_released (const struct buffer_head * bh)
+void wait_buffer_until_released (struct buffer_head *bh)
 {
   int repeat_counter = 0;
 
diff -urN linux-2.4.20-pre5/include/linux/reiserfs_fs.h linux-2.4.20-pre5.n/include/linux/reiserfs_fs.h
--- linux-2.4.20-pre5/include/linux/reiserfs_fs.h	2002-09-01 17:19:27.000000000 +0200
+++ linux-2.4.20-pre5.n/include/linux/reiserfs_fs.h	2002-09-01 17:16:32.000000000 +0200
@@ -1845,7 +1847,7 @@
 
 /* buffer2.c */
 struct buffer_head * reiserfs_getblk (kdev_t n_dev, int n_block, int n_size);
-void wait_buffer_until_released (const struct buffer_head * bh);
+void wait_buffer_until_released (struct buffer_head *bh);
 struct buffer_head * reiserfs_bread (struct super_block *super, int n_block, 
 				     int n_size);
 
