Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268209AbUG2QBN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268209AbUG2QBN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 12:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268213AbUG2P4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 11:56:11 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:18129 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267557AbUG2Puj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 11:50:39 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: colpatch@us.ibm.com
Subject: Re: [Lse-tech] [RFC][PATCH] Change pcibus_to_cpumask() to pcibus_to_node()
Date: Thu, 29 Jul 2004 08:43:46 -0700
User-Agent: KMail/1.6.2
Cc: Christoph Hellwig <hch@infradead.org>, Jesse Barnes <jbarnes@sgi.com>,
       Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       LSE Tech <lse-tech@lists.sourceforge.net>
References: <1090887007.16676.18.camel@arrakis> <200407271140.29818.jbarnes@engr.sgi.com> <1091059607.19459.69.camel@arrakis>
In-Reply-To: <1091059607.19459.69.camel@arrakis>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407290843.46116.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, July 28, 2004 5:06 pm, Matthew Dobson wrote:
> Ok, so I'm no longer convinced that this will work as well as I once
> thought.  It's pretty trivial to add a nodemask_t to the struct pci_bus,
> and even initialize it to a reasonable value (ie: NODE_MASK_ALL) since
> there's the convenient pci_alloc_bus() function in drivers/pci/probe.c.
> The problem is where to put hooks for individual arches to put the
> *real* nodemask in this field...  My only thought right now is to create
> a per-arch callback function, arch_get_pcibus_nodemask() or something,

Yeah, that sounds reasonable.  You could protect a generic definition with 
#ifndef ARCH_HAS_PCIBUS_TO_NODEMASK or something...

> and use the value it returns to populate pci_bus->nodemask.  We would
> have to call this function anywhere a struct pci_bus is allocated, and
> probably pass along the PCI bus number so the arch could determine which
> nodes it belongs to.  Would that work for everyone that cares?  We could
> overload that to return NODE_MASK_ALL for non-NUMA systems, and have it
> do the right thing for arches that care...

Yeah, I think that would work.  The alternative is to simply add the field, 
initialize it in pci_alloc_bus like you're doing, and leave it to the arches 
to fill it in however they see fit.

Jesse
