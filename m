Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315430AbSGVPIX>; Mon, 22 Jul 2002 11:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316541AbSGVPIX>; Mon, 22 Jul 2002 11:08:23 -0400
Received: from ds217-115-141-141.dedicated.hosteurope.de ([217.115.141.141]:56845
	"EHLO ds217-115-141-141.dedicated.hosteurope.de") by vger.kernel.org
	with ESMTP id <S315430AbSGVPIW>; Mon, 22 Jul 2002 11:08:22 -0400
Date: Mon, 22 Jul 2002 17:11:30 +0200
From: Jochen Suckfuell <jo-lkml@suckfuell.net>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] Re: Disk IO statistics still buggy
Message-ID: <20020722171130.A5013@ds217-115-141-141.dedicated.hosteurope.de>
References: <20020709190019.A19394@ds217-115-141-141.dedicated.hosteurope.de> <Pine.LNX.4.44.0207111826470.21365-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0207111826470.21365-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Thu, Jul 11, 2002 at 06:27:25PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I'm just curious about the status: will this patch be included in 2.4.19
final?

On Thu, Jul 11, 2002 at 06:27:25PM -0300, Marcelo Tosatti wrote:
> 
> Christoph,
> Can you take a look at this one ?
> 
> On Tue, 9 Jul 2002, Jochen Suckfuell wrote:
> > The accounting was done on a copy of the request _after_ the request has
> > been dequeued and the irq_request_lock released. I fixed this by taking
> > this lock again while calling the accounting function (see the patch
> > below).
> >
> > [...]
> >
> > --- linux/drivers/scsi/scsi_lib.c Mon Jul  8 16:15:27 2002
> > +++ linux_work/drivers/scsi/scsi_lib.c Tue Jul  9 17:56:39 2002
> > @@ -426,7 +426,9 @@
> >    if (req->waiting != NULL) {
> >     complete(req->waiting);
> >    }
> > +  spin_lock_irq(&io_request_lock);
> >    req_finished_io(req);
> > +  spin_unlock_irq(&io_request_lock);
> >    add_blkdev_randomness(MAJOR(req->rq_dev));
> >
> >          SDpnt = SCpnt->device;

Bye
Jochen

