Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288985AbSAGHd3>; Mon, 7 Jan 2002 02:33:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289003AbSAGHdT>; Mon, 7 Jan 2002 02:33:19 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:60433 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S288985AbSAGHdG>;
	Mon, 7 Jan 2002 02:33:06 -0500
Date: Mon, 7 Jan 2002 08:32:56 +0100
From: Jens Axboe <axboe@suse.de>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Matthias Hanisch <mjh@vr-web.de>, Mikael Pettersson <mikpe@csd.uu.se>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 2.5.2 scheduler code for 2.4.18-pre1 ( was 2.5.2-pre performance degradation on an old 486 )
Message-ID: <20020107083256.B1755@suse.de>
In-Reply-To: <20020106112129.D8673@suse.de> <Pine.LNX.4.40.0201061554410.933-100000@blue1.dev.mcafeelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.40.0201061554410.933-100000@blue1.dev.mcafeelabs.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 06 2002, Davide Libenzi wrote:
> > Davide,
> >
> > If this is caused by ISA bounce problems, then you should be able to
> > reproduce by doing something ala
> >
> > [ drivers/ide/ide-dma.c ]
> >
> > ide_toggle_bounce()
> > {
> > 	...
> >
> > +	addr = BLK_BOUNCE_ISA;
> > 	blk_queue_bounce_limit(&drive->queue, addr);
> > }
> >
> > pseudo-diff, just add the addr = line. Now compare performance with and
> > without your scheduler changes.
> 
> I fail to understand where the scheduler code can influence this.
> There's basically nothing inside blk_queue_bounce_limit()

Eh of course not, no time will be spent inside blk_queue_bounce_limit. I
don't think you looked very long at this :-)

The point is that ISA bouncing will spend some time scheduling waiting
for available memory in the __GFP_DMA zone.

-- 
Jens Axboe

