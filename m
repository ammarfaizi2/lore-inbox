Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264018AbTJ1QKI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 11:10:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264019AbTJ1QKI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 11:10:08 -0500
Received: from mcomail04.maxtor.com ([134.6.76.13]:1041 "EHLO
	mcomail04.maxtor.com") by vger.kernel.org with ESMTP
	id S264018AbTJ1QKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 11:10:01 -0500
Message-ID: <785F348679A4D5119A0C009027DE33C105CDB3CA@mcoexc04.mlm.maxtor.com>
From: "Mudama, Eric" <eric_mudama@Maxtor.com>
To: "'Norman Diamond'" <ndiamond@wta.att.ne.jp>, linux-kernel@vger.kernel.org,
       jw@pegasys.ws
Subject: RE: Blockbusting news, results end
Date: Tue, 28 Oct 2003 09:10:00 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Norman Diamond
> 
> Someone else in this discussion estimated that physical 
> sectors are around 1MB these days.  My friends at Toshiba
> confirmed that physical sectors are much larger than
> logical sectors.  The physical sector size resembles that
> 1MB estimate far better than the 512B logical sector size.

I don't think your friends know what they're talking about.

Disk drives that use anything resembling the "standard" channel technology
have 2 physical sector types: servo sectors and data sectors.  Servo sectors
are designed to give the servo system a constant sample rate at any radius,
therefore they're constant in time, but get physically closer as you get
closer to the ID of the drive.  Data sectors are a fixed size, to hold a
certain number of user bytes of data, and they can be split, etc, as needed
to fit them nicely on the drive.

A modern disk has "a few" data sectors per servo sector at the OD (think
3-4.5), and "a few less" at the ID of the drive. (think 1.5-2).

The 1MB number can't possibly be a servo sector, since a modern drive
transfers ~50-70MB/sec, which would imply that their servo system is holding
postion within microns, only sampling 50-70 times/second.

I don't think any modern drive can hold 1MB on a single track, I know what
our current limit is, and we're not there yet.  (Anyone can figure this out
by looking at sequential read throughput per revolution)

That would mean that to be 1MB for a data sector, or anywhere close, they're
spanning a single data cylinder across tracks.  This doesn't make sense
either.

What I think is possible, but still unlikely, is that their defect
management scheme might not be capable of handling single-block defects.
However, disk drives have had that ability for tens of years, I can't see
how they could possibly sell a drive that way.

There's also a chance that in doing the larger write, you "cleaned up" a
poorly written adjacent track or ratty servo burst, which could account for
it working now.

Other than the track size and the DRAM buffer size, I can't think of
anything else offhand in a disk drive that is "about 1MB"

The insides of these things are near voodoo-magic...

> It is really hard to imagine a physical sector still being 
> 512B because the inter-sector gaps would take some huge
> multiple of the space occupied by the sectors.

We measure these gaps in nanoseconds.  They're not that huge.  But yes,
moving to a larger standard sector size would get you a significantly larger
disk drive built from the same parts.

> I'm sure the physical sectors are not 512B.

I'm sure you're wrong.

I'd imagine that since Seagate and WD and Maxtor are constantly duking it
out to release the next generation of capacity, and we all wind up producing
nearly-identical products when all is said and done, that they're using 512B
data sectors also.
