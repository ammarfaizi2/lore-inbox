Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262972AbUEBKkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262972AbUEBKkY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 May 2004 06:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262961AbUEBKkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 May 2004 06:40:24 -0400
Received: from bay18-f56.bay18.hotmail.com ([65.54.187.106]:56338 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262972AbUEBKkO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 May 2004 06:40:14 -0400
X-Originating-IP: [67.22.169.122]
X-Originating-Email: [jpiszcz@hotmail.com]
From: "Justin Piszcz" <jpiszcz@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Linux Kernel 2.6.5 - Severe Bug(s) With DVD Read Support For Burned DVD-R's?
Date: Sun, 02 May 2004 10:40:13 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <BAY18-F56Q86EZvLohp000028d9@hotmail.com>
X-OriginalArrivalTime: 02 May 2004 10:40:13.0888 (UTC) FILETIME=[D9CDA400:01C43031]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I used a Plextor 8X +/- DVD/RW to burn two DVD-R's at a speed of 2x.
1] 3 files adding up to 4.2GB (no file is > 2.0GB however)
2] Many > 1000 files totaling 2.2GB.

I used growisofs to burn the the ISO's.
With the following command:
growisofs -dvd-compat -Z /dev/scd0=dvd1.iso

As a control, I used a professionally burned DVD

I have the same DVD-READER in all my machines (4-5).
hdd: TOSHIBA DVD-ROM SD-M1712, ATAPI CD/DVD-ROM drive

I have tried with DMA on and DMA off, I get the following errors in DMESG:
hdd: DMA disabled
ISO 9660 Extensions: Microsoft Joliet Level 3
ISO 9660 Extensions: RRIP_1991A
Here is some DEBUG information:
It copies 4.0GB out of the 4.0GB and then, from dmesg:
hdd: media error (bad sector): status=0x51 { DriveReady SeekComplete Error }
hdd: media error (bad sector): error=0x30
hdd: media error (bad sector): status=0x51 { DriveReady SeekComplete Error }
hdd: media error (bad sector): error=0x30
hdd: media error (bad sector): status=0x51 { DriveReady SeekComplete Error }
hdd: media error (bad sector): error=0x30
end_request: I/O error, dev hdd, sector 8173440
hdd: media error (bad sector): status=0x51 { DriveReady SeekComplete Error }
hdd: media error (bad sector): error=0x30
end_request: I/O error, dev hdd, sector 8173444
hdd: media error (bad sector): status=0x51 { DriveReady SeekComplete Error }
hdd: media error (bad sector): error=0x30
end_request: I/O error, dev hdd, sector 8173448
hdd: media error (bad sector): status=0x51 { DriveReady SeekComplete Error }
hdd: media error (bad sector): error=0x30
end_request: I/O error, dev hdd, sector 8173452
hdd: media error (bad sector): status=0x51 { DriveReady SeekComplete Error }
hdd: media error (bad sector): error=0x30
end_request: I/O error, dev hdd, sector 8173456

$ df -k
/dev/hdd               4132960   4132960         0 100% /mnt
$ du -ack *pgp
4093288 total

Therefore, it _almost_ copies the entire DVD, but then it sh*ts the bed, any 
idea what is going on here?
I have the _exact_ drive also as a slave in another box running Windows 2000 
Professional which copies the DVD with no errors at all.

This is a serious problem as I can never copy a DVD-R (that I burned) on 
Linux (to a Linux box), does anyone have any clue to why this occurs?

This is where it gets interesting though, concerning the professionally 
burned DVD, I am not sure if it is DVD+R or DVD-R, but it copied the entire 
disc just fine:

# mkdir /tmp/dvd; cp -r /mnt/* /tmp/dvd
#

491.83GB/d   20985.00MB/h     349.75MB/m    5969.06KB/s
532.37GB/d   22714.80MB/h     378.58MB/m    6461.13KB/s
591.67GB/d   25245.00MB/h     420.75MB/m    7180.80KB/s
622.74GB/d   26570.40MB/h     442.84MB/m    7557.96KB/s
670.07GB/d   28590.00MB/h     476.50MB/m    8132.26KB/s
726.25GB/d   30987.00MB/h     516.45MB/m    8814.20KB/s
756.56GB/d   32280.00MB/h     538.00MB/m    9181.86KB/s

With good speeds as well.

On the Plextor 8X from which I burned it (under 2.4.x) kernel, (2.4.25/26), 
I can copy the entire DVD to anywhere without a single error (on the box 
that I burned it from).

[root@l2 root]# mkdir /x/d
[root@l2 root]# mount /dev/scd0 /mnt
mount: block device /dev/scd0 is write-protected, mounting read-only
[root@l2 root]# cp /mnt/* /x/d
[root@l2 root]# du -sh /x/d
4.0G    /x/d
[root@l2 root]# du -sk /x/d
4136932 /x/d
[root@l2 root]#


Is it a problem with the drive, or something with the media not being 
supported under Linux, or are there some other factors at work here?

_________________________________________________________________
Express yourself with the new version of MSN Messenger! Download today - 
it's FREE! http://messenger.msn.com/go/onm00200471ave/direct/01/

