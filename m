Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271560AbRHPMA7>; Thu, 16 Aug 2001 08:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271559AbRHPMAt>; Thu, 16 Aug 2001 08:00:49 -0400
Received: from fe000.worldonline.dk ([212.54.64.194]:5646 "HELO
	fe000.worldonline.dk") by vger.kernel.org with SMTP
	id <S271561AbRHPMAh>; Thu, 16 Aug 2001 08:00:37 -0400
Date: Thu, 16 Aug 2001 14:03:17 +0200
From: Jens Axboe <axboe@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: [patch] zero-bounce highmem I/O
Message-ID: <20010816140317.Y4352@suse.de>
In-Reply-To: <20010815.070204.39155321.davem@redhat.com> <20010815.072548.48531893.davem@redhat.com> <20010816135150.X4352@suse.de> <20010816.045642.116348743.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010816.045642.116348743.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 16 2001, David S. Miller wrote:
>    From: Jens Axboe <axboe@suse.de>
>    Date: Thu, 16 Aug 2001 13:51:50 +0200
> 
> [ Hopefully this mail won't be encoded in Chinese-BIG5 :-)  sorry
>   about that ]

Looks good :)

>    The only difference between your and my tree now is the PCI_MAX_DMA32
>    flag. Would you consider this? I already use this flag in the block
>    stuff, I just updated the two references you had. Maybe
>    PCI_MAX_DMA32_MASK is a better name.
>    
> I didn't put it into my patch becuase there is no way you can
> use such a value in generic code.
> 
> What if my scsi controller's pci DMA mask is 0x7fffffff or something
> like this?  You don't know at the generic layer, and you must provide
> some way for the block device to indicate stuff like this to you.

Then your SCSI controller will not use PCI_MAX_DMA32 but rather that
particular mask? For block drivers, using 0x7fffffff for
blk_queue_bounce_limit is perfectly fine too.

> That is why PCI_MAX_DMA32, or whatever you would like to name it, does
> not make any sense.  It can be a shorthand for drivers themselves, but
> that is it and personally I'd rather they just put the bits there
> explicitly.

Drivers, right. THe block stuff used it in _one_ place -- the
BLK_BOUNCE_4G define, to indicated the need to bounce anything above 4G.
But no problem, I can just define that to 0xffffffff myself.

> I am just finishing up the "death of alt_address" patch right now.

Excellent.

-- 
Jens Axboe

