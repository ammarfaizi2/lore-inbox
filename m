Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292708AbSCRT7O>; Mon, 18 Mar 2002 14:59:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292688AbSCRT7G>; Mon, 18 Mar 2002 14:59:06 -0500
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:52235 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP
	id <S292730AbSCRT6v>; Mon, 18 Mar 2002 14:58:51 -0500
Date: Mon, 18 Mar 2002 14:56:21 -0500 (EST)
From: Bill Davidsen <davidsen@tmr.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: HPT370 RAID-1 or Software RAID-1, what's "best"?
In-Reply-To: <E16lvju-0004Bj-00@the-village.bc.nu>
Message-ID: <Pine.LNX.3.96.1020318144904.29698B-100000@gatekeeper.tmr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Mar 2002, Alan Cox wrote:

> > Hardware RAID is indeed better, but what you get using HPT370 IDE
> > controlelr is not hardware raid at all. Just read the code of the driver.
> > You get a software raid, period.
> 
> Its not always that simple either.

> Software raid on aic7xxx totally blows away the Dell/AMI megaraid card I
> have, to the point the megaraid now resides in my testing bucket. The promise
> Supertrak 100 (now superceded by the SX6000) is also slower than the
> software IDE raid, but does use less CPU in RAID5 mode.
> 
> Some hardware raid cards do seem to be winners. The Dell Perc2/QC aacraid
> based boards (233Mhz ARM etc) really shift. When I've had the chance to
> borrow the disks to test I've seen it running over 100Mbytes/second. It
> also supports nice stuff like online reconfiguration of active volumes.
> [$$stupid from Dell $$notalot from ebay ;)]

  Another issue is that not all RAID hardware supports anything below the
drive level, while kernel RAID runs at the partition level, and allows
various things to be in partitions on drives, rather than using the whole
drive for one thing.

  I have done things like have four drives split into RAID-5 using one set
of partitions, and RAID-0+1 on another, using different stripe sizes for
the two md sets. And I got there after a lot of trying configs, it reall
worked best that way. Putting overflow swap space on drives with RAID
allows some protection against running out of memory, although you don't
usually want your main swap fighing for space on the elevator.

  There probably is a RAID controller which can do this just as well, but
I haven't used it. Versatility is the name of the game for kernel RAID.

-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.

