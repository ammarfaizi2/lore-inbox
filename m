Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277202AbRJDSoK>; Thu, 4 Oct 2001 14:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277208AbRJDSn7>; Thu, 4 Oct 2001 14:43:59 -0400
Received: from f36.pav2.hotmail.com ([64.4.37.36]:54034 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S277201AbRJDSnt>;
	Thu, 4 Oct 2001 14:43:49 -0400
X-Originating-IP: [128.173.125.231]
From: "End Sp4m" <one_wanderer_nosp4m@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: Apparently 2.4.10 not compatible with ABIT KT7-RAID if CONFIG_BLK_DEV_VIA82CXXX
Date: Thu, 04 Oct 2001 14:44:13 -0400
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F36hht0lLRa8174jDJa00016c8b@hotmail.com>
X-OriginalArrivalTime: 04 Oct 2001 18:44:13.0837 (UTC) FILETIME=[903F73D0:01C14D04]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel folks,

I posted this to nntp://mlist.linux.kernel but apparently that isn't the 
same as sending to the list itself. ;)

All of the hard disks on ide channels 1 and 2 (hda,hdb,hdc,hdd) on my abit 
kt7-raid were giving me dma_intr errors eg as follows:

hda: dma_intr: error=0x84 { DriveStatusError BadCRC }
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }

I would get TONS (many per second during disk access) of these even while 
booting.  Eventually it would stop when the kernel switched to a lower speed 
access mode.  I thought it was a hardware issue because I have another 
system with the identical motherboard and didn't have any problems using 
UDMA.  Then as I was toying with the kernel configuration for the two 
systems I found that CONFIG_BLK_DEV_VIA82CXXX was enabled on the system that 
DID NOT work and disabled on the one that DID work.  So I disabled it and 
now the system works fine.  It doesn't show the hard disk as using UDMA in 
dmesg but hdparm -vi <device> shows it happily chugging away using
udma4 (with CONFIG_BLK_DEV_VIA82CXXX enabled it had to be forced down to 
mdma2 following streams of warning messages before it would start working).

And yes, I am using 80 conductor cables, and I have tried tons of different 
cables and none of them eliminated the problem.

Note, this is a VIA KT133, not KT133A based motherboard.

So if hdparm reports the drive as using udma (but not dmesg) then is the 
drive actually using udma?  And if it works correctly without 
CONFIG_BLK_DEV_VIA82CXXX enabled then why does this kerenl option exist at 
all?  And being that it exists why does it give me MAJOR problems when I 
enable it?

Thanks,

Scott Bartlett

remove _nosp4m to get my still-spambait hotmail address.



_________________________________________________________________
Get your FREE download of MSN Explorer at http://explorer.msn.com/intl.asp

