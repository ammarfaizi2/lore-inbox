Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266117AbUHOFwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266117AbUHOFwX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 01:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266498AbUHOFwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 01:52:23 -0400
Received: from dsl093-032-179.snd1.dsl.speakeasy.net ([66.93.32.179]:7402 "EHLO
	partlyharmless.local") by vger.kernel.org with ESMTP
	id S266117AbUHOFwR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 01:52:17 -0400
Message-ID: <411EFA0E.4040100@physics.ucsd.edu>
Date: Sat, 14 Aug 2004 22:52:14 -0700
From: Terrence Martin <tmartin@physics.ucsd.edu>
User-Agent: Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Boot SATA Error with Via (VT6420) Controller
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I am seem to be having a problem where the sata_via module is getting 
unloaded on boot after it is detected.

Basically the disk is detected, sda is assigned to it, then a error is 
thrown. It may be as the result of kudzu doing something. If I knew what 
it was I would try to stop it. :)

Once the system boots an fdisk /dev/sda fails to find a devices. This is 
because the modules is not loaded at this point.

The thing is if I reload the module after boot I can fdisk, mkfs and 
mount the disk.

I am running Fedora core 2 with the latest fedora kernel. The 
motherboard is a Chaintech Summit SKT600. It is advertised as having 
SATA with no RAID, although lspci says it has the 6420 controller. 
Perhaps raid is just turned off. I actually was looking for the nonRAID 
sata as I prefer the Linux raid.

Below are all the particulars. The lspci output, the initial boot 
messages for the device and the messages I get when I load the module 
from the command line. Any suggestions on how I could get the module to 
stick on boot would be greatly appreciated.

Thank you,

Terrence

uname -a

Linux multi 2.6.7-1.494.2.2 #1 Tue Aug 3 09:39:58 EDT 2004 i686 athlon 
i386 GNU/Linux

Here is what lspci says about the devices

00:0f.0 IDE interface: VIA Technologies, Inc. VIA VT6420 SATA RAID 
Controller (rev 80)
00:0f.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)

Here is the boot message

Aug 15 09:59:35 multi kernel: SCSI subsystem initialized
Aug 15 09:59:35 multi kernel: libata version 1.02 loaded.
Aug 15 09:59:35 multi kernel: sata_via version 0.20
Aug 15 09:59:35 multi kernel: ACPI: PCI interrupt 0000:00:0f.0[B] -> GSI 
11 (level, low) -> IRQ 11
Aug 15 09:59:35 multi kernel: sata_via(0000:00:0f.0): routed to hard irq 
line 11
Aug 15 09:59:35 multi kernel: ata1: SATA max UDMA/133 cmd 0xE200 ctl 
0xE302 bmdma 0xE600 irq 11
Aug 15 09:59:36 multi kernel: ata2: SATA max UDMA/133 cmd 0xE400 ctl 
0xE502 bmdma 0xE608 irq 11
Aug 15 09:59:36 multi kernel: ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 
84:4003 85:3468 86:3c01 87:4003 88:407f
Aug 15 09:59:36 multi kernel: ata1: dev 0 ATA, max UDMA/133, 390721968 
sectors: lba48
Aug 15 09:59:36 multi kernel: ata1: dev 0 configured for UDMA/133
Aug 15 09:59:36 multi kernel: scsi0 : sata_via
Aug 15 09:59:36 multi kernel: ata2: no device found (phy stat 00000000)
Aug 15 09:59:36 multi kernel: scsi1 : sata_via
Aug 15 09:59:36 multi kernel:   Vendor: ATA       Model: 
ST3200822AS       Rev: 3.01
Aug 15 09:59:36 multi kernel:   Type:   
Direct-Access                      ANSI SCSI revision: 05
Aug 15 09:59:36 multi kernel: SCSI device sda: 390721968 512-byte hdwr 
sectors (200050 MB)
Aug 15 09:59:36 multi kernel: SCSI device sda: drive cache: write back
Aug 15 09:59:36 multi kernel:  sda: unknown partition table
Aug 15 09:59:36 multi kernel: Attached scsi disk sda at scsi0, channel 
0, id 0, lun 0
Aug 15 09:59:36 multi kernel: Attached scsi generic sg0 at scsi0, 
channel 0, id 0, lun 0,  type 0
Aug 15 09:59:36 multi kernel: kudzu: Using deprecated /dev/sg mechanism 
instead of SG_IO on the actual device
Aug 15 09:59:36 multi kernel: Synchronizing SCSI cache for disk sda: 
<4>FAILED
Aug 15 09:59:36 multi kernel:   status = 0, message = 00, host = 1, 
driver = 00
Aug 15 09:59:36 multi kernel:  



Here is the command line module load...

Aug 14 22:00:12 multi kernel: libata version 1.02 loaded.
Aug 14 22:00:12 multi kernel: sata_via version 0.20
Aug 14 22:00:12 multi kernel: ACPI: PCI interrupt 0000:00:0f.0[B] -> GSI 
11 (level, low) -> IRQ 11
Aug 14 22:00:12 multi kernel: sata_via(0000:00:0f.0): routed to hard irq 
line 11
Aug 14 22:00:12 multi kernel: ata1: SATA max UDMA/133 cmd 0xE200 ctl 
0xE302 bmdma 0xE600 irq 11
Aug 14 22:00:12 multi kernel: ata2: SATA max UDMA/133 cmd 0xE400 ctl 
0xE502 bmdma 0xE608 irq 11
Aug 14 22:00:13 multi kernel: ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 
84:4003 85:3468 86:3c01 87:4003 88:407f
Aug 14 22:00:13 multi kernel: ata1: dev 0 ATA, max UDMA/133, 390721968 
sectors: lba48
Aug 14 22:00:13 multi kernel: ata1: dev 0 configured for UDMA/133
Aug 14 22:00:13 multi kernel: scsi2 : sata_via
Aug 14 22:00:13 multi kernel: ata2: no device found (phy stat 00000000)
Aug 14 22:00:13 multi kernel: scsi3 : sata_via
Aug 14 22:00:13 multi kernel:   Vendor: ATA       Model: 
ST3200822AS       Rev: 3.01
Aug 14 22:00:13 multi kernel:   Type:   
Direct-Access                      ANSI SCSI revision: 05
Aug 14 22:00:13 multi kernel: SCSI device sda: 390721968 512-byte hdwr 
sectors (200050 MB)
Aug 14 22:00:13 multi kernel: SCSI device sda: drive cache: write back
Aug 14 22:00:13 multi kernel:  sda: unknown partition table
Aug 14 22:00:13 multi kernel: Attached scsi disk sda at scsi2, channel 
0, id 0, lun 0
Aug 14 22:00:13 multi kernel: Attached scsi generic sg0 at scsi2, 
channel 0, id 0, lun 0,  type 0
Aug 14 22:01:00 multi kernel: SCSI device sda: 390721968 512-byte hdwr 
sectors (200050 MB)
Aug 14 22:01:00 multi kernel: SCSI device sda: drive cache: write back
Aug 14 22:01:00 multi kernel:  sda: sda1
Aug 14 22:01:02 multi kernel: SCSI device sda: 390721968 512-byte hdwr 
sectors (200050 MB)
Aug 14 22:01:02 multi kernel: SCSI device sda: drive cache: write back
Aug 14 22:01:02 multi kernel:  sda: sda1
Aug 14 22:11:24 multi kernel: XFS mounting filesystem sda1
Aug 14 22:11:24 multi kernel: Ending clean XFS mount for filesystem: sda1
Aug 14 22:16:47 multi kernel: spurious 8259A interrupt: IRQ7.

