Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268683AbTBZIeL>; Wed, 26 Feb 2003 03:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268684AbTBZIeL>; Wed, 26 Feb 2003 03:34:11 -0500
Received: from packet.digeo.com ([12.110.80.53]:58052 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S268683AbTBZIeK>;
	Wed, 26 Feb 2003 03:34:10 -0500
Date: Wed, 26 Feb 2003 00:44:54 -0800
From: Andrew Morton <akpm@digeo.com>
To: Patrick Mansfield <patmans@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.62-mm2 slow file system writes across multiple disks
Message-Id: <20030226004454.2bfd8deb.akpm@digeo.com>
In-Reply-To: <20030225112458.A5618@beaverton.ibm.com>
References: <20030224120304.A29472@beaverton.ibm.com>
	<20030224135323.28bb2018.akpm@digeo.com>
	<20030224174731.A31454@beaverton.ibm.com>
	<20030224204321.5016ded6.akpm@digeo.com>
	<20030225112458.A5618@beaverton.ibm.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 26 Feb 2003 08:44:20.0508 (UTC) FILETIME=[4139CDC0:01C2DD73]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Mansfield <patmans@us.ibm.com> wrote:
>
> On Mon, Feb 24, 2003 at 08:43:21PM -0800, Andrew Morton wrote:
> > Patrick Mansfield <patmans@us.ibm.com> wrote:
> 
> > > I moved to 2.5.62-mm3 [I had to drop back to qlogicisp for my boot disk,
> > > and run the feral drver as a module in order to boot without hanging], and
> > > ran write-and-fsync with -f, with and without -o (O_DIRECT).
> 
> > Is this using an enormous request queue or really deep TCQ or something?
> > I always turn TCQ off, stupid noxious thing it is.
> 
> Yes - pretty high, the feral driver is defaulting to 63 (comments there
> say "FIX LATER"). Changing it to 8 gave much improved performance. 
> 
> I'm on a slightly different kernel, anyway:
> 
> 10 fsync writes of 200 mb to 10 separate disks, queue depth (TCQ) of 63 gave:
> 
> 0.05user 37.14system 1:09.39elapsed 53%CPU (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (1986major+3228minor)pagefaults 0swaps
> 
> 10 fsync writes of 200 mb to 10 separate disks, queue depth of 8 gave:
> 
> 0.05user 38.56system 0:32.71elapsed 118%CPU (0avgtext+0avgdata 0maxresident)k
> 0inputs+0outputs (1986major+3228minor)pagefaults 0swaps
> 
> The total time dropped by almost half. vmstat numbers were much smoother.

Damn, I wonder what's up with that.  I tried to reproduce this with an
Adaptec controller, but there did not appear to be a significant difference
between zero tags and 64 tags.  Nor was there an appreciable difference between
pagecache writeout and O_DIRECT writeout.

> It would be nice if a larger queue depth did not kill performance.

Does the other qlogic driver exhibit the same thing?

Does writeout to a single disk exhibit the same thing?

> The larger queue depths can be nice for disk arrays with lots of cache and
> (more) random IO patterns.

So says the scsi lore ;)  Have you observed this yourself?  Have you
any numbers handy?

