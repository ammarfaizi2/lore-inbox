Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262604AbSKRODf>; Mon, 18 Nov 2002 09:03:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262620AbSKRODf>; Mon, 18 Nov 2002 09:03:35 -0500
Received: from tolkor.sgi.com ([198.149.18.6]:1505 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id <S262604AbSKRODe>;
	Mon, 18 Nov 2002 09:03:34 -0500
Subject: Re: SCSI I/O performance problems when CONFIG_HIGHIO is off
From: Stephen Lord <lord@sgi.com>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021118120531.GC839@suse.de>
References: <1037392310.13531.419.camel@jen.americas.sgi.com>
	 <20021118120531.GC839@suse.de>
Content-Type: text/plain
Message-Id: <1037628312.1680.5.camel@laptop.americas.sgi.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 18 Nov 2002 08:05:13 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-11-18 at 06:05, Jens Axboe wrote:

> 
> Steve,
> 
> Something isn't quite making sense. If we go over every single instance
> of checking ->highmem_io, they all look sane (ie checking on non-highmem
> setup must yield 0). So that part looks good.
> 
> However, I think a typo snuck in there, in exactly the spot you pasted
> above. Could you try 2.4.20-rc2 with this patch applied?
> 
> ===== drivers/scsi/scsi_merge.c 1.9 vs edited =====
> --- 1.9/drivers/scsi/scsi_merge.c	Mon Sep 16 09:25:10 2002
> +++ edited/drivers/scsi/scsi_merge.c	Mon Nov 18 13:04:41 2002
> @@ -835,7 +835,7 @@
>  	 * case.
>   	 */
>  	if (count == 1 && !SCpnt->host->highmem_io) {
> -		this_count = req->current_nr_sectors;
> +		this_count = req->nr_sectors;
>  		goto single_segment;
>  	}

That looks like it does it, performance is pretty much what I was
getting with HIGHIO on.

Thanks

  Steve
 
-- 
Stephen  Lord <lord@sgi.com>

