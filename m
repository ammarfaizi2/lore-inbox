Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263380AbUEPMmI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263380AbUEPMmI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 08:42:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263555AbUEPMmI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 08:42:08 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:35853 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263380AbUEPMmF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 08:42:05 -0400
Date: Sun, 16 May 2004 13:42:02 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: kernel BUG at drivers/block/ll_rw_blk.c:277!
Message-ID: <20040516134202.A11232@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

                BUG_ON(dma_addr < BLK_BOUNCE_ISA);

linux/include/linux/blkdev.h:#define BLK_BOUNCE_ISA             (ISA_DMA_THRESHOLD)
linux/include/asm-arm/scatterlist.h:#define ISA_DMA_THRESHOLD (0xffffffff)

That's nice.  Someone like to explain the reasoning here.

ISA_DMA_THRESHOLD is the maximum address which ISA can DMA to.  On ARM,
we support ISA DMA controllers all of which can address 32-bit, so our
setting of ISA_DMA_THRESHOLD is correct.

However, it seems that the block layer thinks this has some other meaning
and has hijacked it.

Consequently, block is rather dead on ARM at the moment.  Someone mind
explaining WTF this has happened?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
