Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262702AbSJ0WZ3>; Sun, 27 Oct 2002 17:25:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262707AbSJ0WZ3>; Sun, 27 Oct 2002 17:25:29 -0500
Received: from dsl-62-3-75-185.zen.co.uk ([62.3.75.185]:17536 "EHLO
	giantx.co.uk") by vger.kernel.org with ESMTP id <S262702AbSJ0WZZ>;
	Sun, 27 Oct 2002 17:25:25 -0500
Date: Sun, 27 Oct 2002 22:31:39 +0000
To: linux-kernel@vger.kernel.org
Subject: 2.5.44-ac4 scsi CDROMEJECT problem
Message-ID: <20021027223138.GA601@giantx.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Nyk Tarr <nyk@giantx.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

This patch of Jens Axboe was missing from 2.5.44-ac4. Was this by design
or accidental?



> Irk you are on SCSI, yes you need this incremental patch for that to
> work. Sorry about that, I've put up 16b which contains this.

--- drivers/block/scsi_ioctl.c~	2002-10-25 16:46:58.000000000 +0200
+++ drivers/block/scsi_ioctl.c	2002-10-25 16:47:32.000000000 +0200
@@ -319,6 +319,8 @@
 		case CDROMEJECT:
 			rq = blk_get_request(q, WRITE, __GFP_WAIT);
 			rq->flags = REQ_BLOCK_PC;
+			rq->rq_dev = to_kdev_t(bdev->bd_dev);
+			rq->rq_disk = bdev->bd_disk;
 			rq->data = NULL;
 			rq->data_len = 0;
 			rq->timeout = BLK_DEFAULT_TIMEOUT;

> -- 
> Jens Axboe

-- 
/__
\_|\/
   /\
