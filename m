Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129370AbRACVLI>; Wed, 3 Jan 2001 16:11:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129581AbRACVK7>; Wed, 3 Jan 2001 16:10:59 -0500
Received: from core.federated.com ([199.217.175.51]:785 "EHLO
	core.federated.com") by vger.kernel.org with ESMTP
	id <S129370AbRACVKs>; Wed, 3 Jan 2001 16:10:48 -0500
From: Jim Studt <jim@federated.com>
Message-Id: <200101032110.PAA08416@core.federated.com>
Subject: sis5513 fatal udma problems
To: linux-kernel@vger.kernel.org
Date: Wed, 3 Jan 2001 15:10:39 -0600 (CST)
X-Mailer: ELM [version 2.4ME+ PL66 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The sis5513 has for quite a while had fatal problems with udma on some
machines.  (At least the thelinuxstore PIAs with the P6SET-ML
motherboard, I have heard other people with the same problem).

The sis5513 driver deliberatly overrides the CONFIG_IDEDMA_AUTO and
the BIOS settings that might disable UDMA and forces UDMA which works
for a while then fails, attempts to fallback to a non-DMA mode and
fails that as well.

The logs end up with something along the lines of...
  hdc: timeout waiting for DMA
  ide_dmaproc: chipset supported ide_dma_timeout func only: 14
  hdc: irq timeout: status=0x58 { DriveReady SeekComplete DataRequest }
  hdc: status timeout: status=0xd8 { Busy }
  hdc: DMA disabled
  hdc: drive not ready for command
  ide1: reset: success
  hdc: status error: status=0x58 { DriveReady SeekComplete DataRequest }
  hdc: drive not ready for command
... but it nevers succeeds in the reset.  The drive never becomes ready.

I will make a patch, but I am uncertain what the `right' policy should
be.  I am inclined to first and foremost respect the CONFIG_IDEDMA_AUTO
flag, then to take the fastest mode which is both capable and enabled in
the bios.

Thoughts?  Please? :-)

-- 
                                     Jim Studt, President
                                     The Federated Software Group, Inc.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
