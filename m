Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261440AbSJPVcZ>; Wed, 16 Oct 2002 17:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261436AbSJPVcZ>; Wed, 16 Oct 2002 17:32:25 -0400
Received: from ztxmail05.ztx.compaq.com ([161.114.1.209]:5384 "EHLO
	ztxmail05.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S261434AbSJPVbh>; Wed, 16 Oct 2002 17:31:37 -0400
Date: Wed, 16 Oct 2002 15:33:50 -0600
From: Stephen Cameron <steve.cameron@hp.com>
To: linux-kernel@vger.kernel.org
Cc: axboe@suse.de
Subject: [PATCH 1/8] 2.5.43 cciss partition problem
Message-ID: <20021016153350.A2968@zuul.cca.cpqcorp.net>
Reply-To: steve.cameron@hp.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Regen'ed the cciss patches against 2.5.43

Without this patch, only the first logical disk is usable, as
the other disks can't be opened to read the partition tables.
Applies to 2.5.43

diff -urN linux-2.5.43/drivers/block/cciss.c linux-2.5.43-a/drivers/block/cciss.c
--- linux-2.5.43/drivers/block/cciss.c	Wed Oct 16 08:11:14 2002
+++ linux-2.5.43-a/drivers/block/cciss.c	Wed Oct 16 12:22:08 2002
@@ -352,7 +352,7 @@
 	 * but I'm already using way to many device nodes to claim another one
 	 * for "raw controller".
 	 */
-	if (inode->i_bdev->bd_inode->i_size == 0) {
+	if (hba[ctlr]->drv[dsk].nr_blocks == 0) {
 		if (minor(inode->i_rdev) != 0)
 			return -ENXIO;
 		if (!capable(CAP_SYS_ADMIN))
