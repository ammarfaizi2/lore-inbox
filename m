Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270991AbUJUViF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270991AbUJUViF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 17:38:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271000AbUJUVem
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 17:34:42 -0400
Received: from palrel10.hp.com ([156.153.255.245]:5319 "EHLO palrel10.hp.com")
	by vger.kernel.org with ESMTP id S270840AbUJUVVa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 17:21:30 -0400
Date: Thu, 21 Oct 2004 16:20:58 -0500
From: mike.miller@hp.com
To: marcelo.tosatti@cyclades.com, axboe@suse.de
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [patch 2/2] cciss: cleans up warnings in the pass thru ioctl
Message-ID: <20041021212058.GB10462@beardog.cca.cpqcorp.net>
Reply-To: mikem@beardog.cca.cpqcorp.net
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patch 2 of 2 for 20041021.
This patch cleans up a warning with some versions of gcc.
Under gcc version 3.3.3 a warning is generated that the comparsion will always
be false due to the limits of the data type. buf_size is declared as a WORD
which limits it to 64k. If the app needs to transfer larger amounts of data
it should use the CCISS_BIG_PASSTHRU.
Please consider this for inclusion. Built against 2.4.28-pre4.
Please apply in order.

 cciss.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletion(-)

Signed off by Mike Miller.
-------------------------------------------------------------------------------
diff -burNp lx2428-pre4-p001/drivers/block/cciss.c lx2428-pre4/drivers/block/cciss.c
--- lx2428-pre4-p001/drivers/block/cciss.c	2004-10-21 15:59:09.881439840 -0500
+++ lx2428-pre4/drivers/block/cciss.c	2004-10-21 13:24:26.616710592 -0500
@@ -958,8 +958,10 @@ static int cciss_ioctl(struct inode *ino
 			return -EINVAL;
 		} 
 		/* Check kmalloc limits */
-		if (iocommand.buf_size > 128000)
+		if (iocommand.buf_size > 64000) {
+			printk(KERN_WARNING "cciss: use CCISS_BIG_PASSTHRU\n");
 			return -EINVAL;
+		}
 		if (iocommand.buf_size > 0) {
 			buff =  kmalloc(iocommand.buf_size, GFP_KERNEL);
 			if (buff == NULL) 
