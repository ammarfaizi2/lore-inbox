Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267550AbUG3AI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267550AbUG3AI0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jul 2004 20:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267555AbUG3AIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jul 2004 20:08:25 -0400
Received: from fmr03.intel.com ([143.183.121.5]:59818 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S267550AbUG3AFb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jul 2004 20:05:31 -0400
Date: Thu, 29 Jul 2004 17:02:16 -0700
From: Rajesh Shah <rajesh.shah@intel.com>
To: Matthew Dobson <colpatch@us.ibm.com>
Cc: Rajesh Shah <rajesh.shah@intel.com>, Jesse Barnes <jbarnes@engr.sgi.com>,
       Christoph Hellwig <hch@infradead.org>, Jesse Barnes <jbarnes@sgi.com>,
       Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       LSE Tech <lse-tech@lists.sourceforge.net>
Subject: Re: [Lse-tech] [RFC][PATCH] Change pcibus_to_cpumask() to pcibus_to_node()
Message-ID: <20040729170215.A15930@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <1090887007.16676.18.camel@arrakis> <200407270822.43870.jbarnes@engr.sgi.com> <1090953179.18747.19.camel@arrakis> <200407271140.29818.jbarnes@engr.sgi.com> <1091059607.19459.69.camel@arrakis> <20040729100235.A11986@unix-os.sc.intel.com> <1091140066.4070.9.camel@arrakis>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1091140066.4070.9.camel@arrakis>; from colpatch@us.ibm.com on Thu, Jul 29, 2004 at 03:27:46PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 29, 2004 at 03:27:46PM -0700, Matthew Dobson wrote:
> On Thu, 2004-07-29 at 10:02, Rajesh Shah wrote:
> > On Wed, Jul 28, 2004 at 05:06:48PM -0700, Matthew Dobson wrote:
> > > 
> > > and even initialize it to a reasonable value (ie: NODE_MASK_ALL) since
> > > there's the convenient pci_alloc_bus() function in drivers/pci/probe.c. 
> > > The problem is where to put hooks for individual arches to put the
> > > *real* nodemask in this field...  My only thought right now is to create
> > > a per-arch callback function, arch_get_pcibus_nodemask() or something,
> > > and use the value it returns to populate pci_bus->nodemask.  We would
> > > have to call this function anywhere a struct pci_bus is allocated, and
> > > probably pass along the PCI bus number so the arch could determine which
> > > nodes it belongs to.  Would that work for everyone that cares?  We could
> > 
> > With PCI root/p2p bridge hotplug, the code dealing with the
> > hotplug (e.g. ACPI hotplug code) will have this information, not 
> > arch specific code. How about having the PCI subsystem export
> > an interface to set the nodemask, and have the arch or hotplug
> > code call it to change the defaults? That way, pci_alloc_bus()
> > simply sets the default and does not perform any callback.
> > Does that work for everyone?
> > 
> 
> Does the patch I just posted in this thread work for you?  You could
> have ACPI define the get_pcibus_nodemask(bus) call, and all should work
> fine...
> 
Yes, the patch you posted is fine. I was talking about the part
that was not in the patch but mentioned above (arch callbacks).
I'm working on ACPI based root/p2p bridge hotplug but am far from
being done. I can post the patches to get/set nodemask later, when
my work is farther along.

Rajesh
