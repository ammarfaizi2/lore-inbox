Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261344AbTKBDTb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Nov 2003 22:19:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbTKBDTb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Nov 2003 22:19:31 -0500
Received: from mailrelay2.lrz-muenchen.de ([129.187.254.102]:47046 "EHLO
	mailrelay2.lrz-muenchen.de") by vger.kernel.org with ESMTP
	id S261326AbTKBDT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Nov 2003 22:19:26 -0500
Date: Sun, 2 Nov 2003 04:17:13 +0100
From: Florian Reitmeir <squat@riot.org>
To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org
Subject: many ide drives, raid0/raid5
Message-Id: <20031102031713.GA3464@squat.noreply.org>
Reply-To: Florian Reitmeir <squat@riot.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Organization: riot
X-PGP: 1024D/293697C2 B2DD F351 7639 8224 B8BF 67FD 37D2 B4E5 2936 97C2
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i'm using on the machine kernel 2.6.0-test6-mm1 and 15 IDE Drives. Everything worked fine (uptime about 30 days)
I used, some raid5's, below some raid0's and on top evms.

heres "cat /proc/mdstat" so its more clear

============ cut 
Personalities : [raid0] [raid5]
md4 : active raid5 hdp[2] hdo[1] hdn[0]
      120627072 blocks level 5, 32k chunk, algorithm 2 [4/3] [UUU_]

md3 : active raid0 hdm[1] hdl[0]
			49956352 blocks 32k chunks

md0 : inactive hdc[0]
			80418176 blocks
unused devices: <none>
============ cut 

here are some drives missig, 
	md0, is one drive missing
	md1, complete
	md2, also
									
when i make a "evms_activate" i get


========= CUT
MDRaid5RegMgr: Region md/md4 object index 3 is faulty. Array may be degraded.
MDRaid5RegMgr: Region md/md4 disks array not zeroed
MDRaid5RegMgr: Region md/md4 has disk counts that are not correct.
MDRaid5RegMgr: RAID5 array md/md4 is missing the member md/md3 with RAID index 3.  The array is running in degrade mode.
LvmRegMgr: Container lvm/rubbish has incorrect number of objects!
LvmRegMgr: Looking for 3 objects, found 2 objects.
LvmRegMgr: A UUID is recorded for PV 3, but PV 3 was not found.
LvmRegMgr:      UUID: vWAf1j-veQx-IDk7-SaJ0-dhga-Lase-rQ9ydR
LvmRegMgr: Container lvm/rubbish has a UUID recorded for PV 3, but PV 3 was not found. Would you like to remove PV 3 from container lvm/rubbish *PERMANENTLY*?

You should only remove this PV if you know the PV will *NEVER* be available again. If you think it is just temporarily missing, do not remove it from the container.evms_activate: Responding with default selection "Don't Remove".
LvmRegMgr: Would you like to fix the metadata for container lvm/rubbish?
evms_activate: Responding with default selection "Don't Fix".
LvmRegMgr: Region lvm/rubbish/basket has an incomplete LE map.
Missing 7327 out of 14359 LEs.
MDRaid5RegMgr: RAID5 array md/md2 is missing the member  with RAID index 3.  The array is running in degrade mode.
MDRaid0RegMgr: Region md/md1 object index incorrect: is 0, should be 1
MDRaid0RegMgr: Region md/md1 object index 1 is greater than nr_disks.
MDRaid0RegMgr: Region md/md1 object index 1 is in invalid state.
MDRaid0RegMgr: Region md/md1 disk counts incorrect
Engine: Error code 5 (Input/output error) when reading the primary copy of feature header on object lvm/rubbish/basket.
Engine: Error code 5 (Input/output error) when reading the secondary copy of feature header on object lvm/rubbish/basket.
MDRaid0RegMgr: Region md/md1 object index incorrect: is 0, should be 1
MDRaid0RegMgr: Region md/md1 object index 1 is greater than nr_disks.
MDRaid0RegMgr: Region md/md1 object index 1 is in invalid state.
MDRaid0RegMgr: Region md/md1 disk counts incorrect
MDRaid0RegMgr: Region md/md1 object index incorrect: is 0, should be 1
MDRaid0RegMgr: Region md/md1 object index 1 is greater than nr_disks.
MDRaid0RegMgr: Region md/md1 object index 1 is in invalid state.
MDRaid0RegMgr: Region md/md1 disk counts incorrect
========= CUT


or in other words, its a mess. I verfied, all drives are found and work correct, so its "only" the meta information which is broken, i uses evmsgui to configure the whole thing, so there is no raidtab file, which i could use to force the configuration.

I also tried newer Kernel versions, but there is a timing problem i think, i use promise ide-pci controllers, and the new test9 always tries to reset those with UDMA(i think so), which won't work with that many drives.

So, is there someone who can help me ? 

--
mfG Florian Reitmeir
