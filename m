Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263409AbTD0GIt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Apr 2003 02:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263414AbTD0GIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Apr 2003 02:08:49 -0400
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:43462 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP id S263409AbTD0GIr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Apr 2003 02:08:47 -0400
Date: Sat, 26 Apr 2003 23:20:59 -0700
From: David Redman <djhr@bluetone.com>
Subject: RAID1/5, SMP 2.4.18-27.7-xsmp, EXT3 and file system corruption
To: linux-kernel@vger.kernel.org
Message-id: <3EAB76CB.7070208@bluetone.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4a)
 Gecko/20030401
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

First off, I am not subscribed to the list, I used to be but not any 
more; please reply directly to me: djhr@bluetone.com or to 
david.redman@sun.com.

So onto the problem: I've been seeing data corruption on my RAID 
metadrives for some time (months); over reboots they almost never come 
up clean, and a umount and fsck -f always ends up finding damage.
These are large EXT3 FSs - 120GB.

This is one of the failing configs:
	/dev/md0 4x40GB IBM drives RAID5
	/dev/md1 2x120GB IBM drives RAID1
I have also tried:
	/dev/md0 4x40 RAID5
	/dev/md1 /dev/md0 + 1x120 RAID1
and I see corruption on both metadisks in both configurations.

The arrays get consistently damaged; I get duplicate blocks, corrupted 
inodes, and directory holes.
An example from dmesg:
	Apr 25 04:19:35 nasbox kernel: EXT3-fs error (device md(9,2)):
	ext3_readdir: dir dectory #7603330 contains a hole at offset
	12288
This is from the RAID5 array..

My machine is nothing special Dual P3@700Mhz 384Mb DRAM, P6DBE 
super-micro motherboard. the IDE controllers running the discs are all 
PROMISE IDE PDC20262 controllers, the drives are all using UltraDMA 
cables and all drives are the master on thier own controllers (Ie 3 
cards, each with 2 drives). Root/swap is on the motherboard IDE. My 
kernel is a stock Redhat7.3; A home-brew also gets corrupted FSs.

Anyone else seen this kind of corruption? I've searched google and 
noticed a few other postings, but I thought I'd ask here.

Since I broke the mirror and just mounted a single drive (ie no 
/dev/md1, just using a raw drive /dev/hde1) I have not noticed any 
corruption on the filesystem, the other drive /dev/md0 (RAID5) is still 
getting corrupted.

I have also tried running a mirror on the single 120GB drive in degraded 
mode (ie one disk missing) and it also gets corruption. At this point I 
have to assume that my problem is /dev/md related, and because I dont 
see anyone else complaining I am assuming it is somehow tied to SMP.

I'm going to boot a non-SMP kernel and see if that changes the behavior; 
problem is it takes a horribly long time to fsck the arrays when/if they 
go bad.. sigh.

Thanks for any input;

dave.


