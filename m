Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751466AbVKORt4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751466AbVKORt4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 12:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbVKORt4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 12:49:56 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:56969 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751466AbVKORtz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 12:49:55 -0500
Subject: Re: DMA transfer with kiobuf, kernel 2.4.21
From: Arjan van de Ven <arjan@infradead.org>
To: sej <trash@aie-etudes.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <437A1D6E.4060302@aie-etudes.com>
References: <437A1D6E.4060302@aie-etudes.com>
Content-Type: text/plain
Date: Tue, 15 Nov 2005 18:49:45 +0100
Message-Id: <1132076986.2822.34.camel@laptopd505.fenrus.org>
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

On Tue, 2005-11-15 at 18:39 +0100, sej wrote:
> Hi,
> I allocate a big chunck of memory from user space with :
> 
> #define MEM_SIZE_DMA (128*1024*1024)
> // allocate 128MB of memory
> void *_pVirtualMem = memalign(sysconf(_SC_PAGESIZE), MEM_SIZE_DMA);
> 
> // Reserve memory
> memset(_pVirtualMem, 0, MEM_SIZE_DMA);
> 
> // Lock memory
> if (!mlock(_pVirtualMem, MEM_SIZE_DMA ))
> {
> free(_pVirtualMem);
> return false;
> }
> 
> Then I call an IOCTL from my driver (DmaMapDescrpImg) to create a DMA
> scatter gather list.

that sounds the wrong approach.. why don't you make your device driver
export an mmap function.. and let the userspace app use that ?


> 
> transfer->Descript[i].size        = PAGE_SIZE;
> transfer->Descript[i].pciaddr    = (ULONG)
> virt_to_phys(page_address(iobuf->maplist[idxIobuf]));

you really need to use the PCI DMA mapping api!



