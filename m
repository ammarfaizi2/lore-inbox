Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263874AbTDYL2M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 07:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263870AbTDYL2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 07:28:12 -0400
Received: from verein.lst.de ([212.34.181.86]:37390 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id S263854AbTDYL2L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 07:28:11 -0400
Date: Fri, 25 Apr 2003 13:40:20 +0200
From: Christoph Hellwig <hch@lst.de>
To: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [HEADS UP] planned change to <asm-generic/dma-mapping.h> will cause arch breakage
Message-ID: <20030425134020.A5644@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To allow including <linux/dma-mapping.h> in generic code the default
implemtation of the dma-mapping API in terms of the PCI API will have
to go away.  What does this mean for your architecture?

 - If your architecture doesn't use <asm-generic/dma-mapping.h>
   (arm, i386, parisc):  Nothing.
 - If your architecture doesn't support PCI (cris, s390. um):
   Nothing, except that your arch won't break anymore if somsone
   includes dma-mapping.h in generic code.  But it would be cool to move
   over your dma-capable busses to the dma-mapping API...
 - Everyone else:  Unless you properly implement the dma-mapping in
   your architecture the dma_* APIs won't work anymore for you.
   The simplest way to get support for it on pci busses is to change
   your implementation of the pci_* dma functions to the dma_* prototypes
   and add the following to their top:

	struct pci_dev *pdev = to_pci_dev(dev);

   and maybe

	BUG_ON(dev->bus != &pci_bus_type);

   Of course it would be much nicer if you could add support for the
   dma-mapping API to your other dma-capable busses..
