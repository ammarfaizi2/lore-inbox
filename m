Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966734AbWKOKGY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966734AbWKOKGY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 05:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966736AbWKOKGY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 05:06:24 -0500
Received: from mail-in-10.arcor-online.net ([151.189.21.50]:31718 "EHLO
	mail-in-10.arcor-online.net") by vger.kernel.org with ESMTP
	id S966734AbWKOKGX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 05:06:23 -0500
In-Reply-To: <1163575420.5940.223.camel@localhost.localdomain>
References: <Pine.LNX.4.64.0611141846190.3349@woody.osdl.org> <20061114.190036.30187059.davem@davemloft.net> <1163563260.5940.205.camel@localhost.localdomain> <20061114.200719.38322619.davem@davemloft.net> <1163575420.5940.223.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4AEFD197-2F7B-4449-B072-F883F7A3721E@kernel.crashing.org>
Cc: David Miller <davem@davemloft.net>, torvalds@osdl.org, jeff@garzik.org,
       linux-kernel@vger.kernel.org, tiwai@suse.de
Content-Transfer-Encoding: 7bit
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
Date: Wed, 15 Nov 2006 11:06:15 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
X-Mailer: Apple Mail (2.752.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> However, they have to do all the work of processing the memory
>> transation that the MSI is on the PCI bus, I don't think they  
>> would go
>> so far out of their way to reorder things even if they converted the
>> MSI packet into a PIN to the APIC, for example.
>
> That would suck and not surprise me that much in fact... Take the  
> Apple
> bridge... it's unclear at which point they actually decode the MSI and
> HT interrupts (the later are just internally converted to MSI-like
> stores) to turn them into toggling of MPIC lines,

That's all documented just fine.

> but it probably
> happens as an MMIO slave on the main xbar

Yes indeed.

> and I'm not 100% certain it
> provides ordering vs. the previous stores to memory as they are in the
> coherent domain and the MMIO is not. I just hope very much :-)

All those DMA stores get reflected to the CPUs (the north
bridge itself doesn't keep a cache directory).  All this
happens in-order.  There probably _is_ a window where the
last DMA store isn't yet globally visible but the CPU
interrupt was already signaled, but the act of trying to
access that data orders it itself :-)

> Because
> the store queue to memory can re-order on U4.

That's only the store queue to the actual memory devices,
it's outside of the coherent domain anyway.


Segher

