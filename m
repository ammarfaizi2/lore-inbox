Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317148AbSFBIMi>; Sun, 2 Jun 2002 04:12:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317150AbSFBIMh>; Sun, 2 Jun 2002 04:12:37 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:3514 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S317148AbSFBIMg>;
	Sun, 2 Jun 2002 04:12:36 -0400
Date: Sun, 2 Jun 2002 10:12:04 +0200
From: Jens Axboe <axboe@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch 1/16] unplugging fix
Message-ID: <20020602081204.GD820@suse.de>
In-Reply-To: <3CF88852.BCFBF774@zip.com.au> <3CF9CB92.A6BF921B@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 02 2002, Andrew Morton wrote:
> Andrew Morton wrote:
> > 
> > There's a plugging bug in 2.5.19.  Once you start pushing several disks
> > hard, the new unplug code gets confused and queues are left in plugged
> > state, but not on the plug list.  They never get unplugged and the
> > machine dies mysteriously.
> > 
> 
> This patch didn't fix it.  It made it tons better, but I again have a
> wedged box.  Same symptoms - against IDE this time.
> 
> blk_plug_list is empty.  queue_flags=0x03.  Interestingly,
> q->plug_list is non-empty, non-zero, both list members pointing at
> a list which isn't either itself or blk_plug_list.
> 
> I note that the code isn't taking queues off the plug list when the queue
> is destroyed.  Guess that doesn't matter - we never destroy a plugged
> queue...
> 
> This one is killing me.

I've got a good handle on how to clean the whole plugging thing up, I
suspect it will make this case easier to fix. I'll be back with that
tomorrow, still got guests...

-- 
Jens Axboe

