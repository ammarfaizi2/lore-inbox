Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266994AbRGIDWv>; Sun, 8 Jul 2001 23:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266991AbRGIDWl>; Sun, 8 Jul 2001 23:22:41 -0400
Received: from zeus.kernel.org ([209.10.41.242]:60645 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S266992AbRGIDWc>;
	Sun, 8 Jul 2001 23:22:32 -0400
Message-ID: <3B492324.E36B86AF@linux-ide.org>
Date: Sun, 08 Jul 2001 20:21:08 -0700
From: andre@linux-ide.org
Organization: Linux ATA Development
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: vanl@megsinet.net, linux-kernel@vger.kernel.org
Subject: Re: Does kernel require IDE enabled in BIOS to access HD, FS errors?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Does kernel require IDE enabled in BIOS to access HD, FS errors?

From: M.H.VanLeeuwen (vanl@megsinet.net)
Date: Sat Jul 07 2001 - 00:25:58 EST 

Hi, 

I have a SMP P166 system that has been running for years with an AIC7xxx
SCSI card as 
opposed to the native IDE interface. The BIOS has the IDE 0,1,2,3 set to
<NONE>. 
Running out of disk space I installed one of the original IDE drives.
The kernel 
booted and ID'd the drive correctly. Kernel version 2.4.5/6 behave the
same. 

Uniform Multi-Platform E-IDE driver Revision: 6.31 
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx 
CMD646: IDE controller on PCI bus 00 dev 10 
CMD646: chipset revision 1 
CMD646: not 100% native mode: will probe irqs later 
CMD646: chipset revision 0x01, MultiWord DMA Limited, IRQ workaround
enabled 
CMD646: simplex device: DMA disabled 
ide0: CMD646 Bus-Master DMA disabled (BIOS) 
CMD646: simplex device: DMA disabled 
ide1: CMD646 Bus-Master DMA disabled (BIOS) 
hdb: CD-ROM CDU76E, ATAPI CD/DVD-ROM drive 
ide: Assuming 33MHz system bus speed for PIO modes; override with
idebus=xx 
hdc: WDC AC2850F, ATA DISK drive 
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14 
ide1 at 0x170-0x177,0x376 on irq 15 
hdc: 1667232 sectors (854 MB) w/64KiB Cache, CHS=1654/16/63 
hdb: packet command error: status=0x51 { DriveReady SeekComplete Error } 
hdb: packet command error: error=0x44 
hdb: ATAPI 4X CD-ROM drive, 256kB Cache 
Uniform CD-ROM driver Revision: 3.12 
Partition check: 
 hdc: [PTBL] [827/32/63] hdc1 

However I can't boot from the SCSI drives if the IDE HD is enabled due
to deficiencies 
in the BIOS... boot "A: then C:" or "C: then A:" are the only choices,
if neither are 
present the system boots from the SCSI card, otherwise it fails to boot. 

PROBLEM: cannot reliably R/W to the HD unless the BIOS is set to <auto>
recognize. 
I consistently see MD5SUM errors and FS corruption and other strange FS
symptoms 
when the BIOS is set to <NONE> for the drive and _never_ see any errors
with the 
setting set to <AUTO>. There are no messages emitted by the kernel that
there 
were any system errors encountered leading one to believe that all is
well, when 
it isn't. 

What is interesting, is that the I/O writes increase from once every 14
seconds to 
once every 2-3 seconds and the FS corruption diminishes but don't
disappear 
if a background "dd if=/dev/zero of=/dev/null" is running. 

Is this expected kernel behavior? 

VMSTAT follow... when copying files from SCSI drives to IDE drive. 

More info available if needed... 

Thanks, 
Martin 


Martin, you have an old beast that there are problems in how the chipset
was deployed.
How are you confirming the corruption against the various layers in the
kernel?
If you would like patches & tests to verify I will send them to you.

Cheers

-- 
Andre Hedrick
Linux ATA Development
ASL Kernel Development
-----------------------------------------------------------------------------
ASL, Inc.                                     Toll free: 1-877-ASL-3535
1757 Houret Court                             Fax: 1-408-941-2071
Milpitas, CA 95035                            Web: www.aslab.com
