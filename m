Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261568AbTE1XEP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 May 2003 19:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261624AbTE1XEM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 May 2003 19:04:12 -0400
Received: from modemcable204.207-203-24.mtl.mc.videotron.ca ([24.203.207.204]:55169
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id S261568AbTE1XDB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 May 2003 19:03:01 -0400
Date: Wed, 28 May 2003 19:06:01 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Jeff Garzik <jgarzik@pobox.com>
cc: "Nguyen, Tom L" <tom.l.nguyen@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "" <linux-kernel@vger.kernel.org>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Carbonari, Steven" <steven.carbonari@intel.com>
Subject: Re: RFC Proposal to enable MSI support in Linux kernel
In-Reply-To: <3ED53FE3.8090503@pobox.com>
Message-ID: <Pine.LNX.4.50.0305281854180.4964-100000@montezuma.mastecende.com>
References: <C7AB9DA4D0B1F344BF2489FA165E5024136210@orsmsx404.jf.intel.com>
 <Pine.LNX.4.50.0305201447460.20429-100000@montezuma.mastecende.com>
 <Pine.LNX.4.50.0305281650110.4964-100000@montezuma.mastecende.com>
 <3ED53FE3.8090503@pobox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 May 2003, Jeff Garzik wrote:

> > +#ifdef CONFIG_PCI_USE_VECTOR
> > +	for (i = 0; i < (NR_VECTORS - FIRST_EXTERNAL_VECTOR); i++) {
> > +#else
> >  	for (i = 0; i < NR_IRQS; i++) {
> > +#endif
> 
> This ifdef isn't necessary.  ifdef in a header somewhere.  For example, 
> make NR_IRQS (or some other constant, if changing NR_IRQS definition 
> isn't ok) condition on the CONFIG_xxx options.

Actually we can simply use;

for (i = 0; i < (NR_VECTORS - FIRST_EXTERNAL_VECTOR); i++) {
	vector = ...
	if (i >= NR_IRQS)
		break;
	...
	set_intr_gate(vector, interrupt[i]);
}

> split into two functions, maybe?  (due to the ifdef)  Your call, it's 
> mainly a programmer preference.

I agree.

> A bigger question though:  if platform_legacy_irq() returns zero, will 
> the handler _ever_ be edge-triggered?

Good question, i wouldn't think so, that would collapse that section into 
two lines.

> As I see more and more of these ifdefs, I wonder if they couldn't be 
> hidden inside wrappers?

Yes some of them are a bit easy to botch up later on.. like the following 
excerpt.

> > +#ifdef CONFIG_PCI_USE_VECTOR
> > +			if (!platform_legacy_irq(irq))
> > +				entry->irq = IO_APIC_VECTOR(irq);
> > +			else
> > +#endif
> >  			entry->irq = irq;
> >  			continue;

Thanks,
	Zwane
-- 
function.linuxpower.ca
