Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319625AbSIMTe2>; Fri, 13 Sep 2002 15:34:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319655AbSIMTe2>; Fri, 13 Sep 2002 15:34:28 -0400
Received: from roc-24-93-20-125.rochester.rr.com ([24.93.20.125]:18171 "EHLO
	www.kroptech.com") by vger.kernel.org with ESMTP id <S319625AbSIMTe2>;
	Fri, 13 Sep 2002 15:34:28 -0400
Date: Fri, 13 Sep 2002 15:39:16 -0400
From: Adam Kropelin <akropel1@rochester.rr.com>
To: linux-kernel@vger.kernel.org
Subject: Streaming DMA mapping question
Message-ID: <20020913193916.GA5004@www.kroptech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working on revamping the DMA mapping of a driver and have been reading
Documentation/DMA-Mapping.txt and becoming one with it. On i386 I notice the
following discrepency:

According to the docs, you should either unmap or sync your DMA buffer before
touching it from the host. The i386 implementation of pci_unmap is empty --no
problem; there must not be any unmap work to do on this arch. But the 
implementation of pci_dma_sync does contain a flush_write_buffers() call. This
makes me think that perhaps if I'm going to modify the buffer before I submit it
back to the controller I need to do:

/* so I can read it; not necessary on i386 */
pci_dma_sync_single(...);

fiddle_with_buffer(...);

/* so adapter sees my changes; this is necessary on i386 */
pci_dma_sync_single(...);

Otherwise I don't see why it is safe to touch the buffer after pci_unmap.

Someone lend me a clue?

--Adam
 
