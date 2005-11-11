Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751128AbVKKUJv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbVKKUJv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 15:09:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbVKKUJv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 15:09:51 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:9394
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751128AbVKKUJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 15:09:51 -0500
Date: Fri, 11 Nov 2005 12:09:50 -0800 (PST)
Message-Id: <20051111.120950.06356722.davem@davemloft.net>
To: agx@sigxcpu.org
Cc: linux-kernel@vger.kernel.org, gregkh@suse.de
Subject: Re: sparc64: Oops in pci_alloc_consistent with cingergyT2
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051111153354.GA19838@bogon.ms20.nix>
References: <20051111153354.GA19838@bogon.ms20.nix>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guido Guenther <agx@sigxcpu.org>
Date: Fri, 11 Nov 2005 16:33:55 +0100

> This is due to the fact that cinergyt2_alloc_stream_urbs calls
> pci_alloc_consistent with a NULL argument for the pci dev (it's a USB
> device):
> 
> cinergyt2->streambuf = pci_alloc_consistent(NULL,
>                                               STREAM_URB_COUNT*STREAM_BUF_SIZE,
>                                               &cinergyt2->streambuf_dmahandle);
> 
> dma_alloc_coherent doesn't seem to be implemented on sparc64, what would
> be the right way to tackle this?

It should be using "usb_buffer_alloc()" or similar.

No USB driver should be calling the DMA mapping interfaces
directly.

Where is this driver?  I can't find it in the 2.6.x sources.
