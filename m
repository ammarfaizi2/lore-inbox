Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312256AbSDXOmQ>; Wed, 24 Apr 2002 10:42:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312261AbSDXOmP>; Wed, 24 Apr 2002 10:42:15 -0400
Received: from [195.63.194.11] ([195.63.194.11]:45070 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S312256AbSDXOmP>; Wed, 24 Apr 2002 10:42:15 -0400
Message-ID: <3CC6B5A4.2050807@evision-ventures.com>
Date: Wed, 24 Apr 2002 15:39:48 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc1) Gecko/20020419
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: rwhron@earthlink.net, linux-kernel@vger.kernel.org
Subject: Re: 2.5.9 -- OOPS in IDE code (symbolic dump and boot log included)
In-Reply-To: <20020424093021.A21652@rushmore> <20020424133329.GA8988@suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Uz.ytkownik Jens Axboe napisa?:
> On Wed, Apr 24 2002, rwhron@earthlink.net wrote:
> 
>>>>Oops on 2.5.9 at boot time.
>>>
>>>Could you please introduce two printk("BANG\n") printk("BOOM\n")
>>>aroung the ata_ar_get() in ide-cd? Just to see whatever the
>>>command queue is already up and initialized.
>>
>>This may not be what you wanted:
>>
>>	printk("BANG\n");
>>        ar = ata_ar_get(drive);
>>        printk("BOOM\n");
>>
>>If it is, neither BANG nor BOOM printed before oops.
> 
> 
> Look, the problem is easy. Backout the changes to ide_cdrom_do_request()
> and cdrom_start_read(), then re-add the
> 
> 	HWGROUP(drive)->rq->special = NULL;
> 
> in cdrom_end_request() before calling ide_end_request()
> 
> Something ala, completely untested (not even compiled). See the thread
> about the ide-cd changes being broken.
> 

Jens - this is *not going to work* becouse the DMA methods are
expecting an full ata_request right now.

Uunfortunately pulling the whole ata_ar_get() stuff one
level up to the ide.c file where ->do_request get's called
doesn't work right now.


