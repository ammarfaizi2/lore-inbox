Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263137AbTA0VCL>; Mon, 27 Jan 2003 16:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267130AbTA0VCL>; Mon, 27 Jan 2003 16:02:11 -0500
Received: from chaos.analogic.com ([204.178.40.224]:16531 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S263137AbTA0VCK>; Mon, 27 Jan 2003 16:02:10 -0500
Date: Mon, 27 Jan 2003 16:14:03 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: John Bradford <john@grabjohn.com>
cc: rtilley <rtilley@vt.edu>, linux-kernel@vger.kernel.org
Subject: Re: Hard Disk Failure
In-Reply-To: <200301271956.h0RJu9Ij001336@darkstar.example.net>
Message-ID: <Pine.LNX.3.95.1030127161221.17070A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Jan 2003, John Bradford wrote:

> > > no.  e2fsprogs might cause data loss, but not
> > > physical damage.
> > 
> > This reminds me of something I read once.
> > 
> > In his book, Takedown, Tsutomu Shimomura (forgive me if that's
> > spelled wrong) wrote a few short paragraphs about how he was able to
> > move the head-arm of a magnetic disk drive back and forth with
> > software commands. He could tell the head-arm to go to any cylinder
> > on the drive, he wondered what would happen if he tried to send it
> > to a cylinder that was outside the physical limits of the drive. He
> > told the drive (a 200 cylinder drive) to goto cylinder 4000. The
> > drive actually tried to go to that cylinder and caused a hardware
> > failure in the process.
> 
> It's actually possible to make some old mainframe hard disks 'walk'
> across the floor, by doing various seeks across the disk :-).
> 
> > Is it still possible for software to damage hardware in this fashion
> > or is hardware smarter now? Do drives know not to try and access a
> > cylinder that is outside their physical limits?
> 
> Since modern hard disks are not accessed by their physical
> geometries', I would imagine that it would be rare to be able to cause
> physical damage to a disk by sending a reference to an out of range
> sector.  The disk has to translate the sector you send to it in to
> it's real geometry anyway, so there should be no way to translate an
> invalid sector in to an invalid physical geometry location, which it
> could then not seek to.
> 
> John

In a previous life, I wrote a Disk utility called SPINOK.
It was posted on my BBS (The PROGRAM EXCHANGE) and became
the major product of a company that made a (copy, clone,
theft?) called Spin-Rite. This utility would determine
the optimum interleave for a disk drive. It would first
save the data from a track into memory, then format the
track, then write the data back.

Most disk drives in those days used the ST-506 interface,
however, when the IDE interface became popular, it was
necessary to determine the geometry of the drive before
attempting to format a track with the new interleave. This
was necessary because the track headers contain the cylinder
as well as the head and sector. If this gets written wrong,
you have the slowest drive you can imagine!

So, the utility tries first to determine the number of cylinders,
then the number of sectors per track, then the number of heads.
It does this by trying to read head 0 (all drives have head 0),
sector 1 (all drives have sector 1), cylinder 1024 (the maximum
possible in those days. It would  "work backwards" to determine
the whole geometry. It used Newton's method for quick convergence
so it didn't have to try all combinations.

It was possible for a disk to get "stuck" if it seeked (sought)
to a cylinder that was too high. However, a power-off reset
would fix it because, during power up, the drive always moved
the head-arm throughout the platters to minimize "stiction" and
get the heads flying.

Having mucked with many disk drives, I don't thing it's possible
to kill them from "commands" unless the command is "upload firmware".
If you happen to upload Linux instead of the correct firmware, the
drive may "go penguin" and all bets are off!

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


