Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265348AbUFXOtw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265348AbUFXOtw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 10:49:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265328AbUFXOtw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 10:49:52 -0400
Received: from hqemgate02.nvidia.com ([216.228.112.145]:44554 "EHLO
	hqemgate02.nvidia.com") by vger.kernel.org with ESMTP
	id S265348AbUFXOs4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 10:48:56 -0400
Date: Thu, 24 Jun 2004 09:45:51 -0500
From: Terence Ripperda <tripperda@nvidia.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Andi Kleen <ak@muc.de>, Terence Ripperda <tripperda@nvidia.com>,
       discuss@x86-64.org, linux-kernel@vger.kernel.org, andrea@suse.de
Subject: Re: 32-bit dma allocations on 64-bit platforms
Message-ID: <20040624144551.GI983@hygelac>
Reply-To: Terence Ripperda <tripperda@nvidia.com>
References: <s5hhdt1i4yc.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hhdt1i4yc.wl@alsa2.suse.de>
User-Agent: Mutt/1.4i
X-Accept-Language: en
X-Operating-System: Linux hrothgar 2.4.23 
X-OriginalArrivalTime: 24 Jun 2004 14:48:51.0893 (UTC) FILETIME=[5D854E50:01C459FA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 04:13:47AM -0700, tiwai@suse.de wrote:
> > pci_alloc_consistent is limited to 16MB, but so far nobody has really
> > complained about that. If that should be a real issue we can make
> > it allocate from the swiotlb pool, which is usually 64MB (and can
> > be made bigger at boot time) 
> 
> Can't it be called with GFP_KERNEL at first, then with GFP_DMA if the
> allocated pages are out of dma mask, just like in pci-gart.c?
> (with ifdef x86-64)

pci_alloc_consistent (at least on x86-64) does do this. one of the problems
I've seen in experimentation is that GFP_KERNEL tends to allocate from the
top of memory down. this means that all of the GFP_KERNEL allocations are >
32-bits, which forces us down to GFP_DMA and the < 16M allocations.

I've mainly tested this after a cold boot, so after running for a while,
GFP_KERNEL may hit good allocations a lot more.

Thanks,
Terence

