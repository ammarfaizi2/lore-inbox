Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267493AbUG2W24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267493AbUG2W24 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 18:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267491AbUG2W24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 18:28:56 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:63973 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S267490AbUG2W2W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 18:28:22 -0400
Subject: Re: [Lse-tech] [RFC][PATCH] Change pcibus_to_cpumask() to
	pcibus_to_node()
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
To: Rajesh Shah <rajesh.shah@intel.com>
Cc: Jesse Barnes <jbarnes@engr.sgi.com>, Christoph Hellwig <hch@infradead.org>,
       Jesse Barnes <jbarnes@sgi.com>, Andi Kleen <ak@suse.de>,
       LKML <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       LSE Tech <lse-tech@lists.sourceforge.net>
In-Reply-To: <20040729100235.A11986@unix-os.sc.intel.com>
References: <1090887007.16676.18.camel@arrakis>
	 <200407270822.43870.jbarnes@engr.sgi.com>
	 <1090953179.18747.19.camel@arrakis>
	 <200407271140.29818.jbarnes@engr.sgi.com>
	 <1091059607.19459.69.camel@arrakis>
	 <20040729100235.A11986@unix-os.sc.intel.com>
Content-Type: text/plain
Organization: IBM LTC
Message-Id: <1091140066.4070.9.camel@arrakis>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Thu, 29 Jul 2004 15:27:46 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-07-29 at 10:02, Rajesh Shah wrote:
> On Wed, Jul 28, 2004 at 05:06:48PM -0700, Matthew Dobson wrote:
> > 
> > thought.  It's pretty trivial to add a nodemask_t to the struct pci_bus,
> > and even initialize it to a reasonable value (ie: NODE_MASK_ALL) since
> > there's the convenient pci_alloc_bus() function in drivers/pci/probe.c. 
> > The problem is where to put hooks for individual arches to put the
> > *real* nodemask in this field...  My only thought right now is to create
> > a per-arch callback function, arch_get_pcibus_nodemask() or something,
> > and use the value it returns to populate pci_bus->nodemask.  We would
> > have to call this function anywhere a struct pci_bus is allocated, and
> > probably pass along the PCI bus number so the arch could determine which
> > nodes it belongs to.  Would that work for everyone that cares?  We could
> 
> With PCI root/p2p bridge hotplug, the code dealing with the
> hotplug (e.g. ACPI hotplug code) will have this information, not 
> arch specific code. How about having the PCI subsystem export
> an interface to set the nodemask, and have the arch or hotplug
> code call it to change the defaults? That way, pci_alloc_bus()
> simply sets the default and does not perform any callback.
> Does that work for everyone?
> 
> Rajesh

Does the patch I just posted in this thread work for you?  You could
have ACPI define the get_pcibus_nodemask(bus) call, and all should work
fine...

-Matt

