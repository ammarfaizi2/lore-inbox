Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266573AbUG0SxJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266573AbUG0SxJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 14:53:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266572AbUG0SwT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 14:52:19 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:51136 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S266575AbUG0Sqx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 14:46:53 -0400
From: Jesse Barnes <jbarnes@engr.sgi.com>
To: colpatch@us.ibm.com
Subject: Re: [Lse-tech] [RFC][PATCH] Change pcibus_to_cpumask() to pcibus_to_node()
Date: Tue, 27 Jul 2004 11:40:29 -0700
User-Agent: KMail/1.6.2
Cc: Christoph Hellwig <hch@infradead.org>, Jesse Barnes <jbarnes@sgi.com>,
       Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       LSE Tech <lse-tech@lists.sourceforge.net>
References: <1090887007.16676.18.camel@arrakis> <200407270822.43870.jbarnes@engr.sgi.com> <1090953179.18747.19.camel@arrakis>
In-Reply-To: <1090953179.18747.19.camel@arrakis>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407271140.29818.jbarnes@engr.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, July 27, 2004 11:32 am, Matthew Dobson wrote:
> >   ...
> > #ifdef CONFIG_NUMA
> >   int node; /* or nodemask_t if necessary */
> > #endif
> >   ...
> >
> > to struct pci_bus instead?  That would make the existing code paths a
> > little faster and avoid the need for a global array, which tends to lead
> > to TLB misses.
>
> I like that idea!  Stick a nodemask_t in struct pci_bus, initialize it
> to NODE_MASK_ALL.  If a particular arch wants to put something more
> accurate in there, then great, if not, we're just in the same boat we're
> in now.

Cool, sounds like that'll work well.

> I'm trying to keep the dependency of topology on what the pci_dev and
> pci_bus structs look like to a minimum.  That's why I'd like to keep the
> topology function based on PCI bus numbers (or possibly struct pci_bus),
> not struct pci_dev.  The pci_bus is what really has the node affinity
> anyway, and the device only has that affinity through the fact that it
> is physically plugged into a particular bus.

Sure, that make sense.  And it's easy enough to get a pci_bus from a pci_dev 
that we probably won't run into trouble.

Thanks,
Jesse
