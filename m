Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317097AbSEXGNw>; Fri, 24 May 2002 02:13:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317101AbSEXGNv>; Fri, 24 May 2002 02:13:51 -0400
Received: from pizda.ninka.net ([216.101.162.242]:46824 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317097AbSEXGNt>;
	Fri, 24 May 2002 02:13:49 -0400
Date: Thu, 23 May 2002 22:59:27 -0700 (PDT)
Message-Id: <20020523.225927.132611174.davem@redhat.com>
To: wjhun@ayrnetworks.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Possible discrepancy regarding streaming DMA mappings in
 DMA-mapping.txt?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020523162425.G7205@ayrnetworks.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: William Jhun <wjhun@ayrnetworks.com>
   Date: Thu, 23 May 2002 16:24:25 -0700
   
   However, shouldn't pci_dma_sync_*() be called *before* each
   PCI_DMA_TODEVICE DMA transfer (after the CPU write, of course) and
   *after* each PCI_DMA_FROMDEVICE DMA transfer (before CPU access)? And,
   of course, before and after a "bidirectional" DMA, if appropriate.
   
CPU owns the data before pci_map_{sg,single}(), afterwards device
owns the data.  If CPU wants ownership again, it must wait for
device to finish with the data when do a pci_sync_{sg,single}().

You are thinking about CPU cache flushing, and that is a detail
handled transparently to the DMA apis.  If you follow the rules
described in the documentation and in my previous paragraph,
the ARCH specific code does the right thing for you.
