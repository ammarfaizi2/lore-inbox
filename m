Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264241AbTKUErz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 23:47:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264291AbTKUEry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 23:47:54 -0500
Received: from modemcable067.88-70-69.mc.videotron.ca ([69.70.88.67]:9090 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S264241AbTKUErw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 23:47:52 -0500
Date: Fri, 21 Nov 2003 00:47:49 -0500 (EST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test9-mm4 IDE PDC20267 woes
Message-ID: <Pine.LNX.4.53.0311210040250.1637@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get the following messages under heavy disk load. Might also be worth 
noting that interrupt rate is around 10,000 interrupts/s during heavy disk 
IO.

The marketing name for the disks is "Seagate Barracuda IV" the system is 
2x 2.0GHz xeon. Interestingly i have the noirqbalance parameter on, that 
probably also needs looking into. Not to mention that the MIS line is 
incrementing at a steady pace in step with the ide interrupts.

           CPU0       CPU1       CPU2       CPU3
  0:    2562053          0          0          0    IO-APIC-edge  timer
  1:       8212          0          0          0    IO-APIC-edge  i8042
  2:          0          0          0          0          XT-PIC  cascade
  3:          1          0          0          0    IO-APIC-edge  serial
  4:          1          0          0          0    IO-APIC-edge  serial
  8:          1          0          0          0    IO-APIC-edge  rtc
  9:          0          0          0          0   IO-APIC-level  acpi
 12:      49138          0          0          0    IO-APIC-edge  i8042
 14:      49135          0          0          0    IO-APIC-edge  ide0
 15:         10          0          0          0    IO-APIC-edge  ide1
 16:        594          0          0          0   IO-APIC-level  uhci_hcd
 17:         16          0          0          0   IO-APIC-level  serial
 19:      31549          0          0          0   IO-APIC-level  aic7xxx, uhci_hcd
 20:       6665          0          0          0   IO-APIC-level  eth0
 22:   16324115      21836      48031      42905   IO-APIC-level  ide2, ide3
 23:          6          0          0          0   IO-APIC-level  eth1
 48:     113434          0          0          0   IO-APIC-level  EMU10K1
NMI:          0          0          0          0
LOC:    2562342    2574744    2583077    2583076
ERR:          0
MIS:     112774

04:06.0 RAID bus controller: Promise Technology, Inc. 20267 (rev 02)

PDC20267: IDE controller at PCI slot 0000:04:06.0
PDC20267: chipset revision 2
PDC20267: 100% native mode on irq 22
PDC20267: (U)DMA Burst Bit ENABLED Primary MASTER Mode Secondary MASTER 
Mode.
    ide2: BM-DMA at 0x8880-0x8887, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0x8888-0x888f, BIOS settings: hdg:pio, hdh:pio
hde: ST340014A, ATA DISK drive
ide2 at 0x8c08-0x8c0f,0x88fe on irq 22
hdg: ST340014A, ATA DISK drive
ide3 at 0x8c00-0x8c07,0x88fa on irq 22

...
hdg: dma_timer_expiry: dma status == 0x20
hdg: DMA timeout retry
PDC202XX: Secondary channel reset.
PDC202XX: Primary channel reset.
hdg: timeout waiting for DMA
hde: dma_timer_expiry: dma status == 0x20
hde: DMA timeout retry
PDC202XX: Primary channel reset.
PDC202XX: Secondary channel reset.
hde: timeout waiting for DMA
hdg: dma_timer_expiry: dma status == 0x20
hdg: DMA timeout retry
PDC202XX: Secondary channel reset.
PDC202XX: Primary channel reset.
hdg: timeout waiting for DMA
hde: dma_timer_expiry: dma status == 0x20
hde: DMA timeout retry
PDC202XX: Primary channel reset.
hdg: dma_timer_expiry: dma status == 0x20
hdg: DMA timeout retry
PDC202XX: Secondary channel reset.
PDC202XX: Secondary channel reset.
hde: timeout waiting for DMA
PDC202XX: Primary channel reset.
hdg: timeout waiting for DMA
blk: queue c17b9400, I/O limit 4095Mb (mask 0xffffffff)
blk: queue c17aec00, I/O limit 4095Mb (mask 0xffffffff)
hdg: dma_timer_expiry: dma status == 0x21
hdg: DMA timeout error
hdg: dma timeout error: status=0x58 { DriveReady SeekComplete DataRequest 
}

hdg: status error: status=0x50 { DriveReady SeekComplete }

hdg: no DRQ after issuing MULTWRITE_EXT
hdg: status timeout: status=0xd0 { Busy }

PDC202XX: Secondary channel reset.
PDC202XX: Primary channel reset.
hdg: no DRQ after issuing MULTWRITE_EXT
ide3: reset: master: error (0x00?)
