Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129289AbRB1Vis>; Wed, 28 Feb 2001 16:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129284AbRB1Vii>; Wed, 28 Feb 2001 16:38:38 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:5394 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S129283AbRB1Via>;
	Wed, 28 Feb 2001 16:38:30 -0500
Date: Wed, 28 Feb 2001 22:37:36 +0100
From: Jens Axboe <axboe@suse.de>
To: Steve Whitehouse <Steve@ChyGwyn.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, pavel@suse.cz,
        linux-kernel@vger.kernel.org
Subject: Re: NBD Cleanup patch and bugfix in ll_rw_blk.c
Message-ID: <20010228223736.P21518@suse.de>
In-Reply-To: <Pine.LNX.4.10.10102281138470.5932-100000@penguin.transmeta.com> <200102282127.VAA20600@gw.chygwyn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200102282127.VAA20600@gw.chygwyn.com>; from steve@gw.chygwyn.com on Wed, Feb 28, 2001 at 09:27:39PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 28 2001, Steve Whitehouse wrote:
> > > The bug fix in ll_rw_blk.c prevents hangs when using block devices which
> > > don't have plugging functions,
> > 
> > I'm convinced that the right fix is to just make everybody have plugging
> > functions.
> > 
> I'm working on that. Once I've discovered why enabling plugging causes nbd
> to hang, then I'll send a patch assuming nobody beats me to it :-)

Does anyone actually know why? Pavel didn't seem to, so maybe it
was just disabled on a hunch?

> I tested the patch with a printk() which printed whenever the new call to the
> request function was triggered. It didn't happen once in normal fs use
> with ext2 on a scsi disk. From the code I think its not even possible for
> this to be called at all for a device which has plugging. For a plugged
> device when I/O comes in, there appear to be only two cases:
> 
>  - Device queue empty. Device gets plugged. New request_fn call not called
>  - Device queue not empty. New I/O added to back of queue. New request_fn
>    not called (it only gets called when the I/O is added to the front of
>    the queue).

Exactly right.

> I think nbd is the only device which doesn't use plugging at the
> moment (from a quick grep of the kernel source),

Probably right -- loop used to disable plugging to disallow merging
and tq_disk deadlocks, but now (-ac) it's a make_request style
driver instead.

-- 
Jens Axboe

