Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129618AbRCRGtI>; Sun, 18 Mar 2001 01:49:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131151AbRCRGs6>; Sun, 18 Mar 2001 01:48:58 -0500
Received: from f29.law14.hotmail.com ([64.4.21.29]:42757 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S129618AbRCRGsu>;
	Sun, 18 Mar 2001 01:48:50 -0500
X-Originating-IP: [24.27.17.228]
From: "Kernel Jake" <kerneljake@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.4.x on netpliance i-opener
Date: Sun, 18 Mar 2001 00:48:03 -0600
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F29y20h08xWI0AT2Jve00002ce0@hotmail.com>
X-OriginalArrivalTime: 18 Mar 2001 06:48:04.0157 (UTC) FILETIME=[61B49ED0:01C0AF77]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am having difficulty booting 2.4-based Linux kernels on my
Netpliance I-Opener.  The Linux 2.4 TODO list has the following entry:

IDE fails on some VIA boards (eg the i-opener) (reported fixed by Konrad 
Stepien)

This issue is not really "fixed" as reported in the TODO.  Mr. Stepien
has indicated to me in e-mail that his problem went away on a
non-i-opener motherboard with a VIA chipset when he upgraded to 2.4.0.

There is a long history of this issue.  There was a patch posted to
the linux-kernel mailing list that allegedly solved the problem:

http://www.uwsg.indiana.edu/hypermail/linux/kernel/0009.3/1218.html

This patch was reposted here:

http://boudicca.tux.org/hypermail/linux-kernel/2000week51/0317.html

The patch fixes a bug in the way the IDE probing code handles flash
disks.  The bug occurs when there is one (and only one) hard disk
attached to the IDE connector on the I-Opener motherboard.

Here is what happens when I boot 2.4.2 without the patch:

...
VP_IDE: ide controller on pci bus 00 dev 39
VP_IDE: chipset revsion 6
VP_IDE: not 100% native mode: will probe irqs later
hda: ibm-dyka-22160, ata disk drive
hdb: sundisk sdtb-128, ata disk drive
hdb: set_drive_speed_status: status 0x51 { driveready seekcomplete error }
hdb: set_drive_speed_status: error=0x04 { DriveStatusError}
ide0: Drive 1 didn't accept speed setting. Oh, well.
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hdb: 31360 sectors (16 MB) w/1KiB Cache, CHS=490/2/32
Partition check:
  hdb: hdb1 hdb2 hdb3 hdb4
floppy0: no floppy controllers found
...
VFS: Cannot open root device "301" or 03:01
Please append a correct "root=" boot option
Kernel panic: VFS: Unable to mount root fs on 03:01

... and here is what happens when I boot it *with* the patch:

...
VP_IDE: ide controller on pci bus 00 dev 39
VP_IDE: chipset revsion 6
VP_IDE: not 100% native mode: will probe irqs later
hda: ibm-dyka-22160, ata disk drive
hdb: sundisk sdtb-128, ata disk drive
hdb: set_drive_speed_status: status 0x51 { driveready seekcomplete error }
hdb: set_drive_speed_status: error=0x04 { DriveStatusError}
ide0: Drive 1 didn't accept speed setting. Oh, well.
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: 4233600 sectors (2168 MB) w/90KiB Cache, CHS=525/128/63, UDMA(33)
hdb: 31360 sectors (16 MB) w/1KiB Cache, CHS=490/2/32
Partition check:
  hda: hda1 hda2
  hdb: hdb1 hdb2 hdb3 hdb4
floppy0: no floppy controllers found
...
VFS: Mounted root (ext2 filesystem) readonly.
Freeing unused kernel memory: 176k freed
<slient hang>

You'll notice that the kernel sees hda's geometry and partitions after
the patch is applied, but I am still unable to get my i-opener to
boot.  I have tried the following kernels to no avail: 2.2.16, 2.4.0,
2.4.1, 2.4.2, 2.4.3pre3.  My installation method was to install Redhat
7.0 and upgrade my kernel to 2.4.x.  Yes, I got the latest modutils.
I have tried the following LILO parameters without success:

      hdb=noprobe
      hdb=flash
      hdb=none
      hdb=noprobe

After doing a little debugging with the patch enabled, it appears as
if the execve("/sbin/init") in main.c's init() is never succeeding.  I
tried passing "init=/bin/sh" to LILO and I still get the "silent
hang".

Note: all of the above kernels *will* boot when I plug the harddisk
into my ATX clone machine, but they won't boot on my i-opener.  I
*have* been successful in getting the i-opener to boot when I use an
old 2.0.35 kernel.  But I need USB mass storage to turn my box into an
MP3 player, so I need a 2.4 kernel.  So the problem is not the
harddisk because it boots in other computers, and it's not the BIOS
because I can boot older 2.0 kernels.  I am hypothesizing the problem
is at the driver/filesystem layer.

There are many people in the same predicament as I am.  The i-opener
newsgroups are littered with people who are unable to get 2.4-based
kernels to boot on their machines.  Any help would be appreciated.

_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com

