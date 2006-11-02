Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752828AbWKBMla@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752828AbWKBMla (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 07:41:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752820AbWKBMla
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 07:41:30 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:9682 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1752813AbWKBMl3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 07:41:29 -0500
Date: Thu, 2 Nov 2006 05:41:28 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Jun Sun <jsun@junsun.net>, linux-scsi@vger.kernel.org,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: unchecked_isa_dma and BusLogic SCSI controller
Message-ID: <20061102124128.GC31830@parisc-linux.org>
References: <20061101235330.GA30843@srv.junsun.net> <20061101173358.7b027d13.randy.dunlap@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061101173358.7b027d13.randy.dunlap@oracle.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2006 at 05:33:58PM -0800, Randy Dunlap wrote:
>     unchecked_isa_dma - 1=>only use bottom 16 MB of ram (ISA DMA addressing
>                    restriction), 0=>can use full 32 bit (or better) DMA
>                    address space
> 
> > It is hard for me to see why BusLogic controller would only do DMA
> > in low 16MB.  Is there a fix for this?
> 
> Does anyone know that controller hardware and its limitations?

I don't, but:

		if (pci_set_dma_mask(PCI_Device, DMA_32BIT_MASK ))
			continue;

So somebody thinks the device can do 32-bit addressing.  I would expect
that setting unchecked_isa_dma is a historical mistake.  However, I
don't have any cards of this type to test.

