Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317215AbSEXR4j>; Fri, 24 May 2002 13:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317224AbSEXR4i>; Fri, 24 May 2002 13:56:38 -0400
Received: from pizda.ninka.net ([216.101.162.242]:49792 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317215AbSEXR4g>;
	Fri, 24 May 2002 13:56:36 -0400
Date: Fri, 24 May 2002 10:42:09 -0700 (PDT)
Message-Id: <20020524.104209.31440798.davem@redhat.com>
To: wjhun@ayrnetworks.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Possible discrepancy regarding streaming DMA mappings in
 DMA-mapping.txt?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020524104345.J7205@ayrnetworks.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: William Jhun <wjhun@ayrnetworks.com>
   Date: Fri, 24 May 2002 10:43:46 -0700
   
   So, if I'm not mistaken, you are saying that I need to call
   pci_dma_sync_single() *after* the DMA so that the CPU reclaims ownership
   to the buffer? That's fine and probably serves a good purpose on other
   architectures, but wouldn't I also need to do one before the DMA (after
   the CPU write) operation to flush write buffers/writeback any cachelines
   I've modified for non-cache-coherent architectures?

I see what your problem is, the interfaces were designed such
that the CPU could read the data.  It did not consider writes.

It was designed to handle a case like a networking driver where
a receive packet is inspected before we decide whether we accept the
packet or just give it back to the card.

Feel free to design the "cpu writes, back to device ownership"
interfaces and submit a patch :-)
