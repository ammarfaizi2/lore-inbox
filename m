Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161276AbWGJAEj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161276AbWGJAEj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Jul 2006 20:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161273AbWGJAEj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Jul 2006 20:04:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:49838 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1161272AbWGJAEh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Jul 2006 20:04:37 -0400
From: Andi Kleen <ak@suse.de>
To: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [RFC 0/8] Optional ZONE_DMA
Date: Mon, 10 Jul 2006 02:02:09 +0200
User-Agent: KMail/1.9.3
Cc: Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Hellwig <hch@infradead.org>,
       Marcelo Tosatti <marcelo@kvack.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Martin Bligh <mbligh@google.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
References: <fa.3mXwB3pXW7L2KpeFW2PO8SBLhJA@ifi.uio.no> <44AFF286.6020601@shaw.ca>
In-Reply-To: <44AFF286.6020601@shaw.ca>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607100202.09787.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > On x86_64 systems also usually we do not need ZONE_DMA since there
> > are barely any ISA DMA devices around (or are you still using a floppy?).
> > So for most cases the zone can be dropped. Also if the x86_64 systems
> > has less than 4G RAM or DMA controllers that actually can do 64 bit
> > then we also do not need ZONE_DMA32. My x86_64 system has 1G of
> > memory therefore I can run with a single zone.
> 
> Keep in mind that:

Yes we can't really make it optional. There are reasons to use GFP_DMA
even without ISA. Also on x86-64 CONFIG_ISA is never set so it would
completely eliminate GFP_DMA, which we can't do.

That said however nearly users of GFP_DMA outside arch/* are wrong.
They should be all audited and convered to use the PCI DMA API instead.

> -LPC devices like the floppy controller, maybe enhanced parallel, etc. 
> may have 24-bit DMA restrictions even if there is no physical ISA bus.
> 
> -Even in totally ISA and LPC-free systems, some PCI devices (like those 
> that were a quick hack of an ISA device onto PCI) still have 24-bit 
> address restrictions. There are other devices that have sub-32-bit DMA 
> capabilities, like Broadcom wireless chips that only address 31 bits 
> (although I think they are fixing this in the driver). Without the DMA 
> zone there is no way to ensure that these requests can be satisfied.

There are also devices with 31 or 30 bits that also fall back to GFP_DMA
and a couple of other cases.


-Andi
