Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265052AbSJWPWd>; Wed, 23 Oct 2002 11:22:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265045AbSJWPWd>; Wed, 23 Oct 2002 11:22:33 -0400
Received: from zcamail04.zca.compaq.com ([161.114.32.104]:34573 "EHLO
	zcamail04.zca.compaq.com") by vger.kernel.org with ESMTP
	id <S265052AbSJWPWc>; Wed, 23 Oct 2002 11:22:32 -0400
Date: Wed, 23 Oct 2002 09:24:49 -0600
From: Stephen Cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 1/10] 2.5.44 cciss pattition fix
Message-ID: <20021023092449.A14917@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are our cciss patches again, for 2.5.44.
The whole set can be grabbed via anonymous cvs (empty password):
cvs -d:pserver:anonymous@cvs.cciss.sourceforge.net:/cvsroot/cciss login
cvs -z3 -d:pserver:anonymous@cvs.cciss.sourceforge.net:/cvsroot/cciss co 2.5.44 

patch 1 of 10 for 2.5.44

Allow disks other than the first to be accessed.

 drivers/block/cciss.c |    2 +-
 1 files changed, 1 insertion, 1 deletion

--- linux-2.5.44/drivers/block/cciss.c~nth_vol_partition	Mon Oct 21 11:59:20 2002
+++ linux-2.5.44-root/drivers/block/cciss.c	Mon Oct 21 11:59:20 2002
@@ -352,7 +352,7 @@ static int cciss_open(struct inode *inod
 	 * but I'm already using way to many device nodes to claim another one
 	 * for "raw controller".
 	 */
-	if (inode->i_bdev->bd_inode->i_size == 0) {
+	if (hba[ctlr]->drv[dsk].nr_blocks == 0) {
 		if (minor(inode->i_rdev) != 0)
 			return -ENXIO;
 		if (!capable(CAP_SYS_ADMIN))

.
