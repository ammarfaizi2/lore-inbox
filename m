Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161301AbWI2DJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161301AbWI2DJJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 23:09:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161291AbWI2DJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 23:09:08 -0400
Received: from mail.suse.de ([195.135.220.2]:44177 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1161155AbWI2DI6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 23:08:58 -0400
From: NeilBrown <neilb@suse.de>
To: Andrew Morton <akpm@osdl.org>
Date: Fri, 29 Sep 2006 13:08:50 +1000
Message-Id: <1060929030850.24050@suse.de>
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Cc: nfs@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH 003 of 8] knfsd: Fix auto-sizing of nfsd request/reply buffers
References: <20060929130518.23919.patches@notabene>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


totalram is measured in pages, not bytes, so PAGE_SHIFT must be used
when trying to find 1/4096 of RAM.

Cc:  "J. Bruce Fields" <bfields@fieldses.org>
Signed-off-by: Neil Brown <neilb@suse.de>

### Diffstat output
 ./fs/nfsd/nfssvc.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff .prev/fs/nfsd/nfssvc.c ./fs/nfsd/nfssvc.c
--- .prev/fs/nfsd/nfssvc.c	2006-09-29 11:44:32.000000000 +1000
+++ ./fs/nfsd/nfssvc.c	2006-09-29 11:57:27.000000000 +1000
@@ -209,7 +209,7 @@ int nfsd_create_serv(void)
 		 * Of course, this is only a default.
 		 */
 		nfsd_max_blksize = NFSSVC_MAXBLKSIZE;
-		i.totalram >>= 12;
+		i.totalram <<= PAGE_SHIFT - 12;
 		while (nfsd_max_blksize > i.totalram &&
 		       nfsd_max_blksize >= 8*1024*2)
 			nfsd_max_blksize /= 2;
