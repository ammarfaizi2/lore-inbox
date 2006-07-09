Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161073AbWGIDV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161073AbWGIDV2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 23:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161075AbWGIDV2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 23:21:28 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:26349 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1161073AbWGIDV1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 23:21:27 -0400
Date: Sat, 8 Jul 2006 20:21:08 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Robert Hancock <hancockr@shaw.ca>
cc: linux-kernel@vger.kernel.org, Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Hellwig <hch@infradead.org>,
       Marcelo Tosatti <marcelo@kvack.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Martin Bligh <mbligh@google.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Andi Kleen <ak@suse.de>
Subject: Re: [RFC 0/8] Optional ZONE_DMA
In-Reply-To: <44AFF286.6020601@shaw.ca>
Message-ID: <Pine.LNX.4.64.0607082016360.24311@schroedinger.engr.sgi.com>
References: <fa.3mXwB3pXW7L2KpeFW2PO8SBLhJA@ifi.uio.no> <44AFF286.6020601@shaw.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Jul 2006, Robert Hancock wrote:

> -LPC devices like the floppy controller, maybe enhanced parallel, etc. may
> have 24-bit DMA restrictions even if there is no physical ISA bus.

Yes, I noticed that the floppy drivers has no dependency set but fails 
to build if GENERIC_ISA_DMA is not set.

> -Even in totally ISA and LPC-free systems, some PCI devices (like those that
> were a quick hack of an ISA device onto PCI) still have 24-bit address
> restrictions. There are other devices that have sub-32-bit DMA capabilities,
> like Broadcom wireless chips that only address 31 bits (although I think they
> are fixing this in the driver). Without the DMA zone there is no way to ensure
> that these requests can be satisfied.

These all have to use GFP_DMA and/or GFP_DMA. So if I leave that flag 
undefined then it will be obvious if something is amiss and we can leave 
this experimental for awhile.

> So I don't think it is safe to make this conditional on ISA or even the ISA
> DMA API. Only if all devices on the system have addressing capability of a
> full 32 bits (or at least of all installed RAM) can this zone be removed.

Its safe in the sense that compilation/linking will fail (ISA dma chip 
control functions are not present). Some of the dependencies set right now 
do not correctly express these dependencies. But this could be fixed.

The question is though: Is it worth to do now? Or do we do this later? At 
some point the legacy DMA I/O will become too much of a bother.
