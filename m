Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265323AbRF0RMw>; Wed, 27 Jun 2001 13:12:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265335AbRF0RMm>; Wed, 27 Jun 2001 13:12:42 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:43528 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S265334AbRF0RMd>;
	Wed, 27 Jun 2001 13:12:33 -0400
Date: Wed, 27 Jun 2001 19:12:29 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        "ZINKEVICIUS,MATT (HP-Loveland,ex1)" <matt_zinkevicius@hp.com>
Subject: Re: patch: highmem zero-bounce
Message-ID: <20010627191229.G17905@suse.de>
In-Reply-To: <20010626182215.C14460@suse.de> <20010627114155.A31910@athlon.random> <20010627182745.D17905@suse.de> <20010627184908.E17905@suse.de> <20010627190626.E24623@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010627190626.E24623@athlon.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27 2001, Andrea Arcangeli wrote:
> On Wed, Jun 27, 2001 at 06:49:08PM +0200, Jens Axboe wrote:
> > On Wed, Jun 27 2001, Jens Axboe wrote:
> > > > I can see one mm corruption race condition in the patch, you missed
> > > > nested irq in the for kmap_irq_bh (PIO).  You must _always_
> > > > __cli/__save_flags before accessing the KMAP_IRQ_BH slot, in case the
> > > > remapping is required (so _only_ when the page is in the highmem zone).
> 				^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > > > Otherwise memory corruption will happen when the race triggers (for
> > > > example two ide disks in PIO mode doing I/O at the same time connected
> > > > to different irq sources).
> > > 
> > > Ah yes, my bad. This requires some moving around, I'll post an updated
> > > patch later tonight. Thanks!
> > 
> > A prelim and untested fix just whipped up
> 
> Thanks!
> 
> I'd prefer if the __cli;__save_flags is embedded in the bh_kmap_irq in
> the slow path case where the remap is really required. We can avoid the
> cli for all the memory below 1G. This way it should also be harder to
> forget to cli ;). During PIO the irq should be enabled otherwise it
> means either the driver or the hardware is silly.

Humm yes, I agree. I'll redo it tonight and send an updated
incremental. Hopefully I'll be able to upload a new full version too.

> Plus adding a _fat_ warning in the bh_kmap_irq that nobody should
> re-enable interupt in the middle.

Agree :)

-- 
Jens Axboe

