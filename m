Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750716AbVLXUmF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750716AbVLXUmF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Dec 2005 15:42:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750717AbVLXUmF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Dec 2005 15:42:05 -0500
Received: from smtp.osdl.org ([65.172.181.4]:33410 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750716AbVLXUmE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Dec 2005 15:42:04 -0500
Date: Sat, 24 Dec 2005 12:41:35 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Manfred Spraul <manfred@colorfullife.com>
cc: Jeff Garzik <jgarzik@pobox.com>, Ayaz Abdulla <AAbdulla@nvidia.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Netdev <netdev@oss.sgi.com>
Subject: Re: [PATCH] forcedeth: fix random memory scribbling bug
In-Reply-To: <43ADA7D0.9010908@colorfullife.com>
Message-ID: <Pine.LNX.4.64.0512241241230.14098@g5.osdl.org>
References: <43AD4ADC.8050004@colorfullife.com> <Pine.LNX.4.64.0512241145520.14098@g5.osdl.org>
 <43ADA7D0.9010908@colorfullife.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 24 Dec 2005, Manfred Spraul wrote:

> Linus Torvalds wrote:
> 
> > Of course, on the alloc path, it seems to add an additional
> > "NV_RX_ALLOC_PAD" thing, so maybe the "end-data" thing makes sense.
>
> The problem is the pci_unmap_single() call that happens during nv_close() or
> the rx interrupt handler. I think it makes more sense to rely on fields in the
> individual skb instead of reading from np->rx_buf_sz. If np->rx_buf_sz changes
> inbetween, then we have a memory leak.

Fair enough. Patch applied.

		Linus
