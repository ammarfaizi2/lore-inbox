Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266864AbUJRQiT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266864AbUJRQiT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 12:38:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266867AbUJRQh6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 12:37:58 -0400
Received: from palrel12.hp.com ([156.153.255.237]:36296 "EHLO palrel12.hp.com")
	by vger.kernel.org with ESMTP id S266864AbUJRQfy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 12:35:54 -0400
Date: Mon, 18 Oct 2004 11:35:32 -0500
From: mikem <mikem@beardog.cca.cpqcorp.net>
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Christoph Hellwig <hch@infradead.org>, Andrew Morton <akpm@osdl.org>,
       Jens Axboe <axboe@suse.de>, Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: cciss update [2/2] fixes for Steeleye Lifekeeper
Message-ID: <20041018163532.GA24511@beardog.cca.cpqcorp.net>
References: <20041013212253.GB9866@beardog.cca.cpqcorp.net> <20041014083900.GB7747@infradead.org> <1097764660.2198.11.camel@mulgrave> <20041014183948.GA12325@infradead.org> <1097852716.1718.9.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1097852716.1718.9.camel@mulgrave>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 15, 2004 at 10:05:09AM -0500, James Bottomley wrote:
> On Thu, 2004-10-14 at 13:39, Christoph Hellwig wrote:
> > Such a volume has been configured and set up, and although it's still
> > ugly I'd say it's okay.  But the patch also adds one gendisk per controller
> > even if no volume is set up.
> 
> That's this bit of code:
> 
> @@ -2762,7 +2810,9 @@ static int __devinit cciss_init_one(stru
>                 disk->fops = &cciss_fops;
>                 disk->queue = hba[i]->queue;
>                 disk->private_data = drv;
> -               if( !(drv->nr_blocks))
> +               /* we must register the controller even if no disks
> exist */
> +               /* this is for the online array utilities */
> +               if(!drv->heads && j)
>                         continue;
>                 blk_queue_hardsect_size(hba[i]->queue, drv->block_size);
>                 set_capacity(disk, drv->nr_blocks);
> 
> Mike, is there a way we can only allocate a gendisk when we know there's
> actually a device there (if owned by another controller currently)?
> 
> James

This patch only registers the controller if no logical drives are configured. It will not result in all possible logical drives being added. I added printk's to the driver to show me what I'm registering.
What I see is the controller registers every time, and only drives that are phsically configured are registered. That is true for reserved drives, also.

Thanks,
mikem
