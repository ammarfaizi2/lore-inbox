Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315162AbSEaHMW>; Fri, 31 May 2002 03:12:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315171AbSEaHMV>; Fri, 31 May 2002 03:12:21 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:28359 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S315162AbSEaHMV>;
	Fri, 31 May 2002 03:12:21 -0400
Date: Fri, 31 May 2002 09:12:17 +0200
From: Jens Axboe <axboe@suse.de>
To: "Udo A. Steinberg" <reality@delusion.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [OOPS]: 2.5.19 oopses when writing to floppy
Message-ID: <20020531071217.GG841@suse.de>
In-Reply-To: <3CF6AAB8.51EB64A4@delusion.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 31 2002, Udo A. Steinberg wrote:
> 
> Hi,
> 
> I got the following oops when mcopy'ing to a floppy drive with no disk in it.
> I won't be able to read my mail until Sunday, so if you need further info
> it'll have to wait until then.

Does this fix it?

--- drivers/block/floppy.c~	2002-05-31 09:11:34.000000000 +0200
+++ drivers/block/floppy.c	2002-05-31 09:11:44.000000000 +0200
@@ -3894,7 +3894,7 @@
 	bio.bi_end_io = floppy_rb0_complete;
 
 	submit_bio(READ, &bio);
-	generic_unplug_device(bdev_get_queue(bdev));
+	blk_run_queues();
 	process_fd_request();
 	wait_for_completion(&complete);
 

-- 
Jens Axboe

