Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261862AbTISXfA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 19:35:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbTISXfA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 19:35:00 -0400
Received: from primary.dns.nitric.com ([64.81.197.236]:60422 "EHLO
	primary.mx.nitric.com") by vger.kernel.org with ESMTP
	id S261862AbTISXe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 19:34:57 -0400
To: Allen Martin <AMartin@nvidia.com>
Cc: linux-kernel@vger.kernel.org
From: Merlin Hughes <lnx@merlin.org>
Subject: Re: [PATCH] 2.4.23-pre4 add support for udma6 to nForce IDE drive r 
In-reply-to: <8F12FC8F99F4404BA86AC90CD0BFB04F039F7147@mail-sc-6.nvidia.com> 
Date: Fri, 19 Sep 2003 19:34:55 -0400
Message-Id: <20030919233457.255C2338D9@primary.mx.nitric.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r/AMartin@nvidia.com/2003.09.19/16:08:55
>> Since applying your patch, however, I've managed to run such
>> a dd, with zcav thrown in, with complete relability at UDMA133
>> for several hours without problems.
>
>While I'm certainly happy to hear that, I don't think I can take credit.
>Nothing in the patch should help with system stability issues.
>
>Do you have ACPI turned on?  Look at /proc/interrupts and see if any PCI
>interrupts are set to edge triggered mode.  That's the #1 cause of stability
>problems on nForce systems.

Interesting; lots of ACPI edge-triggered interrupts:

  dagda:~# cat /proc/interrupts 
             CPU0       
    0:     519365    IO-APIC-edge  timer
    1:      16713    IO-APIC-edge  keyboard
    2:          0          XT-PIC  cascade
    8:          4    IO-APIC-edge  rtc
    9:          0   IO-APIC-level  acpi
   14:     863415    IO-APIC-edge  ide0
   15:     201651    IO-APIC-edge  ide1
   19:     306188   IO-APIC-level  nvidia
   20:      57261   IO-APIC-level  usb-ohci, eth0
   21:          0   IO-APIC-level  ehci_hcd, NVidia nForce2
   22:          3   IO-APIC-level  usb-ohci, ohci1394
  NMI:          0 
  LOC:     519312 
  ERR:          0
  MIS:          0

... but no stability problems since the primary drive has been
running at UDMA133. Earlier UDMA100 freezes were completely
repeatable; identical kernel, just without your two patches.

This is a fairly fresh reboot; earlier I had the machine writing
DVDs, hitting firewire (iPod) and USB 2.0 (memory stick pro) drives,
and so forth, without issue.

  AMD_IDE: nVidia Corporation nForce2 IDE (rev a2) UDMA133 controller on pci00:09.0
      ide0: BM-DMA at 0xf000-0xf007, BIOS settings: hda:DMA, hdb:DMA
      ide1: BM-DMA at 0xf008-0xf00f, BIOS settings: hdc:DMA, hdd:DMA
  hda: Maxtor 6Y160P0, ATA DISK drive
  blk: queue c02b75e0, I/O limit 4095Mb (mask 0xffffffff)
  hdc: PIONEER DVD-RW DVR-106D, ATAPI CD/DVD-ROM drive
  ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
  ide1 at 0x170-0x177,0x376 on irq 15
  hda: attached ide-disk driver.
  hda: host protected area => 1
  hda: 320173056 sectors (163929 MB) w/7936KiB Cache, CHS=19929/255/63, UDMA(133)

I take it that I should boot with noapic in future to be safe.

Thanks, Merlin
