Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262385AbULOQnI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262385AbULOQnI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 11:43:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262386AbULOQmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 11:42:17 -0500
Received: from hqemgate03.nvidia.com ([216.228.112.143]:62217 "EHLO
	HQEMGATE03.nvidia.com") by vger.kernel.org with ESMTP
	id S262385AbULOQkI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 11:40:08 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: RAID1 + LVM not detected during boot on 2.6.9
Date: Wed, 15 Dec 2004 08:40:03 -0800
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B0033AE3D6@hqemmail02.nvidia.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: RAID1 + LVM not detected during boot on 2.6.9
thread-index: AcTiwd++r3suIgi6RkaUTNuZIqlNtwAAlpkw
From: "Stephen Warren" <SWarren@nvidia.com>
To: "Aleksandar Milivojevic" <amilivojevic@pbl.ca>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 15 Dec 2004 16:40:12.0902 (UTC) FILETIME=[BF96E060:01C4E2C4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: linux-kernel-owner@vger.kernel.org 
> I've installed one machine (Fedora Core 3 distro) with /boot 
> on  RAID1 device (md0) and all other filesystems on LVM
> volumes located on another  RAID1 device (md1).  There was
> only one volume group, with couple of volumes for file
> systems (one of them was root file system).

I have this exact same setup, and it's working great.

You do have the correct partition types setup, right? The underlying
RAID partitions should be type 0xfd (Linux raid autodetect). Also, where
are your disks attached - are you really sure that the kernel has
drivers for your host controller in the initrd - perhaps you should edit
the linuxrc (I think) script file to cat the content of some /proc files
to prove that the disks are known to the kernel. Perhaps even add sfdisk
to the initrd, and have it dump out the partition tables etc. at boot
time.

For example, fdisk says this about one of my disks:

SEVERN:~$ sudo fdisk /dev/hdg

The number of cylinders for this disk is set to 30515.
There is nothing wrong with that, but this is larger than 1024,
and could in certain setups cause problems with:
1) software that runs at boot time (e.g., old versions of LILO)
2) booting and partitioning software from other OSs
   (e.g., DOS FDISK, OS/2 FDISK)

Command (m for help): 

Disk /dev/hdg: 251.0 GB, 251000193024 bytes
255 heads, 63 sectors/track, 30515 cylinders
Units = cylinders of 16065 * 512 = 8225280 bytes

   Device Boot      Start         End      Blocks   Id  System
/dev/hdg1   *           1          13      104391   fd  Linux raid
autodetect
/dev/hdg2              14       30226   242685922+  fd  Linux raid
autodetect
/dev/hdg3           30227       30357     1052257+  82  Linux swap

-- 
Stephen Warren, Software Engineer, NVIDIA, Fort Collins, CO
swarren@nvidia.com        http://www.nvidia.com/
swarren@wwwdotorg.org     http://www.wwwdotorg.org/pgp.html
