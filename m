Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129790AbRABPCQ>; Tue, 2 Jan 2001 10:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129962AbRABPCG>; Tue, 2 Jan 2001 10:02:06 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:25614 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129790AbRABPBu>;
	Tue, 2 Jan 2001 10:01:50 -0500
Date: Tue, 2 Jan 2001 15:31:02 +0100
From: Jens Axboe <axboe@suse.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andre Hedrick <andre@linux-ide.org>,
        Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: Chipsets, DVD-RAM, and timeouts....
Message-ID: <20010102153102.E10385@suse.de>
In-Reply-To: <20010101175005.B1650@suse.de> <E14D8qR-00015A-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E14D8qR-00015A-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Jan 01, 2001 at 05:34:01PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 01 2001, Alan Cox wrote:
> > for FAT etc when reading. Writing is a bit more difficult, as that
> > then turns out to generate a read before we can commit a dirty
> > block. IMO, this type of thing does not belong in the drivers --
> > we should _never_ receive request for < hard block size.
> 
> Unfortunately someone ripped the support out from 2.2 to do this, then didnt
> fix it. So right now 2.4 is useless to anyone with an M/O drive.

It wasn't deliberately ripped out, it just vanished when Eric started
his SCSI rewrite in 2.3 :-). For 2.5 I would really like the change
mentioned earlier -- make sure that no block drivers should have to
deal with any request for smaller sector sizes than their hw sector
size. For 2.4, I guess I can apply much the same fix for MO as I did
for CD-ROM.

-- 
* Jens Axboe <axboe@suse.de>
* SuSE Labs
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
