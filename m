Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261724AbUEFRdT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261724AbUEFRdT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 13:33:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261830AbUEFRdT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 13:33:19 -0400
Received: from math.ut.ee ([193.40.5.125]:46815 "EHLO math.ut.ee")
	by vger.kernel.org with ESMTP id S261724AbUEFRdO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 13:33:14 -0400
Date: Thu, 6 May 2004 20:33:06 +0300 (EEST)
From: Meelis Roos <mroos@linux.ee>
To: Linux Kernel list <linux-kernel@vger.kernel.org>, <nathans@sgi.com>
Subject: [PATCH] XFS warning on sparc64
Message-ID: <Pine.GSO.4.44.0405061920450.21792-100000@math.ut.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is 2.6.6-rc3+BK as of today on a sparc64 (gcc 3.3.3 on Debian):

  CC [M]  fs/xfs/xfs_buf_item.o
fs/xfs/xfs_buf_item.c: In function `xfs_buf_iodone_callbacks':
fs/xfs/xfs_buf_item.c:1055: warning: long long unsigned int format, xfs_daddr_t arg (arg 3)

The following patch seems to fix it - is it correct?

===== fs/xfs/xfs_buf_item.c 1.16 vs edited =====
--- 1.16/fs/xfs/xfs_buf_item.c	Mon Feb  9 06:12:20 2004
+++ edited/fs/xfs/xfs_buf_item.c	Thu May  6 20:09:01 2004
@@ -1053,7 +1053,7 @@
 		    (time_after(jiffies, (lasttime + 5*HZ)))) {
 			lasttime = jiffies;
 			prdev("XFS write error in file system meta-data "
-			      "block 0x%Lx in %s",
+			      "block 0x%Zx in %s",
 			      XFS_BUF_TARGET(bp),
 			      XFS_BUF_ADDR(bp), mp->m_fsname);
 		}


-- 
Meelis Roos (mroos@linux.ee)

