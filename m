Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280031AbRKITTj>; Fri, 9 Nov 2001 14:19:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280041AbRKITSs>; Fri, 9 Nov 2001 14:18:48 -0500
Received: from jericho.gospelcom.net ([204.253.132.2]:28678 "HELO
	gospelcom.net") by vger.kernel.org with SMTP id <S280035AbRKITSV>;
	Fri, 9 Nov 2001 14:18:21 -0500
Date: Fri, 9 Nov 2001 14:18:34 -0500 (EST)
From: Brian DeFeyter <bdf@gospelcom.net>
X-X-Sender: <bdf@agabus.gf.gospelcom.net>
To: <linux-kernel@vger.kernel.org>
Subject: RAID5 reconstruction problem
Message-ID: <Pine.LNX.4.33.0111091403320.8002-100000@agabus.gf.gospelcom.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Last night I had 2 drives in a 6 drive array instantly fail and cause my 
array to crash. I suspect that the channel these 2 drives were on was the 
cause as these were the only 2 drives on that channel.

Here's my current /etc/raidtab for the failed /dev/md7:

raiddev             /dev/md7
raid-level                  5
nr-raid-disks               6
nr-spare-disks              0
persistent-superblock       1
parity-algorithm            left-symmetric
chunk-size                  32
device              /dev/sdc1
raid-disk           0
device              /dev/sdd1
raid-disk           1
device              /dev/sde1
raid-disk           2
device              /dev/sdf1
raid-disk           3
device              /dev/sdg1
raid-disk           4
device              /dev/sdh1
raid-disk           5

sdc1 and sdd1 where the failed drives. I used the 'fail one drive in 
/etc/raidtab' trick on sdd1 to bring the array back which worked fine. 
Then remarked sdd1 as a 'raid-disk' instead of 'failed-disk' and then did 
a 'raidhotadd /dev/md7 /dev/sdd1' which started the recontruction.

About 1/2 way through, /dev/sdd1 died with the failure diagnostic led 
blinking. I swapped it out with a new drive, paritioned it (Linux, not 
auto-detect), formatted it, and then attempted a 'raidhotadd /dev/md7 
/dev/sdd1'

Unfortunately, the raidhotadd appears to fail right away. I get a couple 
hundred lines of kernel messages with 'DISK' and raidconf printouts. A gut 
feeling tells me it doesn't like the superblock on the new drive. However,
I do know that the drive itself is fine since I manually mounted it and
ran a few tests on it before re-formatting it and putting it into the
array. If anyone wants all the kernel messages, I'll send them along.


Thanks,

 - bdf

