Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130419AbRCGHAF>; Wed, 7 Mar 2001 02:00:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130422AbRCGG7z>; Wed, 7 Mar 2001 01:59:55 -0500
Received: from adsl-63-195-162-81.dsl.snfc21.pacbell.net ([63.195.162.81]:50444
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S130419AbRCGG7s>; Wed, 7 Mar 2001 01:59:48 -0500
Date: Tue, 6 Mar 2001 22:58:44 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Jonathan Morton <chromi@cyberspace.org>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Jeremy Hansen <jeremy@xxedgexx.com>, linux-kernel@vger.kernel.org
Subject: Re: scsi vs ide performance on fsync's
In-Reply-To: <l03130315b6cb7099f738@[192.168.239.101]>
Message-ID: <Pine.LNX.4.10.10103062242090.13719-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Mar 2001, Jonathan Morton wrote:

> Still doesn't make a difference - there is one revolution between writes,
> no matter where on disk it is.

Oh it does, because you are hitting the same sector with the same data.
Rotate your buffer and then you will see the difference.

> >Because of WinBench!
> >All the prefetch/caching are modeled to be optimized to that bench-mark.
> 
> Lies, damn lies, statistics, benchmarks, delivery dates.  Especially a
> consumer-oriented benchmark like WinBench.  It's perfectly natural to
> optimise for particular access patterns, but IMHO that doesn't excuse
> breaking the drive just to get a better benchmark score.

Obviously you have never been in the bowls of drive industry hell.
Why do you think there was a change the ATA-6 to require the
Write-Verify-Read to always return stuff from the platter?
Because the SOB's in storage LIE!  A real wake-up call for you is that
everything about the world of storage is a big-fat-whopper of a LIE.

Storage devices are BLACK-BOXES with the standards/rules to communicate
being dictated by the device not the host.  Storage devices are no beter
then a Coke(tm) vending machine.  You push "Coke" it gives you "Coke".
You have not a clue to how it arrives or where it came from.
Same thing about reading from a drive.

> That isn't the point!  I'm not talking about the physical mechanism, which
> indeed is often the same between one generation of SCSI and the next
> generation of IDE devices.  I'm talking about the IDE controller which is
> slapped on the bottom of said mechanism.  The mech can be of world-class
> quality, but if the controller is shot it doesn't cut the grain.

So there is a $5 differnce in the cell-gates and the line drivers are more
powerful,  80GB ATA + $5 != 80GB SCSI.

> >Since all OSes that enable WC at init will flush
> >it at shutdown and do a periodic purge with in-activity.
> 
> But Linux doesn't, as has been pointed out earlier.  We need to fix Linux.

Friend I have fixed this some time ago but it is bundled with TASKFILE
that is not going to arrive until 2.5.  Because I need a way to execute
this and hold the driver until it is complete, regardless of the shutdown
method.

> >Err, last time I check all good devices flush their write caching on their
> >own to take advantage of having a maximum cache for prefetching.
> 
> Which doesn't work if the buffer is filled up by the OS 0.5 seconds before
> the power goes.

Maybe that is why there is a vender disk-cache dump zone on the edge of
the platters...just maybe you need to buy your drives from somebody that
does this and has a predictive sector stretcher as the energy from the
inertia by the DC three-phase motor executes the dump.

Ever wondered why modern drives have open collectors on the databuss?
Maybe to disconnect the power draw so that the motor now generator
provides the needed power to complete the data dump...

> I'm sorry if this looks like another troll, but I really do like to clear
> up confusion.  I do accept that IDE now has good enough real performance
> for many purposes, but in terms of enforced quality it clearly lags behind
> the entire SCSI field.

I have no desire to debate the merits, but when your onboard host for ATA
starts shipping with GigaBit-Copper speeds then we can have a pissing
contest.

Cheers,

Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com

