Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261683AbVD0Gc3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbVD0Gc3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 02:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbVD0Gc3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 02:32:29 -0400
Received: from [195.24.46.123] ([195.24.46.123]:41370 "EHLO remotex.bg")
	by vger.kernel.org with ESMTP id S261683AbVD0GcQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 02:32:16 -0400
Message-ID: <426F31F5.70405@remotex.bg>
Date: Wed, 27 Apr 2005 09:32:21 +0300
From: Remo Tex <id@remotex.bg>
Organization: Remotex
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Adaptec 2400A i2o + x86_64 doesn't work above 128G
Content-Type: text/plain; charset=windows-1251; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have an Intel EM64T system, D915GAV motherboard,
2 GB RAM, with an Adaptec ATA Raid 2400A i2o controller.
Fedora Core 3 (and 4 test2) x86_64 and
Suse 9.2, 9.3, 64 bit -
  same behavior so I suppose it must be kernel/i2o bug :)

Since in 64 bits mode the dpt_i2o driver isn't supported, so
you have to use the generic i2o layer. But that doesn't work:
either cp or mkfs.ext3 /ext2, any/ - /dev/i2o/hda3
(START at 100 G END at 186 G) works but only below 128 G
and when that limit is reached after a while controller stops
responding (lights off) and OS dies at next disk I/O.
No kernel panic, logs ...etc. nothing to send :(

According to http://i2o.shadowconnect.com/ , it should work.

I've upgraded the BIOS and firmware of the MB and controller to
the latest versions - doesn't help. Can someone suggest what to
try next ? (without firmware update 2400A saw disks as 128 G now 186 G)

# df -h
Filesystem            Size  Used Avail Use% Mounted on
/dev/i2o/hda1          95G  7.8G   82G   9% /
none                 1002M     0 1002M   0% /dev/shm
/dev/i2o/hda3          84G   13G   67G  16% /home
 + 2G swap

and cp failed at 13 G of 80 G as you could see above
NB! Only PowerQuest Partition Magic managed to format /dev/i2o/hda3
    ext3 and survive! So it is not hardware problem, not an OS issue 
perhaps (I tried more than one OS and more than one version)...
must be i20...


Bootlog: [and 2.6.11-1.14_FC3 latest = same result]
Bootdata ok (command line is ro root=LABEL=/ rhgb quiet)
Linux version 2.6.9-1.667smp (bhcompile@dolly.build.redhat.com) (gcc 
version 3.4
.2 20041017 (Red Hat 3.4.2-6.fc3)) #1 SMP Tue Nov 2 15:09:11 EST 2004
...
PCI-DMA: Disabling IOMMU.
IA32 emulation $Id: sys_ia32.c,v 1.32 2002/03/24 13:02:28 ak Exp $
...
SCSI subsystem initialized
I2O Core - (C) Copyright 1999 Red Hat Software
i2o: max_drivers=4
i2o: Checking for PCI I2O controllers...
ACPI: PCI interrupt 0000:06:00.0[A] -> GSI 21 (level, low) -> IRQ 209
i2o: I2O controller found on bus 6 at 0.
i2o: PCI I2O controller at D0000000 size=1048576
i2o: using write combining MTRR
i2o: MTRR workaround for Intel i960 processor
iop0: Installed at IRQ 209
iop0: Activating I2O controller...
iop0: This may take a few minutes if there are many devices
iop0: HRT has 1 entries of 16 bytes each.
Adapter 00000012: TID 0000:[HPC*]:PCI 1: Bus 1 Device 22 Function 0
iop0: Controller added
I2O Block Storage OSM v0.9
   (c) Copyright 1999-2001 Red Hat Software.
block-osm: registered device at major 80
block-osm: New device detected (TID: 205)
 i2o/hda: i2o/hda1 i2o/hda2 i2o/hda3
libata version 1.02 loaded.
ata_piix version 1.02
ACPI: PCI interrupt 0000:00:1f.2[B] -> GSI 19 (level, low) -> IRQ 193
PCI: Setting latency timer of device 0000:00:1f.2 to 64
ata1: SATA max UDMA/133 cmd 0xE800 ctl 0xE402 bmdma 0xD800 irq 193
ata2: SATA max UDMA/133 cmd 0xE000 ctl 0xDC02 bmdma 0xD808 irq 193
ata1: SATA port has no device.
scsi0 : ata_piix
ata2: SATA port has no device.
scsi1 : ata_piix



# lspci
00:00.0 Host bridge: Intel Corp. 915G/P/GV Processor to I/O Controller 
(rev 04)
00:01.0 PCI bridge: Intel Corp. 915G/P/GV PCI Express Root Port (rev 04)
00:02.0 VGA compatible controller: Intel Corp. 82915G Express Chipset 
Family Graphics Controller (rev 04)
00:1b.0 Class 0403: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) High 
Definition Audio Controller (rev 03)
00:1c.0 PCI bridge: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI 
Express Port 1 (rev 03)
00:1c.1 PCI bridge: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI 
Express Port 2 (rev 03)
00:1c.2 PCI bridge: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI 
Express Port 3 (rev 03)
00:1c.3 PCI bridge: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI 
Express Port 4 (rev 03)
00:1d.0 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
USB UHCI #1 (rev 03)
00:1d.1 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
USB UHCI #2 (rev 03)
00:1d.2 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
USB UHCI #3 (rev 03)
00:1d.3 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
USB UHCI #4 (rev 03)
00:1d.7 USB Controller: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
USB2 EHCI Controller (rev 03)
00:1e.0 PCI bridge: Intel Corp. 82801 PCI Bridge (rev d3)
00:1f.0 ISA bridge: Intel Corp. 82801FB/FR (ICH6/ICH6R) LPC Interface 
Bridge (rev 03)
00:1f.1 IDE interface: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) 
IDE Controller (rev 03)
00:1f.2 IDE interface: Intel Corp. 82801FB/FW (ICH6/ICH6W) SATA 
Controller (rev 03)
00:1f.3 SMBus: Intel Corp. 82801FB/FBM/FR/FW/FRW (ICH6 Family) SMBus 
Controller (rev 03)
06:00.0 I2O: Adaptec (formerly DPT) SmartRAID V Controller (rev 02)
06:00.1 PCI bridge: Adaptec (formerly DPT) PCI Bridge (rev 02)
06:02.0 Ethernet controller: Broadcom Corporation NetXtreme BCM5701 
Gigabit Ethernet (rev 15)
06:08.0 Ethernet controller: Intel Corp. 82562ET/EZ/GT/GZ - PRO/100 VE 
(LOM) Ethernet Controller (rev 01)

 
