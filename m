Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261853AbSJNP2t>; Mon, 14 Oct 2002 11:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261866AbSJNP2t>; Mon, 14 Oct 2002 11:28:49 -0400
Received: from ztxmail05.ztx.compaq.com ([161.114.1.209]:24837 "EHLO
	ztxmail05.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S261853AbSJNP2s>; Mon, 14 Oct 2002 11:28:48 -0400
Date: Mon, 14 Oct 2002 09:30:47 -0600
From: Stephen Cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Cc: axboe@suse.de
Subject: [PATCH] 2.5.42 cciss partition problem
Message-ID: <20021014093047.A1094@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hmm, this patch didn't seem to make it into 2.5.42.  Without it, or 
something like it, the cciss driver is pretty badly broken.  Without it, 
only partitions on the first disk can be accessed.  If there's something 
wrong with this patch and this problem needs to be fixed in a different way, 
let me know.

-- steve

diff -urN linux-2.5.42/drivers/block/cciss.c linux-2.5.42-a/drivers/block/cciss.c
--- linux-2.5.42/drivers/block/cciss.c	Mon Oct 14 07:54:28 2002
+++ linux-2.5.42-a/drivers/block/cciss.c	Mon Oct 14 08:09:03 2002
@@ -352,7 +352,7 @@
 	 * but I'm already using way to many device nodes to claim another one
 	 * for "raw controller".
 	 */
-	if (inode->i_bdev->bd_inode->i_size == 0) {
+	if (hba[ctlr]->drv[dsk].nr_blocks == 0) {
 		if (minor(inode->i_rdev) != 0)
 			return -ENXIO;
 		if (!capable(CAP_SYS_ADMIN))
