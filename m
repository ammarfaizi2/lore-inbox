Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751589AbWHZPG5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751589AbWHZPG5 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Aug 2006 11:06:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751565AbWHZPG4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Aug 2006 11:06:56 -0400
Received: from mailout.stusta.mhn.de ([141.84.69.5]:37126 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1750794AbWHZPG4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Aug 2006 11:06:56 -0400
Date: Sat, 26 Aug 2006 17:06:55 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Nathan Scott <nathans@sgi.com>
Cc: xfs@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: [2.6 patch] fs/xfs/xfs_bmap.c:xfs_bmapi(): fix a bug
Message-ID: <20060826150654.GE4765@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes the following bug introduced by commit 
39269e29d4aad04252e0debec4c9b01bac16a257:

Since bma.conv is a char and XFS_BMAPI_CONVERT is 0x1000, bma.conv was 
always assigned zero.

Spotted by the GNU C compiler (SVN version).

Signed-off-by: Adrian Bunk <bunk@stusta.de>

--- linux-2.6.18-rc4-mm2/fs/xfs/xfs_bmap.c.old	2006-08-26 03:31:23.000000000 +0200
+++ linux-2.6.18-rc4-mm2/fs/xfs/xfs_bmap.c	2006-08-26 03:31:28.000000000 +0200
@@ -4993,7 +4993,7 @@ xfs_bmapi(
 				bma.firstblock = *firstblock;
 				bma.alen = alen;
 				bma.off = aoff;
-				bma.conv = (flags & XFS_BMAPI_CONVERT);
+				bma.conv = !!(flags & XFS_BMAPI_CONVERT);
 				bma.wasdel = wasdelay;
 				bma.minlen = minlen;
 				bma.low = flist->xbf_low;


