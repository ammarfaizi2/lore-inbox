Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267536AbTBLTCi>; Wed, 12 Feb 2003 14:02:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267574AbTBLTCi>; Wed, 12 Feb 2003 14:02:38 -0500
Received: from inmail.compaq.com ([161.114.64.102]:47375 "EHLO
	zmamail02.zma.compaq.com") by vger.kernel.org with ESMTP
	id <S267536AbTBLTCh>; Wed, 12 Feb 2003 14:02:37 -0500
Date: Wed, 12 Feb 2003 13:13:04 +0600
From: steve cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Cc: axboe@suse.de
Subject: Re: [PATCH] 2.5.60 make cciss driver compile
Message-ID: <20030212071304.GC1032@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Allow cciss driver attached disks other than the first to be accessed.
(patch 3 of 11)
-- steve

--- linux-2.5.60/drivers/block/cciss.c~nth_vol_partition	2003-02-12 10:12:44.000000000 +0600
+++ linux-2.5.60-scameron/drivers/block/cciss.c	2003-02-12 10:12:44.000000000 +0600
@@ -353,7 +353,7 @@ static int cciss_open(struct inode *inod
 	 * but I'm already using way to many device nodes to claim another one
 	 * for "raw controller".
 	 */
-	if (inode->i_bdev->bd_inode->i_size == 0) {
+	if (hba[ctlr]->drv[dsk].nr_blocks == 0) {
 		if (minor(inode->i_rdev) != 0)
 			return -ENXIO;
 		if (!capable(CAP_SYS_ADMIN))

_
