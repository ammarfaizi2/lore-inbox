Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278159AbRJWSKF>; Tue, 23 Oct 2001 14:10:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278170AbRJWSJz>; Tue, 23 Oct 2001 14:09:55 -0400
Received: from fe010.worldonline.dk ([212.54.64.195]:59664 "HELO
	fe010.worldonline.dk") by vger.kernel.org with SMTP
	id <S278159AbRJWSJp>; Tue, 23 Oct 2001 14:09:45 -0400
Date: Tue, 23 Oct 2001 20:10:10 +0200
From: Jens Axboe <axboe@suse.de>
To: Shailabh Nagar <nagar@us.ibm.com>
Cc: Martin Frey <frey@scs.ch>, "'Reto Baettig'" <baettig@scs.ch>,
        lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: Preliminary results of using multiblock raw I/O
Message-ID: <20011023201010.D12005@suse.de>
In-Reply-To: <OF98236159.2E4369EA-ON85256AEE.004D5B64@pok.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF98236159.2E4369EA-ON85256AEE.004D5B64@pok.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23 2001, Shailabh Nagar wrote:
> >On Tue, Oct 23 2001, Martin Frey wrote:
> >> >I haven't seen the SGI rawio patch, but I'm assuming it used kiobufs to
> >> >pass a single unit of 1 meg down at the time. Yes currently we do incur
> >> >significant overhead compared to that approach.
> >> >
> >> Yes, it used kiobufs to get a gatherlist, setup a gather DMA out
> >> of that list and submitted it to the SCSI layer. Depending on
> >> the controller 1 MB could be transfered with 0 memcopies, 1 DMA,
> >> 1 interrupt. 200 MB/s with 10% CPU load was really impressive.
> >
> >Let me repeat that the only difference between the kiobuf and the
> >current approach is the overhead incurred on multiple __make_request
> >calls. Given the current short queues, this isn't as bad as it used to
> >be. Of course it isn't free, though.
> 
> The patch below attempts to address exactly that - reducing the number of
> submit_bh/__make_request() calls made for raw I/O. The basic idea is to do
> a major
> part of the I/O in page sized blocks.
> 
> Comments on the idea ?

Looks fine to me.

-- 
Jens Axboe

