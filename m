Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263393AbVCJXrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263393AbVCJXrM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 18:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263396AbVCJXQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 18:16:53 -0500
Received: from mail.kroah.org ([69.55.234.183]:17626 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S263377AbVCJXKJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 18:10:09 -0500
Date: Thu, 10 Mar 2005 15:08:04 -0800
From: Greg KH <greg@kroah.com>
To: eric@lammerts.org
Cc: linux-kernel@vger.kernel.org, stable@kernel.org
Subject: [02/11] cramfs: small stat(2) fix
Message-ID: <20050310230804.GC22112@kroah.com>
References: <20050310230519.GA22112@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050310230519.GA22112@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------


From: Eric Lammerts <eric@lammerts.org>

When I stat(2) a device node on a cramfs, the st_blocks field is bogus
(it's derived from the size field which in this case holds the major/minor
numbers).  This makes du(1) output completely wrong.

Signed-off-by: Eric Lammerts <eric@lammerts.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>


diff -puN fs/cramfs/inode.c~cramfs-small-stat2-fix fs/cramfs/inode.c
--- 25/fs/cramfs/inode.c~cramfs-small-stat2-fix	2005-03-04 13:15:57.000000000 -0800
+++ 25-akpm/fs/cramfs/inode.c	2005-03-04 13:15:57.000000000 -0800
@@ -70,6 +70,7 @@ static struct inode *get_cramfs_inode(st
 			inode->i_data.a_ops = &cramfs_aops;
 		} else {
 			inode->i_size = 0;
+			inode->i_blocks = 0;
 			init_special_inode(inode, inode->i_mode,
 				old_decode_dev(cramfs_inode->size));
 		}
_

