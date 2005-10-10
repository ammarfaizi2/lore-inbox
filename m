Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751119AbVJJTL7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751119AbVJJTL7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Oct 2005 15:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbVJJTL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Oct 2005 15:11:59 -0400
Received: from pimout6-ext.prodigy.net ([207.115.63.78]:18888 "EHLO
	pimout6-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S1751119AbVJJTL5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Oct 2005 15:11:57 -0400
X-ORBL: [69.225.172.73]
Subject: Re: [PATCH 2.6.14-rc2 1/2] libata: Marvell spinlock fixes and
	simplification
From: Michael Madore <Michael.Madore@aslab.com>
To: Brett Russ <russb@emc.com>
Cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org, Pasi Pirhonen <upi@papat.org>,
       Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>,
       "Mr. Berkley Shands" <bshands@exegy.com>,
       Jim Edwards <jim@networkdesigning.com>,
       scott olson <scotto701@yahoo.com>,
       Lars Magne Ingebrigtsen <larsi@gnus.org>,
       Evgeny Rodichev <er@sai.msu.su>
In-Reply-To: <43451008.2090305@emc.com>
References: <20051005210610.EC31826369@lns1058.lss.emc.com>
	 <20051005210842.F366B26369@lns1058.lss.emc.com>
	 <1128551744.4041.7.camel@drevil.aslab.com>  <43451008.2090305@emc.com>
Content-Type: text/plain
Date: Mon, 10 Oct 2005 12:10:23 -0700
Message-Id: <1128971423.13572.27.camel@drevil.aslab.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-6) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Brett,

On Thu, 2005-10-06 at 07:52 -0400, Brett Russ wrote:
> Michael Madore wrote:
> > I assume this patch doesn't address the 'abnormal status 0x80' issue on
> > the 6081.
> 
> Correct assumption.  This message seems benign as I've seen it and am 
> working fine despite it.  I'll take a look soon.
> 
> Is the driver working for you on the 6081?

No.  The driver loads, but the disk is not accessible.

> > On the 5081, I still get two machine checks followed by a
> > hard lockup when I load the driver.
> 
> Would you turn on ATA_DEBUG and ATA_VERBOSE_DEBUG in 
> include/linux/libata.h and send along the console output when loading 
> the driver?

Output below, this time with a single Maxtor Maxline Plus II.  I have
included the debug output from both the 5081 and 6081.  In the case of
the 6081, modprobe never returns.

Mike

5081:

SCSI subsystem initialized
mv_port_init: EDMA cfg=0x0000011f EDMA IRQ err
cause/mask=0x00000000/0x00001f7f
mv_port_init: EDMA cfg=0x0000011f EDMA IRQ err
cause/mask=0x00000000/0x00001f7f
mv_port_init: EDMA cfg=0x0000011f EDMA IRQ err
cause/mask=0x00000000/0x00001f7f
mv_port_init: EDMA cfg=0x0000011f EDMA IRQ err
cause/mask=0x00000000/0x00001f7f
mv_port_init: EDMA cfg=0x0000011f EDMA IRQ err
cause/mask=0x00000000/0x00001f7f
mv_port_init: EDMA cfg=0x0000011f EDMA IRQ err
cause/mask=0x00000000/0x00001f7f
mv_port_init: EDMA cfg=0x0000011f EDMA IRQ err
cause/mask=0x00000000/0x00001f7f
mv_port_init: EDMA cfg=0x0000011f EDMA IRQ err
cause/mask=0x00000000/0x00001f7f
mv_host_init: HC0: HC config=0x417feb15 HC IRQ cause (before
clear)=0x00000111
mv_host_init: HC1: HC config=0x00000001 HC IRQ cause (before
clear)=0x00000000
mv_host_init: HC MAIN IRQ cause/mask=0x00000000/0x0007ffff PCI int
cause/mask=0x00000000/0x00577fe6
mv_dump_pci_cfg: 00: 508111ab 02b00317 01040000 00004008
mv_dump_pci_cfg: 10: fc300004 00000000 00000000 00000000
mv_dump_pci_cfg: 20: 00000000 00000000 00000000 508115d9
mv_dump_pci_cfg: 30: 00000000 00000040 00000000 0000010b
mv_dump_pci_cfg: 40: 000a5001 00000000 00000000 00000000
mv_dump_pci_cfg: 50: 00816005 fee01004 00000000 000040e1
mv_dump_pci_cfg: 60: 00300007 01830310
ata_device_add: ENTER
ata_host_add: ENTER
ata_host_add: ENTER
ata_host_add: ENTER
ata_host_add: ENTER
ata_host_add: ENTER
ata_host_add: ENTER
ata_host_add: ENTER
ata_host_add: ENTER
ata_device_add: probe begin
ata_device_add: ata1: probe begin
mv_phy_reset: ENTER, port 0, mmio 0xf8b22000
CPU 2: Machine Check Exception: 0000000000000004
CPU 3: Machine Check Exception: 0000000000000004

6081:

Oct 10 11:36:33 asl48 kernel: SCSI subsystem initialized
Oct 10 11:36:33 asl48 kernel: sata_mv version 0.24
Oct 10 11:36:33 asl48 kernel: ACPI: PCI Interrupt 0000:03:03.0[A] -> GSI
28 (level, low) -> IRQ 209
Oct 10 11:36:33 asl48 kernel: mv_port_init: EDMA cfg=0x0000291f EDMA IRQ
err cause/mask=0x00000000/0xffffffff
Oct 10 11:36:33 asl48 last message repeated 7 times
Oct 10 11:36:33 asl48 kernel: mv_host_init: HC0: HC config=0x000100ff HC
IRQ cause (before clear)=0x00000000
Oct 10 11:36:33 asl48 kernel: mv_host_init: HC1: HC config=0x000100ff HC
IRQ cause (before clear)=0x00000000
Oct 10 11:36:33 asl48 kernel: mv_host_init: HC MAIN IRQ
cause/mask=0x00000000/0x0087ffff PCI int
cause/mask=0x00000000/0x00557fee
Oct 10 11:36:33 asl48 kernel: mv_dump_pci_cfg: 00: 608111ab 02b00317
01000009 00004008
Oct 10 11:36:33 asl48 kernel: mv_dump_pci_cfg: 10: fc300004 00000000
00004001 00000004
Oct 10 11:36:33 asl48 kernel: mv_dump_pci_cfg: 20: 00000000 00000000
00000000 11ab11ab
Oct 10 11:36:33 asl48 kernel: mv_dump_pci_cfg: 30: 00000000 00000040
00000000 0000010b
Oct 10 11:36:33 asl48 kernel: mv_dump_pci_cfg: 40: 00025001 00000000
00000000 00000000
Oct 10 11:36:33 asl48 kernel: mv_dump_pci_cfg: 50: 00816005 fee01004
00000000 000040e1
Oct 10 11:36:33 asl48 kernel: mv_dump_pci_cfg: 60: 00300007 01830318
Oct 10 11:36:33 asl48 kernel: sata_mv(0000:03:03.0) 32 slots 8 ports
SCSI mode IRQ via MSI
Oct 10 11:36:33 asl48 kernel: ata_device_add: ENTER
Oct 10 11:36:33 asl48 kernel: ata_host_add: ENTER
Oct 10 11:36:33 asl48 kernel: ata1: SATA max UDMA/133 cmd 0x0 ctl
0xF8B22120 bmdma 0x0 irq 209
Oct 10 11:36:33 asl48 kernel: ata_host_add: ENTER
Oct 10 11:36:33 asl48 kernel: ata2: SATA max UDMA/133 cmd 0x0 ctl
0xF8B24120 bmdma 0x0 irq 209
Oct 10 11:36:33 asl48 kernel: ata_host_add: ENTER
Oct 10 11:36:33 asl48 kernel: ata3: SATA max UDMA/133 cmd 0x0 ctl
0xF8B26120 bmdma 0x0 irq 209
Oct 10 11:36:33 asl48 kernel: ata_host_add: ENTER
Oct 10 11:36:33 asl48 kernel: ata4: SATA max UDMA/133 cmd 0x0 ctl
0xF8B28120 bmdma 0x0 irq 209
Oct 10 11:36:33 asl48 kernel: ata_host_add: ENTER
Oct 10 11:36:33 asl48 kernel: ata5: SATA max UDMA/133 cmd 0x0 ctl
0xF8B32120 bmdma 0x0 irq 209
Oct 10 11:36:33 asl48 kernel: ata_host_add: ENTER
Oct 10 11:36:33 asl48 kernel: ata6: SATA max UDMA/133 cmd 0x0 ctl
0xF8B34120 bmdma 0x0 irq 209
Oct 10 11:36:33 asl48 kernel: ata_host_add: ENTER
Oct 10 11:36:33 asl48 kernel: ata7: SATA max UDMA/133 cmd 0x0 ctl
0xF8B36120 bmdma 0x0 irq 209
Oct 10 11:36:33 asl48 kernel: ata_host_add: ENTER
Oct 10 11:36:33 asl48 kernel: ata8: SATA max UDMA/133 cmd 0x0 ctl
0xF8B38120 bmdma 0x0 irq 209
Oct 10 11:36:33 asl48 kernel: ata_device_add: probe begin
Oct 10 11:36:33 asl48 kernel: ata_device_add: ata1: probe begin
Oct 10 11:36:33 asl48 kernel: mv_phy_reset: ENTER, port 0, mmio
0xf8b22000
Oct 10 11:36:33 asl48 kernel: mv_phy_reset: S-regs after ATA_RST: SStat
0x00000004 SErr 0x00000000 SCtrl 0x00000004
Oct 10 11:36:33 asl48 kernel: mv_phy_reset: S-regs after PHY wake: SStat
0x00000000 SErr 0x00000000 SCtrl 0x00000300
Oct 10 11:36:33 asl48 kernel: ata1: no device found (phy stat 00000000)
Oct 10 11:36:33 asl48 kernel: ata_device_add: ata1: probe end
Oct 10 11:36:33 asl48 kernel: scsi0 : sata_mv
Oct 10 11:36:33 asl48 kernel: ata_device_add: ata2: probe begin
Oct 10 11:36:33 asl48 kernel: mv_phy_reset: ENTER, port 1, mmio
0xf8b24000
Oct 10 11:36:33 asl48 kernel: mv_phy_reset: S-regs after ATA_RST: SStat
0x00000004 SErr 0x00000000 SCtrl 0x00000004
Oct 10 11:36:33 asl48 kernel: mv_phy_reset: S-regs after PHY wake: SStat
0x00000000 SErr 0x00000000 SCtrl 0x00000300
Oct 10 11:36:33 asl48 kernel: ata2: no device found (phy stat 00000000)
Oct 10 11:36:33 asl48 kernel: ata_device_add: ata2: probe end
Oct 10 11:36:33 asl48 kernel: scsi1 : sata_mv
Oct 10 11:36:33 asl48 kernel: ata_device_add: ata3: probe begin
Oct 10 11:36:33 asl48 kernel: mv_phy_reset: ENTER, port 2, mmio
0xf8b26000
Oct 10 11:36:33 asl48 kernel: mv_phy_reset: S-regs after ATA_RST: SStat
0x00000004 SErr 0x00000000 SCtrl 0x00000004
Oct 10 11:36:33 asl48 kernel: mv_phy_reset: S-regs after PHY wake: SStat
0x00000000 SErr 0x00000000 SCtrl 0x00000300
Oct 10 11:36:33 asl48 kernel: ata3: no device found (phy stat 00000000)
Oct 10 11:36:33 asl48 kernel: ata_device_add: ata3: probe end
Oct 10 11:36:33 asl48 kernel: scsi2 : sata_mv
Oct 10 11:36:33 asl48 kernel: ata_device_add: ata4: probe begin
Oct 10 11:36:33 asl48 kernel: mv_phy_reset: ENTER, port 3, mmio
0xf8b28000
Oct 10 11:36:33 asl48 kernel: mv_phy_reset: S-regs after ATA_RST: SStat
0x00000004 SErr 0x00000000 SCtrl 0x00000004
Oct 10 11:36:33 asl48 kernel: mv_phy_reset: S-regs after PHY wake: SStat
0x00000000 SErr 0x00000000 SCtrl 0x00000300
Oct 10 11:36:33 asl48 kernel: ata4: no device found (phy stat 00000000)
Oct 10 11:36:33 asl48 kernel: ata_device_add: ata4: probe end
Oct 10 11:36:33 asl48 kernel: scsi3 : sata_mv
Oct 10 11:36:33 asl48 kernel: ata_device_add: ata5: probe begin
Oct 10 11:36:33 asl48 kernel: mv_phy_reset: ENTER, port 4, mmio
0xf8b32000
Oct 10 11:36:33 asl48 kernel: mv_phy_reset: S-regs after ATA_RST: SStat
0x00000004 SErr 0x00000000 SCtrl 0x00000004
Oct 10 11:36:33 asl48 kernel: mv_phy_reset: S-regs after PHY wake: SStat
0x00000000 SErr 0x00000000 SCtrl 0x00000300
Oct 10 11:36:33 asl48 kernel: ata5: no device found (phy stat 00000000)
Oct 10 11:36:33 asl48 kernel: ata_device_add: ata5: probe end
Oct 10 11:36:33 asl48 kernel: scsi4 : sata_mv
Oct 10 11:36:33 asl48 kernel: ata_device_add: ata6: probe begin
Oct 10 11:36:33 asl48 kernel: mv_phy_reset: ENTER, port 5, mmio
0xf8b34000
Oct 10 11:36:33 asl48 kernel: mv_phy_reset: S-regs after ATA_RST: SStat
0x00000004 SErr 0x00000000 SCtrl 0x00000004
Oct 10 11:36:33 asl48 kernel: mv_phy_reset: S-regs after PHY wake: SStat
0x00000113 SErr 0x04010000 SCtrl 0x00000300
Oct 10 11:36:33 asl48 kernel: ata_dev_classify: found ATA device by sig
Oct 10 11:36:33 asl48 kernel: mv_phy_reset: EXIT
Oct 10 11:36:33 asl48 kernel: ata_dev_identify: ENTER, host 6, dev 0
Oct 10 11:36:33 asl48 kernel: ata_dev_select: ENTER, ata6: device 0,
wait 1
Oct 10 11:36:33 asl48 kernel: ata_dev_identify: do ATA identify
Oct 10 11:36:33 asl48 kernel: ata_dev_select: ENTER, ata6: device 0,
wait 1
Oct 10 11:36:33 asl48 kernel: ata_exec_command_mmio: ata6: cmd 0xEC
Oct 10 11:36:33 asl48 kernel: ata_pio_sector: data read
Oct 10 11:36:33 asl48 kernel: ata_qc_complete: EXIT
Oct 10 11:36:33 asl48 kernel: ata_dump_id: 49==0x2f00  53==0x0007
63==0x0407  64==0x0003  75==0x0000
Oct 10 11:36:33 asl48 kernel: ata_dump_id: 80==0x00fe  81==0x001e
82==0x7c6b  83==0x7f09  84==0x4003
Oct 10 11:36:33 asl48 kernel: ata_dump_id: 88==0x007f  93==0x0000
Oct 10 11:36:33 asl48 kernel: ata6: dev 0 ATA, max UDMA/133, 490234752
sectors: lba48
Oct 10 11:36:33 asl48 kernel: ata_dev_identify: EXIT, drv_stat = 0x50
Oct 10 11:36:33 asl48 kernel: ata_dev_identify: ENTER/EXIT (host 6, dev
1) -- nodev
Oct 10 11:36:33 asl48 kernel: ata_host_set_pio: base 0x8 xfer_mode 0xc
mask 0x1f x 4
Oct 10 11:36:33 asl48 kernel: ata_dev_set_xfermode: set features - xfer
mode
Oct 10 11:36:33 asl48 kernel: ata_dev_select: ENTER, ata6: device 0,
wait 1
Oct 10 11:36:33 asl48 kernel: ata_tf_load_mmio: hob: feat 0x0 nsect 0x0,
lba 0x0 0x0 0x0
Oct 10 11:36:33 asl48 kernel: ata_tf_load_mmio: feat 0x3 nsect 0x46 lba
0x0 0x0 0x0
Oct 10 11:36:33 asl48 kernel: ata_tf_load_mmio: device 0xA0
Oct 10 11:36:33 asl48 kernel: ata_exec_command_mmio: ata6: cmd 0xEF


