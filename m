Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264355AbUEXTC7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264355AbUEXTC7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 15:02:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264424AbUEXTC7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 15:02:59 -0400
Received: from outmx007.isp.belgacom.be ([195.238.3.234]:8665 "EHLO
	outmx007.isp.belgacom.be") by vger.kernel.org with ESMTP
	id S264355AbUEXTC4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 15:02:56 -0400
Subject: [PATCH 2.6.7-rc1] ext2 debugger broken
From: FabF <fabian.frederick@skynet.be>
To: linus@osdl.org
Cc: lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-cSt93GRzMviaJuBGz6Lf"
Message-Id: <1085423455.5746.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 24 May 2004 20:30:55 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-cSt93GRzMviaJuBGz6Lf
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Linus,

	This fixes ext2 debugger.It seems percpu_counter_read stamp moved
lately.

Regards,
FabF

--=-cSt93GRzMviaJuBGz6Lf
Content-Disposition: attachment; filename=ext2dbg1.diff
Content-Type: text/x-patch; name=ext2dbg1.diff; charset=UTF-8
Content-Transfer-Encoding: 7bit

diff -Naur orig/fs/ext2/ialloc.c edited/fs/ext2/ialloc.c
--- orig/fs/ext2/ialloc.c	2004-05-10 04:32:37.000000000 +0200
+++ edited/fs/ext2/ialloc.c	2004-05-24 20:09:33.000000000 +0200
@@ -663,7 +663,7 @@
 	}
 	brelse(bitmap_bh);
 	printk("ext2_count_free_inodes: stored = %lu, computed = %lu, %lu\n",
-		percpu_counter_read(EXT2_SB(sb)->s_freeinodes_counter),
+		percpu_counter_read(&EXT2_SB(sb)->s_freeinodes_counter),
 		desc_count, bitmap_count);
 	unlock_super(sb);
 	return desc_count;
@@ -724,7 +724,7 @@
 		bitmap_count += x;
 	}
 	brelse(bitmap_bh);
-	if (percpu_counter_read(EXT2_SB(sb)->s_freeinodes_counter) !=
+	if (percpu_counter_read(&EXT2_SB(sb)->s_freeinodes_counter) !=
 				bitmap_count)
 		ext2_error(sb, "ext2_check_inodes_bitmap",
 			    "Wrong free inodes count in super block, "

--=-cSt93GRzMviaJuBGz6Lf--

