Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965231AbWGKHPR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965231AbWGKHPR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 03:15:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965245AbWGKHPQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 03:15:16 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:35367 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S965237AbWGKHPO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 03:15:14 -0400
Date: Tue, 11 Jul 2006 09:17:54 +0200
From: Jens Axboe <axboe@suse.de>
To: Srinivas Ganji <srinivasganji.linux@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Spinlock Related Debug Messages in Block Driver
Message-ID: <20060711071753.GS5210@suse.de>
References: <4dccc9070607102303v380281adp3943e1d58fad8d0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4dccc9070607102303v380281adp3943e1d58fad8d0@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 11 2006, Srinivas Ganji wrote:
> Dear All,
> 
> I implemented the sample block driver for the removable devices and
> the code contains no statements related to the spin lock except a lock
> to the blk_init_queue API as shown below.
> 
> spinlock_t qlock;
> gDisk->blkqueue = blk_init_queue(do_my_request, &gDisk->qlock);
> 
> The kernel version is 2.6.10.
> 
> Everything works fine but when I try to copy a file of huge size
> (about 100MB), the following debug messages are getting displayed on
> the console:
> 
> Fc3: drivers/block/ll_rw_blk.c: 2351: spin_lock already locked by the 
> drivers.
> Fc3: drivers/block/ll_rw_blk.c: 2468: spin_unlock not locked by the drivers.
> 
> In spite of these debug messages; the file is getting copied successfully.
> I studied the Block driver 16th chapter in LDD third edition.
> 
> Can any one provide a pointer to these debug messages. Do I need to
> implement any patches for the kernel.

You need to initialize the lock passed to blk_init_queue() first. See eg
spin_lock_init(), or one of the static initializers
(SPIN_LOCK_UNLOCKED).

-- 
Jens Axboe

