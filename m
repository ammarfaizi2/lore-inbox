Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265603AbTFNDPU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 23:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265605AbTFNDPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 23:15:20 -0400
Received: from auth22.inet.co.th ([203.150.14.104]:40196 "EHLO
	auth22.inet.co.th") by vger.kernel.org with ESMTP id S265603AbTFNDPO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 23:15:14 -0400
From: Michael Frank <mflt1@micrologica.com.hk>
To: Vojtech Pavlik <vojtech@ucw.cz>
Subject: Re: 2.4.21-rc7 hang on boot after spurious 8259A interrupt: IRQ15.
Date: Sat, 14 Jun 2003 11:24:09 +0800
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <200306130958.39707.mflt1@micrologica.com.hk> <20030613214832.A6366@ucw.cz>
In-Reply-To: <20030613214832.A6366@ucw.cz>
X-OS: KDE 3 on GNU/Linux
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306141124.09882.mflt1@micrologica.com.hk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 14 June 2003 03:48, Vojtech Pavlik wrote:
> On Fri, Jun 13, 2003 at 11:36:36AM +0800, Michael Frank wrote:
> > Doing swsusp testing in endless loop. On a P4/2.4G (ACPI=off)
> > on 192nd boot:
> >
> > spurious 8259A interrupt: IRQ15.
> > Calibrating delay loop...
>
> It looks like the IDE code didn't put the controller into sleep
> properly.
>

Please don't get confused by swsusp being tested ;)

The system executes a regular boot from _reset_ at this stage.
swsusp takes over once the kernel is up and restores the
suspended kernel

IDE info:

Uniform Multi-Platform E-IDE driver Revision: 7.00beta4-2.4
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
SIS5513: IDE controller at PCI slot 00:02.5
SIS5513: chipset revision 0
SIS5513: not 100% native mode: will probe irqs later
SiS651    ATA 133 controller
    ide0: BM-DMA at 0x4000-0x4007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0x4008-0x400f, BIOS settings: hdc:pio, hdd:pio
hda: IC35L090AVV207-0, ATA DISK drive
blk: queue c031fd40, I/O limit 4095Mb (mask 0xffffffff)
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
hda: attached ide-disk driver.
hda: host protected area => 1
hda: 160836480 sectors (82348 MB) w/1821KiB Cache, CHS=10011/255/63, UDMA(100)
Partition check:
 hda: hda1 hda2 hda3 hda4

> >  hang
> >
> > Hit Reset and it rebooted OK
> >
> > This is the first spurious 8259A interrupt: IRQ15 seen.
> >
> > I see spurious 8259A interrupt: IRQ7 quite frequently on
> > varying hardware on both 2.4 and 2.5.
> >
> > By design, the 8259A delivers a vector 7 when the IRQ
> > line is deasserted before the IRQ is serviced. This
> > applies to both edge and level trigger modes. A floating
> > "wire" or crapy chipset can pickup noise, but the driver
> > should handle it.
> >
> > No problems seen with mainboard/cpu/ram in three months.
> > I dont' think it is HW, but it could be.
> >
> > Also, spurious 8259A interrupts are quite recent, could
> > something be wrong with recent 8259A driver?
> >

Could it be that the kernel does not handle a spurious int at 
this early stage in the boot process ?

Regards
Michael


-- 
Powered by linux-2.5.70-mm3, compiled with gcc-2.95-3

My current linux related activities in rough order of priority:
- Testing of Swsusp for 2.4
- Research of NFS i/o errors during transfer 2.4>2.5
- Learning 2.5 series kernel debugging with kgdb - it's in the -mm tree
- Studying 2.5 series serial and ide drivers, ACPI, S3
* Input and feedback is always welcome *

