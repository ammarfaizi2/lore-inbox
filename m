Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267081AbUBMT4B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Feb 2004 14:56:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267209AbUBMT4B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Feb 2004 14:56:01 -0500
Received: from fw.osdl.org ([65.172.181.6]:38832 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267081AbUBMTz7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Feb 2004 14:55:59 -0500
Date: Fri, 13 Feb 2004 11:55:16 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>
cc: Willy Tarreau <willy@w.ods.org>, Timothy Miller <miller@techsource.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: File system performance, hardware performance, ext3, 3ware RAID1,
 etc.
In-Reply-To: <20040213193046.GA17790@bounceswoosh.org>
Message-ID: <Pine.LNX.4.58.0402131146040.2144@home.osdl.org>
References: <402C0D0F.6090203@techsource.com> <20040213055350.GG29363@alpha.home.local>
 <20040213193046.GA17790@bounceswoosh.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 13 Feb 2004, Eric D. Mudama wrote:
> 
> This may be a function of the operating system or the filesystem, but
> it isn't necessarilly an artifact of the drives themselves.  With both
> read and write caching enabled, random writes will always be faster
> than random reads from the drive perspective.

Well.. Yes and no.

Writes are fundamentally more schedulable, and that's a huge advantage for 
throughput, since latency really doesn't matter. Which means that you'll 
find a lot of loads that can much more easily get to platter speeds for 
writes.

On the other hand, reads are inherently easier on a pure hardware level, 
since read-ahead and track buffers are trivial ways to get to true platter 
speeds for a lot of reasonable loads.

And the software-visible 512-byte blocking factor just has to be
_incredibly_ painful on a hardware level, and I'd be surprised if there
aren't disks out there already where the actual real physical block-size
is bigger. Which means that I would expect a lot of drives to internally
do read-modify-write cycles for small writes.

And especially in a market where density is often more important than pure
speed, I'd expect hw manufacturers to have a _huge_ bias towards big
blocks on the platter, in order to avoid having to have lots of
inter-sector gaps etc.

So in that kind of schenario, random writes would be clearly slower than
random reads.

> the absolute worst-case write performance should be the same as read
> performance.

That is only true if the disk block-size is smaller than the IO blocksize. 
Can somebody fill me in on what modern disks do, especially the 
high-density ones?

			Linus
