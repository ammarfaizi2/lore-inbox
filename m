Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266619AbUBMBuL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 20:50:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266645AbUBMBuK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 20:50:10 -0500
Received: from mail.shareable.org ([81.29.64.88]:16002 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S266619AbUBMBuG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 20:50:06 -0500
Date: Fri, 13 Feb 2004 01:49:53 +0000
From: Jamie Lokier <jamie@shareable.org>
To: "David S. Miller" <davem@redhat.com>
Cc: dsaxena@plexity.net, mporter@kernel.crashing.org, lists@mdiehl.de,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch] dma_sync_to_device
Message-ID: <20040213014953.GB25499@mail.shareable.org>
References: <20040211061753.GA22167@plexity.net> <Pine.LNX.4.44.0402110729510.2349-100000@notebook.home.mdiehl.de> <20040211111800.A5618@home.com> <20040211103056.69e4660e.davem@redhat.com> <20040211185725.GA25179@plexity.net> <20040211110853.492f479b.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040211110853.492f479b.davem@redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> It is different.  pci_dma_sync_single(..., DMA_TO_DEVICE), on MIPS for example,
> would do absolutely nothing.  At mapping time, the local cpu cache was flushed,
> and assuming the MIPS pci controllers don't have caches of their own there is
> nothing to flush there either.
> 
> Whereas pci_dma_sync_device_single() would flush the dirty lines from the cpu
> caches.  In fact, it will perform the same CPU cache flushes as pci_map_single()
> did, using MIPS as the example again.

The names are a bit confusing.
How about changing them to:

    pci_dma_sync_single         => pci_dma_sync_for_cpu
    pci_dma_sync_device_single  => pci_dma_sync_for_device

-- Jamie
