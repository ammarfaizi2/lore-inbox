Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318111AbSHBEL3>; Fri, 2 Aug 2002 00:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318117AbSHBEL3>; Fri, 2 Aug 2002 00:11:29 -0400
Received: from mail3.atl.registeredsite.com ([64.224.219.77]:15569 "EHLO
	mail3.atl.registeredsite.com") by vger.kernel.org with ESMTP
	id <S318111AbSHBEL2>; Fri, 2 Aug 2002 00:11:28 -0400
Content-Type: text/plain; charset=US-ASCII
From: "Stonie R. Cooper" <stonie.cooper@planetarydata.com>
Organization: Planetary Data, Incorporated
To: linux-kernel@vger.kernel.org
Subject: large ramdisk based filesystem corruption in 2.4.18?
Date: Fri, 2 Aug 2002 04:14:49 +0000
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <02080204144907.16136@helium.fieldlab.planetarydata.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an SMP, 2.4.18, system, with 1GB of RAM.

I initially started by trying to have a 750MB ramdisk for a virtual 
filesystem; I defined the size in the boot parm line via grub.

The dmesg output indicated each ramdisk would be 750MB, and when I do a 
mke2fs on /dev/ramdisk, it indicates it formats a 750MB ext2 file system, but 
when I try to mount, it says the partition has a bad block descriptor, or a 
non-supported filesystem.

I then made the ramdisk definition 512MB and reboot.  Again, mke2fs is 
successful, and formats a 512MB filesystem, but this time I am successful in 
mounting.  However, after creating a few files, I get write errors such as 
described by another developer:

"Somehow I have filled the /ramdisk partition.  The thing that confuses me is 
that a df -k shows:
/dev/ramdisk            507748    481538         0 100% /ramdisk
but a du -sk shows:
119666  ."

I worked with her, and we found no hidden files, and the manual count of 
adding up all the files on the file system was 120MB - even though the df 
reported 481MB.  We unmounted, did a new mke2fs on /dev/ramdisk, but this 
time, it wouldn't mount with the same errors as when I tried a 750MB ramdisk.

Rebooted, and redid the same 512MB ramdisk, but this time it mounted, and ran 
for almost a day before it gave the same conflicting information that it was 
full, even though the du -ks showed differently.  Ideas?
-- 
Stonie R. Cooper
Planetary Data, Incorporated
ph. (402) 782-6611
