Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286747AbRLVJcq>; Sat, 22 Dec 2001 04:32:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286746AbRLVJch>; Sat, 22 Dec 2001 04:32:37 -0500
Received: from bof.de ([195.4.223.10]:40971 "HELO oknodo.bof.de")
	by vger.kernel.org with SMTP id <S286745AbRLVJc1>;
	Sat, 22 Dec 2001 04:32:27 -0500
Date: Sat, 22 Dec 2001 10:38:32 +0100
From: Patrick Schaaf <bof@bof.de>
To: linux-kernel@vger.kernel.org
Subject: very slow rebuilt for RAID15 and RAID51
Message-ID: <20011222103832.B14419@oknodo.bof.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear software-RAID hackers and users,

I'm in the process of setting up RAID15 and RAID51. Right now, this is
for performance testing, but if operational characteristics are good,
it will go into production. The hardware platform is a dual-processor
P-III box (1Ghz processors), an ASUS CUR-DLS board, 2GB RAM, and two
3ware 8-channel IDE controllers (sitting on seperate PCI busses).
There are 16 disk drives, Maxtor 80GB beasts.  The kernel is 2.4.17-rc2,
with the MD code compiled in (no modules). I use the raidtools2 package
of current Debian woody.  As a testing platform, the machine does not
do anything besides the things described here:

In order to compare RAID15 to RAID51, I split the drives into two equal-sized
partitions, sd[a-p]2 for the RAID15, and sd[a-p]3 for the RAID51 tests.

The first layer was created yesterday: 8 mirror pairs, each pair with one
drive on each 3ware controller, rebuilt in parallel at a rate of about
7.5MB/s per mirror pair, 60MB/s aggregate. Next, two RAID5 sets were
created in parallel, each spanning the "3" partition of the 8 drives
of one, and the other, controller. This initial rebuild progressed
at about 12MB/s/set, 24MB/s aggregate. I waited until all this layer 1
rebuild was done.

So far, everything is well. I/O characteristics for sequential read and
write are OK on both variants. Sequential read from the RAID5 sets gives
me a whopping 150MB/s transfer speed. Great.

Then I started the second layer, making a RAID5 set out of the 8 mirror pairs
out of the "2" partitions, and making a mirror pair out of the two RAID5 sets
on the "3" partition. Technically, this seems to work, but the initial rebuild
runs extremely slow, compared to the above rates: the RAID15 rebuild goes
at about 380kB/s, and the RAID51 build at slightly over 100kB/s. I will report
on operational characteristics, once these rebuilds are through (in about
30 days, for the RAID51...)

Anybody got any explanation, hints, or even convincing discouragement?

best regards
  Patrick

Please Cc: me on replies, I'm not subscribed to linux-kernel.

Here is the /etc/raidtab I am using. md[0-7] are the layer 1 mirror pairs,
md1[0-1] are the layer 1 RAID5 arrays, md8 is the RAID15 thing, and md9
is the RAID51 thing.

raiddev /dev/md0
 raid-level 1
 nr-raid-disks 2
 persistent-superblock 1
 chunk-size 8
 device /dev/sda2
 raid-disk 0
 device /dev/sdi2
 raid-disk 1
raiddev /dev/md1
 raid-level 1
 nr-raid-disks 2
 persistent-superblock 1
 chunk-size 8
 device /dev/sdb2
 raid-disk 0
 device /dev/sdj2
 raid-disk 1
raiddev /dev/md2
 raid-level 1
 nr-raid-disks 2
 persistent-superblock 1
 chunk-size 8
 device /dev/sdc2
 raid-disk 0
 device /dev/sdk2
 raid-disk 1
raiddev /dev/md3
 raid-level 1
 nr-raid-disks 2
 persistent-superblock 1
 chunk-size 8
 device /dev/sdd2
 raid-disk 0
 device /dev/sdl2
 raid-disk 1
raiddev /dev/md4
 raid-level 1
 nr-raid-disks 2
 persistent-superblock 1
 chunk-size 8
 device /dev/sde2
 raid-disk 0
 device /dev/sdm2
 raid-disk 1
raiddev /dev/md5
 raid-level 1
 nr-raid-disks 2
 persistent-superblock 1
 chunk-size 8
 device /dev/sdf2
 raid-disk 0
 device /dev/sdn2
 raid-disk 1
raiddev /dev/md6
 raid-level 1
 nr-raid-disks 2
 persistent-superblock 1
 chunk-size 8
 device /dev/sdg2
 raid-disk 0
 device /dev/sdo2
 raid-disk 1
raiddev /dev/md7
 raid-level 1
 nr-raid-disks 2
 persistent-superblock 1
 chunk-size 8
 device /dev/sdh2
 raid-disk 0
 device /dev/sdp2
 raid-disk 1

raiddev /dev/md8
 raid-level 5
 nr-raid-disks 8
 persistent-superblock 1
 chunk-size 128
 device /dev/md0
 raid-disk 0
 device /dev/md1
 raid-disk 1
 device /dev/md2
 raid-disk 2
 device /dev/md3
 raid-disk 3
 device /dev/md4
 raid-disk 4
 device /dev/md5
 raid-disk 5
 device /dev/md6
 raid-disk 6
 device /dev/md7
 raid-disk 7

raiddev /dev/md9
 raid-level 1
 nr-raid-disks 2
 persistent-superblock 1
 chunk-size 8
 device /dev/md10
 raid-disk 0
 device /dev/md11
 raid-disk 1

raiddev /dev/md10
 raid-level 5
 nr-raid-disks 8
 persistent-superblock 1
 chunk-size 32
 device /dev/sda3
 raid-disk 0
 device /dev/sdb3
 raid-disk 1
 device /dev/sdc3
 raid-disk 2
 device /dev/sdd3
 raid-disk 3
 device /dev/sde3
 raid-disk 4
 device /dev/sdf3
 raid-disk 5
 device /dev/sdg3
 raid-disk 6
 device /dev/sdh3
 raid-disk 7

raiddev /dev/md11
 raid-level 5
 nr-raid-disks 8
 persistent-superblock 1
 chunk-size 32
 device /dev/sdi3
 raid-disk 0
 device /dev/sdj3
 raid-disk 1
 device /dev/sdk3
 raid-disk 2
 device /dev/sdl3
 raid-disk 3
 device /dev/sdm3
 raid-disk 4
 device /dev/sdn3
 raid-disk 5
 device /dev/sdo3
 raid-disk 6
 device /dev/sdp3
 raid-disk 7

Finally, here's a current snapshot of /proc/mdstat:

Personalities : [raid0] [raid1] [raid5] 
read_ahead 1024 sectors
md8 : active raid5 md7[7] md6[6] md5[5] md4[4] md3[3] md2[2] md1[1] md0[0]
      272702080 blocks level 5, 128k chunk, algorithm 0 [8/8] [UUUUUUUU]
      [========>............]  resync = 43.9% (17120184/38957440) finish=909.8min speed=396K/sec
md9 : active raid1 md11[1] md10[0]
      272814912 blocks [2/2] [UU]
      [>....................]  resync =  1.7% (4651736/272814912) finish=39435.7min speed=111K/sec
      
md11 : active raid5 sdp3[7] sdo3[6] sdn3[5] sdm3[4] sdl3[3] sdk3[2] sdj3[1] sdi3[0]
      272814976 blocks level 5, 32k chunk, algorithm 0 [8/8] [UUUUUUUU]
      
md10 : active raid5 sdh3[7] sdg3[6] sdf3[5] sde3[4] sdd3[3] sdc3[2] sdb3[1] sda3[0]
      272814976 blocks level 5, 32k chunk, algorithm 0 [8/8] [UUUUUUUU]
      
md0 : active raid1 sdi2[1] sda2[0]
      38957504 blocks [2/2] [UU]
      
md1 : active raid1 sdj2[1] sdb2[0]
      38957504 blocks [2/2] [UU]
      
md2 : active raid1 sdk2[1] sdc2[0]
      38957504 blocks [2/2] [UU]
      
md3 : active raid1 sdl2[1] sdd2[0]
      38957504 blocks [2/2] [UU]
      
md4 : active raid1 sdm2[1] sde2[0]
      38957504 blocks [2/2] [UU]
      
md5 : active raid1 sdn2[1] sdf2[0]
      38957504 blocks [2/2] [UU]
      
md6 : active raid1 sdo2[1] sdg2[0]
      38957504 blocks [2/2] [UU]
      
md7 : active raid1 sdp2[1] sdh2[0]
      38957504 blocks [2/2] [UU]
      
unused devices: <none>
