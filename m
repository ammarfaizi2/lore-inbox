Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267227AbTAPTkF>; Thu, 16 Jan 2003 14:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267233AbTAPTkE>; Thu, 16 Jan 2003 14:40:04 -0500
Received: from nat9.steeleye.com ([65.114.3.137]:18183 "EHLO
	fenric.sc.steeleye.com") by vger.kernel.org with ESMTP
	id <S267227AbTAPTkD>; Thu, 16 Jan 2003 14:40:03 -0500
Date: Thu, 16 Jan 2003 14:47:16 -0500 (EST)
From: Paul Clements <kernel@steeleye.com>
Reply-To: Paul.Clements@steeleye.com
To: Ezra Nugroho <ezran@goshen.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: raid 5 algorithm docs
In-Reply-To: <1042736032.32536.170.camel@ezran.goshen.edu>
Message-ID: <Pine.LNX.4.10.10301161420400.32390-100000@clements.sc.steeleye.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16 Jan 2003, Ezra Nugroho wrote:

> I don't know if linux-raid mailing list is still active, the archive
> sites look very old...

Yes, linux-raid is still alive and kicking...
it's at: linux-raid@vger.kernel.org
 
> Raidtab's man page tells about left/right (a)synchronous algorithm, but
> doesn't tell how they differ.

I haven't seen much documentation either, but here's what I got from 
looking at the code (BTW, the relevant section of code is 
raid5.c:raid5_compute_sector(), if you're curious):

Basically, the left/right refers to how the parity information is laid 
out and the symmetric/asymmetric refers to how the data is laid out. 

The "left" algorithms start with parity on the last disk, moving the 
parity one disk closer to the first disk for each stripe (wrapping 
as necessary). The "right" algorithms do just the opposite, starting 
with parity on the first disk, moving it one disk closer to the last 
disk for each stripe (wrapping as necessary).

The "asymmetric" algorithms place the data blocks for a given stripe in 
simple sequential order, skipping over the parity block as necessary
and always starting with the first data block of a stripe on the 
first disk. The "symmetric" algorithms differ from this in that they
do not always place the first block of a stripe on the first disk,
but continue to lay out the data blocks in sequential disk order,
simply wrapping back to the first disk when it's necessary.
So the symmetric algorithms tend to give better performance on large
sequential reads, for example, since the actual disk reads are 
evenly spread across all disks.

There's a pretty good diagram of the left-symmetric disk layout here: 
www.pdl.cmu.edu/PDL-FTP/Declustering/ASPLOS.ps (see figure 2-1)

-- 
Paul Clements
Paul.Clements@SteelEye.com

