Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261954AbUBWQ1s (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 11:27:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbUBWQ1s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 11:27:48 -0500
Received: from rzdspc1.informatik.uni-hamburg.de ([134.100.9.61]:42951 "EHLO
	rzdspc1.informatik.uni-hamburg.de") by vger.kernel.org with ESMTP
	id S261946AbUBWQ1p (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 11:27:45 -0500
From: "Kilian A. Foth" <foth@informatik.uni-hamburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-ID: <16442.10695.415738.413726@nats47.informatik.uni-hamburg.de>
Date: Mon, 23 Feb 2004 17:26:47 +0100
To: linux-kernel@vger.kernel.org
Subject: DMA fails for large hard drive on an ICH5 controller
X-Mailer: VM 7.14 under 21.4 (patch 14) "Reasonable Discussion" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm getting DMA timeouts in 2.6.3 (and also with SuSE's version of
2.4.21-smp) whenever I try to enable DMA on my hard disk, whether
during boot or later via hdparm:


hda: dma_timer_expiry: dma status == 0x21
hda: timeout waiting for DMA
hda: timeout waiting for DMA
hda: (__ide_dma_test_irq) called while not waiting
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }

hda: drive not ready for command
hda: dma_timer_expiry: dma status == 0x21
hda: timeout waiting for DMA
hda: timeout waiting for DMA
hda: (__ide_dma_test_irq) called while not waiting
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }

hda: drive not ready for command
hda: dma_timer_expiry: dma status == 0x21
hda: timeout waiting for DMA
hda: timeout waiting for DMA
hda: (__ide_dma_test_irq) called while not waiting
hda: status error: status=0x58 { DriveReady SeekComplete DataRequest }

hda: drive not ready for command


The mainboard is an MSI 865PE Neo2 FIS2R (the chipset is an MS-6728,
with the ICH5 IDE controller). The hard drive is a Samsung SV1604N
(160GB). Both the hard drive and the controller are known-good -- I
can enable DMA on the other channels, and in fact on the same channel
with other, older hard drives, just not with this new one. (I don't
have another 160GB disk to test against.)

I've heard of other people using the same controller with large drives
without problems, but also a few with the same problem. I have fiddled
with a few kernel options, among them

  CONFIG_BLK_DEV_GENERIC
  CONFIG_BLK_DEV_IDEDMA_PCI
  CONFIG_IDEDMA_PCI_AUTO
  CONFIG_BLK_DEV_PIIX
  CONFIG_X86_IO_APIC

without success. What should I try next?

-- 
Kilian Foth                                    Phone +49 40 42883-2518
AB NATS, FB Informatik                         Fax   +49 40 42883-2515
Universität Hamburg
Vogt-Kölln-Str. 30
22527 Hamburg
