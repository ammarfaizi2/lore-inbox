Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965001AbVKOTDh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965001AbVKOTDh (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 14:03:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965000AbVKOTDh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 14:03:37 -0500
Received: from relay.uni-heidelberg.de ([129.206.100.212]:7131 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S964993AbVKOTDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 14:03:36 -0500
Date: Tue, 15 Nov 2005 20:03:30 +0100 (CET)
From: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>
To: Jeff Garzik <jgarzik@pobox.com>
cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Marvell SATA fixes v2
In-Reply-To: <4379F31D.4000508@pobox.com>
Message-ID: <Pine.LNX.4.63.0511151956040.3015@dingo.iwr.uni-heidelberg.de>
References: <20051114050404.GA18144@havoc.gtf.org>
 <Pine.LNX.4.63.0511151437320.3015@dingo.iwr.uni-heidelberg.de>
 <4379F31D.4000508@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Nov 2005, Jeff Garzik wrote:

> any chance you could obtain additional debugging output by turning on
> #undef ATA_DEBUG                /* debugging output */
> #undef ATA_VERBOSE_DEBUG        /* yet more debugging output */

With these 2 defined and CONFIG_PCI_MSI turned off (and root FS on an 
IDE disk...), insmod finishes properly, but there is a failed 
assertion and the disk is not found anymore :-(

sata_mv 0000:02:08.0: version 0.25
ACPI: PCI Interrupt 0000:02:08.0[A] -> GSI 26 (level, low) -> IRQ 20
mv_port_init: EDMA cfg=0x0000011f EDMA IRQ err cause/mask=0x00000000/0x00001f7f
mv_port_init: EDMA cfg=0x0000011f EDMA IRQ err cause/mask=0x00000000/0x00001f7f
mv_port_init: EDMA cfg=0x0000011f EDMA IRQ err cause/mask=0x00000000/0x00001f7f
mv_port_init: EDMA cfg=0x0000011f EDMA IRQ err cause/mask=0x00000000/0x00001f7f
mv_init_host: HC0: HC config=0x11dcf013 HC IRQ cause (before clear)=0x00000000
mv_init_host: HC MAIN IRQ cause/mask=0x00000000/0x0007ffff PCI int cause/mask=0x00000000/0x00577fe6
mv_dump_pci_cfg: 00: 504111ab 02b00003 01000003 00002008 
mv_dump_pci_cfg: 10: f5000004 00000000 00000000 00000000 
mv_dump_pci_cfg: 20: 00000000 00000000 00000000 81241043 
mv_dump_pci_cfg: 30: 00000000 00000040 00000000 00000109 
mv_dump_pci_cfg: 40: 000a5001 00000000 00000000 00000000 
mv_dump_pci_cfg: 50: 00806005 00000000 00000000 00000000 
mv_dump_pci_cfg: 60: 00300007 01830240 
sata_mv 0000:02:08.0: 32 slots 4 ports SCSI mode IRQ via INTx
ata_device_add: ENTER
ata_host_add: ENTER
ata5: SATA max UDMA/133 cmd 0x0 ctl 0xF8BA2120 bmdma 0x0 irq 20
ata_host_add: ENTER
ata6: SATA max UDMA/133 cmd 0x0 ctl 0xF8BA4120 bmdma 0x0 irq 20
ata_host_add: ENTER
ata7: SATA max UDMA/133 cmd 0x0 ctl 0xF8BA6120 bmdma 0x0 irq 20
ata_host_add: ENTER
ata8: SATA max UDMA/133 cmd 0x0 ctl 0xF8BA8120 bmdma 0x0 irq 20
ata_device_add: probe begin
ata_device_add: ata5: probe begin
mv_phy_reset: ENTER, port 0, mmio 0xf8ba2000
mv_phy_reset: S-regs after ATA_RST: SStat 0x00000000 SErr 0x00000000 SCtrl 0x00000000
mv_phy_reset: S-regs after PHY wake: SStat 0x00000000 SErr 0x00000000 SCtrl 0x00000000
ata_dev_classify: found ATA device by sig
mv_phy_reset: EXIT
ata_dev_identify: ENTER, host 5, dev 0
ata_dev_select: ENTER, ata5: device 0, wait 1
ATA: abnormal status 0x80 on port 0xF8BA211C
ata_dev_identify: do ATA identify
ata_dev_select: ENTER, ata5: device 0, wait 1
ata_exec_command_mmio: ata5: cmd 0xEC
mv_host_intr: ENTER, hc0 relevant=0x00000002 HC IRQ cause=0x00000100
mv_host_intr: port 0 IRQ found for qc, ata_status 0x58
ata_qc_complete: EXIT
mv_host_intr: EXIT
mv_host_intr: ENTER, hc0 relevant=0x00000002 HC IRQ cause=0x00000100
mv_host_intr: EXIT
ata5: dev 0 cfg 49:0000 82:0000 83:0000 84:0000 85:0000 86:0000 87:0000 88:0000
ata5: no dma
ata5: dev 0 not supported, ignoring
ata_dev_identify: EXIT, err
ata_dev_identify: ENTER/EXIT (host 5, dev 1) -- nodev
Assertion failed! qc != NULL,drivers/scsi/libata-core.c,ata_pio_block,line=3170
Unable to handle kernel NULL pointer dereference at virtual address 00000014
  printing eip:
f886da39
*pde = 3ea2c067
Oops: 0000 [#1]
SMP 
Modules linked in: sata_mv(U) sunrpc dm_mod video button battery ac hfc_usb hisax crc_ccitt isdn slhc uhci_hcd ehci_hcd shpchp i6300esb i2c_i801 i2c_core e1000 ext3 jbd ata_piix libata sd_mod scsi_mod
CPU:    1
EIP:    0060:[<f886da39>]    Not tainted VLI
EFLAGS: 00010292   (2.6.14-1.1665_FC5nomsismp) 
EIP is at ata_pio_block+0x54/0x131 [libata]
eax: 00000056   ebx: 00000058   ecx: 00020000   edx: 00000246
esi: f6fa1314   edi: 00000000   ebp: f6fa1314   esp: f7ecdf3c
ds: 007b   es: 007b   ss: 0068
Process ata/1 (pid: 380, threadinfo=f7ecd000 task=f7ed2030)
Stack: f8871f88 f8872c86 f88728fa f887926a 00000c62 f6fa1314 f6fa18cc f780111c
        f886dbbb 00000212 c0136d06 00000000 f7ecd000 00000000 f7801134 f780113c
        f7801154 f7ecd000 f6fa18c8 f886db8f 00000001 00000000 00000000 00010000 
Call Trace:
  [<f886dbbb>] ata_pio_task+0x2c/0x59 [libata]
  [<c0136d06>] worker_thread+0x184/0x235
  [<f886db8f>] ata_pio_task+0x0/0x59 [libata]
  [<c0122363>] default_wake_function+0x0/0xc
  [<c0136b82>] worker_thread+0x0/0x235
  [<c013acd9>] kthread+0x93/0x97
  [<c013ac46>] kthread+0x0/0x97
  [<c010243d>] kernel_thread_helper+0x5/0xb
Code: 0f 95 c0 84 d0 75 dd 89 cb 84 c9 78 58 31 ff 8b 86 70 05 00 00 85 c0 0f 85 ba 00 00 00 89 f7 81 c7 d4 04 00 00 0f 84 ac 00 00 00 <0f> b6 47 14 2c 05 3c 02 77 1a 80 e3 08 0f 85 8c 00 00 00 c7 86
  <3>ata_device_add: ata5: probe end
scsi4 : sata_mv
ata_device_add: ata6: probe begin
mv_phy_reset: ENTER, port 1, mmio 0xf8ba4000
mv_phy_reset: S-regs after ATA_RST: SStat 0x00000000 SErr 0x00000000 SCtrl 0x00000000
mv_phy_reset: S-regs after PHY wake: SStat 0x00000000 SErr 0x00000000 SCtrl 0x00000000
ata6: no device found (phy stat 00000000)
ata_device_add: ata6: probe end
scsi5 : sata_mv
ata_device_add: ata7: probe begin
mv_phy_reset: ENTER, port 2, mmio 0xf8ba6000
mv_phy_reset: S-regs after ATA_RST: SStat 0x00000000 SErr 0x00000000 SCtrl 0x00000000
mv_phy_reset: S-regs after PHY wake: SStat 0x00000000 SErr 0x00000000 SCtrl 0x00000000
ata7: no device found (phy stat 00000000)
ata_device_add: ata7: probe end
scsi6 : sata_mv
ata_device_add: ata8: probe begin
mv_phy_reset: ENTER, port 3, mmio 0xf8ba8000
mv_phy_reset: S-regs after ATA_RST: SStat 0x00000000 SErr 0x00000000 SCtrl 0x00000000
mv_phy_reset: S-regs after PHY wake: SStat 0x00000000 SErr 0x00000000 SCtrl 0x00000000
ata8: no device found (phy stat 00000000)
ata_device_add: ata8: probe end
scsi7 : sata_mv
ata_device_add: probe begin
ata_device_add: EXIT, returning 4

-- 
Bogdan Costescu

IWR - Interdisziplinaeres Zentrum fuer Wissenschaftliches Rechnen
Universitaet Heidelberg, INF 368, D-69120 Heidelberg, GERMANY
Telephone: +49 6221 54 8869, Telefax: +49 6221 54 8868
E-mail: Bogdan.Costescu@IWR.Uni-Heidelberg.De
