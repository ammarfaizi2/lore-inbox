Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279429AbRKIGOD>; Fri, 9 Nov 2001 01:14:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279449AbRKIGNx>; Fri, 9 Nov 2001 01:13:53 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:27656 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S279429AbRKIGNo>; Fri, 9 Nov 2001 01:13:44 -0500
Message-ID: <3BEB72DA.7ADA8332@zip.com.au>
Date: Thu, 08 Nov 2001 22:08:26 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jeremy Fitzhardinge <jeremy@goop.org>
CC: Constantin Loizides <Constantin.Loizides@isg.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [Ext2-devel] disk throughput
In-Reply-To: <3BEAA3B7.A7F9328E@isg.de>,
		<3BE647F4.AD576FF2@zip.com.au>
		<Pine.GSO.4.21.0111050904000.23204-100000@weyl.math.psu.edu>
		<3BE71131.59BA0CFC@zip.com.au> 
		<20011106105138Z16653-12382+40@humbolt.nl.linux.org>
		<1005063444.25686.18.camel@ixodes.goop.org>  <3BEAA3B7.A7F9328E@isg.de> <1005237961.4537.0.camel@ixodes.goop.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Fitzhardinge wrote:
> 
> On Thu, 2001-11-08 at 07:24, Constantin Loizides wrote:
> >
> > > This is one I made a while ago while doing some measurements; its also
> > <[snip]
> >
> > That's an interesting plot. I would like to do one for my disk!
> >
> > How did you do it?
> > How do you find out about the seek distance???
> > Do you create one big file and then start
> > seeking around accessing different blocks of it?
> 
> Its pretty simple.  I open /dev/hda (the whole device), and read random
> blocks, timing how long it takes for the data to come back since the
> last one.  I set up a few hundred/thousand buckets, and accumulate the
> measured time into the bucket for that seek distance.  So:
> 
>         fd=open("/dev/hda")
>         llseek(fd, last = rand());
>         read(fd)
>         while(!finished) {
>                 blk = rand();
>                 llseek(fd, blk);
>                 read(fd);
>                 bucket[abs(last-blk)] = time;
>                 last = blk;
>         }

How do you avoid aftifacts from Linux caching with this test?

> I found the random seeking was the only way I could get reasonable
> numbers out of the drive; any of the ordered patterns of the form "OK,
> lets measure N block seeks" seemed to be predicted by the drive and gave
> unreasonably fast results.
> 

But we *want* unreasonably fast results!  We need to understand
this device-level prediction, then decide if it's sufficiently
widespread for us to go and exploit the hell out of it.

Have you any ideas as to what's happening?

-
