Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261693AbTDOPib (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 11:38:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261697AbTDOPib 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 11:38:31 -0400
Received: from franka.aracnet.com ([216.99.193.44]:47017 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S261693AbTDOPi3 
	(for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2003 11:38:29 -0400
Date: Tue, 15 Apr 2003 08:50:18 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
Reply-To: LKML <linux-kernel@vger.kernel.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 588] New: 2.5.67 won't get the real partition table for hdb
Message-ID: <75510000.1050421818@[10.10.2.4]>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=588

           Summary: 2.5.67 won't get the real partition table for hdb
    Kernel Version: 2.5.67
            Status: NEW
          Severity: high
             Owner: alan@lxorguk.ukuu.org.uk
         Submitter: torden88@yahoo.no


Distribution: Linux From Scratch, glibc 2.3.2, gcc 3.2.2 (didn't work with
2.95.5 either)
Hardware Environment: Athlon XP 1600+, hdb is a seagate 20,4 gb, 
Software Environment:gcc 3.2.2
Problem Description: 
2.5.67 won't get the real partition table for hdb
Steps to reproduce: Just compile and run a 2.5.67 kernel.
 
When I compiled a 2.5.67 kernel (and 2.5.66, 2.5.65 and 2.5.63), during
boot it says:
Kernel panic: could not mount root fs on /dev/hdb13 (or something).
I look a bit longer up, and i see this:
hdb: hdb1
When it is detecting the partition.
I am using isolinux for booting (lilo and GRUB doesn't work).
It did not work with syslinux either.

fdisk -l /dev/hdb says:
   Device Boot    Start       End    Blocks   Id  System
/dev/hdb1             2      2490  19992892+   f  Win95 Ext'd (LBA)
/dev/hdb2   *         1         2      8032+  83  Linux
Partition 2 does not end on cylinder boundary:
     phys=(1, 0, 63) should be (1, 254, 63)
/dev/hdb5             2        14    104359+  83  Linux
/dev/hdb6            15       651   5116671   83  Linux
/dev/hdb7           652       827   1413688+  83  Linux
/dev/hdb8           828       892    522081   82  Linux swap
/dev/hdb9           893      1019   1020096    b  Win95 FAT32
/dev/hdb10         1020      1529   4096543+  83  Linux
/dev/hdb11         1530      1911   3068383+  83  Linux
/dev/hdb12         1912      2154   1951866   83  Linux
/dev/hdb13         2155      2490   2698888+  83  Linux

I don't boot from /dev/hdb2.

It works perfectly with 2.4.x.

