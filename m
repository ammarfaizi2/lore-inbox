Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750935AbVHTTtB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbVHTTtB (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 15:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750846AbVHTTtA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 15:49:00 -0400
Received: from mx1.redhat.com ([66.187.233.31]:60107 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750712AbVHTTtA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 15:49:00 -0400
Date: Sat, 20 Aug 2005 15:48:40 -0400
From: Dave Jones <davej@redhat.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: Linus Torvalds <torvalds@g5.osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Fix up befs compile.
Message-ID: <20050820194840.GA8455@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Al Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	Linus Torvalds <torvalds@g5.osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fs/befs/linuxvfs.c:466: error: conflicting types for 'befs_follow_link'
fs/befs/linuxvfs.c:44: error: previous declaration of 'befs_follow_link' was here
fs/befs/linuxvfs.c: In function 'befs_follow_link':
fs/befs/linuxvfs.c:490: warning: return makes integer from pointer without a cast

Signed-off-by: Dave Jones <davej@redhat.com>


--- linux-2.6.12/fs/befs/linuxvfs.c~	2005-08-20 15:46:30.000000000 -0400
+++ linux-2.6.12/fs/befs/linuxvfs.c	2005-08-20 15:47:25.000000000 -0400
@@ -461,7 +461,7 @@ befs_destroy_inodecache(void)
  * The data stream become link name. Unless the LONG_SYMLINK
  * flag is set.
  */
-static int
+static void
 befs_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	befs_inode_info *befs_ino = BEFS_I(dentry->d_inode);
@@ -487,7 +487,6 @@ befs_follow_link(struct dentry *dentry, 
 	}
 
 	nd_set_link(nd, link);
-	return NULL;
 }
 
 static void befs_put_link(struct dentry *dentry, struct nameidata *nd, void *p)
