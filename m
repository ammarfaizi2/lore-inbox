Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289532AbSAKGmp>; Fri, 11 Jan 2002 01:42:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289589AbSAKGmg>; Fri, 11 Jan 2002 01:42:36 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:24838 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S289532AbSAKGmT>;
	Fri, 11 Jan 2002 01:42:19 -0500
Date: Fri, 11 Jan 2002 07:42:14 +0100
From: Jens Axboe <axboe@suse.de>
To: Michael Zhu <mylinuxk@yahoo.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: About block device request function.
Message-ID: <20020111074214.N19814@suse.de>
In-Reply-To: <20020110212718.41819.qmail@web14906.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020110212718.41819.qmail@web14906.mail.yahoo.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 10 2002, Michael Zhu wrote:
> Hi, I have a question of the block device request
> function. I use the following sentences to change the
> request function of a block device.
> 
> spin_lock_irq(&io_request_lock);
> 
> original_make_request_fn =
> blk_dev[i].request_queue.make_request_fn;
> 
> blk_dev[i].request_queue.make_request_fn =
> kti_make_request_fn;
> 
> spin_unlock_irq(&io_request_lock);
> 
> "i" is the major number of a block device.
> 
> You know blk_dev[] is the global block device array.
> When I use those sentences to change the floppy block
> device's request function, it works. The major number
> of the floppy disk is 2. But when I use the same one
> to change the hard disk's request function, it doesn't
> work. I found that the
> blk_dev[3].request_queue.make_request_fn is NULL. Does
> that mean that the make_request_fn() of the hard disk
> is NULL. I can't believe it. Can anyone give me an
> answer?

Read drivers/block/ll_rw_blk.c:blk_get_queue() -- either a driver uses
the statically allocated per-major queue, or it provides its own and
defines a get_queue function to return it.

You are still heading in the wrong direction :/

-- 
Jens Axboe

