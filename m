Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264777AbUEUUBK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264777AbUEUUBK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 16:01:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265973AbUEUUBJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 16:01:09 -0400
Received: from mail6.bluewin.ch ([195.186.4.229]:48521 "EHLO mail6.bluewin.ch")
	by vger.kernel.org with ESMTP id S264777AbUEUUBG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 16:01:06 -0400
Date: Fri, 21 May 2004 21:59:34 +0200
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.6] drivers/block/floppy.c: Premature blk_queue_max_sectors()
Message-ID: <20040521195934.GA17681@mars>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: a.othieno@bluewin.ch (Arthur Othieno)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

We're prematurely pampering the request queue before
checking whether it was indeed allocated successfully.

Against 2.6.6. Thanks.


 floppy.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/block/floppy.c	2004-05-20 23:48:04.000000000 +0200
+++ b/drivers/block/floppy.c	2004-05-21 21:29:33.000000000 +0200
@@ -4271,11 +4271,11 @@
 		goto out;
 
 	floppy_queue = blk_init_queue(do_fd_request, &floppy_lock);
-	blk_queue_max_sectors(floppy_queue, 64);
 	if (!floppy_queue) {
 		err = -ENOMEM;
 		goto fail_queue;
 	}
+	blk_queue_max_sectors(floppy_queue, 64);
 
 	blk_register_region(MKDEV(FLOPPY_MAJOR, 0), 256, THIS_MODULE,
 			    floppy_find, NULL, NULL);
