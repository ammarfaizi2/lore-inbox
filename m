Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964963AbVKOSB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964963AbVKOSB7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 13:01:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964965AbVKOSB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 13:01:59 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:26298 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S964984AbVKOSB5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 13:01:57 -0500
Subject: Re: DMA transfer with kiobuf, kernel 2.4.21
From: Arjan van de Ven <arjan@infradead.org>
To: sej <trash@aie-etudes.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <437A20AA.8020001@aie-etudes.com>
References: <437A1D6E.4060302@aie-etudes.com>
	 <1132076986.2822.34.camel@laptopd505.fenrus.org>
	 <437A20AA.8020001@aie-etudes.com>
Content-Type: text/plain
Date: Tue, 15 Nov 2005 19:01:53 +0100
Message-Id: <1132077714.2822.36.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-15 at 18:53 +0100, sej wrote:
> > that sounds the wrong approach.. why don't you make your device driver
> > export an mmap function.. and let the userspace app use that ?
> 
> I can't because I need to allocate 128MB of memory per PCI card and if I put for example 4 cards, I'll have 512MB in kernel memory, and I think there will be some problem in kernel.

no there isn't.. there is no rule that memory you allocate for this as
to be lowmem... at all.

> 
> 
> 
> >transfer->Descript[i].size        = PAGE_SIZE;
> >transfer->Descript[i].pciaddr    = (ULONG)
> >virt_to_phys(page_address(iobuf->maplist[idxIobuf]));
> >  
> >
> 
> > you really need to use the PCI DMA mapping api!
> 
> I have a plx bridge PCI9656 with a DMA controler. So I have to make a 
> descriptor table with physical address and size.
> I work in 32 bits address mode, but I don't know which function to call 
> to get a 36bits address for my controler.

see the PCI DMA mapping api. the docs for it are in Documentation/



