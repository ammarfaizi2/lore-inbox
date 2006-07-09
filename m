Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161029AbWGIP2o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161029AbWGIP2o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 11:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161032AbWGIP2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 11:28:44 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:21706 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161029AbWGIP2n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 11:28:43 -0400
Subject: Re: memory barriers and dma_sync_single_for_*
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <44B11861.3070703@s5r6.in-berlin.de>
References: <44B11861.3070703@s5r6.in-berlin.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Sun, 09 Jul 2006 16:46:27 +0100
Message-Id: <1152459987.27368.64.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sul, 2006-07-09 am 16:53 +0200, ysgrifennodd Stefan Richter:
> My question: Do I need wmb() within the following code?
> 
> 	dma_sync_single_for_cpu(..., DMA_TO_DEVICE);
> 	area->a = new_val_a;
> 	wmb();  /* necessary? */
> 	area->b = new_val_b;

Yes. Otherwise on some processors the I/O may be re-ordered

> 	dma_sync_single_for_device(..., DMA_TO_DEVICE);
> 
> Or are all changes to the area hidden from the device between 
> dma_sync_single_for_cpu and _for_device, thereby making the write order 
> a non-issue? Thanks,

Depends on the processor and setup. On x86-32 for example dma_sync_.. is
generally a NOP. In other environments nothing will be visible until the
sync.

Alan

