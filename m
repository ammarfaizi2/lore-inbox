Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751233AbVHTGqr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751233AbVHTGqr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 20 Aug 2005 02:46:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751240AbVHTGqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 20 Aug 2005 02:46:47 -0400
Received: from wproxy.gmail.com ([64.233.184.203]:61833 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751233AbVHTGqq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 20 Aug 2005 02:46:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=UF1utTs6L/D9KxLTISj/3CPtpr5nTBnHSwkiBMfKVmPtRHTAJjGTswi7CN5l6pxFrZEfehOu3fT0qhDH3XI4T5rFa0VgQOL5g7KxlI4A2szAV571CqC+uXLJuiPy457UANsrHCWm/9YTPn0PJyY2Arr6/JeOXRNhighhlcktZR0=
Date: Sat, 20 Aug 2005 10:55:34 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] befs, freevxfs: fix breakage introduced by symlink fixes
Message-ID: <20050820065534.GA15354@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Somehow only prototypes and return values were converted for
befs_follow_link() and vxfs_immed_follow_link().

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 fs/befs/linuxvfs.c       |    2 +-
 fs/freevxfs/vxfs_immed.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-vanilla/fs/befs/linuxvfs.c
+++ linux-follow_the_white_rabbit/fs/befs/linuxvfs.c
@@ -461,7 +461,7 @@ befs_destroy_inodecache(void)
  * The data stream become link name. Unless the LONG_SYMLINK
  * flag is set.
  */
-static int
+static void *
 befs_follow_link(struct dentry *dentry, struct nameidata *nd)
 {
 	befs_inode_info *befs_ino = BEFS_I(dentry->d_inode);
--- linux-vanilla/fs/freevxfs/vxfs_immed.c
+++ linux-follow_the_white_rabbit/fs/freevxfs/vxfs_immed.c
@@ -72,7 +72,7 @@ struct address_space_operations vxfs_imm
  * Returns:
  *   Zero on success, else a negative error code.
  */
-static int
+static void *
 vxfs_immed_follow_link(struct dentry *dp, struct nameidata *np)
 {
 	struct vxfs_inode_info		*vip = VXFS_INO(dp->d_inode);

