Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267149AbTA0Ibu>; Mon, 27 Jan 2003 03:31:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267154AbTA0Ibu>; Mon, 27 Jan 2003 03:31:50 -0500
Received: from packet.digeo.com ([12.110.80.53]:30622 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S267149AbTA0Ibt>;
	Mon, 27 Jan 2003 03:31:49 -0500
Date: Mon, 27 Jan 2003 00:40:59 -0800
From: Andrew Morton <akpm@digeo.com>
To: Joshua Kwan <joshk@ludicrus.ath.cx>
Cc: linux-kernel@vger.kernel.org, dilinger@voxel.net
Subject: Re: 2.5.59-mm6
Message-Id: <20030127004059.5717e8e3.akpm@digeo.com>
In-Reply-To: <20030127082452.GA18747@ludicrus.ath.cx>
References: <20030126231015.6ad982e4.akpm@digeo.com>
	<pan.2003.01.27.08.17.50.697367@voxel.net>
	<20030127082452.GA18747@ludicrus.ath.cx>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Jan 2003 08:41:00.0189 (UTC) FILETIME=[D16F0CD0:01C2C5DF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joshua Kwan <joshk@ludicrus.ath.cx> wrote:
>
> On Mon, Jan 27, 2003 at 03:17:54AM -0500, Andres Salomon wrote:
> > This one boots for me (with devfs enabled).  I got some rather interesting
> > stack dumps, however, during boot.
> 
> I'm experiencing similar problems without devfs...
> 
> > Warning! Detected 2173 micro-second gap between interrupts.
> >   Compensating for 1 lost ticks.
> > Call Trace:
> >  [<c010b8a8>] handle_IRQ_event+0x38/0x60
> >  [<c010bade>] do_IRQ+0xae/0x160
> >  [<c0105000>] _stext+0x0/0x30
> >  [<c010a150>] common_interrupt+0x18/0x20
> >  [<c0105000>] _stext+0x0/0x30
> 
> Each of these warnings reproduces for each input device on my system 
> (there are 3 now, so if i disconnect, say, my USB mouse, there will be 
> only 2.)

This is debug stuff - it tells us which drivers are disabling interrupts for
more than one or two clock ticks.  Please send the full trace so we can bug
the maintainers into fixing the drivers up.

> In other news (this happened in -mm5, not sure if this happened to 
> others or not:)
> 
> Hangcheck: starting hangcheck timer 0.5.0 (tick is 180 seconds, margin 
> is 60 seconds).
> Uninitialised timer!
> This is just a warning.  Your computer is OK
> function=0xc0216100, data=0x0
> Call Trace:
>  [<c0121ce1>] check_timer_failed+0x61/0x70
>  [<c0216100>] hangcheck_fire+0x0/0xc0
>  [<c0121e5f>] mod_timer+0x2f/0x180
>  [<c0105075>] init+0x35/0x160
>  [<c0105040>] init+0x0/0x160
>  [<c010713d>] kernel_thread_helper+0x5/0x18

Ah, bug.  Thanks, I shall repair that.

> No visible problems though, at all.
> 

No, the uninitialised timer detector fixes the timer up.


