Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262820AbTHUSM5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 14:12:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262847AbTHUSM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 14:12:57 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:44810 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262820AbTHUSM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 14:12:56 -0400
Date: Thu, 21 Aug 2003 19:12:50 +0100
From: =?iso-8859-1?Q?J=F6rn_Engel?= <joern@infradead.org>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] keep cramfs silent, when it ought to be
Message-ID: <20030821191250.A2313@phoenix.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus!

This removes the pointless cramfs message when booting with cramfs
compiled in but not as the root filesystem.

Jörn

-- 
They laughed at Galileo.  They laughed at Copernicus.  They laughed at
Columbus. But remember, they also laughed at Bozo the Clown.
-- unknown

--- linux-2.5.71/fs/cramfs/inode.c~cramfs_message	2003-06-16 11:05:04.000000000 +0200
+++ linux-2.5.71/fs/cramfs/inode.c	2003-06-16 11:05:56.000000000 +0200
@@ -218,7 +218,8 @@
 		/* check at 512 byte offset */
 		memcpy(&super, cramfs_read(sb, 512, sizeof(super)), sizeof(super));
 		if (super.magic != CRAMFS_MAGIC) {
-			printk(KERN_ERR "cramfs: wrong magic\n");
+			if (!silent)
+				printk(KERN_ERR "cramfs: wrong magic\n");
 			goto out;
 		}
 	}
