Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262852AbTDFHJQ (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 03:09:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262853AbTDFHJP (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 03:09:15 -0400
Received: from verein.lst.de ([212.34.181.86]:36878 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id S262852AbTDFHJP (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 03:09:15 -0400
Date: Sun, 6 Apr 2003 09:20:44 +0200
From: Christoph Hellwig <hch@lst.de>
To: torvalds@transmeta.com
Cc: dm@uk.sistina.com, linux-kernel@vger.kernel.org
Subject: [PATCH] dm devfs fix
Message-ID: <20030406092044.B6637@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>, torvalds@transmeta.com,
	dm@uk.sistina.com, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Don't pass DEVFS_FL_CURRENT_OWNER to devfs_register, the uid/gid of new
nodes should always be 0.


--- 1.15/drivers/md/dm-ioctl.c	Sat Mar 22 10:38:04 2003
+++ edited/drivers/md/dm-ioctl.c	Sun Apr  6 07:55:25 2003
@@ -180,8 +180,7 @@
 	}
 
 	sprintf(name, DM_DIR "/%s", hc->name);
-	devfs_register(NULL, name, DEVFS_FL_CURRENT_OWNER,
-		       disk->major, disk->first_minor,
+	devfs_register(NULL, name, 0, disk->major, disk->first_minor,
 		       S_IFBLK | S_IRUSR | S_IWUSR | S_IRGRP,
 		       &dm_blk_dops, NULL);
 	kfree(name);
