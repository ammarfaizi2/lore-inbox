Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262412AbUCHGSU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Mar 2004 01:18:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262404AbUCHGSU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Mar 2004 01:18:20 -0500
Received: from palrel13.hp.com ([156.153.255.238]:27269 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S262400AbUCHGSR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Mar 2004 01:18:17 -0500
Date: Sun, 7 Mar 2004 22:18:02 -0800
From: Grant Grundler <iod00d@hp.com>
To: David Brownell <david-b@pacbell.net>
Cc: davidm@hpl.hp.com, Greg KH <greg@kroah.com>, vojtech@suse.cz,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, pochini@shiny.it
Subject: Re: [linux-usb-devel] Re: serious 2.6 bug in USB subsystem?
Message-ID: <20040308061802.GA25960@cup.hp.com>
References: <20031028013013.GA3991@kroah.com> <200310280300.h9S30Hkw003073@napali.hpl.hp.com> <3FA12A2E.4090308@pacbell.net> <16289.29015.81760.774530@napali.hpl.hp.com> <16289.55171.278494.17172@napali.hpl.hp.com> <3FA28C9A.5010608@pacbell.net> <16457.12968.365287.561596@napali.hpl.hp.com> <404959A5.6040809@pacbell.net> <16457.26208.980359.82768@napali.hpl.hp.com> <4049FE57.2060809@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4049FE57.2060809@pacbell.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 06, 2004 at 08:37:43AM -0800, David Brownell wrote:
> DMA-coherent memory is defined as "memory for which a write by either
> the device or the processor can immediately be read by the processor
> or device without having to worry about caching effects."

The use of "immediate" here means no other sync function needs to
be called to access the data - ie don't need to call pci_sync_single().

In general, the accesses are ordered following PCI ordering rules.
But every architecture (including x86) has issues with "inflight" DMA.
Line based Interrupts are delivered on a different path than DMA 
and thus ordering can't be enforced.
For example, the code around the following comment in drivers/net/tg3.c:
	/*
	 * Flush PCI write.  This also guarantees that our
	 * status block has been flushed to host memory.
	 */


> `Such a
> write-buffering mechanism is clearly a type of (write-)caching effect,

No - the data is still in flight and in some deterministic time frame
will become visible to the CPU.
Calling it a "caching effect" confuses the issues even worse.

> and readl() would be a kind of dma_rmb(), if you will.

Yes, that's correct - but it's orthogonal to "cache coherent".

> I suspect the docs are wrong about what dma-coherent means.

Not "wrong", just misunderstood. ;^)

hth,
grant
