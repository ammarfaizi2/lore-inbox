Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262951AbTEGHat (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 03:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262953AbTEGHas
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 03:30:48 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:7886 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262951AbTEGHar (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 03:30:47 -0400
Date: Wed, 7 May 2003 09:43:12 +0200
From: Jens Axboe <axboe@suse.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Nicolas Pitre <nico@cam.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Russell King <rmk@arm.linux.org.uk>,
       =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>,
       Marcus Meissner <meissner@suse.de>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Only use MSDOS-Partitions by default on X86
Message-ID: <20030507074312.GA483@suse.de>
References: <20030506183010.GK905@suse.de> <Pine.LNX.4.44.0305061436510.11648-100000@xanadu.home> <20030506184914.GL905@suse.de> <1052254888.7532.58.camel@imladris.demon.co.uk> <20030507072237.GW905@suse.de> <1052293277.10965.14.camel@imladris.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052293277.10965.14.camel@imladris.demon.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 07 2003, David Woodhouse wrote:
> On Wed, 2003-05-07 at 08:22, Jens Axboe wrote:
> > > That's a little short of what I was intending. Ideally we stick 'struct
> > > request', 'struct buffer_head' and 'struct bio' inside #ifdef
> > > CONFIG_BLK_DEV, then kill all the dead code which uses them.
> > 
> > struct request can be a goner with my patch, the others not really.
> > request is really a block private property, so it's easy to kill off.
> > You are going for the really minimal approach, basically ruling out lots
> > of filesystems and requiring major surgery all around. While I can see
> > that make sense for an embedded kernel, I'm having a hard time
> > envisioning this as something mergable :-)
> 
> Last time I looked, it wasn't that bad until I got mired in VM code.
> I haven't looked at that since we got CONFIG_SWAP, but I'm fairly sure
> the VM bits will be a lot nicer now too.

I'll let you deal with that, my head is spinning from just thinking
about it :)

> > > mtdblock.c cleanup noted with interest -- I'll play with that shortly;
> > > thanks. Note that you don't actually need flash hardware, you can load
> > > the 'mtdram' device which fakes it with vmalloc-backed storage instead.
> > > Not too useful for powerfail-testing but for mounting something like
> > > ext2 on mtdblock on mtdram it's fine.
> > 
> > I'm attaching an updated version, I don't think it's safe to use atomic
> > kmaps across the do_cached_read/write.
> 
> It's not -- the flash read/write/erase functions may sleep.

Thought so.

> > Also, I want bio_endio() to increment the sector position of the bio as
> > well. Makes for a nicer api, and the sector var in mtdblock would then
> > be killable.
> 
> OK. Let me know when you're done and I'll fix up FTL and NFTL
> accordingly too.

The only change to the patch attached in the previous mail is just to
drop the sector_t sector and use bio->bi_sector throughout the function.
So nothing major.

-- 
Jens Axboe

