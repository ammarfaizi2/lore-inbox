Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284717AbSAGSHI>; Mon, 7 Jan 2002 13:07:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284711AbSAGSG7>; Mon, 7 Jan 2002 13:06:59 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:1042 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S284694AbSAGSGs>; Mon, 7 Jan 2002 13:06:48 -0500
Date: Mon, 7 Jan 2002 10:10:39 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Jens Axboe <axboe@suse.de>
cc: Matthias Hanisch <mjh@vr-web.de>, Mikael Pettersson <mikpe@csd.uu.se>,
        Linus Torvalds <torvalds@transmeta.com>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] 2.5.2 scheduler code for 2.4.18-pre1 ( was 2.5.2-pre
 performance degradation on an old 486 )
In-Reply-To: <20020107083256.B1755@suse.de>
Message-ID: <Pine.LNX.4.40.0201071008170.1612-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 7 Jan 2002, Jens Axboe wrote:

> On Sun, Jan 06 2002, Davide Libenzi wrote:
> > > Davide,
> > >
> > > If this is caused by ISA bounce problems, then you should be able to
> > > reproduce by doing something ala
> > >
> > > [ drivers/ide/ide-dma.c ]
> > >
> > > ide_toggle_bounce()
> > > {
> > > 	...
> > >
> > > +	addr = BLK_BOUNCE_ISA;
> > > 	blk_queue_bounce_limit(&drive->queue, addr);
> > > }
> > >
> > > pseudo-diff, just add the addr = line. Now compare performance with and
> > > without your scheduler changes.
> >
> > I fail to understand where the scheduler code can influence this.
> > There's basically nothing inside blk_queue_bounce_limit()
>
> Eh of course not, no time will be spent inside blk_queue_bounce_limit. I
> don't think you looked very long at this :-)
>
> The point is that ISA bouncing will spend some time scheduling waiting
> for available memory in the __GFP_DMA zone.

I looked and i already pointed out this to Linus.
The memory pool creation ends up by calling alloc_pages and there could
exist race.
I've not had the time for expariments.



- Davide


