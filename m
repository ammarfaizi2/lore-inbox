Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131251AbRAARV1>; Mon, 1 Jan 2001 12:21:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131508AbRAARVR>; Mon, 1 Jan 2001 12:21:17 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:40714 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S131251AbRAARU6>;
	Mon, 1 Jan 2001 12:20:58 -0500
Date: Mon, 1 Jan 2001 17:50:05 +0100
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andre Hedrick <andre@linux-ide.org>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Chipsets, DVD-RAM, and timeouts....
Message-ID: <20010101175005.B1650@suse.de>
In-Reply-To: <Pine.LNX.4.10.10012312252220.21836-300000@master.linux-ide.org> <E14D7Zj-00011M-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E14D7Zj-00011M-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Jan 01, 2001 at 04:12:41PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 01 2001, Alan Cox wrote:
> > 	mke2fs -b 2048 /dev/hdc
> > 	You must format to 2048 size blocks.
> 
> FAT style FS doesnt support 2K blocks 8)

Then don't use FAT on DVD-RAM :-). ide-cd will already appropriately
cache a single block and dish out 512b sectors from that as needed
for FAT etc when reading. Writing is a bit more difficult, as that
then turns out to generate a read before we can commit a dirty
block. IMO, this type of thing does not belong in the drivers --
we should _never_ receive request for < hard block size.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
