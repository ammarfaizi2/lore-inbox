Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281031AbRKLWOx>; Mon, 12 Nov 2001 17:14:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281039AbRKLWOo>; Mon, 12 Nov 2001 17:14:44 -0500
Received: from smtp01.uc3m.es ([163.117.136.121]:18445 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S281031AbRKLWOg>;
	Mon, 12 Nov 2001 17:14:36 -0500
From: "Peter T. Breuer" <ptb@it.uc3m.es>
Message-Id: <200111122214.fACMEPd09762@oboe.it.uc3m.es>
Subject: Re: what is teh current meaning of blk_size?
In-Reply-To: <3BF0365E.46DAABB0@evision-ventures.com> from "Martin Dalecki" at
	"Nov 12, 2001 09:51:42 pm"
To: dalecki@evision.ag
Date: Mon, 12 Nov 2001 23:10:44 +0100 (MET)
X-Anonymously-To: 
Reply-To: ptb@it.uc3m.es
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"A month of sundays ago Martin Dalecki wrote:"
> "Peter T. Breuer" wrote:
> > Is blk_size[][] supposed to contain the size in KB or blocks?
> There is no rumor it's in blocks.
> 
> There are three level of block size measurements in linux:
> 
> 1. FS level one.	(page chunks most of time main exceptions are dos and
> isofs)
> 2. Driver level one.	(nearly always 1024, main exception are ATAPI
> cdrom)
> 3. Hardware device level one. (nearly always 512, only prehistoric SCSI
> drives from the stone age are exceptional and providing 256 byte sized
> block. We discovered them druing our archeological efforts recently
> under 
> a thick layer of mood...)
> 
> It's left as an exercies to the reader which one of the sparse
> matrices in ll_rw_blk.c is declaring which ;-).
> ...

Uh, thanks! I was looking at fs/block_dev.c.

 if (blk_size[MAJOR(dev)])
  size = ((loff_t) blk_size[MAJOR(dev)][MINOR(dev)] << BLOCK_SIZE_BITS) >> blocksize_bits;

which sets the size to the entered blk_size << 10 - blksize_bits.

I missed that BLOCK_SIZE_BITS was constant but blksize_bits is variable.
Amongst other things.


> OK I was to fast to figure it out:
> 
> /*
>  * blk_size contains the size of all block-devices in units of 1024 byte
>  * sectors:

But this is not so .. it is the default, not the rule. And it is only
the default if the block size is the default value.

> int * blk_size[MAX_BLKDEV];
> 
> /*
>  * blksize_size contains the size of all block-devices:

Err .... they mean the BLOCK SIZE of all ...

> int * blksize_size[MAX_BLKDEV];
> 
> /*
>  * hardsect_size contains the size of the hardware sector of a device.

Never used. Thanks for clearing that up!

If you knew if the meaning of blk_size had ever changed, and when in
terms of kernel version, that would also be very very helpful.

Peter

