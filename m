Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266971AbSLKCg2>; Tue, 10 Dec 2002 21:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266972AbSLKCg2>; Tue, 10 Dec 2002 21:36:28 -0500
Received: from packet.digeo.com ([12.110.80.53]:23495 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S266971AbSLKCg1>;
	Tue, 10 Dec 2002 21:36:27 -0500
Message-ID: <3DF6A673.D406BC7F@digeo.com>
Date: Tue, 10 Dec 2002 18:44:03 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.46 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Wil Reichert <wilreichert@yahoo.com>, Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: "bio too big" error
References: <1039572597.459.82.camel@darwin>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Dec 2002 02:44:06.0576 (UTC) FILETIME=[2C82C300:01C2A0BF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wil Reichert wrote:
> 
> Hi,
> 
> I'm getting a "bio too big" error with 2.5.50.  I've got a 330G lvm2
> partition formatted with ext3 using the -T largefile4 parameter.
> Everything seems ok at first, but any sort of access will die very
> unhappily with said error messsage after about 10 seconds of operation
> or so.  The only google search results are the patch submission.  Eeek.
> 

How odd.

Please send the full diagnostic output.

And add this:


--- 25/drivers/block/ll_rw_blk.c~a	Tue Dec 10 18:42:54 2002
+++ 25-akpm/drivers/block/ll_rw_blk.c	Tue Dec 10 18:43:13 2002
@@ -1921,6 +1921,7 @@ end_io:
 			       bdevname(bio->bi_bdev),
 			       bio_sectors(bio),
 			       q->max_sectors);
+			dump_stack();
 			goto end_io;
 		}
 

_
