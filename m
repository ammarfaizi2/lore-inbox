Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266299AbUAVS4v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 13:56:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266319AbUAVS4v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 13:56:51 -0500
Received: from web20723.mail.yahoo.com ([216.136.226.77]:52136 "HELO
	web20723.mail.yahoo.com") by vger.kernel.org with SMTP
	id S266299AbUAVS4r (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 13:56:47 -0500
Message-ID: <20040122185646.93559.qmail@web20723.mail.yahoo.com>
Date: Thu, 22 Jan 2004 10:56:46 -0800 (PST)
From: Joe Schmo <joe619017@yahoo.com>
Subject: Problems with IDE CF
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
We recently encountered a problem very similar to an
old post in majordomo forum. We boot up a linux image
written on a RiData 128mb CF card on IDE interface
(hda), the kernel dumps these error messages on the
screen:

hda: CF-ATA, ATA Disk drive
ide: Assuming 33 MHz system bus speed for PIO modes,
override with idebus=xx
hda: set_drive_speed_status status=0x51 { DriveReady
SeekComplete Error }
hda: set_drive_speed_status error=0x04 { Drive Status
Error }
...
hda: dma_intr: status=0x51 { DriveReady SeekComplete
Error }
hda: dma_intr: error=0x04 { Drive Status Error }
...
hda: DMA disabled
...
hda: lost interrupt
hda: lost interrupt
hda: lost interrupt
[it keeps repeating the last message every few
seconds]

The same image has a very high failure rate when
installed in RiData CF card, but always work when
installed in another brand of CF.  It seems the
original post solved part of their problem after
receiving a recommended solution from Soewono, but I
can't find Soewono's original message from "Linux
Kernel Archive". 

This is very urgent since we will have a meeting with
customer today, and if we can't provide a solution we
won't win the deal. Could anyone please shed some
light? Thanks!
-joe


>
Soewono, 
Excellent, and thank you very much. That fixed the
ludicrous delay and such 
while coming up. I still get the kobject_register
error, however. 
--John 
On Thursday 22 May 2003 13:14 pm, you wrote: 
> Hi J.C. 
> 
> give this a try. 
> 
> best regards 
> Soewono 
> 
> J.C. Wren wrote: 
> > Today I ported 2.5.69 to my embedded 386EX system,
and am encountering 
> > problems with the IDE handling of compact flash
cards (Sandisk, Kingston, 
> > and 
> > a suspected Toshiba controller based card).
kobject_register is failing 
> > with a -17 (EEXISTS) when registering the hda
device: 
> > 
> > ide: Assuming 50MHz system bus speed for PIO
modes; override with 
> > idebus=xx hda: SunDisk SDCFB-48, CFA DISK drive 
> > ide0 at 0x1f0-0x1f7,0x3f6 on irq 9 
> > hda: max request size: 128KiB 
> > hda: task_no_data_intr: status=0x51 { DriveReady
SeekComplete Error } 
> > hda: task_no_data_intr: error=0x04 {
DriveStatusError } 
> > hda: 93952 sectors (48 MB) w/1KiB Cache,
CHS=734/4/32 
> > hda: hda1 
> > hda: hda1 
> > kobject_register failed for hda1 (-17) 
> > Call Trace: [<c01631bf>] [<c0155308>] [<c017007b>]
[<c0163a37>] 
> > [<c0170060>] [<c0177eb6>] [<c0177e64>]
[<c0177e6c>] [<c018afd4>] 
> > [<c0187602>] [<c01883ea>] [<c018aff2>]
[<c0200611>] [<c0105024>] 
> > [<c0105040>] [<c0105024>] [<c0106dbd>] 
> > 
> > The .config looks like: 
> > 
> > CONFIG_IDE=y 
> > CONFIG_BLK_DEV_IDE=y 
> > # CONFIG_BLK_DEV_HD_IDE is not set 
> > # CONFIG_BLK_DEV_HD is not set 
> > CONFIG_BLK_DEV_IDEDISK=y 
> > CONFIG_IDEDISK_MULTI_MODE=y 
> > # CONFIG_IDEDISK_STROKE is not set 
> > # CONFIG_BLK_DEV_IDECD is not set 
> > # CONFIG_BLK_DEV_IDEFLOPPY is not set 
> > # CONFIG_IDE_TASK_IOCTL is not set 
> > # CONFIG_BLK_DEV_CMD640 is not set 
> > 
> > The CF card is connected directly to the bus
through a couple of latches 
> > (i.e., not using a CMD640 or PCI chipset or
anything). There is no DMA. 
> > The hardware is fully functional, as I've been
using the 2.2.12 kernel 
> > driver for a couple of years (although I've always
gotten the status=0x51 
> > that IDEDISK_MULTI_MODE is suggested for). 
> > 
> > The Sandisk and Kingston come up pretty quickly.
The third card, which 
> > apparently has no embedded ID, hangs the system
about 60 seconds, before 
> > continuing with the same error. I've tried
hda=slow, and all the 
> > permutation I can think of that would make any
sense. 
> > 
> > I saw a few reports but no resolution against the
2.4.60-ac kernels. 
> > I've also applied the bk13 patches against 2.5.69
in hopes that there 
> > might be some resolution there. 
> > 
> > I'm prefectly willing to give anything anyone
suggests a try. Are there 
> > any additional debugging options I can/should turn
on that would help 
> > anyone debug this issue? 
> > 
> > --John 


__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free web site building tool. Try it!
http://webhosting.yahoo.com/ps/sb/
