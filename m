Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264995AbSJPPSU>; Wed, 16 Oct 2002 11:18:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265006AbSJPPSU>; Wed, 16 Oct 2002 11:18:20 -0400
Received: from ztxmail03.ztx.compaq.com ([161.114.1.207]:48389 "EHLO
	ztxmail03.ztx.compaq.com") by vger.kernel.org with ESMTP
	id <S264995AbSJPPSR> convert rfc822-to-8bit; Wed, 16 Oct 2002 11:18:17 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: 2.5.43 partition problems?
Date: Wed, 16 Oct 2002 10:24:08 -0500
Message-ID: <45B36A38D959B44CB032DA427A6E10640167D067@cceexc18.americas.cpqcorp.net>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] 2.5.42 cciss partition problem
Thread-Index: AcJzlzf/NEck1PrSRm+M1G9LBGsm1QBjy3eA
From: "Cameron, Steve" <Steve.Cameron@hp.com>
To: <linux-kernel@vger.kernel.org>
Cc: <axboe@suse.de>
X-OriginalArrivalTime: 16 Oct 2002 15:24:08.0783 (UTC) FILETIME=[126955F0:01C27528]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


My patch below works OK for me for 2.5.42.  
However, it does NOT work for 2.5.43.  
With 2.5.43 only partitions are the 1st disk are seen,
(as is also the case with 2.5.42).  

The patch below fixes that for 2.5.42.  It does NOT
fix it for 2.5.43.  Something else is wrong with 2.5.43.
With the patch, the devices
are openable so the partition table can be read I think, but, with this
patch, all the partitions on all the disks show up as identical 
to the partitions on the first disk.

I have not yet tracked down the problem, but thought
I should mention it just to warn cciss users that their partition
tables for disks other than the 1st aren't right if they 
use this patch with 2.5.43.

-- steve

> 
> Hmm, this patch didn't seem to make it into 2.5.42.  Without it, or 
> something like it, the cciss driver is pretty badly broken.  
> Without it, only partitions on the first disk can be accessed.  If 
> there's something wrong with this patch and this problem needs to 
> be fixed in a different way, let me know.
> 
> -- steve
> 
> diff -urN linux-2.5.42/drivers/block/cciss.c 
> linux-2.5.42-a/drivers/block/cciss.c
> --- linux-2.5.42/drivers/block/cciss.c	Mon Oct 14 07:54:28 2002
> +++ linux-2.5.42-a/drivers/block/cciss.c	Mon Oct 14 08:09:03 2002
> @@ -352,7 +352,7 @@
>  	 * but I'm already using way to many device nodes to 
> claim another one
>  	 * for "raw controller".
>  	 */
> -	if (inode->i_bdev->bd_inode->i_size == 0) {
> +	if (hba[ctlr]->drv[dsk].nr_blocks == 0) {
>  		if (minor(inode->i_rdev) != 0)
>  			return -ENXIO;
>  		if (!capable(CAP_SYS_ADMIN))
> 
