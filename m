Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267042AbSKSEs5>; Mon, 18 Nov 2002 23:48:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267044AbSKSEs5>; Mon, 18 Nov 2002 23:48:57 -0500
Received: from CPE3236333432363339.cpe.net.cable.rogers.com ([24.114.185.204]:24324
	"HELO coredump.sh0n.net") by vger.kernel.org with SMTP
	id <S267042AbSKSEsz>; Mon, 18 Nov 2002 23:48:55 -0500
From: Shawn Starr <spstarr@sh0n.net>
Organization: sh0n.net
To: linux-kernel@vger.kernel.org
Subject: [ERROR]: 2.5.48 SCSI Host - No Error Handling (ide-scsi)?
Date: Mon, 18 Nov 2002 23:55:55 -0500
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200211182355.55902.spstarr@sh0n.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Machine:

A7M266-D Athlon MP 2000+ 512MB DDR Registered:

lspci:

0:00.0 Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] System Controller (rev 11)
00:01.0 PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] AGP Bridge
00:07.0 ISA bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ISA (rev 04)
00:07.1 IDE interface: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE (rev 04)
00:07.3 Bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI (rev 03)
00:10.0 PCI bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] PCI (rev 04)
.. cut for only important info ...

hdc: YAMAHA CRW2100E, ATAPI CD/DVD-ROM drive
DEV: registering device: ID = 'ide1', name = IDE Controller
kobject ide1: registering
  parent is 00:07.1
hdd: DVD-ROM DDU1621, ATAPI CD/DVD-ROM drive
ide1 at 0x170-0x177,0x376 on irq 15
DEV: registering device: ID = '1.0', name = IDE Drive
kobject 1.0: registering
  parent is ide1
bus ide: add device 1.0
DEV: registering device: ID = '1.1', name = IDE Drive
kobject 1.1: registering
  parent is ide1
bus ide: add device 1.1
driver pci:AMD IDE: registering
kobject AMD IDE: registering
bus pci: add driver AMD IDE
bound device '00:07.1' to driver 'AMD IDE'
driver pci:PCI IDE: registering
kobject PCI IDE: registering
bus pci: add driver PCI IDE

end_request: I/O error, dev hdc, sector 0
hdc: ATAPI 40X CD-ROM CD-R/RW drive, 8192kB Cache, UDMA(25)
Uniform CD-ROM driver Revision: 3.12
end_request: I/O error, dev hdc, sector 0
end_request: I/O error, dev hdd, sector 0
hdd: ATAPI 40X DVD-ROM drive, 512kB Cache, UDMA(33)
end_request: I/O error, dev hdd, sector 0
SCSI subsystem driver Revision: 1.00
ERROR: SCSI host `ide-scsi' has no error handling
ERROR: This is not a safe way to run your SCSI host
ERROR: The error handling must be added to this driver
Call Trace: [<c02480d3>]  [<c01fa375>]  [<c024f702>]  [<c0248113>]  
[<c010507a>]  [<c0105040>]  [<c0107129>]
scsi0 : SCSI host adapter emulation for IDE ATAPI devices

>From syslog (symbol information provided):
Call Trace: [scsi_register+739/752]  [put_driver+37/144]  [idescsi_detect+34/128]  
[scsi_register_host+51/208]  [init+58/352]  [init+0/352]  [kernel_thread_helper+5/12]


I'm using IDE-SCSI emulation for the CRW2100E. I assume this is normal behaviour if the ide-scsi driver 
has no error handling ;-)

>From Linus Changelog 2.5.48:

James Bottomley <jejb@mulgrave.(none)>:
  o add request prep functions to SCSI
  o warn (and don't attach) if no error handling

Shawn.


