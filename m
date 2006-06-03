Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932567AbWFCBmE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932567AbWFCBmE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jun 2006 21:42:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932574AbWFCBmE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jun 2006 21:42:04 -0400
Received: from x8.develooper.com ([216.52.237.208]:39900 "EHLO
	x8.develooper.com") by vger.kernel.org with ESMTP id S932567AbWFCBmD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jun 2006 21:42:03 -0400
In-Reply-To: <447A614B.3050603@rtr.ca>
References: <5D6C23F5-B03E-4C3D-8BC6-A009E51122D8@develooper.com> <447A614B.3050603@rtr.ca>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <EA69B14D-2874-48EA-BF67-0A96DE690FA6@develooper.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: =?ISO-8859-1?Q?Ask_Bj=F8rn_Hansen?= <ask@develooper.com>
Subject: Re: sata_mv with Adaptec AIC-8130/Marvell 88SX6041 ("Badness in __msleep")
Date: Fri, 2 Jun 2006 18:42:08 -0700
To: Mark Lord <liml@rtr.ca>
X-Mailer: Apple Mail (2.750)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On May 28, 2006, at 19:49, Mark Lord wrote:

> The attached patch [0.7-backport] is an untested backport of the  
> latest sata_mv,
> which should be more reliable than what you've been using. [0.5]

It works most of the time (where the 0.5 didn't work most of the  
time), but I still see the "Badness in __msleep" occasionally (and it  
only detects one of the disks then).    However, the Adaptec BIOS is  
only seeing one of the disks sometimes, so maybe there's something  
wrong with the hardware.  The BIOS did detect both drives in the boot  
that gave the output below though.

  - ask

libata version 1.20 loaded.
sata_mv 0000:03:03.0: version 0.7-backport
GSI 16 sharing vector 0xA9 and IRQ 16
ACPI: PCI Interrupt 0000:03:03.0[A] -> GSI 42 (level, low) -> IRQ 16
sata_mv 0000:03:03.0: Applying B2 workarounds to unknown rev
sata_mv 0000:03:03.0: 32 slots 4 ports unknown mode IRQ via INTx
ata1: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFC200000A2120 bmdma 0x0 irq 16
ata2: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFC200000A4120 bmdma 0x0 irq 16
ata3: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFC200000A6120 bmdma 0x0 irq 16
ata4: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFC200000A8120 bmdma 0x0 irq 16
Badness in __msleep at drivers/scsi/sata_mv.c:1922 (Not tainted)

Call Trace: <IRQ> <ffffffff8805769a>{:sata_mv:__mv_phy_reset+276}
        <ffffffff8805724d>{:sata_mv:mv_channel_reset+143}  
<ffffffff88058e9d>{:sata_mv:mv_interrupt+570}
        <ffffffff8015a0cc>{handle_IRQ_event+41} <ffffffff8015a199> 
{__do_IRQ+156}
        <ffffffff8010ce01>{do_IRQ+59} <ffffffff8010ad3e>{ret_from_intr 
+0} <EOI>
        <ffffffff80338ac3>{thread_return+0} <ffffffff8803e00f> 
{:libata:ata_check_status+15}
        <ffffffff88057880>{:sata_mv:__mv_phy_reset+762}  
<ffffffff88058c63>{:sata_mv:mv_interrupt+0}
        <ffffffff8015a55b>{request_irq+139} <ffffffff8804188b> 
{:libata:ata_device_add+835}
        <ffffffff802d068d>{pci_conf1_read+184} <ffffffff802d068d> 
{pci_conf1_read+184}
        <ffffffff88058c01>{:sata_mv:mv_init_one+1637}  
<ffffffff8020c250>{pci_device_probe+256}
        <ffffffff8026c979>{driver_probe_device+82} <ffffffff8026cad4> 
{__driver_attach+142}
        <ffffffff8026ca46>{__driver_attach+0} <ffffffff8026c378> 
{bus_for_each_dev+67}
        <ffffffff8026bfe7>{bus_add_driver+118} <ffffffff8020c496> 
{__pci_register_driver+142}
        <ffffffff80156e37>{stop_machine_run+58} <ffffffff8014d0c4> 
{sys_init_module+278}
        <ffffffff8010a7ba>{system_call+126}
ata1: dev 0 cfg 49:2f00 82:746b 83:7f61 84:4023 85:7469 86:3c41  
87:4023 88:407f
ata1: dev 0 ATA-7, max UDMA/133, 781422768 sectors: LBA48
ata1: dev 0 configured for UDMA/133
scsi0 : sata_mv
input: ImPS/2 Generic Wheel Mouse as /class/input/input1
ata2: no device found (phy stat 00000000)
scsi1 : sata_mv
ata3: no device found (phy stat 00000000)
scsi2 : sata_mv
ata4: no device found (phy stat 00000000)
scsi3 : sata_mv
   Vendor: ATA       Model: WDC WD4000YR-01P  Rev: 01.0
   Type:   Direct-Access                      ANSI SCSI revision: 05
SCSI device sda: 781422768 512-byte hdwr sectors (400088 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
SCSI device sda: 781422768 512-byte hdwr sectors (400088 MB)
sda: Write Protect is off
sda: Mode Sense: 00 3a 00 00
SCSI device sda: drive cache: write back
sda: sda1 sda2 sda3 < sda5 >
sd 0:0:0:0: Attached scsi disk sda
md: raid1 personality registered for level 1
device-mapper: 4.5.0-ioctl (2005-10-04) initialised: dm-devel@redhat.com
md: Autodetecting RAID arrays.



-- 
http://www.askbjoernhansen.com/


