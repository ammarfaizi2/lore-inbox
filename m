Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263421AbUCPBpi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 20:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262927AbUCPBnB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 20:43:01 -0500
Received: from gate.crashing.org ([63.228.1.57]:45021 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263399AbUCPBmG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 20:42:06 -0500
Subject: Re: consistent_sync_for_cpu() and friends on ppc32
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@redhat.com>
Cc: Olaf Hering <olh@suse.de>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20040315164917.6a85966b.davem@redhat.com>
References: <20040315201616.GA31268@suse.de>
	 <20040315123647.4ce943b7.davem@redhat.com>
	 <1079396621.1967.196.camel@gaston>
	 <20040315164917.6a85966b.davem@redhat.com>
Content-Type: text/plain
Message-Id: <1079400967.2302.213.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 16 Mar 2004 12:36:07 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 1) User prepares buffer X with data.
> 2) pci_map_single(X, TO_DEVICE)
> 3) Device does DMA, interrupts cpu.
> 4) pci_dma_sync_single_for_cpu(X)
> 5) Write new contents.
> 6) pci_dma_sync_single_for_device(X)
> 7) Device does DMA again, interrupts cpu.
> 8) ...
> 
> Step 2 would writeback flush the cpu cache, step 4 would be a NOP,
> step 6 would writeback flush the cpu cache.
> 
> The direction does not provide enough information to do these operations
> with the right amount of information.

Hrm... I'm still not sure how I'm supposed to implement those
for non-consistent PPCs (embedded). We don't carry state information
around, so I suppose I'll have to rely on the direction beeing the
same for the whole duration of the operation... In which case, it's
just a matter of having for_cpu nop'ing when direction is TO_DEVICE
and for_device nop'ing when direction is FROM_DEVICE ? Not clear
imho...

Ben.


