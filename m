Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264097AbTEGQCX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 12:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264098AbTEGQCW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 12:02:22 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:4879 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S264097AbTEGQCT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 12:02:19 -0400
Date: Wed, 7 May 2003 18:14:51 +0200
From: Jan Kara <jack@suse.cz>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Quota write transaction size fix
Message-ID: <20030507161451.GG28363@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Hello Linus,

  I'm sending a patch which changes numbers of blocks reserved for quota
writes to more appropriate values (with current values ext3 asserts can
be triggered). Please apply.

								Honza

diff -ruNX /home/jack/.kerndiffexclude linux-2.5.68/fs/ext3/super.c linux-2.5.68-1-ext3dfix/fs/ext3/super.c
--- linux-2.5.68/fs/ext3/super.c	Sun May  4 12:32:24 2003
+++ linux-2.5.68-1-ext3dfix/fs/ext3/super.c	Sun May  4 12:49:38 2003
@@ -1992,8 +1992,10 @@
 
 #ifdef CONFIG_QUOTA
 
-#define EXT3_OLD_QFMT_BLOCKS 2
-#define EXT3_V0_QFMT_BLOCKS 6
+/* Blocks: (2 data blocks) * (3 indirect + 1 descriptor + 1 bitmap) + superblock */
+#define EXT3_OLD_QFMT_BLOCKS 11
+/* Blocks: quota info + (4 pointer blocks + 1 entry block) * (3 indirect + 1 descriptor + 1 bitmap) + superblock */
+#define EXT3_V0_QFMT_BLOCKS 27
 
 static int (*old_sync_dquot)(struct dquot *dquot);
 
