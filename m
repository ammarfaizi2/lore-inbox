Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319783AbSIMUcL>; Fri, 13 Sep 2002 16:32:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319786AbSIMUcL>; Fri, 13 Sep 2002 16:32:11 -0400
Received: from pizda.ninka.net ([216.101.162.242]:49612 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S319783AbSIMUcK>;
	Fri, 13 Sep 2002 16:32:10 -0400
Date: Fri, 13 Sep 2002 13:28:42 -0700 (PDT)
Message-Id: <20020913.132842.97163812.davem@redhat.com>
To: akropel1@rochester.rr.com
Cc: linux-kernel@vger.kernel.org, alan@redhat.com
Subject: Re: Streaming DMA mapping question
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020913202150.GA24340@www.kroptech.com>
References: <20020913193916.GA5004@www.kroptech.com>
	<20020913.123641.50140065.davem@redhat.com>
	<20020913202150.GA24340@www.kroptech.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Adam Kropelin <akropel1@rochester.rr.com>
   Date: Fri, 13 Sep 2002 16:21:50 -0400

   On Fri, Sep 13, 2002 at 12:36:41PM -0700, David S. Miller wrote:
   > Actually, rather it appears that the i386 pci_unmap_*() routines need
   > the write buffer flush as well.
   
   Ah, a bug then. 
   
On further discussion with Alan Cox, the bug is actually that
pci_map_*() needs the write buffer flush added.  pci_map_*()
and pci_dma_sync_*() transfer ownership from CPU to PCI controller
as abstracted in DMA-mapping.txt   Therefore these are the cases
where the CPU write buffers need to be flushed.

pci_unmap_*() is ok as-is.

   I was looking at the x86 implementation to help me narrow down the possible
   source of a bug I'm seeing in the driver. I noticed the driver was examining a
   DMA buffer without unmapping or syncing.

Really, the cases handled by the x86 write buffer fluses are very
marginal and unlikely to happen.  In fact the write buffer flush on
x86 is done on winchip and ppro chips only.

I think you're problems are elsewhere :-)
   
   Kudos to you and others who spent time writing it.

Thank you.

   
