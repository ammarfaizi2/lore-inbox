Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261957AbVGUPWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261957AbVGUPWo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 11:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261797AbVGUPWY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 11:22:24 -0400
Received: from amber.ccs.neu.edu ([129.10.116.51]:2544 "EHLO amber.ccs.neu.edu")
	by vger.kernel.org with ESMTP id S261794AbVGUPVH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 11:21:07 -0400
Date: Thu, 21 Jul 2005 11:21:05 -0400 (EDT)
From: Jim Faulkner <jfaulkne@ccs.neu.edu>
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: IDE Zip drive doesn't work under 2.6.12
Message-ID: <Pine.GSO.4.58.0507211045180.28914@denali.ccs.neu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Recently I upgraded from 2.6.11.11 to 2.6.12.3.  This morning I tried
using my Zip drive... unfortunately it doesn't work under 2.6.12.3.  To
verify that this was a kernel problem, I rebooted to 2.6.11.11.  Here's
some relevant output using 2.6.11.11:

uname -a:
Linux michelangelo 2.6.11.11 #2 SMP Fri Jun 3 21:02:33 EDT 2005 i686
Intel(R) Xeon(TM) CPU 1700MHz GenuineIntel GNU/Linux

parts of dmesg:
    ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:DMA
hdd: IOMEGA ZIP 250 ATAPI, ATAPI FLOPPY drive
hdd: 98304kB, 196608 blocks, 512 sector size
hdd: 98304kB, 96/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm
 hdd: hdd4

michelangelo ~ # mount /dev/hdd4 /mnt/zip
michelangelo ~ # df -h
Filesystem            Size  Used Avail Use% Mounted on
/dev/md1               17G  3.7G   13G  23% /
udev                  506M  2.6M  503M   1% /dev
none                  506M     0  506M   0% /dev/shm
/dev/hdd4              96M     0   96M   0% /mnt/zip

And here's what happens under the 2.6.12 kernel:

Linux michelangelo 2.6.12.3 #1 SMP Wed Jul 20 18:14:36 EDT 2005 i686
Intel(R) Xeon(TM) CPU 1700MHz GenuineIntel GNU/Linux

 ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA, hdd:DMA
hdd: IOMEGA ZIP 250 ATAPI, ATAPI FLOPPY drive
hdd: 98304kB, 196608 blocks, 512 sector size
hdd: 98304kB, 96/64/32 CHS, 4096 kBps, 512 sector size, 2941 rpm
hdd: CHECK for good STATUS
 hdd: hdd4

michelangelo ~ # mount /dev/hdd4 /mnt/zip
mount: special device /dev/hdd4 does not exist
michelangelo ~ #

Every time I run that "mount" command under 2.6.12.3 I get that same error
message, and each time this line shows up in my dmesg again:
 hdd: hdd4

Something else weird happens when I run the "mount" command.  Right after
running the command, /dev/hdd4 disappears for a few seconds, then
re-appears:
michelangelo ~ # ls -al /dev/hdd4
brw-rw----  1 root root 22, 68 Jul 21 11:05 /dev/hdd4
michelangelo ~ # mount /dev/hdd4 /mnt/zip
mount: special device /dev/hdd4 does not exist
michelangelo ~ # ls -al /dev/hdd4
ls: /dev/hdd4: No such file or directory
michelangelo ~ # ls -al /dev/hdd4
ls: /dev/hdd4: No such file or directory
michelangelo ~ # ls -al /dev/hdd4
brw-rw----  1 root root 22, 68 Jul 21 11:06 /dev/hdd4
michelangelo ~ #

I'm using udev-058.  Should I be using a newer version of udev with
2.6.12?  Or is this a kernel bug?  Please CC my e-mail address in any
replies since I am not subscribed to this list.

thanks,
Jim Faulkner
