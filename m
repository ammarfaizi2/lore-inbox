Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263694AbVCEEfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263694AbVCEEfi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Mar 2005 23:35:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263381AbVCDXUl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Mar 2005 18:20:41 -0500
Received: from fire.osdl.org ([65.172.181.4]:54426 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263234AbVCDVRU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Mar 2005 16:17:20 -0500
Message-Id: <200503042117.j24LHFox017964@shell0.pdx.osdl.net>
Subject: [patch 1/5] cramfs: small stat(2) fix
To: greg@kroah.com
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, eric@lammerts.org
From: akpm@osdl.org
Date: Fri, 04 Mar 2005 13:16:54 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Eric Lammerts <eric@lammerts.org>

When I stat(2) a device node on a cramfs, the st_blocks field is bogus
(it's derived from the size field which in this case holds the major/minor
numbers).  This makes du(1) output completely wrong.

Signed-off-by: Eric Lammerts <eric@lammerts.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/fs/cramfs/inode.c |    1 +
 1 files changed, 1 insertion(+)

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
