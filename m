Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279343AbRJWKCf>; Tue, 23 Oct 2001 06:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279346AbRJWKCZ>; Tue, 23 Oct 2001 06:02:25 -0400
Received: from fe100.worldonline.dk ([212.54.64.211]:23568 "HELO
	fe100.worldonline.dk") by vger.kernel.org with SMTP
	id <S279343AbRJWKCO>; Tue, 23 Oct 2001 06:02:14 -0400
Date: Tue, 23 Oct 2001 12:02:40 +0200
From: Jens Axboe <axboe@suse.de>
To: Martin Frey <frey@scs.ch>
Cc: "'Shailabh Nagar'" <nagar@us.ibm.com>, "'Reto Baettig'" <baettig@scs.ch>,
        lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [Lse-tech] Re: Preliminary results of using multiblock raw I/O
Message-ID: <20011023120240.N638@suse.de>
In-Reply-To: <20011023084238.C638@suse.de> <000b01c15ba9$58ba4e90$e6c02f10@SCHLEPPDOWN>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000b01c15ba9$58ba4e90$e6c02f10@SCHLEPPDOWN>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23 2001, Martin Frey wrote:
> >I haven't seen the SGI rawio patch, but I'm assuming it used kiobufs to
> >pass a single unit of 1 meg down at the time. Yes currently we do incur
> >significant overhead compared to that approach.
> >
> Yes, it used kiobufs to get a gatherlist, setup a gather DMA out
> of that list and submitted it to the SCSI layer. Depending on
> the controller 1 MB could be transfered with 0 memcopies, 1 DMA,
> 1 interrupt. 200 MB/s with 10% CPU load was really impressive.

Let me repeat that the only difference between the kiobuf and the
current approach is the overhead incurred on multiple __make_request
calls. Given the current short queues, this isn't as bad as it used to
be. Of course it isn't free, though.

It's still 0 mem copies, and can be completed with 1 interrupts and DMA
operation.

-- 
Jens Axboe

