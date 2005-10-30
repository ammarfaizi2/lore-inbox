Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbVJ3VLJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbVJ3VLJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Oct 2005 16:11:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751122AbVJ3VLJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Oct 2005 16:11:09 -0500
Received: from mail.avalus.com ([195.82.114.197]:50584 "EHLO shed.alex.org.uk")
	by vger.kernel.org with ESMTP id S1751105AbVJ3VLI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Oct 2005 16:11:08 -0500
Date: Sun, 30 Oct 2005 21:10:56 +0000
From: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Reply-To: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Alex Bligh - linux-kernel <linux-kernel@alex.org.uk>
Subject: 3ware 9550SX problems - mke2fs incredibly slow writing last third
 of inode tables
Message-ID: <BEDEA151E8B1D6CEDD295442@[192.168.100.25]>
X-Mailer: Mulberry/4.0.4 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am having great difficulty getting a 3Ware 9550SX working.

I'm using 2.6.12 with EITHER the 2.6.14 driver, or the latest 3-ware driver
(2.26.04.006) from their web site, plus latest BIOS and firmware, on an
Dual AMD64 opteron 275 system.

I'm only not using 2.6.14 because compiling an ubuntu-boot-sequeunce
compatible kernel for AMD64 SMP is decidedly non-trivial (i.e. I have spent
the whole day doing it and failed dismally).

The RAID card is attached to a 4 x 512Gb SATA-II disk array in RAID-5
configuration (1.5Tb total)

All seems to go well until I try and do mke2fs. This appears to work,
and tries to write the inode tables. However, at (about) 3400 inodes
(of 11176), it slows to a crawl, writing one table every 10 seconds.
strace shows it is still running, and no errors are being reported.
However, it seems very sick.

No debug messages indicating any errors.

The only other clue as to what may be wrong is in the boot sequence.
I see lots of bad LUN messages (detail below). However, it does appear
to be detecting the disks right in the end.

Anyone got any ideas?


Oct 30 20:09:09 localhost kernel: [ 138.688249] 
/dev/scsi/host4/bus0/target0/lun0: p1 < p5 >
Oct 30 20:09:09 localhost kernel: [ 138.712496] Attached scsi disk sdb at 
scsi4, channel 0, id 0, lun 0
Oct 30 20:09:09 localhost kernel: [ 138.712814] scsi: On host 4 channel 0 
id 0
only 511 (max_scsi_report_luns) of 214715501 luns reported, try increasing 
max_scsi_report_luns.
Oct 30 20:09:09 localhost kernel: [ 138.712817] scsi: host 4 channel 0 id 0 
lun 0x383438203636202d has a LUN larger than currently supported.
Oct 30 20:09:09 localhost kernel: [ 138.712822] scsi: host 4 channel 0 id 0 
lun 0x204c697665203078 has a LUN larger than currently supported.
Oct 30 20:09:09 localhost kernel: [ 138.712826] scsi: host 4 channel 0 id 0 
lun 0x6666666666666666 has a LUN larger than currently supported.
Oct 30 20:09:09 localhost kernel: [ 138.712830] scsi: host 4 channel 0 id 0 
lun 0x3838303039303030 has a LUN larger than currently supported.
Oct 30 20:09:09 localhost kernel: [ 138.712835] scsi: host 4 channel 0 id 0 
lun 0x0a74696c65626c69 has a LUN larger than currently supported.
Oct 30 20:09:09 localhost kernel: [ 138.712839] scsi: host 4 channel 0 id 0 
lun 0x7420333332382031 has a LUN larger than currently supported.
Oct 30 20:09:09 localhost kernel: [ 138.712843] scsi: host 4 channel 0 id 0 
lun 0x206662636f6e2c20 has a LUN larger than currently supported.
Oct 30 20:09:09 localhost kernel: [ 138.712848] scsi: host 4 channel 0 id 0 
lun 0x4c69766520307866 has a LUN larger than currently supported.
Oct 30 20:09:09 localhost kernel: [ 138.712852] scsi: host 4 channel 0 id 0 
lun 0x6666666666666638 has a LUN larger than currently supported.


--
Alex Bligh
