Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751186AbWC3P6U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbWC3P6U (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 10:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751187AbWC3P6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 10:58:20 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:7737 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1751186AbWC3P6T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 10:58:19 -0500
Date: Thu, 30 Mar 2006 17:58:04 +0200
From: Jens Axboe <axboe@suse.de>
To: erich <erich@areca.com.tw>
Cc: "(?s?w????)?w?iO" <billion.wu@areca.com.tw>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, dax@gurulabs.com, ccaputo@alt.net,
       Matti Aarnio <matti.aarnio@zmailer.org>
Subject: Re: about ll_rw_blk.c of void generic_make_request(struct bio *bio)
Message-ID: <20060330155804.GP13476@suse.de>
References: <001d01c65302$0fee8e10$b100a8c0@erich2003>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <001d01c65302$0fee8e10$b100a8c0@erich2003>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29 2006, erich wrote:
> Dear Jens Axboe,
> 
> I am an engineer of Areca (SATA RAID controller producer).
> I have coding linux driver for kernel.org "arcmsr".
> I have got dump message %s: rw=%ld, want=%Lu, limit=%Lu message from ext2 
> file system.
> But I am do well at Ext3 and all linux files system.
> This issue only occur at read command.
> Could you give me some info how to fix this bug in my linux scsi raid 
> driver?
> 
> About the code ll_rw_blk.c mention that "it may well happen - the kernel 
> calls bread() without checking the size of the device, e.g., when mounting 
> a device."
> 
> I hope that you have more experience with it and knew what's wrong I am 
> doing in my driver.
> 
> 
> generic_make_request(struct bio *bio)
> 
> if (maxsector)
> {
>  sector_t sector = bio->bi_sector;
> 
>  if (maxsector < nr_sectors || maxsector - nr_sectors < sector)
>  {
>   /*
>    * This may well happen - the kernel calls bread()
>    * without checking the size of the device, e.g., when
>    * mounting a device.
>    */
>   handle_bad_sector(bio);
>   goto end_io;
>  }
> }

I can't really say, from my recollection of leafing over lkml emails, I
seem to recall someone saying he hit this with a newer kernel where as
the older one did not?

What are the sectors exactly it complains about, eg the full line you
see?

-- 
Jens Axboe

