Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315755AbSEJBy5>; Thu, 9 May 2002 21:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315756AbSEJBy4>; Thu, 9 May 2002 21:54:56 -0400
Received: from ns3.swva.net ([66.37.69.243]:61702 "EHLO ns3.swva.net")
	by vger.kernel.org with ESMTP id <S315755AbSEJByz>;
	Thu, 9 May 2002 21:54:55 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Silvan <silvan@windows-sucks.com>
To: linux-kernel@vger.kernel.org
Subject: Kernel 2.4.18 + ext3 = filesystem corruption
Date: Thu, 9 May 2002 21:56:12 -0400
X-Mailer: KMail [version 1.4]
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200205092156.12911.silvan@windows-sucks.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I posted this to the newsgroup linux.kernel before I realized it was a one-way 
gateway.  I'm finally getting around to forwarding this to the list proper.

I've just heard from a fellow in New Zealand running a completely different 
distro (Debian Woody) with a completely different motherboard (some Abit, and 
he's running an SMP kernel, so I assume he has an SMP box), yet experiencing 
the same 2.4.18+ext3 corruption relationship.  I've sent him a message 
offering to compare hardware, but have not heard back yet.  If I find a 
common thread, I'll be sure to let you know.  Thus far I don't see anything 
we share, but I suspect that if I _do_ find common hardware that will narrow 
your focus in addressing this bug.  My hearing about his plight has prompted 
me to make a further effort to bring this to your attention, as it 
strengthens my opinion that this is a bonafide bug at work.

The following is the post I made to the newsgroup:

,--------------- Forwarded message (begin)

 Subject: Kernel 2.4.18 + ext3 = filesystem corruption
 From: Silvan <silvan@windows-sucks.com>
 Date: Fri, 26 Apr 2002 11:08:10 -0400

 I had a filesystem explosion (across the board corruption on all ext3 
 partitions, brought to my attention by a rather nasty series of EXT3_fs 
 errors and an immediate crash) about a month back.  I lost some data, and 
 there were numerous errors that had to be repaired.  I realized that I 
 couldn't ever remember seeing a fsck since moving to ext3, so I 
 experimented with tune2fs and dumpe2fs.  All of the partitions were set 
 with a random, large negative number for the maximum mount count.  I have 
 no idea whether that was true before the crash or not.
 
 I began to eliminate suspects.  I checked RAM, running memtest 86 for 24 
 hours with no errors.  I reverted to kernel 2.4.16, removed my journals and 
 mounted ext2, switched to conservative settings all around (lower PCI bus 
 speed, conservative hdparm options, etc.)
 
 I've been gradually bringing things back to their previous state, fscking my 
 partitions regularly (daily at first, then gradually moving to a 5 mounts or 
 7 days interval) as I've gone.  I had no filesystem errors of any kind 
 since the last disaster, and then I decided to move back to 2.4.18.  No 
 problems for a few days, so I installed new journals and moved back to 
 ext3.
 
 Within four days, I had another filesystem explosion, though it was less 
 severe than the last, affecting only hde6 and hde9.  Files weren't there, 
 entire chunks of directories were missing, and so on, and everything was 
 pretty well hosed in that state.  Upon recovery, while fscking during the 
 subsequent boot, there were numerous, numerous errors in the filesystem, 
 and I've lost more data.
 
 Both crashes were seemingly spontaneous, triggered by everyday activities, 
 probably brought on when I finally accessed a file that had a hole in it 
 and brought the whole house of cards tumbling down.  I have no record of 
 anything that happened, as nothing useful made its way into any of my logs.
 
 I'm running Mandrake 8.1 with a generic kernel 2.4.18.  No patches.  2.4.16 
 and 2.4.18 were compiled with the same config, and I don't think there is 
 anything noteworthy there.  Everything works perfectly, except that I 
 sometimes experience video display corruption when switching virtual 
 terminals.  More a problem with 2.4.16, but it happens with both kernels.  
 (A separate issue, and not the source of my concern.  I'll take video 
 corruption over data loss any day.)
 
 My hardware:
 
 AMD K7-1000 on ASUS A7V (VIA Apollo KT133a chipset, integrated Promise 
 ATA-100 controller), 256 MB RAM, Linksys 10/100E NIC, USR PCI Performance 
 Pro modem, SB PCI 128, Riva TNT2 AGP video (running at 4X in BIOS and in X), 
 CREATIVE CD-RW RW8439E, CD-950E/TKU, Maxtor 94610H6, generic PS/2 mouse, 
 generic FD, and a 104-key keyboard.
 
 Kernel boots (LILO) with:  append=" devfs=nomount hda=ide-scsi 
 mem=nopentium"
 
 Partitions are all ext3.
 
 I can think of nothing further to add.  I've done my best to isolate this, 
 but I haven't been able to repeat this in a controlled way so that I can 
 attribute a precise event as triggering the corruption.  It seems that the 
 corruption is on-going over time while 2.4.18 is running, and eventually I 
 stumble into a hole.  I personally suspect the journaling code, but that's 
 speculation borne of almost pure ignorance.
 
`--------------- Forwarded message (end)

-- 
Michael McIntyre  zone 6b in SW VA
Silvan Pagan
umount /mnt/windows;mke2fs /dev/hde1;tune2fs -j /dev/hde1
www.geocities.com/Paris/Rue/5407/index.html
