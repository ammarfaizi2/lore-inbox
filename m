Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131850AbRAIT4S>; Tue, 9 Jan 2001 14:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129733AbRAITz7>; Tue, 9 Jan 2001 14:55:59 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:33296 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S130231AbRAITz0>; Tue, 9 Jan 2001 14:55:26 -0500
Date: Tue, 9 Jan 2001 20:54:20 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Ingo Molnar <mingo@elte.hu>
Cc: Jens Axboe <axboe@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        "Stephen C. Tweedie" <sct@redhat.com>,
        Christoph Hellwig <hch@caldera.de>,
        "David S. Miller" <davem@redhat.com>, riel@conectiva.com.br,
        netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: [PLEASE-TESTME] Zerocopy networking patch, 2.4.0-1
Message-ID: <20010109205420.H29904@athlon.random>
In-Reply-To: <20010109183808.A12128@suse.de> <Pine.LNX.4.30.0101091935461.7155-100000@e2>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.30.0101091935461.7155-100000@e2>; from mingo@elte.hu on Tue, Jan 09, 2001 at 07:38:28PM +0100
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2001 at 07:38:28PM +0100, Ingo Molnar wrote:
> 
> On Tue, 9 Jan 2001, Jens Axboe wrote:
> 
> > > > ever seen, this is why i quoted it - the talk was about block-IO
> > > > performance, and Stephen said that our block IO sucks. It used to suck,
> > > > but in 2.4, with the right patch from Jens, it doesnt suck anymore. )
> > >
> > > Thats fine. Get me 128K-512K chunks nicely streaming into my raid controller
> > > and I'll be a happy man
> >
> > No problem, apply blk-13B and you'll get 512K chunks for SCSI and RAID.
> 
> i cannot agree more - Jens' patch did wonders to IO performance here. It

BTW, I noticed what is left in blk-13B seems to be my work (Jens's fixes for
merging when the I/O queue is full are just been integrated in test1x). The
512K SCSI command, wake_up_nr, elevator fixes and cleanups and removal of the
bogus 64 max_segment limit in scsi.c that matters only with the IOMMU to allow
devices with sg_tablesize <64 to do SG with 64 segments were all thought and
implemented by me. My last public patch with most of the blk-13B stuff in it
was here:

	ftp://ftp.us.kernel.org/pub/linux/kernel/people/andrea/patches/2.4.0-test7/blkdev-3

I sumbitted a later revision of the above blkdev-3 to Jens and he kept nicely
maintaining it in sync with 2.4.x-latest.

My blkdev tree is even more advanced but I didn't had time to update with 2.4.0
and marge it with Jens yet (I just described to Jens what "more advanced"
means though, in practice it means something like a x2 speedup in tiotest seek
write numbers, streaming I/O doesn't change on highmem boxes but it doesn't
hurt lowmem boxes anymore). Current blk-13B isn't ok for integration yet
because it hurts with lowmem (try with mem=32m with your scsi array that gets
512K*512 requests in flight :) and it's not able to exploit the elevator as
well as my tree even on highmemory machines. So I'd wait until I merge the last
bits with Jens (I raised the QUEUE_NR_REQUESTS to 3000) before inclusion.

Confirm Jens?

Andrea
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
