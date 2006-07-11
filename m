Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030208AbWGKHoA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030208AbWGKHoA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 03:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030428AbWGKHoA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 03:44:00 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:54843 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S1030208AbWGKHn6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 03:43:58 -0400
Date: Tue, 11 Jul 2006 09:46:37 +0200
From: Jens Axboe <axboe@suse.de>
To: Srinivas Ganji <srinivasganji.linux@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Spinlock Related Debug Messages in Block Driver
Message-ID: <20060711074637.GT5210@suse.de>
References: <4dccc9070607102303v380281adp3943e1d58fad8d0@mail.gmail.com> <20060711071753.GS5210@suse.de> <4dccc9070607110042r78aeb843gb7b23d70505dfcec@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dccc9070607110042r78aeb843gb7b23d70505dfcec@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11 2006, Srinivas Ganji wrote:
> On 7/11/06, Jens Axboe <axboe@suse.de> wrote:
> >On Tue, Jul 11 2006, Srinivas Ganji wrote:
> >> Dear All,
> >>
> >> I implemented the sample block driver for the removable devices and
> >> the code contains no statements related to the spin lock except a lock
> >> to the blk_init_queue API as shown below.
> >>
> >> spinlock_t qlock;
> >> gDisk->blkqueue = blk_init_queue(do_my_request, &gDisk->qlock);
> >>
> >> The kernel version is 2.6.10.
> >>
> >> Everything works fine but when I try to copy a file of huge size
> >> (about 100MB), the following debug messages are getting displayed on
> >> the console:
> >>
> >> Fc3: drivers/block/ll_rw_blk.c: 2351: spin_lock already locked by the
> >> drivers.
> >> Fc3: drivers/block/ll_rw_blk.c: 2468: spin_unlock not locked by the 
> >drivers.
> >>
> >> In spite of these debug messages; the file is getting copied 
> >successfully.
> >> I studied the Block driver 16th chapter in LDD third edition.
> >>
> >> Can any one provide a pointer to these debug messages. Do I need to
> >> implement any patches for the kernel.
> >
> >You need to initialize the lock passed to blk_init_queue() first. See eg
> >spin_lock_init(), or one of the static initializers
> >(SPIN_LOCK_UNLOCKED).
> >
> >--
> >Jens Axboe
> 
> Dear Jen,
> 
> Thanks for  your reply.
> I used the spin_lock_init API before blk_init_queue API. Even though I
> got the error.
> 
> Is there any other reason for gertting the error messages?

Then it's probably a bug in your driver. I cannot say more without
seeing the source.

-- 
Jens Axboe

