Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751105AbWE2CbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751105AbWE2CbK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 May 2006 22:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751117AbWE2CbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 May 2006 22:31:10 -0400
Received: from x8.develooper.com ([216.52.237.208]:3285 "EHLO
	x8.develooper.com") by vger.kernel.org with ESMTP id S1751105AbWE2CbJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 May 2006 22:31:09 -0400
Mime-Version: 1.0 (Apple Message framework v750)
Content-Transfer-Encoding: 7bit
Message-Id: <5D6C23F5-B03E-4C3D-8BC6-A009E51122D8@develooper.com>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
From: =?ISO-8859-1?Q?Ask_Bj=F8rn_Hansen?= <ask@develooper.com>
Subject: sata_mv with Adaptec AIC-8130/Marvell 88SX6041 ("Badness in __msleep")
Date: Sun, 28 May 2006 19:31:06 -0700
X-Mailer: Apple Mail (2.750)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

I have a box with a Adaptec AIC-8130/Marvell 88SX6041 chip  
integrated.  I am using the latest FC5 kernel (~2.6.16.1) with the  
sata_mv 0.5 driver (which is the same as in 2.6.16.18).   The arch is  
x86_64 (dual Opteron something).

I have two disks attached, but the sata_mv driver usually just sees  
one.  If I try and try again it will eventually see both disks.   
Occasionally it doesn't see either.  (By "see" I mean "they end up  
being usable by the system")

I've included a dmesg output below.


  - ask

[....]
ACPI: PCI Interrupt 0000:02:03.1[B] -> GSI 50 (level, low) -> IRQ 19
eth2: Tigon3 [partno(BCM95704A6) rev 2100 PHY(5704)] (PCIX:133MHz:64- 
bit) 10/100/1000BaseT Ethernet 00:30:48:58:fc:c1
eth2: RXcsums[1] LinkChgREG[0] MIirq[0] ASF[0] Split[0] WireSpeed[1]  
TSOcap[1]
eth2: dma_rwctrl[769f4000] dma_mask[64-bit]
libata version 1.20 loaded.
sata_mv 0000:03:03.0: version 0.5
GSI 20 sharing vector 0xC9 and IRQ 20
ACPI: PCI Interrupt 0000:03:03.0[A] -> GSI 42 (level, low) -> IRQ 20
sata_mv 0000:03:03.0: Applying B2 workarounds to unknown rev
sata_mv 0000:03:03.0: 32 slots 4 ports unknown mode IRQ via INTx
ata1: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFC20000122120 bmdma 0x0 irq 20
ata2: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFC20000124120 bmdma 0x0 irq 20
ata3: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFC20000126120 bmdma 0x0 irq 20
ata4: SATA max UDMA/133 cmd 0x0 ctl 0xFFFFC20000128120 bmdma 0x0 irq 20
Badness in __msleep at drivers/scsi/sata_mv.c:1733 (Not tainted)

Call Trace: <IRQ> <ffffffff881d457d>{:sata_mv:__mv_phy_reset+276}
        <ffffffff881d427c>{:sata_mv:mv_channel_reset+137}  
<ffffffff881d5071>{:sata_mv:mv_interrupt+610}
        <ffffffff8015a2e4>{handle_IRQ_event+41} <ffffffff8015a3b1> 
{__do_IRQ+156}
        <ffffffff8010ce01>{do_IRQ+59} <ffffffff8010ad3e>{ret_from_intr 
+0} <EOI>
        <ffffffff80339aee>{thread_return+0} <ffffffff881bb00f> 
{:libata:ata_check_status+15}
        <ffffffff881d4763>{:sata_mv:__mv_phy_reset+762}  
<ffffffff881d4e0f>{:sata_mv:mv_interrupt+0}
        <ffffffff8015a773>{request_irq+139} <ffffffff881beb80> 
{:libata:ata_device_add+835}
        <ffffffff802d0da9>{pci_conf1_read+184} <ffffffff802d0da9> 
{pci_conf1_read+184}
        <ffffffff881d5ced>{:sata_mv:mv_init_one+1531}  
<ffffffff8020c6f8>{pci_device_probe+256}
        <ffffffff8026cf05>{driver_probe_device+82} <ffffffff8026d060> 
{__driver_attach+142}
        <ffffffff8026cfd2>{__driver_attach+0} <ffffffff8026c904> 
{bus_for_each_dev+67}
        <ffffffff8026c573>{bus_add_driver+118} <ffffffff8020c93e> 
{__pci_register_driver+142}
        <ffffffff8015702f>{stop_machine_run+58} <ffffffff8014d17c> 
{sys_init_module+278}
        <ffffffff8010a7ba>{system_call+126}
ata1: dev 0 cfg 49:2f00 82:746b 83:7f61 84:4023 85:7469 86:3c41  
87:4023 88:407f
ata1: dev 0 ATA-7, max UDMA/133, 781422768 sectors: LBA48
ata1: dev 0 configured for UDMA/133
scsi0 : sata_mv
ata2: no device found (phy stat 00000214)
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
sda: sda1 sda2
sd 0:0:0:0: Attached scsi disk sda
PM: Writing back config space on device 0000:02:03.0 at offset 1.  
(Was 2b00000, writing 2b00106)
PM: Writing back config space on device 0000:02:03.0 at offset 2.  
(Was 2000000, writing 2000010)
PM: Writing back config space on device 0000:02:03.0 at offset 3.  
(Was 804000, writing 804010)
PM: Writing back config space on device 0000:02:03.0 at offset b.  
(Was 164814e4, writing 164815d9)
tg3: eth1: Link is up at 100 Mbps, full duplex.
tg3: eth1: Flow control is on for TX and on for RX.
[....]



-- 
http://www.askbjoernhansen.com/

