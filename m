Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992660AbWJTQlm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992660AbWJTQlm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 12:41:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992668AbWJTQlm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 12:41:42 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:33482 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S2992660AbWJTQll (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 12:41:41 -0400
From: Christian <christiand59@web.de>
To: linux-kernel@vger.kernel.org
Subject: Device mapper/LVM throughput problem
Date: Fri, 20 Oct 2006 18:41:31 +0200
User-Agent: KMail/1.9.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610201841.31435.christiand59@web.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:176b6e6b41629db5898eee8167b5e3a0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello lkml!

I've just tested the disk throughput on my machine using hdparm and found some 
puzzling results. I have  a two disk nvidia fakeraid 0 configuration using 
dmraid and lvm.

When testing the single disks, I get good results just like when testing the 
dmraid mapping. When I test the throughput on a raid partition or the LVM 
Volumes I get very bad performance. Has anybody seen something like this 
before?


single disks: (good results)

user@ubuntu:~$ sudo hdparm -Tt /dev/sd[ab]

/dev/sda:
 Timing cached reads:   3384 MB in  2.00 seconds = 1693.17 MB/sec
 Timing buffered disk reads:  210 MB in  3.02 seconds =  69.56 MB/sec

/dev/sdb:
 Timing cached reads:   4096 MB in  2.00 seconds = 2049.10 MB/sec
 Timing buffered disk reads:  208 MB in  3.01 seconds =  69.01 MB/sec


dmraid mapping: (good results)

user@ubuntu:~$ sudo hdparm -Tt /dev/mapper/nvidia_cbcaiacc

/dev/mapper/nvidia_cbcaiacc:
 Timing cached reads:   3380 MB in  2.00 seconds = 1690.50 MB/sec
HDIO_DRIVE_CMD(null) (wait for flush complete) failed: Inappropriate ioctl for 
device
 Timing buffered disk reads:  392 MB in  3.01 seconds = 130.05 MB/sec
HDIO_DRIVE_CMD(null) (wait for flush complete) failed: Inappropriate ioctl for 
device


third (or any other) partition on raid (bad throughput):

user@ubuntu:~$ sudo hdparm -Tt /dev/mapper/nvidia_cbcaiacc3

/dev/mapper/nvidia_cbcaiacc3:
 Timing cached reads:   3272 MB in  2.00 seconds = 1636.72 MB/sec
HDIO_DRIVE_CMD(null) (wait for flush complete) failed: Inappropriate ioctl for 
device
 Timing buffered disk reads:  158 MB in  3.00 seconds =  52.63 MB/sec
HDIO_DRIVE_CMD(null) (wait for flush complete) failed: Inappropriate ioctl for 
device


LVM Volume (even worse)

user@ubuntu:~$ sudo hdparm -Tt /dev/VolGroup00/LogVol00

/dev/VolGroup00/LogVol00:
 Timing cached reads:   3636 MB in  2.00 seconds = 1818.96 MB/sec
HDIO_DRIVE_CMD(null) (wait for flush complete) failed: Inappropriate ioctl for 
device
 Timing buffered disk reads:  114 MB in  3.01 seconds =  37.82 MB/sec
HDIO_DRIVE_CMD(null) (wait for flush complete) failed: Inappropriate ioctl for 
device

So on LogVol00 residing on a two disk striped set I get only 38MB/s 
throughput! I would anticipate something in the range of 130-140 MB/s


user@ubuntu:~$ uname -a
Linux ubuntu.localnet 2.6.18-rc7 #2 SMP Wed Sep 13 11:28:41 CEST 2006 x86_64 
GNU/Linux

-Christian
