Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262787AbSJLDBc>; Fri, 11 Oct 2002 23:01:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262789AbSJLDBc>; Fri, 11 Oct 2002 23:01:32 -0400
Received: from packet.digeo.com ([12.110.80.53]:492 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S262787AbSJLDBa>;
	Fri, 11 Oct 2002 23:01:30 -0400
Message-ID: <3DA791E0.F0A1B11@digeo.com>
Date: Fri, 11 Oct 2002 20:07:12 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.41 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Rob Mueller <robm@fastmail.fm>
CC: linux-kernel@vger.kernel.org, Jeremy Howard <jhoward@fastmail.fm>
Subject: Re: Strange load spikes on 2.4.19 kernel
References: <0f3201c2718c$750a13b0$1900a8c0@lifebook> <3DA77A20.2D28DBE7@digeo.com> <0f4301c27196$af8a8880$1900a8c0@lifebook>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 12 Oct 2002 03:07:12.0854 (UTC) FILETIME=[7602FF60:01C2719C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Mueller wrote:
> 
> > > Filesystem is ext3 with one big / partition (that's a mistake
> > > we won't repeat, but too late now). This should be mounted
> > > with data=journal given the kernel command line above, though
> > > it's a bit hard to tell from the dmesg log:
> > >
> >
> > It's possible tht the journal keeps on filling.  When that happens,
> > everything has to wait for writeback into the main filesystem.
> > Completion of that writeback frees up journal space and then everything
> > can unblock.
> >
> > Suggest you try data=ordered.
> 
> We have a 192M journal, and from the dmesg log it's saying that it's got a 5
> second flush interval, so I can't imagine that the journal is filling, but
> we'll try it and see I guess.
> 
> What I don't understand is why the spike is so sudden, and decays so slowly.
> It's Friday night now, so the load is fairly low. I setup a loop to dump
> uptime information every 10 seconds and attached the result below. It's
> running smoothly, then 'bam', it's hit with something big, which then slowly
> decays off.
> 
> A few extra things:
> 1. It happens every couple of minutes or so, but not exactly on any time, so
> it's not a cron job or anything
> 2. Viewing 'top', there are no extra processes obviously running when it
> happens
> 

If it was this, one would expect it to happen every time you'd written
0.75 * 192 Mbytes to the filesystem.  Which seems about right.

Easy enough to test though.
