Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269318AbRIRMHB>; Tue, 18 Sep 2001 08:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269326AbRIRMGl>; Tue, 18 Sep 2001 08:06:41 -0400
Received: from dialin-145-254-153-165.arcor-ip.net ([145.254.153.165]:25860
	"EHLO picklock.adams.family") by vger.kernel.org with ESMTP
	id <S269318AbRIRMGf>; Tue, 18 Sep 2001 08:06:35 -0400
Message-ID: <3BA7370C.E5F9460B@loewe-komp.de>
Date: Tue, 18 Sep 2001 13:59:08 +0200
From: Peter =?iso-8859-1?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>
Organization: B16
X-Mailer: Mozilla 4.77 [de] (X11; U; Linux 2.4.9-ac10 i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: Sam Varshavchik <mrsam@courier-mta.com>
CC: Joseph Cheek <joseph@cheek.com>, linux-kernel@vger.kernel.org
Subject: Re: disregard: Re: ide zip 100 won't mount
In-Reply-To: <courier.3BA68362.00004D02@ny.email-scan.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Varshavchik wrote:
> 
> Joseph Cheek writes:
> 
> > hmm, i went into windows *one more time* just to make sure it was still
> > working, and not a hardware problem.  well... looks like it doesn't work
> > in windows either.  must be hardware.
> >
> > funny thing it shows up in dmesg and in "My Computer", just can't read
> > from it.
> 
> That's pretty much what the sense codes below did indicate - media problem.
> Try a different disk.
> 

I had the same problem. The second media works, the first got
screwed up? I can't reproduce the problem now.

The media gets destroyed after partitioning and running mke2fs.
I can't believe it myself - but have no other explanation.

When the media was broken I got:
<7>VFS: Disk change detected on device ide0(3,64)
<6> /dev/ide/host0/bus0/target1/lun0:<7>LDM:  DEBUG (ldm.c, 877):
 validate_partition_table: Found basic MS-DOS partition, not a dynamic
disk.
<4> p1 p2 p3 p4
<7>VFS: Disk change detected on device ide0(3,65)
<6> /dev/ide/host0/bus0/target1/lun0:<7>LDM:  DEBUG (ldm.c, 877):
 validate_partition_table: Found basic MS-DOS partition, not a dynamic
disk.
<4> p1 p2 p3 p4
[and so on with funny device numbers up to 3,93]

cat /proc/partitions
   3    64      98288 ide/host0/bus0/target1/lun0/disc
   3    65  272218546 ide/host0/bus0/target1/lun0/part1
   3    66  269488144 ide/host0/bus0/target1/lun0/part2
   3    67  699181456 ide/host0/bus0/target1/lun0/part3
   3    68      10668 ide/host0/bus0/target1/lun0/part4

Note: a new media has NO partition - it's a floppy.
Now is it possible that the media gets destroyed if the hardware
tries to seek to illegal positions?


> > Joseph Cheek wrote:
> >
> >> i've tried 2.4.7-ac10 and 2.4.9-ac10.  same results.  at boot i get:
> >>
> >> Sep 17 11:02:48 seattle kernel: ide-floppy driver 0.97.sv
> >> Sep 17 11:02:48 seattle kernel: hdd: No disk in drive
> >> Sep 17 11:02:48 seattle kernel: hdd: 98304kB, 96/64/32 CHS, 4096 kBps,
> >> 512
> >> sector size, 2941 rpm
> >>
> >> looks good, right?  but i put a disk in and i get:
> >>
> >> Sep 17 14:36:23 seattle kernel: ide-floppy: hdd: I/O error, pc =  0, key
> >> =
> >> 2, asc = 30, ascq =  0
> >> Sep 17 14:36:23 seattle kernel: ide-floppy: hdd: I/O error, pc = 1b, key
> >> =
> >> 2, asc = 30, ascq =  0
> >> Sep 17 14:36:23 seattle kernel: hdd: No disk in drive
> >>
> >> not hardware, as it works in windows on the same machine.
