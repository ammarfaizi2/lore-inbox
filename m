Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262321AbTFOPvl (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 11:51:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262320AbTFOPvl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 11:51:41 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:58274 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S262321AbTFOPvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 11:51:33 -0400
Date: Sun, 15 Jun 2003 18:05:24 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: quinlan@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] make cramfs look less hostile
Message-ID: <20030615160524.GD1063@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This thing has been biting me now and again.  "cramfs: wrong magic\n"
looks like an error condition to most people and thus creates bug
reports.  But there is no bug per se in having cramfs support in the
kernel and booting from a jffs2 rootfs.  So instead of teaching the
users over and over, how about this little one-liner?

Jörn

-- 
Mundie uses a textbook tactic of manipulation: start with some
reasonable talk, and lead the audience to an unreasonable conclusion.
-- Bruce Perens

--- linux-2.5.71/fs/cramfs/inode.c~cramfs_message	2003-06-05 17:47:36.000000000 +0200
+++ linux-2.5.71/fs/cramfs/inode.c	2003-06-15 17:58:03.000000000 +0200
@@ -218,7 +218,7 @@
 		/* check at 512 byte offset */
 		memcpy(&super, cramfs_read(sb, 512, sizeof(super)), sizeof(super));
 		if (super.magic != CRAMFS_MAGIC) {
-			printk(KERN_ERR "cramfs: wrong magic\n");
+			printk(KERN_INFO "cramfs: magic not found\n");
 			goto out;
 		}
 	}
