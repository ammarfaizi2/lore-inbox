Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261226AbULWTPs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbULWTPs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 14:15:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261239AbULWTPs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 14:15:48 -0500
Received: from proxy.netplan.co.za ([196.25.213.66]:58377 "EHLO
	mail.netgroup.co.za") by vger.kernel.org with ESMTP id S261226AbULWTPb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 14:15:31 -0500
Message-ID: <41CB1BE3.465BD490@netgroup.co.za>
Date: Thu, 23 Dec 2004 21:26:27 +0200
From: Jaco van der Schyff <jvds@netgroup.co.za>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.25 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: DMA problems with 3+ Promise IDE controllers
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am curios if DMA bursting on the Promise cards are enabled by default
on 
2.6.x kernels.
                    
CONFIG_PDC202XX_BURST exists for the old PDC driver, but there seems
to be no similar option for the PDC202XX_NEW driver.
                    
The problem I have is that I start to experience DMA errors as soon
as I plug in a third Promise PDC20268 Ultra 100/TX2 card into one
of my boxes.  The system runs fine with only two cards, but as soon
as the third card is connected and drives attached to it, the following 
errors are generated:
                    
kernel: hde: max request size: 1024KiB
kernel: hde: 390721968 sectors (200049 MB) w/8192KiB Cache,
CHS=24321/255/63, UD
MA(100)
kernel:  hde:hde: dma_intr: status=0x51 { DriveReady SeekComplete Error
}
kernel: hdg: max request size: 1024KiB
kernel: hdg: 390721968 sectors (200049 MB) w/8192KiB Cache,
CHS=24321/255/63, UD
MA(100)
kernel:  hdg:hdg: dma_intr: status=0x51 { DriveReady SeekComplete Error
}
                    
and

kernel: hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
kernel: ide: failed opcode was: unknown
kernel: hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
kernel: hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
kernel: ide: failed opcode was: unknown
kernel: hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
kernel: hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
kernel: ide: failed opcode was: unknown
kernel: hde: dma_intr: status=0x51 { DriveReady SeekComplete Error }
kernel: hde: dma_intr: error=0x84 { DriveStatusError BadCRC }
kernel: ide: failed opcode was: unknown
kernel: PDC202XX: Primary channel reset.
kernel: ide2: reset: success
kernel:  hde1 hde2
kernel: hdg: dma_intr: error=0x84 { DriveStatusError BadCRC }
kernel: ide: failed opcode was: unknown
kernel: hdg: dma_intr: status=0x51 { DriveReady SeekComplete Error }
kernel: hdg: dma_intr: error=0x84 { DriveStatusError BadCRC }
kernel: ide: failed opcode was: unknown
kernel: hdg: dma_intr: status=0x51 { DriveReady SeekComplete Error }
kernel: hdg: dma_intr: error=0x84 { DriveStatusError BadCRC }
kernel: ide: failed opcode was: unknown
kernel: hdg: dma_intr: status=0x51 { DriveReady SeekComplete Error }
kernel: hdg: dma_intr: error=0x84 { DriveStatusError BadCRC }
kernel: ide: failed opcode was: unknown
kernel: PDC202XX: Secondary channel reset.
kernel: ide3: reset: success
kernel:  hdg1 hdg2

These errors are causing havok in my RAID5 setup.
                       
IDE device detection in kernel:
                       
kernel: ICH5: chipset revision 2
kernel: ICH5: not 100%% native mode: will probe irqs later
kernel:     ide0: BM-DMA at 0xffa0-0xffa7, BIOS settings: hda:DMA,
hdb:pio
kernel:     ide1: BM-DMA at 0xffa8-0xffaf, BIOS settings: hdc:DMA,
hdd:pio
kernel: PDC20268: IDE controller at PCI slot 0000:02:04.0
kernel: PCI: Found IRQ 9 for device 0000:02:04.0
kernel: PCI: Sharing IRQ 9 with 0000:00:1d.2
kernel: PCI: Sharing IRQ 9 with 0000:00:1f.1
helios kernel: PCI: Sharing IRQ 9 with 0000:01:01.0
helios kernel: PDC20268: chipset revision 2
helios kernel: PDC20268: ROM enabled at 0xff8c0000
kernel: PDC20268: 100%% native mode on irq 9
kernel:     ide2: BM-DMA at 0x9400-0x9407, BIOS settings: hde:pio,
hdf:pio
kernel:     ide3: BM-DMA at 0x9408-0x940f, BIOS settings: hdg:pio,
hdh:pio
kernel: PDC20268: IDE controller at PCI slot 0000:02:02.0
kernel: PCI: Found IRQ 12 for device 0000:02:02.0
kernel: PCI: Sharing IRQ 12 with 0000:00:1f.3
kernel: PDC20268: chipset revision 2
kernel: PDC20268: ROM enabled at 0xff8d0000
kernel: PDC20268: 100%% native mode on irq 12
kernel:     ide4: BM-DMA at 0xa800-0xa807, BIOS settings: hdi:pio,
hdj:pio
kernel:     ide5: BM-DMA at 0xa808-0xa80f, BIOS settings: hdk:pio,
hdl:pio
kernel: PDC20268: IDE controller at PCI slot 0000:02:00.0
kernel: PCI: Found IRQ 10 for device 0000:02:00.0
kernel: PDC20268: chipset revision 2
kernel: PDC20268: ROM enabled at 0xff8e0000
kernel: PDC20268: 100%% native mode on irq 10
kernel:     ide6: BM-DMA at 0xbc00-0xbc07, BIOS settings: hdm:pio,
hdn:pio
kernel:     ide7: BM-DMA at 0xbc08-0xbc0f, BIOS settings: hdo:pio,
hdp:pio


Any idea how I could get all three cards to work in UDMA100 mode?

Help will as always be greatly appreciated

- Jaco van der Schyff
