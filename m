Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266223AbUBLDqY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 22:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266248AbUBLDqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 22:46:24 -0500
Received: from fed1mtao07.cox.net ([68.6.19.124]:41202 "EHLO
	fed1mtao07.cox.net") by vger.kernel.org with ESMTP id S266223AbUBLDqX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 22:46:23 -0500
Date: Wed, 11 Feb 2004 20:46:11 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: "David S. Miller" <davem@redhat.com>
Cc: mporter@kernel.crashing.org, lists@mdiehl.de, linux-kernel@vger.kernel.org
Subject: Re: [Patch] dma_sync_to_device
Message-ID: <20040212034610.GA27317@plexity.net>
Reply-To: dsaxena@plexity.net
References: <20040211061753.GA22167@plexity.net> <Pine.LNX.4.44.0402110729510.2349-100000@notebook.home.mdiehl.de> <20040211111800.A5618@home.com> <20040211103056.69e4660e.davem@redhat.com> <20040211185725.GA25179@plexity.net> <20040211110853.492f479b.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040211110853.492f479b.davem@redhat.com>
User-Agent: Mutt/1.3.28i
Organization: Plexity Networks
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 11 2004, at 11:08, David S. Miller was caught saying:
> New sequence:
> 
> 1) pci_map_single(..., DMA_TO_DEVICE).  Flush dirty data from cpu caches to memory,
>    so device may see it.
> 
> 2) device reads buffer
> 
> 3) pci_dma_sync_single(... DMA_TO_DEVICE).  If PCI controller has caches, flush them.
> 
> 4) CPU writes new buffer data.
> 
> 5) pci_dma_sync_device_single(... DMA_TO_DEVICE).  Like #1, flush dirty data from cpu
>    caches to memory.
> 
> 6) Device reads buffer.
> 
> Still disagree? :-)

/me groks now. I am assuming this is a 2.7 thing as it is
reinterpreting/redefining the API. In ARM, pci_dma_sync_single() does
a cache flush, which is why I was confused asked about two cache flushes.
What you are proposing is that by definition pci_dma_sync_* syncs 
bridges caches with system memory, while pci_dma_sync_device_* syncs 
the CPU's cache with system memory.

This will definetely confuse a lot of driver writers. 

~Deepak

-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/
