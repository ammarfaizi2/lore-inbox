Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310130AbSCAJHR>; Fri, 1 Mar 2002 04:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310404AbSCAJFM>; Fri, 1 Mar 2002 04:05:12 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:60428 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S310405AbSCAJEE>; Fri, 1 Mar 2002 04:04:04 -0500
Message-ID: <3C7F43BE.B0D2EAE@aitel.hist.no>
Date: Fri, 01 Mar 2002 10:02:54 +0100
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.5-dj2 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Bharath Krishnan <bharath@mit.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Yet another disk transfer speed problem
In-Reply-To: <1014914087.3274.22.camel@wavelets.mit.edu> 
		<006401c1c091$d721ec00$5a5b903f@h90> <1014926801.3274.40.camel@wavelets.mit.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bharath Krishnan wrote:
> 
> Hi,
> 
> I would expect the disk which acts slower(maxtor) to be atleast as fast
> as the other one (ibm).
> 
> reasons:
> 
> 1. Both are 7200RPM
Not enough to get anywhere near equal performance.
This also depends on how densely data is packed onto a single track.
A 7200 RPM drive reads a whole track in 1/7200 minute, or 1/120 second.
That limits the maximum speed - but how much data is there
on a single track?  Slow 7200 RPM drives have many tracks and little
data on each track.  Fast drives have fewer tracks and more
data in each.  Note that this has nothing to do with disk geometry
reported by hdparm, that geometry is just a lie.
All new drives have a varying amount of data per track as the
outermost tracks are longer than the innermost.
That of course also means the speed varies a lot depending on
_what_ track is used for testing.  

My atlas IV scsi drive does 21MB/s on the outer tracks and 15MB/s
on the inner tracks according to specs.  Running bonnie tests
on partitions at either end of the drive confirms the difference.

So, expect 7200 RPM drives from different manufacturers to
have very different transfer speeds.  Or even different sized
drives from the same.

> 2. The slower one(maxtor hdg) is one of the newer ata133 disks while
> that faster one  is ata100(ibm hde). I would expect atleast equal
> performance from both.


133 or 100 sets an upper limit of 133 or 100MB/s for sure, but that
doesn't matter _at all_ because the platters aren't that fast
anyway.  The best you'll ever get depends on how much data they fit
on the outermost track.  The 133 interface will be 33% faster when
transferring small amounts of data to or from the drive's internal
cache, but it won't impact transfers bigger than the cacee size
at all.  hdparms 64M test is bigger than the drive's internal cache
which probably is a few megs only.

Helge Hafting
