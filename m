Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318898AbSICUNg>; Tue, 3 Sep 2002 16:13:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318899AbSICUNf>; Tue, 3 Sep 2002 16:13:35 -0400
Received: from hacksaw.org ([216.41.5.170]:12957 "EHLO
	habitrail.home.fools-errant.com") by vger.kernel.org with ESMTP
	id <S318898AbSICUN2>; Tue, 3 Sep 2002 16:13:28 -0400
Message-Id: <200209032020.g83KKWj4019180@habitrail.home.fools-errant.com>
X-Mailer: exmh version 2.5 08/15/2002 with nmh-1.0.4
To: Thunder from the hill <thunder@lightweight.ods.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PATCH - change to blkdev->queue calling triggers BUG in md.c 
In-reply-to: Your message of "Tue, 03 Sep 2002 13:38:47 MDT."
             <Pine.LNX.4.44.0209031324340.3373-100000@hawkeye.luckynet.adm> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 03 Sep 2002 16:20:32 -0400
From: Hacksaw <hacksaw@hacksaw.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Possibly, but you can even put together smaller arrays then (at least on a 
> sane controller). That's what the disk size setup is for. And that's, 
> after all, nothing the OS needs to take care of. It just gets to see say 
> 16 disks of 1 TiB size each. Nothing mad.
>
> But why have a partition table on each of these 16 pseudo disks?

If not a partition table, then some positive indication that there is nothing 
more.

> > More importantly, The hardware should be considered largely immutable.
> 
> Why? There's a reason why raid is mutable.

Because changing hardware is often quite annoying, and proprietary, and hard 
or impossible to script. I had one RAID that could only be set up by changing 
things using four buttons on the front panel.

But more importantly, I want controllers that survive total power down. No 
battery backed RAM, not for the setup. The cache can and should be, but the 
set up needs to survive user stupidity as well as hardware defects. And flash 
RAM still has a limited number of cycles, and can sometimes have *very* 
limited cycles, despite the best efforts of the manufacturer.

> > One reason for this: what if the controller dies?
> 
> I plug another in here and restore.

Restoring a 4TiB RAID is not what I want to be doing with a department of idle 
developers, especially if the problem is strictly with the controller. I want 
the controller to be able to get it's information from the disks. That way I 
plug in the new controller, and it says "Ready to go."

> > In fact, I'd like the controller to store its RAID setup on the disk as
> > well. Maybe even on all of them.
> 
> I don't see how partitioning could help you out here.

It was an aside.

Another factor is usage. I've had users who were assigned a slice of a RAID 
who asked me to divide the slice up, so that one experiment couldn't hose 
another by filling the whole logical disk.

> > Of course, if the partition equals the entire disk, great. The table
> > will be really short.
> 
> ...and pointless.

Admittedly. But it's important to indicate the lack of a partition table, so 
the software can get on with life, rather than trying to determine if the 
partition table got scribbled on.

> 
> > If you've ever had 70 people waiting to be able to do any work while you
> > try and restore a disk that had the partition table scribbled on, you
> > appreciate what I am saying.
> 
> Well, there's absolutely no need to do that. There are tools which can
> scribble together the old table, and these could even kick automagically.  
> (Who else thinks the BIOS shall always be replaced with something sane?)
> Once your table is restored, good luck.

Again, searching a huge RAID to determine the old partition is not something I 
want to spend an afternoon doing, not when I can spend a few blocks out of 
millions and have backups.

-- 
We perceive our perceptions.
http://www.hacksaw.org -- http://www.privatecircus.com -- KB1FVD


