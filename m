Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262605AbUG1TMF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262605AbUG1TMF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 15:12:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262547AbUG1TMA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 15:12:00 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:62674 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262605AbUG1TLA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 15:11:00 -0400
Subject: Re: [Lse-tech] [RFC][PATCH] Change pcibus_to_cpumask()
	to	pcibus_to_node()
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, Christoph Hellwig <hch@infradead.org>,
       Jesse Barnes <jbarnes@sgi.com>, Andi Kleen <ak@suse.de>,
       LKML <linux-kernel@vger.kernel.org>,
       LSE Tech <lse-tech@lists.sourceforge.net>
In-Reply-To: <82510000.1091026879@[10.10.2.4]>
References: <1090887007.16676.18.camel@arrakis>
	 <20040727105145.A18533@infradead.org>
	 <200407270822.43870.jbarnes@engr.sgi.com>
	 <1090953179.18747.19.camel@arrakis>  <82510000.1091026879@[10.10.2.4]>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1091041808.19459.10.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 28 Jul 2004 12:10:09 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-07-28 at 08:01, Martin J. Bligh wrote:
> >> I wonder though if we shouldn't add
> >> 
> >>   ...
> >> # ifdef CONFIG_NUMA
> >>   int node; /* or nodemask_t if necessary */
> >> # endif
> >>   ...
> >> 
> >> to struct pci_bus instead?  That would make the existing code paths a little 
> >> faster and avoid the need for a global array, which tends to lead to TLB 
> >> misses.
> > 
> > I like that idea!  Stick a nodemask_t in struct pci_bus, initialize it
> > to NODE_MASK_ALL.  If a particular arch wants to put something more
> > accurate in there, then great, if not, we're just in the same boat we're
> > in now.
> > 
> > Anyone else have opinions one way or the other on Jesse's idea?
> 
> Sounds great - if it's possible to add it to something more generic than
> PCI, that'd be even better, but pci would still be very useful.
> 
> M.

Is there anything like that?  I'm not aware of any structure that keeps
track of general "buses", which would be what we want.  Something that
keeps track of PCI buses, Infiniband buses, arch-specific fabric buses,
etc.  Barring the existence of such a structure, I'll just shove it in
the PCI bus structure for now.

-Matt

