Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264558AbSIVVtP>; Sun, 22 Sep 2002 17:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264559AbSIVVtP>; Sun, 22 Sep 2002 17:49:15 -0400
Received: from www.applecomm.net ([210.80.130.210]:56327 "EHLO
	www.applecomm.net") by vger.kernel.org with ESMTP
	id <S264558AbSIVVtO>; Sun, 22 Sep 2002 17:49:14 -0400
Message-ID: <3D8E3B1A.5050800@harmsconsulting.com>
Date: Mon, 23 Sep 2002 07:50:18 +1000
From: Andree Leidenfrost <andree.leidenfrost@harmsconsulting.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.1) Gecko/20020826
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Kernel Panic: 2.4.20pre7-ac3 and earlier with PDC20276
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am experiencing kernel errors when accessing disks attached to the 
PDC20276. Executing command 'badblocks -svw /dev/hde' starts fine:

sv-sap001:/home/andree# badblocks -svw /dev/hde
Checking for bad blocks in read-write mode
 From block 0 to 39082680
Writing pattern 0xaaaaaaaa:   1266090/ 39082680

After a while I start getting messages like the stuff below on the 
console (this manually copied from the console).

This happens on both drives and on both channels. Cables were replaced, 
so were the harddisks. I returned the machine to my dealer who tested 
things under WinXP and says that everything works fine. I have tried 
this with 2.4.19 and pretty much all 2.4.20preX and 2.4.20preX-acY 
version over the past three weeks without success. When I switch off DMA 
('hdparm -d0 /dev/hde') things are of course terribly slow but they work 
fine.

I am trying hdaprm -d1 -X15 at the moment. It has been running for 40 
hours now and gotten as far as 27047040/39082680. So far it looks like I 
only get 'eepro100: wait_for_cmd_done timeout!' but no IDE errors.

Sometimes I am getting a kernel Aiiii followed by a kernel panic saying 
something like 'Trying to kill interrupt handler'. I just haven't been 
albe to reproduce it for this mail.

I am happy to do other testing if  someone tells me what to do. Just 
bear in mind that though being an experienced Linux administrator I am 
nothing close to a kernel developer. ;-)

Best regards
Andree

 

Console output snippet:

hde: dma_rtimer_expiry: dma status == 0x21
hde: timeout waiting for DMA
PDC202XX: Primary channel reset.
hde: timeout waiting for DMA
hde: (__ide_dma_test_irq) called while not waiting
hde: status error: status=0x58 { DriveReady SeekComplete DataRequest }

hde: drive not ready for command
hde: status timeout: status=0xd0 { Busy }

PDC202XX: Primary channel reset.
hde: drive not ready for command
ide2: reset: success

eepro100: wait_for_cmd_done timeout!
(repeated many times)

hda: timeout waiting for DMA
hda: timeout waiting for DMA
hda: (__ide_dma_test_irq) called while not waiting
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }

hda: drive not ready for command
hda: status timeout: status=0xd0 { Busy }

hda: no DRQ after issueing write
ide0: reset: success


 


Motherboard: Gigabyte GA-7DPXW+
Chipset: AMD-760MPX
RAID: PDC20276
CPU: 2 x AthlonMP 1800+

