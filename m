Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266234AbUG0Djl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266234AbUG0Djl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 23:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266236AbUG0Djl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 23:39:41 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:46015 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S266234AbUG0Djj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 23:39:39 -0400
From: Jesse Barnes <jbarnes@sgi.com>
To: colpatch@us.ibm.com
Subject: Re: [RFC][PATCH] Change pcibus_to_cpumask() to pcibus_to_node()
Date: Mon, 26 Jul 2004 23:38:29 -0400
User-Agent: KMail/1.6.2
Cc: Andi Kleen <ak@suse.de>, LKML <linux-kernel@vger.kernel.org>,
       "Martin J. Bligh" <mbligh@aracnet.com>,
       LSE Tech <lse-tech@lists.sourceforge.net>
References: <1090887007.16676.18.camel@arrakis>
In-Reply-To: <1090887007.16676.18.camel@arrakis>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407262338.29995.jbarnes@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, July 26, 2004 8:10 pm, Matthew Dobson wrote:
> So in discussions with Jesse at OLS, we decided that pcibus_to_node() is
> a more generally useful function than pcibus_to_cpumask().  If anyone
> disagrees with that, now would be a good time to let us know.

Thanks for putting the fact that I was an idiot so kindly... :)

> 1) Replace instances of pcibus_to_cpumask(bus) with
> node_to_cpumask(pcibus_to_node(bus)).  There are currently only 2 uses
> of pcibus_to_cpumask(): flush_gart() in arch/x86_64/kernel/pci-gart.c
> and pci_bus_show_cpuaffinity() in drivers/pci/probe.c.
> 2) Define the asm-generic version of pcibus_to_node() to always return
> node 0, as this is the sensible non-NUMA behavior.
> 3) Drop the mips/mach-ip27 and ppc64 versions of pcibus_to_cpumask()
> entirely, since they were simply defined to be identical to the
> asm-generic version.
> 4) Define the i386 version of pcibus_to_node().

Looks good to me.

> Future work:
>
> 1) Correctly map PCI buses to nodes for x86_64.
> 2) IA64 implementation?

I'll put this together, though the implementation will probably change as we 
add PROM support in the SLIT and SRAT tables for our host to PCI bridges.

Platforms that support it should probably also use pcibus_to_node in their 
pci_alloc_consistent and dma_alloc_coherent APIs if possible.

Thanks,
Jesse
