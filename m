Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318313AbSGYDTh>; Wed, 24 Jul 2002 23:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318314AbSGYDTh>; Wed, 24 Jul 2002 23:19:37 -0400
Received: from ausadmmsps305.aus.amer.dell.com ([143.166.224.100]:62218 "HELO
	AUSADMMSPS305.aus.amer.dell.com") by vger.kernel.org with SMTP
	id <S318313AbSGYDTg>; Wed, 24 Jul 2002 23:19:36 -0400
X-Server-Uuid: bc938b4d-8e35-4c08-ac42-ea3e606f44ee
Message-ID: <F44891A593A6DE4B99FDCB7CC537BBBBB8394A@AUSXMPS308.aus.amer.dell.com>
From: Matt_Domsch@Dell.com
To: viro@math.psu.edu, Andries.Brouwer@cwi.nl
cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: RE: 2.5.28 and partitions
Date: Wed, 24 Jul 2002 22:22:41 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
X-WSS-ID: 1121B08E4086219-01-01
Content-Type: text/plain; 
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> That stuff becomes an issue for 2Tb disks.  Do we actually have something
> that large attached to 32bit boxen?

Absolutely.  A single external disk pod with 14 73GB SCSI disks is >1TB,
with 145GB disks expected in the very near future, and 120GB IDE disks
available today.  You can put 4 disk pods on a single 4-channel RAID
controller.  You can have multiple 4-channel RAID controllers and do
software RAID across the lot.  You can attach your server to a multi-TB
Dell|EMC SAN.  All of these configs are limited by the current 32-bit block
address.

> ... and still use i386 with these disks?  

Yep.  We're doing all of this today on our x86 server products, and don't
expect x86 to die any time soon.  I'm on conference calls each week with
customers who have huge data storage requirements, who like the
price/performance of x86 servers and the ever-decreasing cost of storage.
Medical imaging.  Render farms.  CAD/CAM.  Search engines.  Mirror sites.
Scientific compute clusters (they want a real CFS too).  Spam quarantine :-)
I'm excited by Peter Chubb's LBD patch for 2.5.x, but a product with a 2.6.x
kernel is still a long way away, and customers with money are asking for
this today.  "Be patient" isn't something a salesperson likes to hear when
there's a commission on the line. :-)

Right now all of these solutions are being done with multiple ~1TB
partitions and file systems, which for most applications works.  But some of
the above believe they would benefit from, say, a single 10TB shared
clustered file system (with another 10TB of disks to back the thing up).
That isn't possible today, even though one could build such.

> >u64 for sector_t doesn't change anything for 64bit boxen 
> >that might be interested in really large disks and
> >screws 32bit ones that shouldn't have to pay for that...
> 
> True. That's why sector_t should be a compile time option in 
> the kernel

I'd be happy with an option too.  Then the distros can choose to enable it
for some kernels "i686 bigmem-bigdisk", but not for i686 UP.  There does
arise the proliferation of kernels problem, but I'm sure the distros will
have some ideas there.

The promise of 64-bit block addresses eventually was a huge part of why I
worked on the GPT code in the kernel, partx, parted, etc.  I could really
use it today, and it'll be a solid requirement less than a year from now.


Thanks,
Matt
--
Matt Domsch
Sr. Software Engineer, Lead Engineer, Architect
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
#1 US Linux Server provider for 2001 and Q1/2002! (IDC May 2002)

