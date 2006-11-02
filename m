Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752317AbWKBNga@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752317AbWKBNga (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 08:36:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752311AbWKBNga
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 08:36:30 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:4226 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1752305AbWKBNg3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 08:36:29 -0500
Date: Thu, 2 Nov 2006 13:35:48 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Matthew Wilcox <matthew@wil.cx>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Jun Sun <jsun@junsun.net>,
       linux-scsi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: unchecked_isa_dma and BusLogic SCSI controller
Message-ID: <20061102133548.GA27715@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Matthew Wilcox <matthew@wil.cx>,
	Randy Dunlap <randy.dunlap@oracle.com>, Jun Sun <jsun@junsun.net>,
	linux-scsi@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
References: <20061101235330.GA30843@srv.junsun.net> <20061101173358.7b027d13.randy.dunlap@oracle.com> <20061102124128.GC31830@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061102124128.GC31830@parisc-linux.org>
User-Agent: Mutt/1.4.2.2i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 02, 2006 at 05:41:28AM -0700, Matthew Wilcox wrote:
> On Wed, Nov 01, 2006 at 05:33:58PM -0800, Randy Dunlap wrote:
> >     unchecked_isa_dma - 1=>only use bottom 16 MB of ram (ISA DMA addressing
> >                    restriction), 0=>can use full 32 bit (or better) DMA
> >                    address space
> > 
> > > It is hard for me to see why BusLogic controller would only do DMA
> > > in low 16MB.  Is there a fix for this?
> > 
> > Does anyone know that controller hardware and its limitations?
> 
> I don't, but:
> 
> 		if (pci_set_dma_mask(PCI_Device, DMA_32BIT_MASK ))
> 			continue;
> 
> So somebody thinks the device can do 32-bit addressing.  I would expect
> that setting unchecked_isa_dma is a historical mistake.  However, I
> don't have any cards of this type to test.

The buslogic driver also supports non-PCI devices, and at least the
ISA boards have the obvious limitiation that unchecked_isa_dma = 1
caters to.  Now someone would have to audit the driver whether it's
enough to only set this on the actual isa hosts instead of the host
template.
