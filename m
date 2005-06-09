Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261379AbVFIBem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261379AbVFIBem (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 21:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262211AbVFIBee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 21:34:34 -0400
Received: from fsmlabs.com ([168.103.115.128]:33943 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261379AbVFIBe1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 21:34:27 -0400
Date: Wed, 8 Jun 2005 19:37:19 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Ashok Raj <ashok.raj@intel.com>
cc: Andi Kleen <ak@suse.de>, Grant Grundler <grundler@parisc-linux.org>,
       Greg KH <gregkh@suse.de>, Jeff Garzik <jgarzik@pobox.com>,
       "David S. Miller" <davem@davemloft.net>,
       "Nguyen, Tom L" <tom.l.nguyen@intel.com>, roland@topspin.com,
       linux-pci@atrey.karlin.mff.cuni.cz, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] PCI: remove access to pci_[enable|disable]_msi()
 for drivers - take 2
In-Reply-To: <20050608090944.A4147@unix-os.sc.intel.com>
Message-ID: <Pine.LNX.4.61.0506081915140.22613@montezuma.fsmlabs.com>
References: <20050608133226.GR23831@wotan.suse.de> <20050608090944.A4147@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Jun 2005, Ashok Raj wrote:

> On Wed, Jun 08, 2005 at 06:32:26AM -0700, Andi Kleen wrote:
> > 
> >    > I also see one minor weakness in the assumption that CPU Vectors
> >    > are global. Both IA64/PARISC can support per-CPU Vector tables.
> 
> One thing to keep in mind is that since now we have support for CPU hotplug
> we need to factor in cases when cpu is removed, the per-cpu vectors would
> require migrating to a new cpu far interrupt target. Which would 
> possibly require vector-sharing support as well in case the vector is used 
> in all other cpus.
> 
> Possibly irq balancer might need to be revisited as well, and potentially
> might trigger some sharing needs.
> 
> A combination of 
>  - Not allocating IRQs to pins not used (Which Natalie from Unisys
>    submitted) 
>    http://marc.theaimsgroup.com/?l=linux-kernel&m=111656957923038&w=2
>  - per-cpu vector tables (long back i remember seeing some post from sgi
>    on the topic, possibly under intr domains etc.. not too sure)

I did something for i386 which setup per node vector tables, i resurrected 
it for newer systems (ES7000) but haven't fixed MSI support yet. But that 
may not be what you're referring to ;)

>  - vector sharing

This might be simpler if we did IRQ handling domains and setup a group of 
processors with the same vector tables. That way we just migrate onto one 
of the other cpus in the IRQ handling domain. This should also leave 
plenty of room for many devices per IRQ handling domain (my reference is 
a 4 processor per IRQ domain).

Thanks,
	Zwane

