Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbUBNIrU (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 03:47:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbUBNIrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 03:47:20 -0500
Received: from bart.one-2-one.net ([217.115.142.76]:63239 "EHLO
	bart.webpack.hosteurope.de") by vger.kernel.org with ESMTP
	id S261368AbUBNIrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 03:47:18 -0500
Date: Sat, 14 Feb 2004 09:51:17 +0100 (CET)
From: Martin Diehl <lists@mdiehl.de>
X-X-Sender: martin@notebook.home.mdiehl.de
To: James Bottomley <James.Bottomley@SteelEye.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Patch] dma_sync_to_device
In-Reply-To: <1076682474.2159.17.camel@mulgrave>
Message-ID: <Pine.LNX.4.44.0402140328350.17970-100000@notebook.home.mdiehl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Feb 2004, James Bottomley wrote:

> Just to be sure we eliminate all confusion (and it amazes me how
> frequently this comes up), could you add some words DMA-mapping.txt to
> make clear that this new API does not address PCI posting (which is a
> problem with onward write cache flushing in the PCI bridge)---otherwise
> I can see device driver writers thinking that
> pci_dma_sync_to_device_single(... DMA_TO_DEVICE) will flush posted
> writes.

Ok, will do.

Just to make sure I got you right, your concern is people mixing up the 
effect of this call with some means to sync with posted writes on iomem 
mapped memory location provided by some device on the bus? I.e. the 
situation where they probably want to use readl() or similar to force the 
posted writes to complete in contrast to sync_to_device which ensures the 
modified system memory gets synced before the busmastering starts?

If so, wouldn't this concern be related to the pci_dma api as a whole, not 
only the new pci_dma_sync_to_device call particularly? I mean, none of the 
api functions to deal with consistent or streaming maps of system memory 
are applicable for flushing posted writes to iomem on the bus. Maybe the 
confusion comes from the fact on some archs the pci_dma_sync call would 
have to flush posted writes _from_ the busmaster device to system memory?

Could you please confirm my understanding of the issue is correct (or not) 
before I'm trying to add some clarification to DMA-mapping.txt.

Martin

