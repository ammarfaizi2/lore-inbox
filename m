Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261333AbTAQVhq>; Fri, 17 Jan 2003 16:37:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261364AbTAQVhq>; Fri, 17 Jan 2003 16:37:46 -0500
Received: from air-2.osdl.org ([65.172.181.6]:36226 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S261333AbTAQVhp>;
	Fri, 17 Jan 2003 16:37:45 -0500
Date: Fri, 17 Jan 2003 13:46:39 -0800
From: Bob Miller <rem@osdl.org>
To: vandrove@vc.cvut.cz
Cc: trivial@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: [Trivial 2.5.58] Remove compile warning from fs/ncpfs/inode.c
Message-ID: <20030117214639.GA22540@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The global declaration for ncp_symlink_inode_operations is only for certain
configurations.  This patch limit its declaration to the configurations
where it is needed.

diff -Nru a/fs/ncpfs/inode.c b/fs/ncpfs/inode.c
--- a/fs/ncpfs/inode.c	Thu Jan 16 14:06:04 2003
+++ b/fs/ncpfs/inode.c	Thu Jan 16 14:06:04 2003
@@ -227,11 +227,13 @@
 	ncp_update_inode(inode, nwinfo);
 }
 
+#if defined(CONFIG_NCPFS_EXTRAS) || defined(CONFIG_NCPFS_NFS_NS)
 static struct inode_operations ncp_symlink_inode_operations = {
 	.readlink	= page_readlink,
 	.follow_link	= page_follow_link,
 	.setattr	= ncp_notify_change,
 };
+#endif
 
 /*
  * Get a new inode.

-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17
