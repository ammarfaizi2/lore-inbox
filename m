Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272388AbTGaFZf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 01:25:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272395AbTGaFZf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 01:25:35 -0400
Received: from vitelus.com ([64.81.243.207]:38875 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id S272396AbTGaFZ3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 01:25:29 -0400
Date: Wed, 30 Jul 2003 22:22:44 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: linux-kernel@vger.kernel.org
Subject: IDE errors with HPT302
Message-ID: <20030731052244.GB30855@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In a box, we have a HPT302 IDE card, sharing an IRQ with the 3c905C
Ethernet card:

HPT302: IDE controller at PCI slot 00:09.0
PCI: Found IRQ 11 for device 00:09.0
PCI: Sharing IRQ 11 with 00:0f.0
HPT302: chipset revision 1
HPT302: not 100% native mode: will probe irqs later
HPT37X: using 33MHz PCI clock
    ide2: BM-DMA at 0xb400-0xb407, BIOS settings: hde:pio, hdf:pio
    ide3: BM-DMA at 0xb408-0xb40f, BIOS settings: hdg:pio, hdh:pio

There is also a HPT370 in the system and a PIIX4.

Here are the errors, which make the card unusable:

Partition check:
 hda: hda1 hda2 < hda5 >
 hde:<4>hde: dma_timer_expiry: dma status == 0x61
hde: error waiting for DMA
hde: dma timeout retry: status=0x58 { DriveReady SeekComplete DataRequest }

hde: status timeout: status=0xd0 { Busy }

hdf: DMA disabled
hde: drive not ready for command
ide2: reset: success
blk: queue c02d1ff8, I/O limit 4095Mb (mask 0xffffffff)
 hde1
 hdf: unknown partition table
 hdg:<4>hdg: dma_timer_expiry: dma status == 0x01
hdg: error waiting for DMA
hdg: dma timeout retry: status=0x58 { DriveReady SeekComplete DataRequest }

blk: queue c02d2464, I/O limit 4095Mb (mask 0xffffffff)
 unknown partition table
 hdh:<4>hdh: dma_timer_expiry: dma status == 0x21
hdh: error waiting for DMA
hdh: dma timeout retry: status=0x58 { DriveReady SeekComplete DataRequest }

I'm assuming this is a driver issue since it happens with all 4 of the
drives. This happens with 2.4.21 and 2.4.22-pre9. Anyone had similar
experiences?
