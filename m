Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263970AbRF0Q2D>; Wed, 27 Jun 2001 12:28:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263979AbRF0Q1x>; Wed, 27 Jun 2001 12:27:53 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:16135 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S263970AbRF0Q1s>;
	Wed, 27 Jun 2001 12:27:48 -0400
Date: Wed, 27 Jun 2001 18:27:45 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        "ZINKEVICIUS,MATT (HP-Loveland,ex1)" <matt_zinkevicius@hp.com>
Subject: Re: patch: highmem zero-bounce
Message-ID: <20010627182745.D17905@suse.de>
In-Reply-To: <20010626182215.C14460@suse.de> <20010627114155.A31910@athlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010627114155.A31910@athlon.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 27 2001, Andrea Arcangeli wrote:
> On Tue, Jun 26, 2001 at 06:22:15PM +0200, Jens Axboe wrote:
> > Hi,
> > 
> > I updated the patches to 2.4.6-pre5, and removed the zone-dma32
> > addition. This means that machines with > 4GB of RAM will need to go all
> 
> good, we can relax the ZONE_NORMAL later, that's a separate problem with
> skipping the bounces.

Exactly

> I can see one mm corruption race condition in the patch, you missed
> nested irq in the for kmap_irq_bh (PIO).  You must _always_
> __cli/__save_flags before accessing the KMAP_IRQ_BH slot, in case the
> remapping is required (so _only_ when the page is in the highmem zone).
> Otherwise memory corruption will happen when the race triggers (for
> example two ide disks in PIO mode doing I/O at the same time connected
> to different irq sources).

Ah yes, my bad. This requires some moving around, I'll post an updated
patch later tonight. Thanks!

-- 
Jens Axboe

