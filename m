Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265230AbSLIL4v>; Mon, 9 Dec 2002 06:56:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265262AbSLIL4v>; Mon, 9 Dec 2002 06:56:51 -0500
Received: from mina.ecs.soton.ac.uk ([152.78.64.20]:35998 "HELO
	mina.ecs.soton.ac.uk") by vger.kernel.org with SMTP
	id <S265230AbSLIL4u>; Mon, 9 Dec 2002 06:56:50 -0500
Date: Mon, 9 Dec 2002 12:04:32 +0000
From: Hugo Mills <hugo-lkml@carfax.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Need help recovering RAID array after admin error
Message-ID: <20021209120431.GB9768@mina.ecs.soton.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Hi,

   Software RAID-5 does indeed protect against a disk failure.

   Software RAID-5 doesn't protect against removing the wrong disk
from the array after a disk failure. :(

   I'm using 2.4.20-ac1 with a Debian-testing system and the new mdadm
tools. I have (or had) a 3-device RAID-5 array.  One disk decided to
have a bit of a funny turn, and the RAID code kicked it out of the
array as failed. I believe (although it's difficult to be absolutely
certain) that it was the middle disk in the array (disk 1) which
failed.

   The mdadm monitoring daemon, however, mailed me immediately to tell
me of the failure, and it reported the device node of disk 2. I didn't
do any further checks, but immediately used mdadm to pull what I
thought was the faulty disk from the array, at which point my system
started rapidly to collapse. At that point, I panicked and hit
Alt-SysRq-b.

   I can still boot the machine, since boot and root fs aren't on the
RAID-5 device.

   After some investigation, I believe that the failed disk is
actually still good, at least enough to get the important data off
it. I prodded the RAID-5 partitions and examined their superblocks
with mdadm. I can't quote the results verbatim, since the machine is
no longer net-capable, and it's 2 miles away from here, but...

   Disk 0: thinks that disk 1 has failed, that disk 2 no longer
exists, that disk 3 is now what was disk 2, and that disk 3 is an
unsynced spare. Has superblock version 56.

   Disk 1: thinks that everything is OK. Has superblock version 55.

   Disk 2/3: thinks much the same as disk 0. Has superblock version 56.

   Is there any way that I can rebuild the array in a degraded mode
from disks 0 and 1, using the superblock information from disk 1?

   If not, and if I had a big enough storage area, could I dd the
relevant partitions onto it as files and reconstruct enough data in
userspace to mount the filesystems from the array on a loopback to
recover my data?

   Can anyone help?

   I would have backups of this data, only the backup system I was
using corrupted disks and crashed the VM, so I stoppeed using it... :(

   Hugo.

-- 
 --- Hugo Mills - <hugo@soton.ac.uk> - ECS at Southampton University --- 
          --- Comb-e-chem project: http://www.combechem.org/ ---         
              Quantum Mechanics: The dreams stuff is made of             
